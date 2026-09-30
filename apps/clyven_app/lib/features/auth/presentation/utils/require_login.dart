import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../widgets/login_dialog.dart';

Future<bool> requireLogin(BuildContext context, WidgetRef ref) async {
  if (ref.read(authProvider).value != null) {
    return true;
  }

  // Some action widgets pass a BuildContext that is outside the app Navigator
  // (for example a builder/overlay context). The WidgetRef belongs to the
  // Consumer widget itself, so use that as the safe fallback for dialogs.
  final dialogContext = Navigator.maybeOf(context) != null
      ? context
      : ref.context;

  if (!dialogContext.mounted || Navigator.maybeOf(dialogContext) == null) {
    return false;
  }

  final loggedIn = await showDialog<bool>(
    context: dialogContext,
    barrierDismissible: false,
    builder: (context) {
      return const LoginDialog();
    },
  );

  if (loggedIn != true || !dialogContext.mounted) {
    return false;
  }

  return ref.read(authProvider).value != null;
}
