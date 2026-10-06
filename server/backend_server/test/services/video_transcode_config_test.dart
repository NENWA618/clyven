import 'dart:convert';

import 'package:glyphora_backend_server/src/services/video_transcode_config.dart';
import 'package:glyphora_backend_server/src/services/transcode_retry_policy.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> build(Duration segmentDuration) =>
      jsonDecode(
            jsonEncode(
              buildVideoTranscodeJob(
                inputUri: 'gs://bucket/videos/user/portrait.mp4',
                outputUri:
                    'gs://bucket/${TranscodeRetryPolicy.outputPrefix(15, 0)}',
                segmentDuration: segmentDuration,
              ),
            ),
          )
          as Map<String, dynamic>;

  test('HLS job exposes four adaptive renditions', () {
    final job = build(const Duration(seconds: 6));

    expect(job['templateId'], isNull);
    expect(job['inputUri'], 'gs://bucket/videos/user/portrait.mp4');

    final config = job['config'] as Map<String, dynamic>;
    final streams = config['elementaryStreams'] as List<dynamic>;
    final videoStreams = streams.where((s) => s['videoStream'] != null);

    expect(videoStreams.length, 4);

    for (final stream in videoStreams) {
      final codec = stream['videoStream']['h264'] as Map<String, dynamic>;
      expect(codec.containsKey('widthPixels'), isFalse);
      expect(codec['heightPixels'], anyOf(360, 480, 720, 1080));
      expect(codec['bitrateBps'], greaterThan(0));
      expect(codec['frameRate'], 30);
    }

    final keys = streams.map((s) => s['key']).toSet();
    final muxStreams = config['muxStreams'] as List<dynamic>;

    expect(muxStreams.length, 4);

    for (final mux in muxStreams) {
      expect(mux['container'], 'ts');
      expect(mux['elementaryStreams'], everyElement(isIn(keys)));
      expect(mux['segmentSettings']['segmentDuration'], '6s');
    }

    final manifest = (config['manifests'] as List<dynamic>).single;
    expect(manifest['type'], 'HLS');
    expect(manifest['muxStreams'], muxStreams.map((s) => s['key']).toList());
  });

  test('Shorts can use 3 second segments', () {
    final job = build(const Duration(seconds: 3));
    final config = job['config'] as Map<String, dynamic>;
    final muxStreams = config['muxStreams'] as List<dynamic>;

    for (final mux in muxStreams) {
      expect(mux['segmentSettings']['segmentDuration'], '3s');
    }
  });
}
