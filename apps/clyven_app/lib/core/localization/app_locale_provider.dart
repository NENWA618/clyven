import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    return null;
  }

  void useSystem() {
    state = null;
  }

  void useEnglish() {
    state = const Locale('en');
  }

  void useSimplifiedChinese() {
    state = const Locale('zh');
  }
}

final appLocaleProvider =
    NotifierProvider<AppLocaleNotifier, Locale?>(
  AppLocaleNotifier.new,
);
