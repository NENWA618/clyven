import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../subtitle_editor_utils.dart';
import 'subtitle_cue_row.dart';

class SubtitleCueList extends StatefulComponent {
  const SubtitleCueList({
    required this.cues,
    required this.selectedCueId,
    required this.activeCueId,
    required this.editedTexts,
    required this.editedStartTimes,
    required this.editedEndTimes,
    required this.savingCueIds,
    required this.savingTimingCueIds,
    required this.deletingCueIds,
    required this.saveErrors,
    required this.timingErrors,
    required this.deleteErrors,
    required this.onRowClick,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onSaveTiming,
    required this.onTextChanged,
    required this.onSaveText,
    required this.onDelete,
    super.key,
  });

  final List<SubtitleCueDetail> cues;

  final int? selectedCueId;
  final int? activeCueId;

  final Map<int, String> editedTexts;
  final Map<int, String> editedStartTimes;
  final Map<int, String> editedEndTimes;

  final Set<int> savingCueIds;
  final Set<int> savingTimingCueIds;
  final Set<int> deletingCueIds;

  final Map<int, String> saveErrors;
  final Map<int, String> timingErrors;
  final Map<int, String> deleteErrors;

  final void Function(SubtitleCueDetail detail) onRowClick;

  final void Function(int cueId, String value) onStartChanged;

  final void Function(int cueId, String value) onEndChanged;

  final void Function(SubtitleCueDetail detail) onSaveTiming;

  final void Function(int cueId, String value) onTextChanged;

  final void Function(SubtitleCueDetail detail) onSaveText;

  final void Function(SubtitleCueDetail detail) onDelete;

  @override
  State<SubtitleCueList> createState() => _SubtitleCueListState();
}

class _SubtitleCueListState extends State<SubtitleCueList> {
  static const int _pageSize = 50;

  int _visibleCount = _pageSize;

  @override
  Component build(BuildContext context) {
    if (component.cues.isEmpty) {
      return div(classes: 'empty-state', [.text('这个视频目前没有该语言的字幕。')]);
    }

    final visibleCount = _visibleCount > component.cues.length
        ? component.cues.length
        : _visibleCount;

    final remaining = component.cues.length - visibleCount;

    return div(classes: 'subtitle-editor-main', [
      div(classes: 'subtitle-editor-list-header', [
        span([.text('Timeline')]),
        span([.text('Subtitle')]),
      ]),

      for (var index = 0; index < visibleCount; index++) _buildRow(index),

      if (remaining > 0)
        div(classes: 'subtitle-cue-load-more', [
          button(
            type: ButtonType.button,
            classes: 'subtitle-cue-load-more-button',
            onClick: () {
              final nextCount = _visibleCount + _pageSize;

              setState(() {
                _visibleCount = nextCount > component.cues.length
                    ? component.cues.length
                    : nextCount;
              });
            },
            [.text('加载更多 · 剩余 $remaining 条')],
          ),
        ]),
    ]);
  }

  Component _buildRow(int index) {
    final detail = component.cues[index];
    final cueId = detail.cue.id;

    return SubtitleCueRow(
      number: index + 1,
      detail: detail,
      selected: component.selectedCueId == cueId,
      active: component.activeCueId == cueId,
      startText: cueId == null
          ? formatSubtitleTime(detail.cue.startMs)
          : component.editedStartTimes[cueId] ??
                formatSubtitleTime(detail.cue.startMs),
      endText: cueId == null
          ? formatSubtitleTime(detail.cue.endMs)
          : component.editedEndTimes[cueId] ??
                formatSubtitleTime(detail.cue.endMs),
      text: cueId == null
          ? detail.cue.text
          : component.editedTexts[cueId] ?? detail.cue.text,
      savingTiming:
          cueId != null && component.savingTimingCueIds.contains(cueId),
      savingText: cueId != null && component.savingCueIds.contains(cueId),
      deleting: cueId != null && component.deletingCueIds.contains(cueId),
      timingError: cueId == null ? null : component.timingErrors[cueId],
      saveError: cueId == null ? null : component.saveErrors[cueId],
      deleteError: cueId == null ? null : component.deleteErrors[cueId],
      onRowClick: () {
        component.onRowClick(detail);
      },
      onStartChanged: (value) {
        if (cueId != null) {
          component.onStartChanged(cueId, value);
        }
      },
      onEndChanged: (value) {
        if (cueId != null) {
          component.onEndChanged(cueId, value);
        }
      },
      onSaveTiming: () {
        component.onSaveTiming(detail);
      },
      onTextChanged: (value) {
        if (cueId != null) {
          component.onTextChanged(cueId, value);
        }
      },
      onSaveText: () {
        component.onSaveText(detail);
      },
      onDelete: () {
        component.onDelete(detail);
      },
    );
  }
}
