import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return ServerpodNotificationRepository(
    client: ref.watch(serverpodClientProvider),
  );
});

class NotificationNotifier extends AsyncNotifier<List<AppNotification>> {
  NotificationRepository get _repository {
    return ref.read(notificationRepositoryProvider);
  }

  @override
  Future<List<AppNotification>> build() async {
    final user = await ref.watch(authProvider.future);

    // 游客可以进入“回响”页面，但没有私人通知数据。
    if (user == null) {
      return const [];
    }

    return _repository.loadNotifications();
  }

  Future<void> markAsRead(int notificationId) async {
    await _repository.markAsRead(notificationId);

    final current = state.value;

    if (current == null) {
      return;
    }

    state = AsyncData(
      current.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(isRead: true);
        }

        return notification;
      }).toList(),
    );
  }

  Future<void> markAllAsRead() async {
    await _repository.markAllAsRead();

    final current = state.value;

    if (current == null) {
      return;
    }

    state = AsyncData(
      current
          .map((notification) => notification.copyWith(isRead: true))
          .toList(),
    );
  }
}

final notificationProvider =
    AsyncNotifierProvider<NotificationNotifier, List<AppNotification>>(
      NotificationNotifier.new,
    );
