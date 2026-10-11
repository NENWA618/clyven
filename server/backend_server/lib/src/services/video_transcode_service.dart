import 'dart:convert';
import 'dart:io';

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
      Platform.environment['GLYPHORA_TRANSCODER']?.toLowerCase() == 'cloudflare_stream';

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

    final client = HttpClient();
    try {
      final request = await client.openUrl(
        method,
        Uri.parse('https://api.cloudflare.com/client/v4/accounts/'
            '$_streamAccountId/stream$path'),
      );
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $_streamToken');
      request.headers.contentType = ContentType.json;
      if (body != null) request.write(jsonEncode(body));
      final response = await request.close();
      final payload = await utf8.decoder.bind(response).join();
      final decoded = jsonDecode(payload);
      if (response.statusCode < 200 || response.statusCode >= 300 ||
          decoded is! Map<String, dynamic> || decoded['success'] != true ||
          decoded['result'] is! Map<String, dynamic>) {
        throw StateError('Cloudflare Stream API error: ${response.statusCode} ${payload.length > 1000 ? payload.substring(0, 1000) : payload}');
      }
      return decoded['result'] as Map<String, dynamic>;
    } finally {
      client.close(force: true);
    }
  }

  Future<Video> _startStream(Session session, Video video) async {
    // This integration uses public playback URLs. Never accidentally publish
    // private Glyphora videos through Cloudflare Stream.
    if (!video.isPublic) {
      throw StateError(
        'Cloudflare Stream public playback is disabled for private videos. '
        'Signed playback must be implemented before private uploads migrate.',
      );
    }
    if (video.id == null) throw StateError('Video ID required.');
    final sourceUrl = await session.storage.getPublicUrl(
      storageId: 'public',
      path: video.videoStorageKey,
    );
    if (sourceUrl == null || sourceUrl.scheme != 'https') {
      throw StateError('Cloudflare Stream requires an accessible HTTPS source video URL.');
    }
    final result = await _streamRequest('POST', '/copy', body: {
      'url': sourceUrl.toString(),
      'meta': {'glyphoraVideoId': video.id.toString()},
      'requireSignedURLs': false,
    });
    final uid = result['uid']?.toString();
    if (uid == null || uid.isEmpty) {
      throw StateError('Cloudflare Stream response missing uid.');
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
    if (ready && manifest != null && Uri.tryParse(manifest)?.scheme == 'https') {
      video.hlsManifestStorageKey = manifest;
      video.transcodeState = 'SUCCEEDED';
    } else if (state == 'error') {
      video.transcodeState = 'FAILED';
      session.log('Cloudflare Stream processing failed videoId=${video.id}: $status', level: LogLevel.warning);
    } else {
      video.transcodeState = 'PENDING';
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
