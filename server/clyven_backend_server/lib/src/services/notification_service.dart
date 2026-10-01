import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Inserts a notification row for [recipientId], unless the actor is
/// notifying themself (liking/commenting/following your own content never
/// produces a notification).
///
/// Like and follow notifications are deduplicated so toggling the same
/// relationship repeatedly does not flood the recipient's notification feed.
/// Comment notifications remain event-based and are not deduplicated here.
Future<void> createNotification(
  Session session, {
  required String recipientId,
  required String actorId,
  required String actorName,
  required NotificationType type,
  int? videoId,
  String? commentPreview,
  Transaction? transaction,
}) async {
  if (recipientId == actorId) {
    return;
  }

  if (type == NotificationType.like && videoId != null) {
    final existing = await AppNotification.db.findFirstRow(
      session,
      where: (t) =>
          t.recipientId.equals(recipientId) &
          t.actorId.equals(actorId) &
          t.type.equals(NotificationType.like) &
          t.videoId.equals(videoId),
      transaction: transaction,
    );

    if (existing != null) {
      return;
    }
  }

  if (type == NotificationType.follow) {
    final existing = await AppNotification.db.findFirstRow(
      session,
      where: (t) =>
          t.recipientId.equals(recipientId) &
          t.actorId.equals(actorId) &
          t.type.equals(NotificationType.follow),
      transaction: transaction,
    );

    if (existing != null) {
      return;
    }
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
    transaction: transaction,
  );
}
