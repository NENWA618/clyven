import 'dart:async';
import 'dart:html' as html;

class SubtitleTimelineController {
  SubtitleTimelineController({
    required this.getDurationMs,
    required this.onSeek,
  });

  final int Function() getDurationMs;
  final void Function(int milliseconds) onSeek;

  void seekFromTimelineClick(dynamic event) {
    if (event is! html.MouseEvent) {
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

    final rect = track.getBoundingClientRect();

    if (rect.width <= 0) {
      return;
    }

    final mouseX = event.client.x.toDouble();

    final relativeX = (mouseX - rect.left)
        .clamp(
          0,
          rect.width,
        )
        .toDouble();

    final targetMs =
        (relativeX / rect.width * durationMs).round();

    onSeek(targetMs);
  }

  void beginScrubPlayhead(dynamic event) {
    event.preventDefault();
    event.stopPropagation();

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

    void seekFromMouse(html.MouseEvent mouseEvent) {
      final rect = track.getBoundingClientRect();

      if (rect.width <= 0) {
        return;
      }

      final relativeX = (mouseEvent.client.x - rect.left)
          .clamp(
            0,
            rect.width,
          )
          .toDouble();

      final targetMs =
          (relativeX / rect.width * durationMs).round();

      onSeek(targetMs);
    }

    late StreamSubscription<html.MouseEvent> moveSubscription;
    late StreamSubscription<html.MouseEvent> upSubscription;

    moveSubscription = html.document.onMouseMove.listen(
      (moveEvent) {
        seekFromMouse(moveEvent);
      },
    );

    upSubscription = html.document.onMouseUp.listen(
      (_) async {
        await moveSubscription.cancel();
        await upSubscription.cancel();
      },
    );
  }
}