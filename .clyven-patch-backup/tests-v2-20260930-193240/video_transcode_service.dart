import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class _TranscodeJobStatus {
  const _TranscodeJobStatus({
    required this.state,
    this.error,
  });

  final String state;
  final String? error;
}

class _ParsedTranscodeJob {
  const _ParsedTranscodeJob({
    required this.attempt,
    required this.rawJobName,
  });

  final int attempt;
  final String rawJobName;
}

class VideoTranscodeService {
  const VideoTranscodeService();

  static const _projectId = 'glyphora-video';
  static const _location = 'asia-southeast1';
  static const _bucket = 'glyphora-video-storage-11129163384';
  static const _scope = 'https://www.googleapis.com/auth/cloud-platform';

  static const int _maxRetryAttempts = 3;

  static AutoRefreshingAuthClient? _cachedClient;

  // The client auto-refreshes its own token, so it's safe to reuse across
  // calls/instances instead of re-authenticating with GCP on every request.
  static Future<AutoRefreshingAuthClient> _client() async {
    return _cachedClient ??= await clientViaApplicationDefaultCredentials(
      scopes: const [_scope],
    );
  }

  String _manifestKey(int videoId, int attempt) {
    if (attempt <= 0) {
      return 'transcoded/$videoId/manifest.m3u8';
    }

    return 'transcoded/$videoId/retry-$attempt/manifest.m3u8';
  }

  String _outputPrefix(int videoId, int attempt) {
    if (attempt <= 0) {
      return 'transcoded/$videoId/';
    }

    return 'transcoded/$videoId/retry-$attempt/';
  }

  String _encodeJobName(int attempt, String rawJobName) {
    if (attempt <= 0) {
      return rawJobName;
    }

    return 'retry$attempt|$rawJobName';
  }

  _ParsedTranscodeJob _parseJobName(String value) {
    final match = RegExp(r'^retry(\d+)\|(.*)$').firstMatch(value);

    if (match == null) {
      return _ParsedTranscodeJob(
        attempt: 0,
        rawJobName: value,
      );
    }

    return _ParsedTranscodeJob(
      attempt: int.tryParse(match.group(1) ?? '') ?? 0,
      rawJobName: match.group(2) ?? value,
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
        outputPrefix: _outputPrefix(videoId, 0),
      );

      video.hlsManifestStorageKey = _manifestKey(videoId, 0);
      video.transcoderJobName = jobName;
      video.transcodeState = 'PENDING';
      video.updatedAt = DateTime.now().toUtc();

      session.log(
        'TRANSCODE_CREATED videoId=$videoId attempt=0 job=$jobName',
      );

      return Video.db.updateRow(session, video);
    }

    final parsed = _parseJobName(currentJobName);

    final expectedManifestKey = _manifestKey(
      videoId,
      parsed.attempt,
    );

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

      if (parsed.attempt < _maxRetryAttempts) {
        final nextAttempt = parsed.attempt + 1;

        final retryJobName = await _createJob(
          videoStorageKey: video.videoStorageKey,
          outputPrefix: _outputPrefix(videoId, nextAttempt),
        );

        video.hlsManifestStorageKey = _manifestKey(videoId, nextAttempt);
        video.transcoderJobName = _encodeJobName(nextAttempt, retryJobName);
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
      body: jsonEncode({
        'inputUri': 'gs://$_bucket/$videoStorageKey',
        'outputUri': 'gs://$_bucket/$outputPrefix',
        'templateId': 'preset/web-hd',
      }),
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
