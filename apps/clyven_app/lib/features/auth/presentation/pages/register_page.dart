import 'package:clyven_app/core/localization/localized_error_message.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  static const Color _ink = Color(0xFF161616);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  // 0 = email
  // 1 = verification code
  // 2 = create identity
  int _step = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _usernameController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage(l10n.emailRequired);
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .startRegistration(email: email);

    if (!mounted) {
      return;
    }

    if (success) {
      setState(() {
        _step = 1;
      });
    }
  }

  Future<void> _verifyCode() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      _showMessage(l10n.verificationCodeRequired);
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .verifyRegistrationCode(code: code);

    if (!mounted) {
      return;
    }

    if (success) {
      setState(() {
        _step = 2;
      });
    }
  }

  Future<void> _finishRegistration() async {
    final l10n = AppLocalizations.of(context)!;
    final username = _usernameController.text.trim();
    final displayName = _displayNameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty) {
      _showMessage(l10n.usernameRequired);
      return;
    }

    if (displayName.isEmpty) {
      _showMessage(l10n.displayNameRequired);
      return;
    }

    if (password.length < 8) {
      _showMessage(l10n.passwordMin8Validation);
      return;
    }

    final success = await ref.read(authProvider.notifier).finishRegistration(
          username: username,
          displayName: displayName,
          password: password,
        );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.pop(
        context,
        true,
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            18,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(),
              const SizedBox(height: 34),
              _buildBadge(l10n),
              const SizedBox(height: 18),
              Text(
                l10n.registerTitle,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 42,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.6,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _subtitle(l10n),
                style: TextStyle(
                  color: _ink.withValues(alpha: 0.62),
                  fontSize: 15,
                  height: 1.55,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 34),
              _buildStepIndicator(l10n),
              const SizedBox(height: 26),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _buildCurrentStep(
                  authAsync,
                  l10n,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(AppLocalizations l10n) {
    switch (_step) {
      case 0:
        return l10n.registerSubtitleEmail;
      case 1:
        return l10n.registerSubtitleCode;
      case 2:
        return l10n.registerSubtitleIdentity;
      default:
        return '';
    }
  }

  Widget _buildBackButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        if (_step == 0) {
          Navigator.pop(context);
          return;
        }

        setState(() {
          _step--;
        });
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.68),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: _ink,
        ),
      ),
    );
  }

  Widget _buildBadge(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        l10n.newVoice,
        style: const TextStyle(
          color: _ink,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildStepIndicator(AppLocalizations l10n) {
    return Row(
      children: [
        _stepDot(
          index: 0,
          text: l10n.email,
        ),
        _stepLine(active: _step >= 1),
        _stepDot(
          index: 1,
          text: l10n.verification,
        ),
        _stepLine(active: _step >= 2),
        _stepDot(
          index: 2,
          text: l10n.identity,
        ),
      ],
    );
  }

  Widget _stepDot({
    required int index,
    required String text,
  }) {
    final active = _step >= index;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? _ink : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? _ink : const Color(0xFFD8D2C9),
            ),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : _ink,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: TextStyle(
            color: _ink.withValues(alpha: active ? 1 : 0.45),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _stepLine({
    required bool active,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 20,
        ),
        height: 2,
        color: active ? _ink : const Color(0xFFD8D2C9),
      ),
    );
  }

  Widget _buildCurrentStep(
    AsyncValue authAsync,
    AppLocalizations l10n,
  ) {
    switch (_step) {
      case 0:
        return _buildEmailStep(
          authAsync,
          l10n,
        );
      case 1:
        return _buildCodeStep(
          authAsync,
          l10n,
        );
      case 2:
        return _buildIdentityStep(
          authAsync,
          l10n,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildEmailStep(
    AsyncValue authAsync,
    AppLocalizations l10n,
  ) {
    return Column(
      key: const ValueKey('email'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(
          controller: _emailController,
          hint: l10n.email,
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildError(authAsync),
        const SizedBox(height: 14),
        _buildButton(
          text: l10n.sendVerificationCode,
          loading: authAsync.isLoading,
          onPressed: _sendCode,
        ),
      ],
    );
  }

  Widget _buildCodeStep(
    AsyncValue authAsync,
    AppLocalizations l10n,
  ) {
    return Column(
      key: const ValueKey('code'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _emailController.text,
          style: TextStyle(
            color: _ink.withValues(alpha: 0.55),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _codeController,
          hint: l10n.verificationCode,
          icon: Icons.lock_clock_outlined,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: authAsync.isLoading ? null : _sendCode,
          child: Text(l10n.resendVerificationCode),
        ),
        _buildError(authAsync),
        const SizedBox(height: 14),
        _buildButton(
          text: l10n.verifyEmail,
          loading: authAsync.isLoading,
          onPressed: _verifyCode,
        ),
      ],
    );
  }

  Widget _buildIdentityStep(
    AsyncValue authAsync,
    AppLocalizations l10n,
  ) {
    return Column(
      key: const ValueKey('identity'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(
          controller: _usernameController,
          hint: l10n.username,
          icon: Icons.alternate_email_rounded,
        ),
        const SizedBox(height: 14),
        _buildField(
          controller: _displayNameController,
          hint: l10n.displayName,
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 14),
        _buildPasswordField(l10n),
        const SizedBox(height: 12),
        Text(
          l10n.passwordMin8Hint,
          style: TextStyle(
            color: _ink.withValues(alpha: 0.46),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        _buildError(authAsync),
        const SizedBox(height: 14),
        _buildButton(
          text: l10n.createIdentity,
          loading: authAsync.isLoading,
          onPressed: _finishRegistration,
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        color: _ink,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: _ink.withValues(alpha: 0.38),
        ),
        prefixIcon: Icon(
          icon,
          color: _ink,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.72),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFE3DED5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: _ink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(AppLocalizations l10n) {
    return TextField(
      controller: _passwordController,
      obscureText: _hidePassword,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) {
        _finishRegistration();
      },
      style: const TextStyle(
        color: _ink,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: l10n.password,
        hintStyle: TextStyle(
          color: _ink.withValues(alpha: 0.38),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: _ink,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
          icon: Icon(
            _hidePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.72),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFFE3DED5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: _ink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildError(AsyncValue authAsync) {
    if (!authAsync.hasError) {
      return const SizedBox();
    }

    final l10n = AppLocalizations.of(context)!;
    final message = localizedErrorMessage(
      l10n,
      authAsync.error,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE6E2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFF9E2921),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool loading,
    required Future<void> Function() onPressed,
  }) {
    final accent = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: loading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: accent,
          disabledBackgroundColor: _ink.withValues(alpha: 0.55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: accent,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}
