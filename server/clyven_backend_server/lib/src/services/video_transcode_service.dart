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

class VideoTranscodeService {
  const VideoTranscodeService();

  static const _projectId = 'glyphora-video';
  static const _location = 'asia-southeast1';
  static const _bucket = 'glyphora-video-storage-11129163384';
  static const _scope = 'https://www.googleapis.com/auth/cloud-platform';
  static const _retryPrefix = 'retry1|';

  String _manifestKey(int videoId) => 'transcoded/$videoId/manifest.m3u8';

  String _retryManifestKey(int videoId) =>
      'transcoded/$videoId/retry-1/manifest.m3u8';

  String _outputPrefix(int videoId) => 'transcoded/$videoId/';

  String _retryOutputPrefix(int videoId) => 'transcoded/$videoId/retry-1/';

  bool _isRetryJob(String value) => value.startsWith(_retryPrefix);

  String _rawJobName(String value) =>
      _isRetryJob(value) ? value.substring(_retryPrefix.length) : value;

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
        outputPrefix: _outputPrefix(videoId),
      );

      video.hlsManifestStorageKey = _manifestKey(videoId);
      video.transcoderJobName = jobName;
      video.transcodeState = 'PENDING';
      video.updatedAt = DateTime.now();

      return Video.db.updateRow(session, video);
    }

    final retryJob = _isRetryJob(currentJobName);
    final status = await _getJobStatus(_rawJobName(currentJobName));

    if (status.state == 'FAILED') {
      print(
        '[Clyven Transcoder] Video $videoId failed'
        '${retryJob ? ' after retry' : ''}: ${status.error ?? 'unknown error'}',
      );

      if (!retryJob) {
        final retryJobName = await _createJob(
          videoStorageKey: video.videoStorageKey,
          outputPrefix: _retryOutputPrefix(videoId),
        );

        video.hlsManifestStorageKey = _retryManifestKey(videoId);
        video.transcoderJobName = '$_retryPrefix$retryJobName';
        video.transcodeState = 'PENDING';
        video.updatedAt = DateTime.now();

        print(
          '[Clyven Transcoder] Retrying video $videoId once with job '
          '$retryJobName',
        );

        return Video.db.updateRow(session, video);
      }
    }

    final expectedManifestKey = retryJob
        ? _retryManifestKey(videoId)
        : _manifestKey(videoId);

    if (video.hlsManifestStorageKey != expectedManifestKey ||
        video.transcodeState != status.state) {
      video.hlsManifestStorageKey = expectedManifestKey;
      video.transcodeState = status.state;
      video.updatedAt = DateTime.now();

      return Video.db.updateRow(session, video);
    }

    return video;
  }

  Future<String> _createJob({
    required String videoStorageKey,
    required String outputPrefix,
  }) async {
    final client = await clientViaApplicationDefaultCredentials(
      scopes: const [_scope],
    );

    try {
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
    } finally {
      client.close();
    }
  }

  Future<_TranscodeJobStatus> _getJobStatus(String jobName) async {
    final client = await clientViaApplicationDefaultCredentials(
      scopes: const [_scope],
    );

    try {
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

      final state =
          body['state']?.toString().trim().toUpperCase() ?? 'UNKNOWN';
      final rawError = body['error'];
      final error = rawError == null ? null : jsonEncode(rawError);

      return _TranscodeJobStatus(
        state: state,
        error: error,
      );
    } finally {
      client.close();
    }
  }
}
