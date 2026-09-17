import 'package:clyven_app/core/localization/localized_error_message.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/register_page.dart';
import '../providers/auth_provider.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({
    super.key,
  });

  @override
  ConsumerState<LoginDialog> createState() {
    return _LoginDialogState();
  }
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  static const Color _inkColor = Color(0xFF161616);

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  bool _isSubmitting = false;

  Future<void> _register() async {
    final registered = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const RegisterPage();
        },
      ),
    );

    if (!mounted || registered != true) {
      return;
    }

    final user = ref.read(authProvider).value;

    if (user == null) {
      return;
    }

    Navigator.pop(
      context,
      true,
    );
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isSubmitting) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final account = _accountController.text.trim();
    final password = _passwordController.text;

    if (account.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = l10n.loginAccountAndPasswordRequired;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authProvider.notifier).login(
            account: account,
            password: password,
          );

      if (!mounted) {
        return;
      }

      final authState = ref.read(authProvider);
      final user = authState.value;

      if (user == null) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = localizedErrorMessage(
            l10n,
            authState.error,
          );
        });
        return;
      }

      Navigator.pop(
        context,
        true,
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _errorMessage = localizedErrorMessage(
          l10n,
          error,
        );
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.person_outline_rounded,
              color: colors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.login,
            style: const TextStyle(
              color: _inkColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _accountController,
              autofocus: true,
              enabled: !_isSubmitting,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: l10n.account,
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              enabled: !_isSubmitting,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _login();
              },
              decoration: InputDecoration(
                hintText: l10n.password,
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : _register,
          child: Text(l10n.register),
        ),
        TextButton(
          onPressed: _isSubmitting
              ? null
              : () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: _inkColor,
            foregroundColor: colors.primary,
          ),
          onPressed: _isSubmitting ? null : _login,
          child: _isSubmitting
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.primary,
                  ),
                )
              : Text(
                  l10n.login,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
        ),
      ],
    );
  }
}
