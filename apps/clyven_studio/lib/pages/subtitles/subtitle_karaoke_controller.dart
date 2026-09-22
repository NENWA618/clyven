import 'package:clyven_backend_client/clyven_backend_client.dart';

import 'subtitle_cue_service.dart';
import 'subtitle_editor_utils.dart';

class KaraokeSegmentDraft {
  KaraokeSegmentDraft({
    required this.text,
    required this.startTime,
    required this.endTime,
  });

  String text;
  String startTime;
  String endTime;
}

class SubtitleKaraokeController {
  SubtitleKaraokeController({
    required this.service,
    required this.isLoggedIn,
    required this.onChanged,
  });

  final SubtitleCueService service;
  final bool Function() isLoggedIn;
  final void Function() onChanged;

  final Map<int, List<KaraokeSegmentDraft>> draftsByCueId = {};
  final Set<int> hydratedCueIds = {};
  final Set<int> savingCueIds = {};
  final Map<int, String> errors = {};

  List<KaraokeSegmentDraft> draftsFor(
    SubtitleCueDetail detail,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return const [];
    }

    if (!hydratedCueIds.contains(cueId)) {
      final serverSegments =
          List<SubtitleKaraokeSegment>.from(
            detail.karaokeSegments ?? const <SubtitleKaraokeSegment>[],
          )..sort(
            (a, b) => a.position.compareTo(b.position),
          );

      draftsByCueId[cueId] = [
        for (final segment in serverSegments)
          KaraokeSegmentDraft(
            text: segment.text,
            startTime: formatSubtitleTime(
              segment.startOffsetMs,
            ),
            endTime: formatSubtitleTime(
              segment.endOffsetMs,
            ),
          ),
      ];

      hydratedCueIds.add(cueId);
    }

    return draftsByCueId[cueId] ?? const [];
  }

  void initializeFromSubtitle(
    SubtitleCueDetail detail,
    String sourceText,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final durationMs = detail.cue.endMs - detail.cue.startMs;

    if (durationMs <= 0) {
      errors[cueId] = '当前字幕时长无效';
      onChanged();
      return;
    }

    final source = sourceText.trim();

    if (source.isEmpty) {
      errors[cueId] = '当前 script 没有字幕文字';
      draftsByCueId[cueId] = <KaraokeSegmentDraft>[];
      hydratedCueIds.add(cueId);
      onChanged();
      return;
    }

    final pieces = _piecesFromSource(
      detail,
      source,
    );

    if (pieces.isEmpty) {
      errors[cueId] = '无法从当前字幕生成 Karaoke 片段';
      onChanged();
      return;
    }

    final drafts = <KaraokeSegmentDraft>[];

    for (var index = 0; index < pieces.length; index++) {
      final startMs = (durationMs * index / pieces.length).round();
      final endMs = (durationMs * (index + 1) / pieces.length).round();

      drafts.add(
        KaraokeSegmentDraft(
          text: pieces[index],
          startTime: formatSubtitleTime(startMs),
          endTime: formatSubtitleTime(endMs),
        ),
      );
    }

    draftsByCueId[cueId] = drafts;
    hydratedCueIds.add(cueId);
    errors.remove(cueId);
    onChanged();
  }

  List<String> _piecesFromSource(
    SubtitleCueDetail detail,
    String source,
  ) {
    final tokens = [...detail.tokens]
      ..sort(
        (a, b) => a.position.compareTo(b.position),
      );

    if (tokens.isNotEmpty) {
      final pieces = <String>[];
      var cursor = 0;
      var matched = true;

      for (final token in tokens) {
        final tokenText = token.text;

        if (tokenText.isEmpty) {
          continue;
        }

        final index = source.indexOf(
          tokenText,
          cursor,
        );

        if (index < 0) {
          matched = false;
          break;
        }

        final end = index + tokenText.length;

        pieces.add(
          source.substring(cursor, end),
        );

        cursor = end;
      }

      if (matched && pieces.isNotEmpty) {
        if (cursor < source.length) {
          pieces[pieces.length - 1] = '${pieces.last}${source.substring(cursor)}';
        }

        return pieces.where((item) => item.isNotEmpty).toList();
      }
    }

    return _fallbackPieces(source);
  }

  List<String> _fallbackPieces(String source) {
    final wordLikeMatches = RegExp(r'\S+\s*').allMatches(source).toList();

    if (wordLikeMatches.length > 1) {
      return [
        for (final match in wordLikeMatches)
          if ((match.group(0) ?? '').isNotEmpty) match.group(0)!,
      ];
    }

    return [
      for (final rune in source.runes) String.fromCharCode(rune),
    ];
  }

  void addSegment(
    SubtitleCueDetail detail,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final drafts = draftsFor(detail);
    final durationMs = detail.cue.endMs - detail.cue.startMs;

    var startMs = 0;

    if (drafts.isNotEmpty) {
      startMs = parseSubtitleTime(drafts.last.endTime) ?? 0;
    }

    if (startMs >= durationMs) {
      errors[cueId] = '没有剩余时间，请先缩短上一片段';
      onChanged();
      return;
    }

    final candidateEnd = startMs + 1000;
    final endMs = candidateEnd > durationMs ? durationMs : candidateEnd;

    drafts.add(
      KaraokeSegmentDraft(
        text: '',
        startTime: formatSubtitleTime(startMs),
        endTime: formatSubtitleTime(endMs),
      ),
    );

    errors.remove(cueId);
    onChanged();
  }

  void removeSegment(
    SubtitleCueDetail detail,
    int index,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final drafts = draftsFor(detail);

    if (index < 0 || index >= drafts.length) {
      return;
    }

    drafts.removeAt(index);
    errors.remove(cueId);
    onChanged();
  }

  void clear(
    SubtitleCueDetail detail,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    draftsByCueId[cueId] = <KaraokeSegmentDraft>[];

    hydratedCueIds.add(cueId);
    errors.remove(cueId);
    onChanged();
  }

  void updateText(
    SubtitleCueDetail detail,
    int index,
    String value,
  ) {
    _updateDraft(
      detail,
      index,
      (draft) {
        draft.text = value;
      },
    );
  }

  void updateStart(
    SubtitleCueDetail detail,
    int index,
    String value,
  ) {
    _updateDraft(
      detail,
      index,
      (draft) {
        draft.startTime = value;
      },
    );
  }

  void updateEnd(
    SubtitleCueDetail detail,
    int index,
    String value,
  ) {
    _updateDraft(
      detail,
      index,
      (draft) {
        draft.endTime = value;
      },
    );
  }

  void _updateDraft(
    SubtitleCueDetail detail,
    int index,
    void Function(KaraokeSegmentDraft draft) update,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final drafts = draftsFor(detail);

    if (index < 0 || index >= drafts.length) {
      return;
    }

    update(drafts[index]);
    errors.remove(cueId);
    onChanged();
  }

  void useCurrentTimeAsStart(
    SubtitleCueDetail detail,
    int index,
    int absoluteVideoMs,
  ) {
    final relativeMs = _relativeTime(
      detail,
      absoluteVideoMs,
    );

    updateStart(
      detail,
      index,
      formatSubtitleTime(relativeMs),
    );
  }

  void useCurrentTimeAsEnd(
    SubtitleCueDetail detail,
    int index,
    int absoluteVideoMs,
  ) {
    final relativeMs = _relativeTime(
      detail,
      absoluteVideoMs,
    );

    updateEnd(
      detail,
      index,
      formatSubtitleTime(relativeMs),
    );
  }

  int _relativeTime(
    SubtitleCueDetail detail,
    int absoluteVideoMs,
  ) {
    final durationMs = detail.cue.endMs - detail.cue.startMs;

    return (absoluteVideoMs - detail.cue.startMs).clamp(0, durationMs).toInt();
  }

  Future<void> save(
    SubtitleCueDetail detail,
  ) async {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    if (!isLoggedIn()) {
      errors[cueId] = '请先登录 Studio';
      onChanged();
      return;
    }

    final drafts = draftsFor(detail);
    final durationMs = detail.cue.endMs - detail.cue.startMs;

    final inputs = <SubtitleKaraokeSegmentInput>[];

    var previousEndMs = 0;

    for (var index = 0; index < drafts.length; index++) {
      final draft = drafts[index];
      final startMs = parseSubtitleTime(draft.startTime);
      final endMs = parseSubtitleTime(draft.endTime);

      if (draft.text.trim().isEmpty) {
        errors[cueId] = '第 ${index + 1} 段文字不能为空';
        onChanged();
        return;
      }

      if (startMs == null || endMs == null) {
        errors[cueId] = '第 ${index + 1} 段时间格式必须是 mm:ss.mmm';
        onChanged();
        return;
      }

      if (startMs < 0 || endMs <= startMs) {
        errors[cueId] = '第 ${index + 1} 段结束时间必须大于开始时间';
        onChanged();
        return;
      }

      if (endMs > durationMs) {
        errors[cueId] = '第 ${index + 1} 段超出字幕时长';
        onChanged();
        return;
      }

      if (startMs < previousEndMs) {
        errors[cueId] = '第 ${index + 1} 段与前一段重叠';
        onChanged();
        return;
      }

      inputs.add(
        SubtitleKaraokeSegmentInput(
          startOffsetMs: startMs,
          endOffsetMs: endMs,
          text: draft.text,
        ),
      );

      previousEndMs = endMs;
    }

    savingCueIds.add(cueId);
    errors.remove(cueId);
    onChanged();

    try {
      final saved = await service.replaceKaraokeSegments(
        cueId: cueId,
        segments: inputs,
      );

      detail.karaokeSegments = saved;

      draftsByCueId[cueId] = [
        for (final segment in saved)
          KaraokeSegmentDraft(
            text: segment.text,
            startTime: formatSubtitleTime(
              segment.startOffsetMs,
            ),
            endTime: formatSubtitleTime(
              segment.endOffsetMs,
            ),
          ),
      ];

      hydratedCueIds.add(cueId);
      savingCueIds.remove(cueId);
      onChanged();
    } catch (e) {
      savingCueIds.remove(cueId);
      errors[cueId] = e.toString();
      onChanged();
    }
  }
}
