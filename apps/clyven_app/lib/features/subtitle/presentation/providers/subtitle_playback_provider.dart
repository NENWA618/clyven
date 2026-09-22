import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/subtitle_playback_state.dart';

class SubtitlePlaybackNotifier extends Notifier<SubtitlePlaybackState> {
  final String videoId;

  SubtitlePlaybackNotifier(this.videoId);

  @override
  SubtitlePlaybackState build() => const SubtitlePlaybackState();

  void setEnabled(bool value) {
    state = state.copyWith(enabled: value);
  }

  void setDisplayMode(SubtitleDisplayMode value) {
    state = state.copyWith(displayMode: value);
  }

  void selectPrimary(SubtitlePlaybackSelection selection) {
    state = state.copyWith(enabled: true, primary: selection);
    if (sameSubtitleSelection(state.primary, state.secondary)) {
      state = state.copyWith(clearSecondary: true);
    }
  }

  void selectSecondary(SubtitlePlaybackSelection? selection) {
    if (selection == null) {
      state = state.copyWith(clearSecondary: true);
      return;
    }

    if (sameSubtitleSelection(state.primary, selection)) return;
    state = state.copyWith(enabled: true, secondary: selection);
  }

  void clearSecondary() {
    state = state.copyWith(clearSecondary: true);
  }
}

final subtitlePlaybackProvider =
    NotifierProvider.family<
      SubtitlePlaybackNotifier,
      SubtitlePlaybackState,
      String
    >(SubtitlePlaybackNotifier.new);
