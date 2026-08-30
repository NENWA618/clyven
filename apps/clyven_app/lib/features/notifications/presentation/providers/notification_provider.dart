import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/app_notification.dart';
import '../../data/repositories/notification_repository.dart';

final notificationRepositoryProvider =
    Provider<NotificationRepository>(
  (ref) {
    return MockNotificationRepository();
  },
);

class NotificationNotifier
    extends AsyncNotifier<
        List<AppNotification>> {
  NotificationRepository
      get _repository {
    return ref.read(
      notificationRepositoryProvider,
    );
  }

  @override
  Future<List<AppNotification>>
      build() {
    return _repository
        .loadNotifications();
  }

  Future<void> markAsRead(
    String notificationId,
  ) async {
    await _repository.markAsRead(
      notificationId,
    );

    final current =
        state.value;

    if (current == null) {
      return;
    }

    state = AsyncData(
      current.map(
        (notification) {
          if (notification.id ==
              notificationId) {
            return notification.copyWith(
              isRead: true,
            );
          }

          return notification;
        },
      ).toList(),
    );
  }
}

final notificationProvider =
    AsyncNotifierProvider<
        NotificationNotifier,
        List<AppNotification>>(
  NotificationNotifier.new,
);