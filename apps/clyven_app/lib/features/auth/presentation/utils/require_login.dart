import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../widgets/login_dialog.dart';

Future<bool> requireLogin(
  BuildContext context,
  WidgetRef ref,
) async {
  if (ref.read(authProvider).value != null) {
    return true;
  }

  final loggedIn =
      await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const LoginDialog();
    },
  );

  if (loggedIn != true ||
      !context.mounted) {
    return false;
  }

  return ref.read(authProvider).value !=
      null;
}