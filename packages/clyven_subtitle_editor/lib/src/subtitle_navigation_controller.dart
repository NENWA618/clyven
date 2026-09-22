import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleNavigationController {
  SubtitleNavigationController({
    required this.getCues,
    required this.getSelectedCueId,
    required this.getCurrentVideoTimeMs,
    required this.onSelectCue,
    required this.onSeek,
  });

  final List<SubtitleCueDetail> Function() getCues;
  final int? Function() getSelectedCueId;
  final int Function() getCurrentVideoTimeMs;

  final void Function(int cueId) onSelectCue;
  final void Function(int milliseconds) onSeek;

  void jumpToAdjacentCue(int direction) {
    final cues = getCues();

    if (cues.isEmpty) {
      return;
    }

    var currentIndex = -1;

    final selectedCueId = getSelectedCueId();

    if (selectedCueId != null) {
      currentIndex = cues.indexWhere(
        (detail) => detail.cue.id == selectedCueId,
      );
    }

    if (currentIndex == -1) {
      final currentVideoTimeMs = getCurrentVideoTimeMs();

      for (var index = 0; index < cues.length; index++) {
        if (currentVideoTimeMs < cues[index].cue.startMs) {
          currentIndex = direction > 0 ? index - 1 : index;
          break;
        }
      }
    }

    if (currentIndex == -1) {
      currentIndex = direction > 0 ? -1 : cues.length;
    }

    final targetIndex = (currentIndex + direction)
        .clamp(0, cues.length - 1)
        .toInt();

    final detail = cues[targetIndex];
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    onSelectCue(cueId);
    onSeek(detail.cue.startMs);

    _scrollCueRowIntoView(cueId);
  }

  void _scrollCueRowIntoView(int cueId) {
    final element = html.document.getElementById('subtitle-row-$cueId');

    if (element == null) {
      return;
    }

    element.scrollIntoView();
  }
}
