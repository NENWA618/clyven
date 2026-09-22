import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class AppThemeNotifier extends Notifier<ClyvenThemeSettings> {
  static const String _modeKey = 'clyven.theme_mode';
  static const String _colorKey = 'clyven.theme_color';
  static const String _companionKey = 'clyven.theme_companion_color';
  static const String _displayModeKey = 'clyven.display_mode';

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
    final companion =
        ClyvenTheme.isCompanionAllowed(color, state.companionColor)
        ? state.companionColor
        : ClyvenTheme.defaultCompanionFor(color);

    state = state.copyWith(color: color, companionColor: companion);

    unawaited(_saveColor(color));
    unawaited(_saveCompanion(companion));
  }

  void setCompanionColor(ClyvenThemeColor companion) {
    if (!ClyvenTheme.isCompanionAllowed(state.color, companion)) {
      return;
    }

    state = state.copyWith(companionColor: companion);
    unawaited(_saveCompanion(companion));
  }

  void setDisplayMode(ClyvenDisplayMode displayMode) {
    state = state.copyWith(displayMode: displayMode);
    unawaited(_saveDisplayMode(displayMode));
  }

  Future<void> _restore() async {
    try {
      final savedMode = await _preferences.getString(_modeKey);
      final savedColor = await _preferences.getString(_colorKey);
      final savedCompanion = await _preferences.getString(_companionKey);
      final savedDisplayMode = await _preferences.getString(_displayModeKey);

      final color = _parseColor(savedColor);
      final parsedCompanion = _parseColor(savedCompanion);
      final companion = ClyvenTheme.isCompanionAllowed(color, parsedCompanion)
          ? parsedCompanion
          : ClyvenTheme.defaultCompanionFor(color);

      state = ClyvenThemeSettings(
        mode: _parseMode(savedMode),
        color: color,
        companionColor: companion,
        displayMode: _parseDisplayMode(savedDisplayMode),
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
    return ClyvenThemeColor.orange;
  }

  ClyvenDisplayMode _parseDisplayMode(String? value) {
    for (final mode in ClyvenDisplayMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return ClyvenDisplayMode.day;
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

  Future<void> _saveCompanion(ClyvenThemeColor companion) async {
    try {
      await _preferences.setString(_companionKey, companion.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }

  Future<void> _saveDisplayMode(ClyvenDisplayMode displayMode) async {
    try {
      await _preferences.setString(_displayModeKey, displayMode.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }
}

final appThemeProvider =
    NotifierProvider<AppThemeNotifier, ClyvenThemeSettings>(
      AppThemeNotifier.new,
    );
