import 'dart:convert';

import 'package:clyven_backend_server/src/services/video_transcode_config.dart';
import 'package:clyven_backend_server/src/services/transcode_retry_policy.dart';
import 'package:test/test.dart';

void main() {
  test('HLS job delegates aspect ratio and rotation to Transcoder', () {
    final job =
        jsonDecode(
              jsonEncode(
                buildVideoTranscodeJob(
                  inputUri: 'gs://bucket/videos/user/portrait.mp4',
                  outputUri:
                      'gs://bucket/${TranscodeRetryPolicy.outputPrefix(15, 0)}',
                ),
              ),
            )
            as Map<String, dynamic>;
    expect(job['templateId'], isNull);
    expect(job['inputUri'], 'gs://bucket/videos/user/portrait.mp4');
    final config = job['config'] as Map<String, dynamic>;
    final streams = config['elementaryStreams'] as List<dynamic>;
    final videoStreams = streams.where((s) => s['videoStream'] != null);
    expect(videoStreams.length, 2);
    for (final stream in videoStreams) {
      final codec = stream['videoStream']['h264'] as Map<String, dynamic>;
      expect(
        codec.containsKey('widthPixels'),
        isFalse,
        reason: 'Both dimensions would force portrait into a fixed ratio.',
      );
      expect(codec['heightPixels'], anyOf(360, 720));
      expect(codec['bitrateBps'], greaterThan(0));
      expect(codec['frameRate'], 30);
    }
    expect(
      config.containsKey('inputs'),
      isFalse,
      reason: 'No crop, pad or rotation override on the source.',
    );
    final keys = streams.map((s) => s['key']).toSet();
    final muxStreams = config['muxStreams'] as List<dynamic>;
    for (final mux in muxStreams) {
      expect(mux['container'], 'ts');
      expect(mux['elementaryStreams'], everyElement(isIn(keys)));
    }
    final manifest = (config['manifests'] as List<dynamic>).single;
    expect(manifest['type'], 'HLS');
    expect(manifest['muxStreams'], muxStreams.map((s) => s['key']).toList());
    expect(
      '${TranscodeRetryPolicy.outputPrefix(15, 0)}${manifest['fileName']}',
      TranscodeRetryPolicy.manifestKey(15, 0),
    );
  });
}
