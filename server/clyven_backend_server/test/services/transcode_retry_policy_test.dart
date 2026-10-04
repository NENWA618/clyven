import 'package:clyven_backend_server/src/services/transcode_retry_policy.dart';
import 'package:test/test.dart';

void main() {
  group('TranscodeRetryPolicy', () {
    test('new transcodes use current media version v2', () {
      expect(TranscodeRetryPolicy.currentMediaVersion, 2);
      expect(
        TranscodeRetryPolicy.manifestKey(15, 0),
        'transcoded/15/v2/manifest.m3u8',
      );
      expect(
        TranscodeRetryPolicy.outputPrefix(15, 0),
        'transcoded/15/v2/',
      );
    });

    test('retries stay inside the selected media version', () {
      expect(
        TranscodeRetryPolicy.manifestKey(15, 2, mediaVersion: 1),
        'transcoded/15/v1/retry-2/manifest.m3u8',
      );
      expect(
        TranscodeRetryPolicy.outputPrefix(15, 2, mediaVersion: 1),
        'transcoded/15/v1/retry-2/',
      );
      expect(
        TranscodeRetryPolicy.manifestKey(15, 2, mediaVersion: 2),
        'transcoded/15/v2/retry-2/manifest.m3u8',
      );
    });

    test('detects persisted media version from manifest key', () {
      expect(
        TranscodeRetryPolicy.mediaVersionFromManifestKey(
          'transcoded/15/v1/manifest.m3u8',
        ),
        1,
      );
      expect(
        TranscodeRetryPolicy.mediaVersionFromManifestKey(
          'transcoded/15/v2/retry-1/manifest.m3u8',
        ),
        2,
      );
      expect(
        TranscodeRetryPolicy.mediaVersionFromManifestKey(null),
        2,
      );
    });

    test('encodes and parses retry job names', () {
      const raw = 'projects/p/locations/l/jobs/abc';
      final encoded = TranscodeRetryPolicy.encodeJobName(3, raw);

      expect(encoded, 'retry3|$raw');

      final parsed = TranscodeRetryPolicy.parseJobName(encoded);
      expect(parsed.attempt, 3);
      expect(parsed.rawJobName, raw);
    });

    test('treats a normal job name as attempt zero', () {
      const raw = 'projects/p/locations/l/jobs/abc';
      final parsed = TranscodeRetryPolicy.parseJobName(raw);

      expect(parsed.attempt, 0);
      expect(parsed.rawJobName, raw);
    });

    test('allows retries up to retry 3 and then stops', () {
      expect(TranscodeRetryPolicy.maxRetryAttempts, 3);
      expect(TranscodeRetryPolicy.canRetry(0), isTrue);
      expect(TranscodeRetryPolicy.canRetry(1), isTrue);
      expect(TranscodeRetryPolicy.canRetry(2), isTrue);
      expect(TranscodeRetryPolicy.canRetry(3), isFalse);
    });
  });
}
