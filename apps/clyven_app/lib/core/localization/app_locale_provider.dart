import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleNotifier extends Notifier<Locale?> {
  static const String _localeKey = 'clyven.app_locale';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  @override
  Locale? build() {
    unawaited(_restore());
    return null;
  }

  void useSystem() {
    state = null;
    unawaited(_removeSavedLocale());
  }

  void useEnglish() {
    state = const Locale('en');
    unawaited(_saveLocale('en'));
  }

  void useSimplifiedChinese() {
    state = const Locale('zh');
    unawaited(_saveLocale('zh'));
  }

  Future<void> _restore() async {
    try {
      final languageCode = await _preferences.getString(_localeKey);

      state = switch (languageCode) {
        'en' => const Locale('en'),
        'zh' => const Locale('zh'),
        _ => null,
      };
    } catch (_) {
      // Storage failure should never prevent the app from starting.
      state = null;
    }
  }

  Future<void> _saveLocale(String languageCode) async {
    try {
      await _preferences.setString(_localeKey, languageCode);
    } catch (_) {
      // Keep the in-memory selection even if persistence is unavailable.
    }
  }

  Future<void> _removeSavedLocale() async {
    try {
      await _preferences.remove(_localeKey);
    } catch (_) {
      // Falling back to the current in-memory system locale is sufficient.
    }
  }
}

final appLocaleProvider = NotifierProvider<AppLocaleNotifier, Locale?>(
  AppLocaleNotifier.new,
);
