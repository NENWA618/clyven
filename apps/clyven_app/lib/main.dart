import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/auth_gate.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: ClyvenApp(),
    ),
  );
}

class ClyvenApp extends StatelessWidget {
  const ClyvenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,

    localizationsDelegates:
        AppLocalizations.localizationsDelegates,

    supportedLocales:
        AppLocalizations.supportedLocales,

    theme: ThemeData(
      useMaterial3: true,
    ),

    home: const AuthGate(),
  );
  }
}