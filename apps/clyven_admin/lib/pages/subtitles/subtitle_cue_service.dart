import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleCueService {
  SubtitleCueService({
    required this.client,
    this.scriptCode,
    this.onDraftChanged,
  });

  final Client client;
  final String? scriptCode;
  final void Function()? onDraftChanged;

  Future<SubtitleCue> updateText({
    required int cueId,
    required String text,
  }) async {
    final updated = await client.subtitle.updateCueText(
      cueId: cueId,
      text: text,
      scriptCode: scriptCode,
    );
    onDraftChanged?.call();

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
  }) async {
    final updated = await client.subtitle.updateCueTiming(
      cueId: cueId,
      startMs: startMs,
      endMs: endMs,
    );

    onDraftChanged?.call();
    return updated;
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
    onDraftChanged?.call();
  }

  Future<void> delete({required int cueId}) async {
    await client.subtitle.deleteCue(cueId: cueId);
    onDraftChanged?.call();
  }

  Future<List<SubtitleKaraokeSegment>> replaceKaraokeSegments({
    required int cueId,
    required List<SubtitleKaraokeSegmentInput> segments,
  }) async {
    final saved = await client.subtitle.replaceKaraokeSegments(
      cueId: cueId,
      segments: segments,
      scriptCode: scriptCode,
    );

    onDraftChanged?.call();
    return saved;
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
      final legacyText = detail.cue.text;
      final texts = detail.texts;

      SubtitleCueText? exactText;

      if (texts != null) {
        for (final text in texts) {
          if (text.scriptCode == selectedScript) {
            exactText = text;
            break;
          }
        }
      }

      if (exactText != null) {
        detail.cue.text = exactText.text;
        continue;
      }

      // Backward compatibility: old subtitle rows may only have
      // SubtitleCue.text and no SubtitleCueText records at all.
      // In that case legacyText is the only representation we have.
      if (texts == null || texts.isEmpty) {
        detail.cue.text = legacyText;
        continue;
      }

      // Older subtitle data can have the selected script only in cue.text
      // even when other script rows already exist. Exact script rows still win,
      // but never blank a real legacy subtitle in Studio.
      detail.cue.text = legacyText;
    }

    return details;
  }

  Future<SubtitlePublishStatus> getPublishStatus({
    required int videoId,
    required String languageCode,
  }) {
    return client.subtitle.getSubtitlePublishStatus(
      videoId: videoId,
      languageCode: languageCode,
    );
  }

  Future<SubtitlePublishStatus> publish({
    required int videoId,
    required String languageCode,
  }) {
    return client.subtitle.publishSubtitleTrack(
      videoId: videoId,
      languageCode: languageCode,
    );
  }
}
