import 'package:glyphora_backend_client/backend_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/utils/require_login.dart';
import '../../../notifications/data/models/notification_settings_filter.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../notifications/presentation/providers/notification_provider.dart';
import '../../../notifications/presentation/providers/notification_settings_provider.dart';
import '../../../profile/presentation/pages/my_profile_page.dart';
import '../../../video/presentation/pages/create_video_page.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../../video/presentation/widgets/publish_type_sheet.dart';
import '../providers/main_tab_provider.dart';
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
    ref.listen<int?>(mainTabRequestProvider, (previous, requestedIndex) {
      if (requestedIndex == null) {
        return;
      }
      setState(() {
        _selectedIndex = requestedIndex;
      });
      ref.read(mainTabRequestProvider.notifier).clear();
    });

    final user = ref.watch(authProvider).value;

    final notificationsAsync = user == null
        ? null
        : ref.watch(notificationProvider);

    final notificationSettings =
        (user == null ? null : ref.watch(notificationSettingsProvider).value) ??
        NotificationSettings(userId: '');

    final unreadCount = notificationSettings.pushEnabled
        ? notificationsAsync?.value?.where((notification) {
                return !notification.isRead &&
                    notificationSettings.isEnabledFor(notification.type);
              }).length ??
              0
        : 0;

    final navigationDock = HomeNavigationDock(
      selectedIndex: _selectedIndex,
      unreadCount: unreadCount,
      overlayMode: _selectedIndex == 1,

        onSelected: (index) {
          if (index != _selectedIndex) {
            if (index == 0) ref.invalidate(allPublishedVideosProvider);
            if (index == 1) ref.invalidate(publishedShortsProvider);
          }
          setState(() {
            _selectedIndex = index;
          });
        },

        onCreate: () async {
          final contentType = await showPublishTypeSheet(context);

          if (contentType == null || !context.mounted) {
            return;
          }

          final allowed = await requireLogin(context, ref);

          if (!allowed || !context.mounted) {
            return;
          }

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateVideoPage(contentType: contentType);
              },
            ),
          );
        },
      );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              const HomePage(),
              DiscoverPage(isActive: _selectedIndex == 1),
              const NotificationsPage(),
              const MyProfilePage(),
            ],
          ),
          if (_selectedIndex == 1)
            Align(
              alignment: Alignment.bottomCenter,
              child: navigationDock,
            ),
        ],
      ),
      bottomNavigationBar: _selectedIndex == 1 ? null : navigationDock,
    );
  }
}
