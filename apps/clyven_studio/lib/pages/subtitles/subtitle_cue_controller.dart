import 'package:clyven_backend_client/clyven_backend_client.dart';

import 'subtitle_cue_service.dart';
import 'subtitle_editor_utils.dart';

class SubtitleCueController {
  SubtitleCueController({
    required this.service,
    required this.getCues,
    required this.isLoggedIn,
    required this.onChanged,
  });

  final SubtitleCueService service;
  final List<SubtitleCueDetail> Function() getCues;
  final bool Function() isLoggedIn;
  final void Function() onChanged;

  final Map<int, String> editedTexts = {};
  final Set<int> savingCueIds = {};
  final Map<int, String> saveErrors = {};

  final Map<int, String> editedStartTimes = {};
  final Map<int, String> editedEndTimes = {};

  final Set<int> savingTimingCueIds = {};
  final Map<int, String> timingErrors = {};
  final Set<int> deletingCueIds = {};
  final Map<int, String> deleteErrors = {};

  String newCueStart = '00:00.000';
  String newCueEnd = '00:03.000';
  String newCueText = '';

  bool creatingCue = false;
  String? createCueError;

  Future<void> saveCue(
    SubtitleCueDetail detail,
  ) async {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    if (!isLoggedIn()) {
      saveErrors[cueId] = '请先登录 Studio';
      onChanged();
      return;
    }

    final text = editedTexts[cueId] ?? detail.cue.text;

    savingCueIds.add(cueId);
    saveErrors.remove(cueId);
    onChanged();

    try {
      final updated = await service.updateText(
        cueId: cueId,
        text: text,
      );

      detail.cue.text = updated.text;

      editedTexts.remove(cueId);
      savingCueIds.remove(cueId);

      onChanged();
    } catch (e) {
      savingCueIds.remove(cueId);
      saveErrors[cueId] = e.toString();

      onChanged();
    }
  }

  Future<void> saveTiming(
    SubtitleCueDetail detail,
  ) async {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    if (!isLoggedIn()) {
      timingErrors[cueId] = '请先登录 Studio';
      onChanged();
      return;
    }

    final startText =
        editedStartTimes[cueId] ??
        formatSubtitleTime(
          detail.cue.startMs,
        );

    final endText =
        editedEndTimes[cueId] ??
        formatSubtitleTime(
          detail.cue.endMs,
        );

    final startMs = parseSubtitleTime(startText);

    final endMs = parseSubtitleTime(endText);

    if (startMs == null || endMs == null) {
      timingErrors[cueId] = '时间格式必须是 mm:ss.mmm';

      onChanged();
      return;
    }

    if (endMs <= startMs) {
      timingErrors[cueId] = '结束时间必须大于开始时间';

      onChanged();
      return;
    }

    final cues = getCues();

    final overlappingCue = findOverlappingCue(
      cues: cues,
      startMs: startMs,
      endMs: endMs,
      excludeCueId: cueId,
    );

    if (overlappingCue != null) {
      final number = cues.indexOf(overlappingCue) + 1;

      timingErrors[cueId] = '与第 $number 条字幕时间重叠';

      onChanged();
      return;
    }

    savingTimingCueIds.add(cueId);
    timingErrors.remove(cueId);
    onChanged();

    try {
      final updated = await service.updateTiming(
        cueId: cueId,
        startMs: startMs,
        endMs: endMs,
      );

      detail.cue.startMs = updated.startMs;
      detail.cue.endMs = updated.endMs;

      editedStartTimes.remove(cueId);
      editedEndTimes.remove(cueId);

      savingTimingCueIds.remove(cueId);

      onChanged();
    } catch (e) {
      savingTimingCueIds.remove(cueId);
      timingErrors[cueId] = e.toString();

      onChanged();
    }
  }

  Future<void> deleteCue({
  required SubtitleCueDetail detail,
  required int videoId,
  required String languageCode,
}) async {
  final cueId = detail.cue.id;

  if (cueId == null) {
    return;
  }

  if (!isLoggedIn()) {
    deleteErrors[cueId] = '请先登录 Studio';
    onChanged();
    return;
  }

  deletingCueIds.add(cueId);
  deleteErrors.remove(cueId);
  onChanged();

  try {
    await service.delete(
      cueId: cueId,
    );

    final refreshed = await service.loadCues(
      videoId: videoId,
      languageCode: languageCode,
    );

    final cues = getCues();

    cues
      ..clear()
      ..addAll(refreshed);

    deletingCueIds.remove(cueId);

    editedTexts.remove(cueId);
    editedStartTimes.remove(cueId);
    editedEndTimes.remove(cueId);

    saveErrors.remove(cueId);
    timingErrors.remove(cueId);
    deleteErrors.remove(cueId);

    onChanged();
  } catch (e) {
    deletingCueIds.remove(cueId);
    deleteErrors[cueId] = e.toString();

    onChanged();
  }
}

Future<void> createCue({
  required int videoId,
  required String languageCode,
}) async {
  if (!isLoggedIn()) {
    createCueError = '请先登录 Studio';
    onChanged();
    return;
  }

  final startMs = parseSubtitleTime(newCueStart);
  final endMs = parseSubtitleTime(newCueEnd);

  if (startMs == null || endMs == null) {
    createCueError = '时间格式必须是 mm:ss.mmm';
    onChanged();
    return;
  }

  if (endMs <= startMs) {
    createCueError = '结束时间必须大于开始时间';
    onChanged();
    return;
  }

  final cues = getCues();

  final overlappingCue = findOverlappingCue(
    cues: cues,
    startMs: startMs,
    endMs: endMs,
  );

  if (overlappingCue != null) {
    final number = cues.indexOf(overlappingCue) + 1;

    createCueError = '与第 $number 条字幕时间重叠';
    onChanged();
    return;
  }

  if (newCueText.trim().isEmpty) {
    createCueError = '字幕内容不能为空';
    onChanged();
    return;
  }

  creatingCue = true;
  createCueError = null;
  onChanged();

  try {
    await service.create(
      videoId: videoId,
      languageCode: languageCode,
      startMs: startMs,
      endMs: endMs,
      text: newCueText.trim(),
    );

    final refreshed = await service.loadCues(
      videoId: videoId,
      languageCode: languageCode,
    );

    cues
      ..clear()
      ..addAll(refreshed);

    newCueText = '';
    creatingCue = false;

    onChanged();
  } catch (e) {
    creatingCue = false;
    createCueError = e.toString();

    onChanged();
  }
}

Future<void> commitDraggedCueTiming({
  required SubtitleCueDetail detail,
  required int cueId,
  required int originalStart,
  required int originalEnd,
  required int newStart,
  required int newEnd,
}) async {
  final cues = getCues();

  final overlappingCue = findOverlappingCue(
    cues: cues,
    startMs: newStart,
    endMs: newEnd,
    excludeCueId: cueId,
  );

  if (overlappingCue != null) {
    final number = cues.indexOf(overlappingCue) + 1;

    detail.cue.startMs = originalStart;
    detail.cue.endMs = originalEnd;
    timingErrors[cueId] = '与第 $number 条字幕时间重叠';

    onChanged();
    return;
  }

  savingTimingCueIds.add(cueId);
  timingErrors.remove(cueId);
  onChanged();

  try {
    final updated = await service.updateTiming(
      cueId: cueId,
      startMs: newStart,
      endMs: newEnd,
    );

    detail.cue.startMs = updated.startMs;
    detail.cue.endMs = updated.endMs;

    editedStartTimes.remove(cueId);
    editedEndTimes.remove(cueId);

    savingTimingCueIds.remove(cueId);

    onChanged();
  } catch (e) {
    detail.cue.startMs = originalStart;
    detail.cue.endMs = originalEnd;

    savingTimingCueIds.remove(cueId);
    timingErrors[cueId] = e.toString();

    onChanged();
  }
}

Future<void> nudgeCue({
  required int cueId,
  required int deltaMs,
  required int durationMs,
}) async {
  SubtitleCueDetail? detail;

  for (final item in getCues()) {
    if (item.cue.id == cueId) {
      detail = item;
      break;
    }
  }

  if (detail == null || durationMs <= 0) {
    return;
  }

  final cueDuration =
      detail.cue.endMs - detail.cue.startMs;

  final newStart = (detail.cue.startMs + deltaMs)
      .clamp(
        0,
        durationMs - cueDuration,
      )
      .toInt();

  final newEnd = newStart + cueDuration;

  final overlappingCue = findOverlappingCue(
    cues: getCues(),
    startMs: newStart,
    endMs: newEnd,
    excludeCueId: cueId,
  );

  if (overlappingCue != null) {
    return;
  }

  final oldStart = detail.cue.startMs;
  final oldEnd = detail.cue.endMs;

  detail.cue.startMs = newStart;
  detail.cue.endMs = newEnd;

  savingTimingCueIds.add(cueId);
  onChanged();

  try {
    final updated = await service.updateTiming(
      cueId: cueId,
      startMs: newStart,
      endMs: newEnd,
    );

    detail.cue.startMs = updated.startMs;
    detail.cue.endMs = updated.endMs;

    editedStartTimes.remove(cueId);
    editedEndTimes.remove(cueId);

    savingTimingCueIds.remove(cueId);

    onChanged();
  } catch (e) {
    detail.cue.startMs = oldStart;
    detail.cue.endMs = oldEnd;

    savingTimingCueIds.remove(cueId);
    timingErrors[cueId] = e.toString();

    onChanged();
  }
}

void useCurrentTimeAsStart(int milliseconds) {
  newCueStart = formatSubtitleTime(milliseconds);
  createCueError = null;
  onChanged();
}

void useCurrentTimeAsEnd(int milliseconds) {
  newCueEnd = formatSubtitleTime(milliseconds);
  createCueError = null;
  onChanged();
}
}
