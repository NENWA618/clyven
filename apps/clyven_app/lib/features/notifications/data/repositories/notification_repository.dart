import '../models/app_notification.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>>
      loadNotifications();

  Future<void> markAsRead(
    String notificationId,
  );
}

class MockNotificationRepository
    implements NotificationRepository {
  final List<AppNotification>
      _notifications = [
    AppNotification(
      id: 'notification-001',
      type: AppNotificationType.comment,
      title: '有人回复了你的投稿',
      message: '「这个角度很有意思。」',
      createdAt: DateTime(
        2026,
        8,
        7,
        12,
        30,
      ),
      isRead: false,
      videoId: 'video-001',
    ),
    AppNotification(
      id: 'notification-002',
      type: AppNotificationType.like,
      title: '你的影像获得了喜欢',
      message: '语言群岛喜欢了你的投稿。',
      createdAt: DateTime(
        2026,
        8,
        7,
        10,
        15,
      ),
      isRead: false,
      videoId: 'video-002',
    ),
    AppNotification(
      id: 'notification-003',
      type: AppNotificationType.follow,
      title: '新的关注',
      message: '边界记录室开始关注你。',
      createdAt: DateTime(
        2026,
        8,
        6,
        20,
        40,
      ),
      isRead: true,
    ),
  ];

  @override
  Future<List<AppNotification>>
      loadNotifications() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List.unmodifiable(
      _notifications,
    );
  }

  @override
  Future<void> markAsRead(
    String notificationId,
  ) async {
    final index =
        _notifications.indexWhere(
      (notification) {
        return notification.id ==
            notificationId;
      },
    );

    if (index == -1) {
      return;
    }

    _notifications[index] =
        _notifications[index].copyWith(
      isRead: true,
    );
  }
}