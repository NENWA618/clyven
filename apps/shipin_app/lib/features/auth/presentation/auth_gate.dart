import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/presentation/pages/main_page.dart';
import 'providers/auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final authAsync = ref.watch(authProvider);

    return authAsync.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },

      // 登录状态读取失败，也允许以游客身份进入
      error: (error, stackTrace) {
        return const MainPage();
      },

      // user 有值 = 已登录
      // user == null = 游客
      // 两种情况都进入主页面
      data: (user) {
        return const MainPage();
      },
    );
  }
}