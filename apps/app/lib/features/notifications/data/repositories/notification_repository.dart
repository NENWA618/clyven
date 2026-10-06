import 'package:glyphora_backend_client/backend_client.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> loadNotifications();

  Future<void> markAsRead(int notificationId);

  Future<void> markAllAsRead();
}

class ServerpodNotificationRepository implements NotificationRepository {
  final Client client;

  ServerpodNotificationRepository({required this.client});

  @override
  Future<List<AppNotification>> loadNotifications() {
    return client.notification.list();
  }

  @override
  Future<void> markAsRead(int notificationId) {
    return client.notification.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() {
    return client.notification.markAllAsRead();
  }
}
