import 'dart:async';
import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleCueDragController {
  SubtitleCueDragController({
    required this.getDurationMs,
    required this.onSelectCue,
    required this.onPreviewChanged,
    required this.onCommitTiming,
  });

  final int Function() getDurationMs;

  final void Function(int cueId) onSelectCue;

  final void Function() onPreviewChanged;

  final Future<void> Function({
    required SubtitleCueDetail detail,
    required int cueId,
    required int originalStart,
    required int originalEnd,
    required int newStart,
    required int newEnd,
  }) onCommitTiming;

  StreamSubscription<html.MouseEvent>? _moveSubscription;
  StreamSubscription<html.MouseEvent>? _upSubscription;

  void beginResizeCue(
    SubtitleCueDetail detail, {
    required bool resizeStart,
  }) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final track = html.document.getElementById(
      'subtitle-timeline-track',
    );

    if (track == null) {
      return;
    }

    final durationMs = getDurationMs();

    if (durationMs <= 0) {
      return;
    }

    final originalStart = detail.cue.startMs;
    final originalEnd = detail.cue.endMs;

    onSelectCue(cueId);

    _cancelCurrentDrag();

    _moveSubscription = html.document.onMouseMove.listen(
      (moveEvent) {
        final rect = track.getBoundingClientRect();

        if (rect.width <= 0) {
          return;
        }

        final relativeX = (moveEvent.client.x - rect.left)
            .clamp(
              0,
              rect.width,
            )
            .toDouble();

        final targetMs =
            (relativeX / rect.width * durationMs).round();

        if (resizeStart) {
          detail.cue.startMs = targetMs
              .clamp(
                0,
                detail.cue.endMs - 100,
              )
              .toInt();
        } else {
          detail.cue.endMs = targetMs
              .clamp(
                detail.cue.startMs + 100,
                durationMs,
              )
              .toInt();
        }

        onPreviewChanged();
      },
    );

    _upSubscription = html.document.onMouseUp.listen(
      (_) async {
        _cancelCurrentDrag();

        await onCommitTiming(
          detail: detail,
          cueId: cueId,
          originalStart: originalStart,
          originalEnd: originalEnd,
          newStart: detail.cue.startMs,
          newEnd: detail.cue.endMs,
        );
      },
    );
  }

  void beginMoveCue(
    SubtitleCueDetail detail,
  ) {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final track = html.document.getElementById(
      'subtitle-timeline-track',
    );

    if (track == null) {
      return;
    }

    final durationMs = getDurationMs();

    if (durationMs <= 0) {
      return;
    }

    final originalStart = detail.cue.startMs;
    final originalEnd = detail.cue.endMs;
    final cueDuration = originalEnd - originalStart;

    double? firstMouseX;

    onSelectCue(cueId);

    _cancelCurrentDrag();

    _moveSubscription = html.document.onMouseMove.listen(
      (moveEvent) {
        final rect = track.getBoundingClientRect();

        if (rect.width <= 0) {
          return;
        }

        final mouseX = moveEvent.client.x.toDouble();

        firstMouseX ??= mouseX;

        final deltaX = mouseX - firstMouseX!;

        final deltaMs =
            (deltaX / rect.width * durationMs).round();

        final maxStart = durationMs - cueDuration;

        final newStart = (originalStart + deltaMs)
            .clamp(
              0,
              maxStart,
            )
            .toInt();

        detail.cue.startMs = newStart;
        detail.cue.endMs = newStart + cueDuration;

        onPreviewChanged();
      },
    );

    _upSubscription = html.document.onMouseUp.listen(
      (_) async {
        _cancelCurrentDrag();

        final newStart = detail.cue.startMs;
        final newEnd = detail.cue.endMs;

        if (newStart == originalStart &&
            newEnd == originalEnd) {
          return;
        }

        await onCommitTiming(
          detail: detail,
          cueId: cueId,
          originalStart: originalStart,
          originalEnd: originalEnd,
          newStart: newStart,
          newEnd: newEnd,
        );
      },
    );
  }

  void _cancelCurrentDrag() {
    _moveSubscription?.cancel();
    _upSubscription?.cancel();

    _moveSubscription = null;
    _upSubscription = null;
  }

  void dispose() {
    _cancelCurrentDrag();
  }
}