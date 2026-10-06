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

    if (currentJobName == null || currentJobName.isEmpty) {
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
