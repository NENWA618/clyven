import 'dart:async';
import 'dart:html' as html;

class SubtitleKeyboardController {
  SubtitleKeyboardController({
    required this.onTogglePlayback,
    required this.onSeekBackward,
    required this.onSeekForward,
    required this.onJumpPreviousCue,
    required this.onJumpNextCue,
    required this.onReversePlayback,
    required this.onPause,
    required this.onForwardPlayback,
    required this.onNudgeBackward,
    required this.onNudgeForward,
    required this.onSetStart,
    required this.onSetEnd,
  });

  final void Function() onTogglePlayback;

  final void Function() onSeekBackward;
  final void Function() onSeekForward;

  final void Function() onJumpPreviousCue;
  final void Function() onJumpNextCue;

  final void Function() onReversePlayback;
  final void Function() onPause;
  final void Function() onForwardPlayback;

  final void Function() onNudgeBackward;
  final void Function() onNudgeForward;

  final void Function() onSetStart;
  final void Function() onSetEnd;

  StreamSubscription<html.KeyboardEvent>? _subscription;

  void start() {
    _subscription = html.window.onKeyDown.listen(
      _handleKeyDown,
    );
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }

  void _handleKeyDown(
    html.KeyboardEvent event,
  ) {
    final target = event.target;

    if (target is html.InputElement ||
        target is html.TextAreaElement) {
      return;
    }

    if (event.code == 'Space') {
      event.preventDefault();
      onTogglePlayback();
      return;
    }

    if (event.code == 'ArrowLeft') {
      event.preventDefault();

      if (event.shiftKey == true) {
        onJumpPreviousCue();
      } else {
        onSeekBackward();
      }

      return;
    }

    if (event.code == 'ArrowRight') {
      event.preventDefault();

      if (event.shiftKey == true) {
        onJumpNextCue();
      } else {
        onSeekForward();
      }

      return;
    }

    if (event.code == 'KeyJ') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onReversePlayback();
      return;
    }

    if (event.code == 'KeyK') {
      event.preventDefault();
      onPause();
      return;
    }

    if (event.code == 'KeyL') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onForwardPlayback();
      return;
    }

    if (event.code == 'BracketLeft') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onNudgeBackward();
      return;
    }

    if (event.code == 'BracketRight') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onNudgeForward();
      return;
    }

    if (event.code == 'KeyI') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onSetStart();
      return;
    }

    if (event.code == 'KeyO') {
      event.preventDefault();

      if (event.repeat == true) {
        return;
      }

      onSetEnd();
    }
  }
}