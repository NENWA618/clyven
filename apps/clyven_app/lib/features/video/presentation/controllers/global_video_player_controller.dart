import 'package:flutter/material.dart';

@immutable
class GlobalVideoPlayerState {
  final String? videoId;
  final bool expanded;

  const GlobalVideoPlayerState({required this.videoId, required this.expanded});

  const GlobalVideoPlayerState.empty() : videoId = null, expanded = false;

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

  void minimize() {
    if (!_state.hasVideo || !_state.expanded) {
      return;
    }

    _state = GlobalVideoPlayerState(videoId: _state.videoId, expanded: false);

    notifyListeners();
  }

  void expand() {
    if (!_state.hasVideo || _state.expanded) {
      return;
    }

    _state = GlobalVideoPlayerState(videoId: _state.videoId, expanded: true);

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
