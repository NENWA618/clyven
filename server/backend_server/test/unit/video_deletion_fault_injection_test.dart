import 'package:glyphora_backend_server/src/services/video_deletion_fault_injection.dart';
import 'package:test/test.dart';

void main() {
  const base = <String, String>{
    'GLYPHORA_STAGING': 'true',
    'GLYPHORA_REQUIRE_CLOUDFLARE': 'true',
    'GLYPHORA_DELETE_FAULT_ENABLE': 'true',
    'GLYPHORA_DELETE_FAULT_VIDEO_ID': '42',
    'GLYPHORA_DELETE_FAULT_STEP': 'after_stream',
  };

  test('one-shot failure triggers only for selected video and step', () {
    final consumed = <String>{};
    expect(VideoDeletionFaultInjection.shouldFail(
      videoId: 42, step: 'after_stream', environment: base,
      consumed: consumed,
    ), isTrue);
    expect(VideoDeletionFaultInjection.shouldFail(
      videoId: 42, step: 'after_stream', environment: base,
      consumed: consumed,
    ), isFalse);
    expect(VideoDeletionFaultInjection.shouldFail(
      videoId: 43, step: 'after_stream', environment: base,
      consumed: consumed,
    ), isFalse);
  });

  test('never injects outside explicitly enabled staging', () {
    for (final removed in <String>[
      'GLYPHORA_STAGING',
      'GLYPHORA_REQUIRE_CLOUDFLARE',
      'GLYPHORA_DELETE_FAULT_ENABLE',
    ]) {
      final environment = Map<String, String>.from(base)..remove(removed);
      expect(VideoDeletionFaultInjection.shouldFail(
        videoId: 42, step: 'after_stream', environment: environment,
        consumed: <String>{},
      ), isFalse);
    }
  });

  test('rejects missing target id and unknown phases', () {
    expect(VideoDeletionFaultInjection.shouldFail(
      videoId: 42, step: 'after_stream',
      environment: {...base, 'GLYPHORA_DELETE_FAULT_VIDEO_ID': ''},
      consumed: <String>{},
    ), isFalse);
    expect(VideoDeletionFaultInjection.shouldFail(
      videoId: 42, step: 'unknown',
      environment: {...base, 'GLYPHORA_DELETE_FAULT_STEP': 'unknown'},
      consumed: <String>{},
    ), isFalse);
  });
}
