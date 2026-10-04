import 'package:flutter/material.dart';

@immutable
class GlobalVideoPlayerState {
  final String? videoId;
  final bool expanded;
  final int? clipStartMs;
  final int? clipEndMs;
  final bool loopClip;

  const GlobalVideoPlayerState({
    required this.videoId,
    required this.expanded,
    this.clipStartMs,
    this.clipEndMs,
    this.loopClip = false,
  });

  const GlobalVideoPlayerState.empty()
    : videoId = null,
      expanded = false,
      clipStartMs = null,
      clipEndMs = null,
      loopClip = false;

  bool get hasVideo => videoId != null;
}

class GlobalVideoPlayerController extends ChangeNotifier {
  GlobalVideoPlayerState _state = const GlobalVideoPlayerState.empty();

  GlobalVideoPlayerState get state => _state;

  void open(String videoId) {
    FocusManager.instance.primaryFocus?.unfocus();

    _state = GlobalVideoPlayerState(videoId: videoId, expanded: true);

    notifyListeners();
  }

  void openClip({
    required String videoId,
    required int startMs,
    required int endMs,
    bool loop = true,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (startMs < 0 || endMs <= startMs) {
      throw ArgumentError('Invalid clip range: startMs=$startMs endMs=$endMs');
    }

    _state = GlobalVideoPlayerState(
      videoId: videoId,
      expanded: true,
      clipStartMs: startMs,
      clipEndMs: endMs,
      loopClip: loop,
    );

    notifyListeners();
  }

  void minimize() {
    if (!_state.hasVideo || !_state.expanded) {
      return;
    }

    _state = GlobalVideoPlayerState(
      videoId: _state.videoId,
      expanded: false,
      clipStartMs: _state.clipStartMs,
      clipEndMs: _state.clipEndMs,
      loopClip: _state.loopClip,
    );

    notifyListeners();
  }

  void expand() {
    if (!_state.hasVideo || _state.expanded) {
      return;
    }

    _state = GlobalVideoPlayerState(
      videoId: _state.videoId,
      expanded: true,
      clipStartMs: _state.clipStartMs,
      clipEndMs: _state.clipEndMs,
      loopClip: _state.loopClip,
    );

    notifyListeners();
  }

  void close() {
    if (!_state.hasVideo) {
      return;
    }

    _state = const GlobalVideoPlayerState.empty();
    notifyListeners();
  }
}

final globalVideoPlayerController = GlobalVideoPlayerController();

void openGlobalVideo(String videoId) {
  globalVideoPlayerController.open(videoId);
}

void openGlobalVideoClip({
  required String videoId,
  required int startMs,
  required int endMs,
  bool loop = true,
}) {
  globalVideoPlayerController.openClip(
    videoId: videoId,
    startMs: startMs,
    endMs: endMs,
    loop: loop,
  );
}
