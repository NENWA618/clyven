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
    unawaited(_preferences.setString(_modeKey, mode.name));
  }

  void setColor(ClyvenThemeColor color) {
    state = state.copyWith(color: color);
    unawaited(_preferences.setString(_colorKey, color.name));
  }

  Future<void> _restore() async {
    try {
      final savedMode = await _preferences.getString(_modeKey);
      final savedColor = await _preferences.getString(_colorKey);

      final mode = ClyvenThemeMode.values.where(
        (value) => value.name == savedMode,
      ).firstOrNull;
      final color = ClyvenThemeColor.values.where(
        (value) => value.name == savedColor,
      ).firstOrNull;

      state = ClyvenThemeSettings(
        mode: mode ?? ClyvenThemeMode.accentOnly,
        color: color ?? ClyvenThemeColor.acid,
      );
    } catch (_) {
      state = const ClyvenThemeSettings();
    }
  }
}

final appThemeProvider =
    NotifierProvider<AppThemeNotifier, ClyvenThemeSettings>(
  AppThemeNotifier.new,
);
