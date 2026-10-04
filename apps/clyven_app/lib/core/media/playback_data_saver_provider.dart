import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaybackDataSaverNotifier extends Notifier<bool> {
  static const String _key = 'clyven.playback_data_saver';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  bool build() {
    unawaited(_restore());
    return false;
  }

  void setEnabled(bool enabled) {
    state = enabled;
    unawaited(_save(enabled));
  }

  Future<void> _restore() async {
    try {
      state = await _preferences.getBool(_key) ?? false;
    } catch (_) {
      state = false;
    }
  }

  Future<void> _save(bool enabled) async {
    try {
      await _preferences.setBool(_key, enabled);
    } catch (_) {
      // Keep the in-memory preference when persistence is unavailable.
    }
  }
}

final playbackDataSaverProvider =
    NotifierProvider<PlaybackDataSaverNotifier, bool>(
      PlaybackDataSaverNotifier.new,
    );
