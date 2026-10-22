import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'package:googleapis_auth/auth_io.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'transcode_retry_policy.dart';
import 'video_transcode_config.dart';

class _TranscodeJobStatus {
  const _TranscodeJobStatus({
    required this.state,
    this.error,
  });

  final String state;
  final String? error;
}

class VideoTranscodeService {
  const VideoTranscodeService();

  static const _projectId = 'glyphora-video';
  static const _location = 'asia-southeast1';
  static const _bucket = 'glyphora-video-storage-11129163384';
  static const _scope = 'https://www.googleapis.com/auth/cloud-platform';

  static bool get _useStream =>
      Platform.environment['GLYPHORA_TRANSCODER']?.toLowerCase() ==
      'cloudflare_stream';

  static String get _streamAccountId =>
      Platform.environment['CLOUDFLARE_ACCOUNT_ID']?.trim() ?? '';

  static String get _streamToken =>
      Platform.environment['CLOUDFLARE_STREAM_API_TOKEN']?.trim() ?? '';

  static const _shortSegmentDuration = Duration(seconds: 3);
  static const _videoSegmentDuration = Duration(seconds: 6);

  static AutoRefreshingAuthClient? _cachedClient;

  static Future<AutoRefreshingAuthClient> _client() async {
    return _cachedClient ??= await clientViaApplicationDefaultCredentials(
      scopes: const [_scope],
    );
  }

  static Duration _segmentDurationFor(Video video) {
    return video.contentType == VideoContentType.short
        ? _shortSegmentDuration
        : _videoSegmentDuration;
  }

  Future<Video> ensure(
    Session session,
    Video video,
  ) async {
    final videoId = video.id;

    if (videoId == null) {
      throw StateError('Cannot transcode a video without an id.');
    }

    final currentJobName = video.transcoderJobName?.trim();

    // Do not start new Google Transcoder jobs on Cloudflare Containers.
    // Existing Google jobs may still be polled during a controlled cutover.
    if ((currentJobName == null || currentJobName.isEmpty) &&
        Platform.environment['GLYPHORA_REQUIRE_CLOUDFLARE'] == 'true' &&
        !_useStream) {
      throw StateError(
        'Cloudflare deployment requires GLYPHORA_TRANSCODER=cloudflare_stream '
        'before accepting new video transcoding jobs.',
      );
    }

    if (currentJobName?.startsWith('cfstream:') == true) {
      return _ensureStream(session, video, currentJobName!);
    }

    if (currentJobName == null || currentJobName.isEmpty) {
      if (_useStream) {
        return _startStream(session, video);
      }
      final mediaVersion = TranscodeRetryPolicy.currentMediaVersion;
      final jobName = await _createJob(
        videoStorageKey: video.videoStorageKey,
        outputPrefix: TranscodeRetryPolicy.outputPrefix(
          videoId,
          0,
          mediaVersion: mediaVersion,
        ),
        segmentDuration: _segmentDurationFor(video),
      );

      video.hlsManifestStorageKey = TranscodeRetryPolicy.manifestKey(
        videoId,
        0,
        mediaVersion: mediaVersion,
      );
      video.transcoderJobName = jobName;
      video.transcodeState = 'PENDING';
      video.updatedAt = DateTime.now().toUtc();

      session.log(
        'TRANSCODE_CREATED videoId=$videoId '
        'mediaVersion=$mediaVersion '
        'contentType=${video.contentType.name} '
        'segmentSeconds=${_segmentDurationFor(video).inSeconds} '
        'attempt=0 job=$jobName',
      );

      return Video.db.updateRow(session, video);
    }

    // Cloudflare Containers have no Google application-default credentials.
    // Keep finished legacy manifests readable, but do not poll/retry Google
    // Transcoder jobs from Cloudflare while the backfill is incomplete.
    if (Platform.environment['GLYPHORA_REQUIRE_CLOUDFLARE'] == 'true') {
      return video;
    }

    final parsed = TranscodeRetryPolicy.parseJobName(currentJobName);
    final persistedManifestKey = video.hlsManifestStorageKey?.trim();
    final mediaVersion = TranscodeRetryPolicy.mediaVersionFromManifestKey(
      persistedManifestKey,
    );
    final expectedManifestKey =
        persistedManifestKey != null && persistedManifestKey.isNotEmpty
        ? persistedManifestKey
        : TranscodeRetryPolicy.manifestKey(
            videoId,
            parsed.attempt,
            mediaVersion: mediaVersion,
          );

    if (video.transcodeState == 'SUCCEEDED' &&
        video.hlsManifestStorageKey == expectedManifestKey) {
      return video;
    }

    final status = await _getJobStatus(parsed.rawJobName);

    if (status.state == 'FAILED') {
      session.log(
        'TRANSCODE_FAILED videoId=$videoId '
        'mediaVersion=$mediaVersion '
        'attempt=${parsed.attempt} '
        'error=${status.error ?? 'unknown error'}',
        level: LogLevel.warning,
      );

      if (TranscodeRetryPolicy.canRetry(parsed.attempt)) {
        final nextAttempt = parsed.attempt + 1;

        final retryJobName = await _createJob(
          videoStorageKey: video.videoStorageKey,
          outputPrefix: TranscodeRetryPolicy.outputPrefix(
            videoId,
            nextAttempt,
            mediaVersion: mediaVersion,
          ),
          segmentDuration: _segmentDurationFor(video),
        );

        video.hlsManifestStorageKey = TranscodeRetryPolicy.manifestKey(
          videoId,
          nextAttempt,
          mediaVersion: mediaVersion,
        );
        video.transcoderJobName = TranscodeRetryPolicy.encodeJobName(
          nextAttempt,
          retryJobName,
        );
        video.transcodeState = 'PENDING';
        video.updatedAt = DateTime.now().toUtc();

        session.log(
          'TRANSCODE_RETRY videoId=$videoId '
          'mediaVersion=$mediaVersion '
          'contentType=${video.contentType.name} '
          'segmentSeconds=${_segmentDurationFor(video).inSeconds} '
          'attempt=$nextAttempt job=$retryJobName',
          level: LogLevel.warning,
        );

        return Video.db.updateRow(session, video);
      }
    }

    if (video.hlsManifestStorageKey != expectedManifestKey ||
        video.transcodeState != status.state) {
      video.hlsManifestStorageKey = expectedManifestKey;
      video.transcodeState = status.state;
      video.updatedAt = DateTime.now().toUtc();

      return Video.db.updateRow(session, video);
    }

    return video;
  }

  Future<Map<String, dynamic>> _streamRequest(
    String method,
    String path, {
    Object? body,
  }) async {
    if (_streamAccountId.isEmpty || _streamToken.isEmpty) {
      throw StateError('Cloudflare Stream account ID or API token is missing.');
    }

    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final uri = Uri.parse(
        'https://api.cloudflare.com/client/v4/accounts/'
        '$_streamAccountId/stream$path',
      );
      final pendingRequest = client.openUrl(method, uri);
      final request = await pendingRequest.timeout(
        const Duration(seconds: 20),
      );
      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $_streamToken',
      );
      request.headers.contentType = ContentType.json;
      if (body != null) request.write(jsonEncode(body));
      final pendingResponse = request.close();
      final response = await pendingResponse.timeout(
        const Duration(seconds: 30),
      );
      final pendingPayload = utf8.decoder.bind(response).join();
      final payload = await pendingPayload.timeout(
        const Duration(seconds: 30),
      );
      final decoded = jsonDecode(payload);
      if (response.statusCode < 200 ||
          response.statusCode >= 300 ||
          decoded is! Map<String, dynamic> ||
          decoded['success'] != true ||
          decoded['result'] is! Map<String, dynamic>) {
        throw StateError(
          'Cloudflare Stream API error: ${response.statusCode} ${payload.length > 1000 ? payload.substring(0, 1000) : payload}',
        );
      }
      return decoded['result'] as Map<String, dynamic>;
    } finally {
      client.close(force: true);
    }
  }

  /// Stream ingestion ONLY. Never return this URL to Glyphora clients.
  static Uri _signedPrivateImportUri(String objectKey) {
    final key = Platform.environment['GLYPHORA_PRIVATE_INGEST_KEY'] ?? '';
    final base = Platform.environment['GLYPHORA_PRIVATE_INGEST_BASE_URL'] ?? '';
    if (key.length < 32)
      throw StateError('Private ingest key is not configured.');
    final origin = Uri.tryParse(base);
    if (origin == null ||
        origin.scheme != 'https' ||
        origin.host.isEmpty ||
        origin.userInfo.isNotEmpty ||
        origin.hasQuery ||
        origin.hasFragment ||
        (origin.path.isNotEmpty && origin.path != '/')) {
      throw StateError('Private ingest base URL must be an HTTPS origin.');
    }
    if (!RegExp(
      r'^videos/[A-Za-z0-9_-]+/[A-Za-z0-9._-]+$',
    ).hasMatch(objectKey)) {
      throw StateError('Invalid private video key.');
    }
    final expires =
        (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 + 7200)
            .toString();
    final encoded = base64Url
        .encode(utf8.encode(objectKey))
        .replaceAll('=', '');
    final mac = Hmac(
      sha256,
      utf8.encode(key),
    ).convert(utf8.encode('$expires.$encoded')).toString();
    return origin.replace(
      path: '/__glyphora_private_ingest/$encoded',
      queryParameters: {'exp': expires, 'sig': mac},
    );
  }

  Future<Video> _startStream(Session session, Video video) async {
    if (video.id == null) throw StateError('Video ID required.');
    // GLYPHORA_PRIVATE_STREAM_SIGNER_STAGE3C4
    // Never infer legacy NULL provenance from isPublic.
    final isPrivate = !video.isPublic;
    if (isPrivate && video.videoStorageId != 'private') {
      throw StateError(
        'Private Stream import requires explicit private storage provenance.',
      );
    }
    if (!isPrivate && video.videoStorageId == 'private') {
      throw StateError('Refusing public Stream import of private file.');
    }
    final Uri sourceUrl;
    if (isPrivate) {
      sourceUrl = _signedPrivateImportUri(video.videoStorageKey);
    } else {
      final publicUrl = await session.storage.getPublicUrl(
        storageId: 'public',
        path: video.videoStorageKey,
      );
      if (publicUrl == null || publicUrl.scheme != 'https') {
        throw StateError('Cloudflare Stream requires accessible HTTPS source.');
      }
      sourceUrl = publicUrl;
    }
    // GLYPHORA_PRIVATE_STREAM_IMPORT_CLAIM_V1
    // Persist the intent BEFORE the external /copy call. An unexpected failure
    // can leave a Stream asset whose UID was not saved. We deliberately do not
    // automatically retry such an ambiguous request, because it could create
    // a duplicate paid Stream asset. Reconcile the remote asset first.
    if (isPrivate) {
      final claimed = await session.db.unsafeQuery(
        r'''UPDATE "video"
            SET "transcodeState" = 'IMPORTING', "updatedAt" = NOW()
            WHERE "id" = @videoId
              AND "isPublic" = false
              AND "videoStorageId" = 'private'
              AND "videoStorageKey" = @sourceKey
              AND "transcoderJobName" IS NULL
              AND ("transcodeState" IS NULL OR "transcodeState" = 'FAILED')
            RETURNING "id"''',
        parameters: QueryParameters.named({
          'videoId': video.id,
          'sourceKey': video.videoStorageKey,
        }),
      );
      if (claimed.length != 1) {
        throw StateError(
          'Private Stream import already claimed or requires manual '
          'reconciliation. Refusing duplicate Stream /copy request.',
        );
      }
      video.transcodeState = 'IMPORTING';
    }
    final result = await _streamRequest(
      'POST',
      '/copy',
      body: {
        'url': sourceUrl.toString(),
        'meta': {'glyphoraVideoId': video.id.toString()},
        'requireSignedURLs': isPrivate,
      },
    );
    final uid = result['uid']?.toString();
    if (uid == null || uid.isEmpty) {
      throw StateError('Cloudflare Stream response missing uid.');
    }
    // GLYPHORA_PRIVATE_STREAM_CAS_STAGE3C7
    // Save only the transcode fields. Never overwrite concurrent edits to the
    // video row using an old Video instance returned before the network call.
    if (isPrivate) {
      final updated = await session.db.unsafeQuery(
        r'''UPDATE "video"
            SET "transcoderJobName" = @job,
                "transcodeState" = 'PENDING',
                "hlsManifestStorageKey" = NULL,
                "updatedAt" = NOW()
            WHERE "id" = @videoId
              AND "isPublic" = false
              AND "videoStorageId" = 'private'
              AND "videoStorageKey" = @sourceKey
              AND "transcodeState" = 'IMPORTING'
              AND "transcoderJobName" IS NULL
            RETURNING "id"''',
        parameters: QueryParameters.named({
          'videoId': video.id,
          'job': 'cfstream:$uid',
          'sourceKey': video.videoStorageKey,
        }),
      );
      if (updated.length != 1) {
        throw StateError(
          'Stream accepted an import but DB claim changed. UID=$uid; '
          'manual reconciliation required. Refusing unsafe overwrite.',
        );
      }
      final fresh = await Video.db.findById(session, video.id!);
      if (fresh == null) {
        throw StateError('Stream UID=$uid saved but video row disappeared.');
      }
      return fresh;
    }
    video.transcoderJobName = 'cfstream:$uid';
    video.transcodeState = 'PENDING';
    video.hlsManifestStorageKey = null;
    video.updatedAt = DateTime.now().toUtc();
    return Video.db.updateRow(session, video);
  }

  Future<Video> _ensureStream(
    Session session,
    Video video,
    String jobName,
  ) async {
    if (video.transcodeState == 'SUCCEEDED' &&
        video.hlsManifestStorageKey?.startsWith('https://') == true) {
      return video;
    }
    final uid = jobName.substring('cfstream:'.length);
    final result = await _streamRequest('GET', '/$uid');
    final status = result['status'];
    final state = status is Map ? status['state']?.toString() : null;
    final ready = result['readyToStream'] == true;
    final playback = result['playback'];
    final manifest = playback is Map ? playback['hls']?.toString() : null;
    if (ready &&
        manifest != null &&
        Uri.tryParse(manifest)?.scheme == 'https') {
      video.hlsManifestStorageKey = manifest;
      video.transcodeState = 'SUCCEEDED';
    } else if (state == 'error') {
      video.transcodeState = 'FAILED';
      session.log(
        'Cloudflare Stream processing failed videoId=${video.id}: $status',
        level: LogLevel.warning,
      );
    } else {
      video.transcodeState = 'PENDING';
    }
    if (!video.isPublic && video.videoStorageId == 'private') {
      // Update only the matching Stream job; never overwrite concurrent edits
      // or attach a manifest to a changed video. Failure is fail-closed.
      final updated = await session.db.unsafeQuery(
        r'''UPDATE "video"
            SET "transcodeState" = @state,
                "hlsManifestStorageKey" = @manifest,
                "updatedAt" = NOW()
            WHERE "id" = @videoId
              AND "isPublic" = false
              AND "videoStorageId" = 'private'
              AND "videoStorageKey" = @sourceKey
              AND "transcoderJobName" = @job
            RETURNING "id"''',
        parameters: QueryParameters.named({
          'videoId': video.id,
          'sourceKey': video.videoStorageKey,
          'job': jobName,
          'state': video.transcodeState,
          'manifest': video.hlsManifestStorageKey,
        }),
      );
      if (updated.length != 1) {
        throw StateError('Stream status update refused: video changed.');
      }
      final fresh = await Video.db.findById(session, video.id!);
      if (fresh == null) throw StateError('Video missing after status update.');
      return fresh;
    }
    video.updatedAt = DateTime.now().toUtc();
    return Video.db.updateRow(session, video);
  }

  Future<String> _createJob({
    required String videoStorageKey,
    required String outputPrefix,
    required Duration segmentDuration,
  }) async {
    final client = await _client();

    final uri = Uri.parse(
      'https://transcoder.googleapis.com/v1/'
      'projects/$_projectId/locations/$_location/jobs'
      '?fields=name,state',
    );

    final response = await client.post(
      uri,
      headers: const {
        'content-type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(
        buildVideoTranscodeJob(
          inputUri: 'gs://$_bucket/$videoStorageKey',
          outputUri: 'gs://$_bucket/$outputPrefix',
          segmentDuration: segmentDuration,
        ),
      ),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'Transcoder create job failed '
        '(${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body);

    if (body is! Map<String, dynamic>) {
      throw StateError('Unexpected Transcoder create response.');
    }

    final name = body['name']?.toString().trim();

    if (name == null || name.isEmpty) {
      throw StateError('Transcoder response did not include a job name.');
    }

    return name;
  }

  Future<_TranscodeJobStatus> _getJobStatus(String jobName) async {
    final client = await _client();

    final uri = Uri.parse(
      'https://transcoder.googleapis.com/v1/$jobName'
      '?fields=state,error',
    );

    final response = await client.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'Transcoder get job failed '
        '(${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body);

    if (body is! Map<String, dynamic>) {
      throw StateError('Unexpected Transcoder job response.');
    }

    final state = body['state']?.toString().trim().toUpperCase() ?? 'UNKNOWN';
    final rawError = body['error'];
    final error = rawError == null ? null : jsonEncode(rawError);

    return _TranscodeJobStatus(
      state: state,
      error: error,
    );
  }
}
