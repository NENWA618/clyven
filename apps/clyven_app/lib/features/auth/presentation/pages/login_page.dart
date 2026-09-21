import 'package:clyven_app/core/localization/localized_error_message.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static const Color _inkColor = Color(0xFF161616);

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colors.primary,
                  size: 34,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.loginTitle,
                style: const TextStyle(
                  color: _inkColor,
                  fontSize: 36,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.loginSubtitle,
                style: const TextStyle(color: Color(0xFF77736C), fontSize: 14),
              ),
              const SizedBox(height: 36),
              TextField(
                controller: _accountController,
                decoration: _inputDecoration(
                  l10n.account,
                  Icons.person_outline_rounded,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: _inputDecoration(
                  l10n.password,
                  Icons.lock_outline_rounded,
                ),
              ),
              const SizedBox(height: 20),
              if (authAsync.hasError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    localizedErrorMessage(l10n, authAsync.error),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _inkColor,
                    foregroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: authAsync.isLoading ? null : _login,
                  child: authAsync.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          l10n.enter,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: TextButton(
                  onPressed: authAsync.isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPage();
                              },
                            ),
                          );
                        },
                  child: Text(
                    l10n.createAccountPrompt,
                    style: TextStyle(
                      color: colors.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white.withOpacity(0.72),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE3DED5)),
      ),
    );
  }

  Future<void> _login() async {
    await ref
        .read(authProvider.notifier)
        .login(
          account: _accountController.text,
          password: _passwordController.text,
        );

    if (!mounted) {
      return;
    }

    final user = ref.read(authProvider).value;

    if (user == null) {
      return;
    }

    Navigator.pop(context, true);
  }
}
