import 'dart:io';

/// Test-only, process-local, one-shot failure injection for deletion retries.
///
/// Requires an explicit staging environment AND exact target video ID. There
/// is no public endpoint and no production default. Restart clears the latch.
class VideoDeletionFaultInjection {
  static final Set<String> _consumed = <String>{};

  static bool shouldFail({
    required int videoId,
    required String step,
    required Map<String, String> environment,
    required Set<String> consumed,
  }) {
    if (environment['GLYPHORA_STAGING'] != 'true' ||
        environment['GLYPHORA_REQUIRE_CLOUDFLARE'] != 'true' ||
        environment['GLYPHORA_DELETE_FAULT_ENABLE'] != 'true') {
      return false;
    }
    final targetId = int.tryParse(
      environment['GLYPHORA_DELETE_FAULT_VIDEO_ID'] ?? '',
    );
    if (targetId == null || targetId != videoId) return false;

    const allowed = {'before_stream', 'after_stream', 'after_r2'};
    final configured = environment['GLYPHORA_DELETE_FAULT_STEP'];
    if (!allowed.contains(configured) || configured != step) return false;

    final key = '$videoId:$step';
    if (consumed.contains(key)) return false;
    consumed.add(key);
    return true;
  }

  static void check({required int videoId, required String step}) {
    if (shouldFail(
      videoId: videoId,
      step: step,
      environment: Platform.environment,
      consumed: _consumed,
    )) {
      throw StateError(
        'STAGING_DELETE_FAULT_INJECTED videoId=$videoId step=$step',
      );
    }
  }
}
