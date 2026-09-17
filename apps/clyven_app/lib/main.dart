import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/app_locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_provider.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ClyvenApp(),
    ),
  );
}

class ClyvenApp extends ConsumerWidget {
  const ClyvenApp({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final locale = ref.watch(appLocaleProvider);
    final themeSettings = ref.watch(appThemeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates:
          AppLocalizations.localizationsDelegates,
      supportedLocales:
          AppLocalizations.supportedLocales,
      theme: ClyvenTheme.build(themeSettings),
      home: const AuthGate(),
    );
  }
}
