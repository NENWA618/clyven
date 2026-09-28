import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _userId(Session session) {
    return session.authenticated!.userIdentifier.toString();
  }

  Future<List<AppNotification>> list(Session session) async {
    final userId = _userId(session);

    return AppNotification.db.find(
      session,
      where: (n) => n.recipientId.equals(userId),
      orderBy: (n) => n.createdAt,
      orderDescending: true,
      limit: 50,
    );
  }

  Future<void> markAsRead(Session session, int notificationId) async {
    final userId = _userId(session);

    final row = await AppNotification.db.findById(session, notificationId);

    if (row == null || row.recipientId != userId || row.isRead) {
      return;
    }

    row.isRead = true;
    await AppNotification.db.updateRow(session, row);
  }

  Future<void> markAllAsRead(Session session) async {
    final userId = _userId(session);

    final rows = await AppNotification.db.find(
      session,
      where: (n) => n.recipientId.equals(userId) & n.isRead.equals(false),
    );

    for (final row in rows) {
      row.isRead = true;
      await AppNotification.db.updateRow(session, row);
    }
  }
}
