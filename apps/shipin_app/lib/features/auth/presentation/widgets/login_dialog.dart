import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../pages/register_page.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({
    super.key,
  });

  @override
  ConsumerState<LoginDialog> createState() {
    return _LoginDialogState();
  }
}

class _LoginDialogState
    extends ConsumerState<LoginDialog> {
  static const Color _inkColor =
      Color(0xFF161616);

  static const Color _purpleColor =
      Color(0xFF7657FF);

  static const Color _acidColor =
      Color(0xFFE5FF58);

  final TextEditingController
      _accountController =
      TextEditingController();

  final TextEditingController
      _passwordController =
      TextEditingController();

  String? _errorMessage;
  bool _isSubmitting = false;

  Future<void> _register() async {
  final registered =
      await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) {
        return const RegisterPage();
      },
    ),
  );

  if (!mounted ||
      registered != true) {
    return;
  }

  final user =
      ref.read(authProvider).value;

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

    final account =
        _accountController.text.trim();

    final password =
        _passwordController.text;

    if (account.isEmpty ||
        password.isEmpty) {
      setState(() {
        _errorMessage =
            '请输入账号和密码';
      });

      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await ref
          .read(
            authProvider.notifier,
          )
          .login(
            account: account,
            password: password,
          );

      if (!mounted) {
        return;
      }

      final user =
          ref.read(authProvider).value;

      if (user == null) {
        setState(() {
          _isSubmitting = false;
          _errorMessage =
              '账号或密码错误';
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
        _errorMessage =
            error.toString();
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor:
          const Color(0xFFF4F1EA),

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(26),
      ),

      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration:
                BoxDecoration(
              color: _purpleColor,
              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),
            child: const Icon(
              Icons
                  .person_outline_rounded,
              color: _acidColor,
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            '登录',
            style: TextStyle(
              color: _inkColor,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
        ],
      ),

      content: SizedBox(
        width: 340,
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            TextField(
              controller:
                  _accountController,
              autofocus: true,
              enabled:
                  !_isSubmitting,
              textInputAction:
                  TextInputAction.next,
              decoration:
                  InputDecoration(
                hintText: '账号',
                prefixIcon:
                    const Icon(
                  Icons
                      .person_outline_rounded,
                ),
                filled: true,
                fillColor:
                    Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  _passwordController,
              enabled:
                  !_isSubmitting,
              obscureText: true,
              textInputAction:
                  TextInputAction.done,
              onSubmitted: (_) {
                _login();
              },
              decoration:
                  InputDecoration(
                hintText: '密码',
                prefixIcon:
                    const Icon(
                  Icons
                      .lock_outline_rounded,
                ),
                filled: true,
                fillColor:
                    Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            if (_errorMessage !=
                null) ...[
              const SizedBox(
                height: 12,
              ),
              Align(
                alignment:
                    Alignment.centerLeft,
                child: Text(
                  _errorMessage!,
                  style:
                      const TextStyle(
                    color:
                        Colors.redAccent,
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
    onPressed:
        _isSubmitting ? null : _register,
    child: const Text(
      '注册',
    ),
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
    child: const Text(
      '取消',
    ),
  ),

  FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: _inkColor,
      foregroundColor: _acidColor,
    ),
    onPressed:
        _isSubmitting ? null : _login,
    child: _isSubmitting
        ? const SizedBox(
            width: 18,
            height: 18,
            child:
                CircularProgressIndicator(
              strokeWidth: 2,
              color: _acidColor,
            ),
          )
        : const Text(
            '登录',
            style: TextStyle(
              fontWeight:
                  FontWeight.w800,
            ),
          ),
  ),
],
    );
  }
}