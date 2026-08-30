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

class _RegisterPageState
    extends ConsumerState<RegisterPage> {
  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _acid =
      Color(0xFFE5FF58);

  final TextEditingController
      _emailController =
      TextEditingController();

  final TextEditingController
      _codeController =
      TextEditingController();

  final TextEditingController
      _usernameController =
      TextEditingController();

  final TextEditingController
      _displayNameController =
      TextEditingController();

  final TextEditingController
      _passwordController =
      TextEditingController();

  bool _hidePassword = true;

  // 0 = 邮箱
  // 1 = 验证码
  // 2 = 创建身份
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
    final email =
        _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage('请输入邮箱');
      return;
    }

    final success =
        await ref
            .read(
              authProvider.notifier,
            )
            .startRegistration(
              email: email,
            );

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
    final code =
        _codeController.text.trim();

    if (code.isEmpty) {
      _showMessage('请输入验证码');
      return;
    }

    final success =
        await ref
            .read(
              authProvider.notifier,
            )
            .verifyRegistrationCode(
              code: code,
            );

    if (!mounted) {
      return;
    }

    if (success) {
      setState(() {
        _step = 2;
      });
    }
  }

  Future<void> _finishRegistration()
      async {
    final username =
        _usernameController.text.trim();

    final displayName =
        _displayNameController.text.trim();

    final password =
        _passwordController.text;

    if (username.isEmpty) {
      _showMessage('请输入用户名');
      return;
    }

    if (displayName.isEmpty) {
      _showMessage('请输入显示名称');
      return;
    }

    if (password.length < 8) {
      _showMessage('密码至少需要 8 个字符');
      return;
    }

    final success =
        await ref
            .read(
              authProvider.notifier,
            )
            .finishRegistration(
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

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final authAsync =
        ref.watch(authProvider);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            24,
            18,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _buildBackButton(),

              const SizedBox(
                height: 34,
              ),

              _buildBadge(),

              const SizedBox(
                height: 18,
              ),

              const Text(
                '建立你的\n内容身份',
                style: TextStyle(
                  color: _ink,
                  fontSize: 42,
                  height: 1.05,
                  fontWeight:
                      FontWeight.w900,
                  letterSpacing: -1.6,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                _subtitle,
                style: TextStyle(
                  color: _ink.withValues(
                    alpha: 0.62,
                  ),
                  fontSize: 15,
                  height: 1.55,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 34,
              ),

              _buildStepIndicator(),

              const SizedBox(
                height: 26,
              ),

              AnimatedSwitcher(
                duration:
                    const Duration(
                  milliseconds: 220,
                ),
                child: _buildCurrentStep(
                  authAsync,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _subtitle {
    switch (_step) {
      case 0:
        return '先验证你的邮箱。这个邮箱以后可以用于登录和找回账号。';

      case 1:
        return '输入邮箱收到的验证码，完成邮箱验证。';

      case 2:
        return '一个身份可以观看、讨论、收藏，也可以成为创作者。';

      default:
        return '';
    }
  }

  Widget _buildBackButton() {
    return InkWell(
      borderRadius:
          BorderRadius.circular(30),
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
          color: Colors.white
              .withValues(
            alpha: 0.68,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: _ink,
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: _acid,
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: const Text(
        'NEW VOICE',
        style: TextStyle(
          color: _ink,
          fontSize: 11,
          fontWeight:
              FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _stepDot(
          index: 0,
          text: '邮箱',
        ),

        _stepLine(
          active: _step >= 1,
        ),

        _stepDot(
          index: 1,
          text: '验证',
        ),

        _stepLine(
          active: _step >= 2,
        ),

        _stepDot(
          index: 2,
          text: '身份',
        ),
      ],
    );
  }

  Widget _stepDot({
    required int index,
    required String text,
  }) {
    final active =
        _step >= index;

    return Column(
      children: [
        AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 180,
          ),
          width: 30,
          height: 30,
          alignment:
              Alignment.center,
          decoration: BoxDecoration(
            color:
                active
                    ? _ink
                    : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  active
                      ? _ink
                      : const Color(
                          0xFFD8D2C9,
                        ),
            ),
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color:
                  active
                      ? _acid
                      : _ink,
              fontSize: 12,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
        ),

        const SizedBox(
          height: 6,
        ),

        Text(
          text,
          style: TextStyle(
            color: _ink.withValues(
              alpha:
                  active
                      ? 1
                      : 0.45,
            ),
            fontSize: 11,
            fontWeight:
                FontWeight.w700,
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
        margin:
            const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 20,
        ),
        height: 2,
        color:
            active
                ? _ink
                : const Color(
                    0xFFD8D2C9,
                  ),
      ),
    );
  }

  Widget _buildCurrentStep(
    AsyncValue authAsync,
  ) {
    switch (_step) {
      case 0:
        return _buildEmailStep(
          authAsync,
        );

      case 1:
        return _buildCodeStep(
          authAsync,
        );

      case 2:
        return _buildIdentityStep(
          authAsync,
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildEmailStep(
    AsyncValue authAsync,
  ) {
    return Column(
      key:
          const ValueKey(
        'email',
      ),
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _buildField(
          controller:
              _emailController,
          hint: '邮箱',
          icon:
              Icons.mail_outline_rounded,
          keyboardType:
              TextInputType
                  .emailAddress,
        ),

        const SizedBox(
          height: 20,
        ),

        _buildError(
          authAsync,
        ),

        const SizedBox(
          height: 14,
        ),

        _buildButton(
          text: '发送验证码',
          loading:
              authAsync.isLoading,
          onPressed: _sendCode,
        ),
      ],
    );
  }

  Widget _buildCodeStep(
    AsyncValue authAsync,
  ) {
    return Column(
      key:
          const ValueKey(
        'code',
      ),
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          _emailController.text,
          style: TextStyle(
            color: _ink.withValues(
              alpha: 0.55,
            ),
            fontSize: 13,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        _buildField(
          controller:
              _codeController,
          hint: '验证码',
          icon:
              Icons.lock_clock_outlined,
          keyboardType:
              TextInputType.number,
        ),

        const SizedBox(
          height: 12,
        ),

        TextButton(
          onPressed:
              authAsync.isLoading
                  ? null
                  : _sendCode,
          child: const Text(
            '重新发送验证码',
          ),
        ),

        _buildError(
          authAsync,
        ),

        const SizedBox(
          height: 14,
        ),

        _buildButton(
          text: '验证邮箱',
          loading:
              authAsync.isLoading,
          onPressed: _verifyCode,
        ),
      ],
    );
  }

  Widget _buildIdentityStep(
    AsyncValue authAsync,
  ) {
    return Column(
      key:
          const ValueKey(
        'identity',
      ),
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _buildField(
          controller:
              _usernameController,
          hint: '用户名',
          icon:
              Icons
                  .alternate_email_rounded,
        ),

        const SizedBox(
          height: 14,
        ),

        _buildField(
          controller:
              _displayNameController,
          hint: '显示名称',
          icon:
              Icons.badge_outlined,
        ),

        const SizedBox(
          height: 14,
        ),

        _buildPasswordField(),

        const SizedBox(
          height: 12,
        ),

        Text(
          '密码至少 8 个字符',
          style: TextStyle(
            color: _ink.withValues(
              alpha: 0.46,
            ),
            fontSize: 12,
            fontWeight:
                FontWeight.w500,
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        _buildError(
          authAsync,
        ),

        const SizedBox(
          height: 14,
        ),

        _buildButton(
          text: '创建身份',
          loading:
              authAsync.isLoading,
          onPressed:
              _finishRegistration,
        ),
      ],
    );
  }

  Widget _buildField({
    required
    TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType?
        keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
          keyboardType,
      textInputAction:
          TextInputAction.next,
      style: const TextStyle(
        color: _ink,
        fontSize: 16,
        fontWeight:
            FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: _ink.withValues(
            alpha: 0.38,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: _ink,
        ),
        filled: true,
        fillColor: Colors.white
            .withValues(
          alpha: 0.72,
        ),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              const BorderSide(
            color: Color(
              0xFFE3DED5,
            ),
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              const BorderSide(
            color: _ink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller:
          _passwordController,
      obscureText:
          _hidePassword,
      textInputAction:
          TextInputAction.done,
      onSubmitted: (_) {
        _finishRegistration();
      },
      style: const TextStyle(
        color: _ink,
        fontSize: 16,
        fontWeight:
            FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: '密码',
        hintStyle: TextStyle(
          color: _ink.withValues(
            alpha: 0.38,
          ),
        ),
        prefixIcon:
            const Icon(
          Icons.lock_outline_rounded,
          color: _ink,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _hidePassword =
                  !_hidePassword;
            });
          },
          icon: Icon(
            _hidePassword
                ? Icons
                    .visibility_off_outlined
                : Icons
                    .visibility_outlined,
          ),
        ),
        filled: true,
        fillColor: Colors.white
            .withValues(
          alpha: 0.72,
        ),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              const BorderSide(
            color: Color(
              0xFFE3DED5,
            ),
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              const BorderSide(
            color: _ink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildError(
    AsyncValue authAsync,
  ) {
    if (!authAsync.hasError) {
      return const SizedBox();
    }

    final message =
        authAsync.error
            .toString()
            .replaceFirst(
              'Bad state: ',
              '',
            );

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(
        14,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFFFE6E2,
        ),
        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(
            0xFF9E2921,
          ),
          fontSize: 13,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool loading,
    required
    Future<void> Function()
        onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed:
            loading
                ? null
                : onPressed,
        style:
            FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: _acid,
          disabledBackgroundColor:
              _ink.withValues(
            alpha: 0.55,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),
        ),
        child:
            loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: _acid,
                    ),
                  )
                : Text(
                    text,
                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
      ),
    );
  }
}