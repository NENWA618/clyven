import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/auth_gate.dart';
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
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}