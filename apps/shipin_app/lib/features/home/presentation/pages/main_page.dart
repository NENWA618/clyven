import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/utils/require_login.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../notifications/presentation/providers/notification_provider.dart';
import '../../../profile/presentation/pages/my_profile_page.dart';
import '../../../video/presentation/pages/create_video_page.dart';
import '../widgets/home_navigation_dock.dart';
import 'discover_page.dart';
import 'home_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value;

    // 游客不读取私人通知数据，也不显示未读数。
    // 但是游客仍然可以进入“回响”页面。
    final notificationsAsync = user == null
        ? null
        : ref.watch(notificationProvider);

    final unreadCount =
        notificationsAsync?.value
                ?.where((notification) {
                  return !notification.isRead;
                })
                .length ??
            0;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          DiscoverPage(),
          NotificationsPage(),
          MyProfilePage(),
        ],
      ),

      bottomNavigationBar: HomeNavigationDock(
        selectedIndex: _selectedIndex,
        unreadCount: unreadCount,

        // 导航本身不要求登录。
        // 游客也可以直接进入“回响”和“我的”。
        onSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        // “发布”属于真正的账号操作，
        // 所以这里仍然要求登录。
        onCreate: () async {
          final allowed = await requireLogin(
            context,
            ref,
          );

          if (!allowed || !mounted) {
            return;
          }

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CreateVideoPage();
              },
            ),
          );
        },
      ),
    );
  }
}