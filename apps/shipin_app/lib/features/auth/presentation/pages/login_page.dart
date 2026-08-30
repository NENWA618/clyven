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

class _LoginPageState
    extends ConsumerState<LoginPage> {
  static const Color _backgroundColor =
      Color(0xFFF4F1EA);

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

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authAsync =
        ref.watch(authProvider);

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: _purpleColor,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: _acidColor,
                  size: 34,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                '重新进入\n你的内容轨道',
                style: TextStyle(
                  color: _inkColor,
                  fontSize: 36,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                '登录后继续观看、讨论、收藏和关注。',
                style: TextStyle(
                  color: Color(0xFF77736C),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 36),

              TextField(
                controller: _accountController,
                decoration: _inputDecoration(
                  '账号',
                  Icons.person_outline_rounded,
                ),
              ),

              const SizedBox(height: 14),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: _inputDecoration(
                  '密码',
                  Icons.lock_outline_rounded,
                ),
              ),

              const SizedBox(height: 20),

              if (authAsync.hasError)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 14,
                  ),
                  child: Text(
                    authAsync.error.toString(),
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
                    backgroundColor:
                        _inkColor,
                    foregroundColor:
                        _acidColor,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                  onPressed:
                      authAsync.isLoading
                          ? null
                          : _login,
                  child: authAsync.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          '进入',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w800,
                          ),
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
    child: const Text(
      '还没有身份？创建一个',
      style: TextStyle(
        color: _purpleColor,
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

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor:
          Colors.white.withOpacity(0.72),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Color(0xFFE3DED5),
        ),
      ),
    );
  }

  Future<void> _login() async {
  await ref.read(authProvider.notifier).login(
    account: _accountController.text,
    password: _passwordController.text,
  );

  if (!mounted) {
    return;
  }

  final user = ref.read(authProvider).value;

  // 登录失败，不退出登录页
  if (user == null) {
    return;
  }

  // 登录成功，回到打开 LoginPage 的页面
  Navigator.pop(context, true);
}
}