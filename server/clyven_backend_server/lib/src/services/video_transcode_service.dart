import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class VideoTranscodeService {
  const VideoTranscodeService();

  static const _projectId = 'glyphora-video';
  static const _location = 'asia-southeast1';
  static const _bucket = 'glyphora-video-storage-11129163384';
  static const _scope = 'https://www.googleapis.com/auth/cloud-platform';

  String _manifestKey(int videoId) => 'transcoded/$videoId/manifest.m3u8';

  String _outputPrefix(int videoId) => 'transcoded/$videoId/';

  Future<Video> ensure(
    Session session,
    Video video,
  ) async {
    final videoId = video.id;

    if (videoId == null) {
      throw StateError('Cannot transcode a video without an id.');
    }

    final manifestKey = _manifestKey(videoId);
    final currentJobName = video.transcoderJobName?.trim();

    if (currentJobName == null || currentJobName.isEmpty) {
      final jobName = await _createJob(
        videoStorageKey: video.videoStorageKey,
        outputPrefix: _outputPrefix(videoId),
      );

      video.hlsManifestStorageKey = manifestKey;
      video.transcoderJobName = jobName;
      video.transcodeState = 'PENDING';
      video.updatedAt = DateTime.now();

      return Video.db.updateRow(session, video);
    }

    final state = await _getJobState(currentJobName);

    if (video.hlsManifestStorageKey != manifestKey ||
        video.transcodeState != state) {
      video.hlsManifestStorageKey = manifestKey;
      video.transcodeState = state;
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

  Future<String> _getJobState(String jobName) async {
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

      return body['state']?.toString().trim().toUpperCase() ?? 'UNKNOWN';
    } finally {
      client.close();
    }
  }
}
