import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Inserts a notification row for [recipientId], unless the actor is
/// notifying themself (liking/commenting/following your own content never
/// produces a notification).
Future<void> createNotification(
  Session session, {
  required String recipientId,
  required String actorId,
  required String actorName,
  required NotificationType type,
  int? videoId,
  String? commentPreview,
}) async {
  if (recipientId == actorId) {
    return;
  }

  await AppNotification.db.insertRow(
    session,
    AppNotification(
      recipientId: recipientId,
      actorId: actorId,
      actorName: actorName,
      type: type,
      videoId: videoId,
      commentPreview: commentPreview,
      isRead: false,
      createdAt: DateTime.now(),
    ),
  );
}
