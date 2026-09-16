import 'dart:async';
import 'dart:html' as html;

class SubtitleVideoController {
  SubtitleVideoController({
    required this.onSeek,
  });

  final void Function(int milliseconds) onSeek;

  Timer? _reversePlaybackTimer;

  html.VideoElement? get _videoElement {
    final element = html.document.getElementById(
      'subtitle-video-player',
    );

    if (element is html.VideoElement) {
      return element;
    }

    return null;
  }

  int? currentTimeMs() {
    final element = _videoElement;

    if (element == null) {
      return null;
    }

    return (element.currentTime * 1000).round();
  }

  void seekTo(int milliseconds) {
    final element = _videoElement;

    if (element == null) {
      return;
    }

    element.currentTime = milliseconds / 1000;

    onSeek(milliseconds);
  }

  void togglePlayback() {
    stopReversePlayback();

    final element = _videoElement;

    if (element == null) {
      return;
    }

    if (element.paused) {
      element.play();
    } else {
      element.pause();
    }
  }

  void pause() {
    stopReversePlayback();
    _videoElement?.pause();
  }

  void playForward() {
    stopReversePlayback();

    final element = _videoElement;

    if (element == null) {
      return;
    }

    element.playbackRate = 1.0;
    element.play();
  }

  void startReversePlayback() {
    final element = _videoElement;

    if (element == null) {
      return;
    }

    element.pause();

    _reversePlaybackTimer?.cancel();

    _reversePlaybackTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) {
        final currentMs = currentTimeMs();

        if (currentMs == null) {
          stopReversePlayback();
          return;
        }

        final targetMs = currentMs - 100;

        if (targetMs <= 0) {
          seekTo(0);
          stopReversePlayback();
          return;
        }

        seekTo(targetMs);
      },
    );
  }

  void stopReversePlayback() {
    _reversePlaybackTimer?.cancel();
    _reversePlaybackTimer = null;
  }

  void keepTimelinePlayheadVisible({
    required int milliseconds,
    required int durationMs,
  }) {
    final timeline = html.document.querySelector(
      '.subtitle-timeline',
    );

    final track = html.document.getElementById(
      'subtitle-timeline-track',
    );

    if (timeline == null || track == null) {
      return;
    }

    if (durationMs <= 0) {
      return;
    }

    final trackWidth = track.getBoundingClientRect().width;
    final viewportWidth = timeline.getBoundingClientRect().width;

    if (trackWidth <= 0 || viewportWidth <= 0) {
      return;
    }

    final playheadX =
        milliseconds / durationMs * trackWidth;

    final scrollLeft = timeline.scrollLeft.toDouble();

    final leftSafe =
        scrollLeft + viewportWidth * 0.2;

    final rightSafe =
        scrollLeft + viewportWidth * 0.8;

    double? targetScroll;

    if (playheadX < leftSafe) {
      targetScroll =
          playheadX - viewportWidth * 0.2;
    } else if (playheadX > rightSafe) {
      targetScroll =
          playheadX - viewportWidth * 0.8;
    }

    if (targetScroll == null) {
      return;
    }

    final maxScroll =
        (timeline.scrollWidth - timeline.clientWidth)
            .toDouble();

    timeline.scrollLeft = targetScroll
        .clamp(
          0.0,
          maxScroll,
        )
        .round();
  }

  void dispose() {
    stopReversePlayback();
  }
}