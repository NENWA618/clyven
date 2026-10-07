import 'package:glyphora_studio/services/upload_hardening.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('videoFileExtension', () {
    test('normalizes uppercase extensions', () {
      expect(videoFileExtension('lesson.MP4'), 'mp4');
    });

    test('returns empty string when there is no extension', () {
      expect(videoFileExtension('lesson'), '');
    });

    test('sanitizes unusual extension characters', () {
      expect(videoFileExtension('lesson.MP4!?'), 'mp4');
    });
  });

  group('validateVideoMetadata', () {
    test('accepts a valid mp4', () {
      expect(
        () => validateVideoMetadata(
          fileName: 'lesson.mp4',
          fileSize: 1024,
          durationSeconds: 12.5,
          coverBytes: const [1, 2, 3],
        ),
        returnsNormally,
      );
    });

    test('rejects an empty file', () {
      expect(
        () => validateVideoMetadata(
          fileName: 'lesson.mp4',
          fileSize: 0,
          durationSeconds: 12.5,
          coverBytes: const [1],
        ),
        throwsA(predicate((e) => e.toString().contains('The video file is empty'))),
      );
    });

    test('rejects an unsupported extension', () {
      expect(
        () => validateVideoMetadata(
          fileName: 'lesson.txt',
          fileSize: 1024,
          durationSeconds: 12.5,
          coverBytes: const [1],
        ),
        throwsA(predicate((e) => e.toString().contains('Unsupported video format'))),
      );
    });

    test('rejects unreadable duration', () {
      expect(
        () => validateVideoMetadata(
          fileName: 'lesson.mp4',
          fileSize: 1024,
          durationSeconds: 0,
          coverBytes: const [1],
        ),
        throwsA(predicate((e) => e.toString().contains('Could not read the video duration'))),
      );
    });

    test('rejects empty cover', () {
      expect(
        () => validateVideoMetadata(
          fileName: 'lesson.mp4',
          fileSize: 1024,
          durationSeconds: 12.5,
          coverBytes: const [],
        ),
        throwsA(predicate((e) => e.toString().contains('Could not generate a cover'))),
      );
    });
  });

  group('retryAsync', () {
    test('first attempt success does not retry', () async {
      final attempts = <int>[];

      final value = await retryAsync<int>(
        action: (attempt) async {
          attempts.add(attempt);
          return 42;
        },
        delay: (_) async {},
      );

      expect(value, 42);
      expect(attempts, [1]);
    });

    test('uses 2s then 4s backoff and succeeds on third attempt', () async {
      final attempts = <int>[];
      final delays = <Duration>[];

      final value = await retryAsync<String>(
        action: (attempt) async {
          attempts.add(attempt);
          if (attempt < 3) throw StateError('temporary');
          return 'ok';
        },
        delay: (duration) async => delays.add(duration),
      );

      expect(value, 'ok');
      expect(attempts, [1, 2, 3]);
      expect(
        delays,
        const [Duration(seconds: 2), Duration(seconds: 4)],
      );
    });

    test('throws after maximum attempts', () async {
      var calls = 0;

      await expectLater(
        retryAsync<void>(
          attempts: 3,
          action: (_) async {
            calls++;
            throw StateError('still failing');
          },
          delay: (_) async {},
        ),
        throwsA(
          isA<StateError>().having((e) => e.message, 'message', 'still failing'),
        ),
      );

      expect(calls, 3);
    });

    test('reports callbacks', () async {
      final started = <int>[];
      final retried = <int>[];

      await retryAsync<void>(
        action: (attempt) async {
          if (attempt == 1) throw StateError('temporary');
        },
        delay: (_) async {},
        onAttempt: started.add,
        onRetry: (attempt, _) => retried.add(attempt),
      );

      expect(started, [1, 2]);
      expect(retried, [1]);
    });
  });
}
