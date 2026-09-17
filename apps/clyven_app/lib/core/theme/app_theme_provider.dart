import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class AppThemeNotifier extends Notifier<ClyvenThemeSettings> {
  static const String _modeKey = 'clyven.theme_mode';
  static const String _colorKey = 'clyven.theme_color';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  ClyvenThemeSettings build() {
    unawaited(_restore());
    return const ClyvenThemeSettings();
  }

  void setMode(ClyvenThemeMode mode) {
    state = state.copyWith(mode: mode);
    unawaited(_saveMode(mode));
  }

  void setColor(ClyvenThemeColor color) {
    state = state.copyWith(color: color);
    unawaited(_saveColor(color));
  }

  Future<void> _restore() async {
    try {
      final savedMode = await _preferences.getString(_modeKey);
      final savedColor = await _preferences.getString(_colorKey);

      state = ClyvenThemeSettings(
        mode: _parseMode(savedMode),
        color: _parseColor(savedColor),
      );
    } catch (_) {
      state = const ClyvenThemeSettings();
    }
  }

  ClyvenThemeMode _parseMode(String? value) {
    for (final mode in ClyvenThemeMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return ClyvenThemeMode.accentOnly;
  }

  ClyvenThemeColor _parseColor(String? value) {
    for (final color in ClyvenThemeColor.values) {
      if (color.name == value) {
        return color;
      }
    }
    return ClyvenThemeColor.acid;
  }

  Future<void> _saveMode(ClyvenThemeMode mode) async {
    try {
      await _preferences.setString(_modeKey, mode.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }

  Future<void> _saveColor(ClyvenThemeColor color) async {
    try {
      await _preferences.setString(_colorKey, color.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }
}

final appThemeProvider =
    NotifierProvider<AppThemeNotifier, ClyvenThemeSettings>(
  AppThemeNotifier.new,
);
