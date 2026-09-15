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
  final List<AppNotification> _notifications = [
  AppNotification(
    id: 'notification-001',
    type: AppNotificationType.comment,
    actorName: 'Harbor Signal',
    contentPreview: 'This perspective is really interesting.',
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
    actorName: 'Atlas of Voices',
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
    actorName: 'Boundary Archive',
    createdAt: DateTime(
      2026,
      8,
      6,
      20,
      40,
    ),
    isRead: true,
  ),

    AppNotification(
      id: 'notification-001',
      type: AppNotificationType.comment,
      actorName: '远岸信号',
      contentPreview: '这个角度很有意思。',
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
      actorName: '语言群岛',
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
      actorName: '边界记录室',
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
