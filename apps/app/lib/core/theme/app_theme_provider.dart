import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class AppThemeNotifier extends Notifier<GlyphoraThemeSettings> {
  static const String _modeKey = 'glyphora.theme_mode';
  static const String _colorKey = 'glyphora.theme_color';
  static const String _companionKey = 'glyphora.theme_companion_color';
  static const String _displayModeKey = 'glyphora.display_mode';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  GlyphoraThemeSettings build() {
    unawaited(_restore());
    return const GlyphoraThemeSettings();
  }

  void setMode(GlyphoraThemeMode mode) {
    state = state.copyWith(mode: mode);
    unawaited(_saveMode(mode));
  }

  void setColor(GlyphoraThemeColor color) {
    final companion =
        GlyphoraTheme.isCompanionAllowed(color, state.companionColor)
        ? state.companionColor
        : GlyphoraTheme.defaultCompanionFor(color);

    state = state.copyWith(color: color, companionColor: companion);

    unawaited(_saveColor(color));
    unawaited(_saveCompanion(companion));
  }

  void setCompanionColor(GlyphoraThemeColor companion) {
    if (!GlyphoraTheme.isCompanionAllowed(state.color, companion)) {
      return;
    }

    state = state.copyWith(companionColor: companion);
    unawaited(_saveCompanion(companion));
  }

  void setDisplayMode(GlyphoraDisplayMode displayMode) {
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
      final companion = GlyphoraTheme.isCompanionAllowed(color, parsedCompanion)
          ? parsedCompanion
          : GlyphoraTheme.defaultCompanionFor(color);

      state = GlyphoraThemeSettings(
        mode: _parseMode(savedMode),
        color: color,
        companionColor: companion,
        displayMode: _parseDisplayMode(savedDisplayMode),
      );
    } catch (_) {
      state = const GlyphoraThemeSettings();
    }
  }

  GlyphoraThemeMode _parseMode(String? value) {
    for (final mode in GlyphoraThemeMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return GlyphoraThemeMode.accentOnly;
  }

  GlyphoraThemeColor _parseColor(String? value) {
    for (final color in GlyphoraThemeColor.values) {
      if (color.name == value) {
        return color;
      }
    }
    return GlyphoraThemeColor.orange;
  }

  GlyphoraDisplayMode _parseDisplayMode(String? value) {
    for (final mode in GlyphoraDisplayMode.values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return GlyphoraDisplayMode.day;
  }

  Future<void> _saveMode(GlyphoraThemeMode mode) async {
    try {
      await _preferences.setString(_modeKey, mode.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }

  Future<void> _saveColor(GlyphoraThemeColor color) async {
    try {
      await _preferences.setString(_colorKey, color.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }

  Future<void> _saveCompanion(GlyphoraThemeColor companion) async {
    try {
      await _preferences.setString(_companionKey, companion.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }

  Future<void> _saveDisplayMode(GlyphoraDisplayMode displayMode) async {
    try {
      await _preferences.setString(_displayModeKey, displayMode.name);
    } catch (_) {
      // Keep the in-memory theme when local persistence is unavailable.
    }
  }
}

final appThemeProvider =
    NotifierProvider<AppThemeNotifier, GlyphoraThemeSettings>(
      AppThemeNotifier.new,
    );
