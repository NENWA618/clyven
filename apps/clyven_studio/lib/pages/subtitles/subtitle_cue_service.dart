import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleCueService {
  SubtitleCueService({
    required this.client,
    this.scriptCode,
  });

  final Client client;
  final String? scriptCode;

  Future<SubtitleCue> updateText({
    required int cueId,
    required String text,
  }) async {
    final updated = await client.subtitle.updateCueText(
      cueId: cueId,
      text: text,
      scriptCode: scriptCode,
    );

    // For a non-primary script the server correctly keeps cue.text as the
    // primary fallback. The editor, however, is editing the selected script,
    // so keep the local row on the text the user just saved.
    if (scriptCode != null) {
      updated.text = text;
    }

    return updated;
  }

  Future<SubtitleCue> updateTiming({
    required int cueId,
    required int startMs,
    required int endMs,
  }) {
    return client.subtitle.updateCueTiming(
      cueId: cueId,
      startMs: startMs,
      endMs: endMs,
    );
  }

  Future<void> create({
    required int videoId,
    required String languageCode,
    required int startMs,
    required int endMs,
    required String text,
  }) async {
    await client.subtitle.createCue(
      videoId: videoId,
      languageCode: languageCode,
      startMs: startMs,
      endMs: endMs,
      text: text,
      scriptCode: scriptCode,
    );
  }

  Future<void> delete({
    required int cueId,
  }) async {
    await client.subtitle.deleteCue(cueId: cueId);
  }

  Future<List<SubtitleCueDetail>> loadCues({
    required int videoId,
    required String languageCode,
  }) async {
    final details = await client.subtitle.getCueDetails(
      videoId: videoId,
      languageCode: languageCode,
      scriptCode: scriptCode,
    );

    final selectedScript = scriptCode;
    if (selectedScript == null) return details;

    // Existing cue widgets read detail.cue.text. Project the selected script
    // representation into that local display field while keeping the server
    // model unchanged.
    for (final detail in details) {
      // Once a concrete script is selected, never fall back to the
      // primary cue text from another script.
      detail.cue.text = '';

      final texts = detail.texts;
      if (texts == null) {
        continue;
      }

      for (final text in texts) {
        if (text.scriptCode == selectedScript) {
          detail.cue.text = text.text;
          break;
        }
      }
    }

    return details;
  }
}
