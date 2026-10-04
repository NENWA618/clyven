import 'dart:convert';

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

  static AutoRefreshingAuthClient? _cachedClient;

  // The client auto-refreshes its own token, so it's safe to reuse across
  // calls/instances instead of re-authenticating with GCP on every request.
  static Future<AutoRefreshingAuthClient> _client() async {
    return _cachedClient ??= await clientViaApplicationDefaultCredentials(
      scopes: const [_scope],
    );
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

    if (currentJobName == null || currentJobName.isEmpty) {
      final jobName = await _createJob(
        videoStorageKey: video.videoStorageKey,
        outputPrefix: TranscodeRetryPolicy.outputPrefix(videoId, 0),
      );

      video.hlsManifestStorageKey = TranscodeRetryPolicy.manifestKey(
        videoId,
        0,
      );
      video.transcoderJobName = jobName;
      video.transcodeState = 'PENDING';
      video.updatedAt = DateTime.now().toUtc();

      session.log(
        'TRANSCODE_CREATED videoId=$videoId attempt=0 job=$jobName',
      );

      return Video.db.updateRow(session, video);
    }

    final parsed = TranscodeRetryPolicy.parseJobName(currentJobName);
    final persistedManifestKey = video.hlsManifestStorageKey?.trim();
    final expectedManifestKey =
        persistedManifestKey != null && persistedManifestKey.isNotEmpty
        ? persistedManifestKey
        : TranscodeRetryPolicy.manifestKey(videoId, parsed.attempt);

    // 已成功的转码不再重复请求 GCP Transcoder API。
    if (video.transcodeState == 'SUCCEEDED' &&
        video.hlsManifestStorageKey == expectedManifestKey) {
      return video;
    }

    final status = await _getJobStatus(parsed.rawJobName);

    if (status.state == 'FAILED') {
      session.log(
        'TRANSCODE_FAILED videoId=$videoId '
        'attempt=${parsed.attempt} '
        'error=${status.error ?? 'unknown error'}',
        level: LogLevel.warning,
      );

      if (TranscodeRetryPolicy.canRetry(parsed.attempt)) {
        final nextAttempt = parsed.attempt + 1;

        final retryJobName = await _createJob(
          videoStorageKey: video.videoStorageKey,
          outputPrefix: TranscodeRetryPolicy.outputPrefix(videoId, nextAttempt),
        );

        video.hlsManifestStorageKey = TranscodeRetryPolicy.manifestKey(
          videoId,
          nextAttempt,
        );
        video.transcoderJobName = TranscodeRetryPolicy.encodeJobName(
          nextAttempt,
          retryJobName,
        );
        video.transcodeState = 'PENDING';
        video.updatedAt = DateTime.now().toUtc();

        session.log(
          'TRANSCODE_RETRY videoId=$videoId '
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

  Future<String> _createJob({
    required String videoStorageKey,
    required String outputPrefix,
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
