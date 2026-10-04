import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'push_service.dart';

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

  final inserted = await AppNotification.db.insertRow(
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

  // Inside a transaction the row is not committed yet; skip the push rather
  // than announcing something the recipient cannot open.
  if (transaction == null) {
    await _pushNotification(
      session,
      inserted,
      actorName: actorName,
      commentPreview: commentPreview,
    );
  }
}

Future<void> _pushNotification(
  Session session,
  AppNotification notification, {
  required String actorName,
  String? commentPreview,
}) async {
  final settings = await NotificationSettings.db.findFirstRow(
    session,
    where: (s) => s.userId.equals(notification.recipientId),
  );

  if (settings != null) {
    final allowed = settings.pushEnabled &&
        switch (notification.type) {
          NotificationType.like => settings.likeEnabled,
          NotificationType.comment => settings.commentEnabled,
          NotificationType.follow => settings.followEnabled,
        };
    if (!allowed) return;
  }


  await PushService.sendToUser(
    session,
    userId: notification.recipientId,
    messageFor: (languageCode) => _pushMessage(
      languageCode,
      notification.type,
      actorName,
      commentPreview,
    ),
    data: {
      'type': notification.type.name,
      'notificationId': '${notification.id}',
      if (notification.videoId != null) 'videoId': '${notification.videoId}',
    },
  );
}

/// Push copy per client language. Mirrors the app's own notification strings
/// (apps/clyven_app/lib/l10n); unknown languages fall back to English.
PushMessage _pushMessage(
  String languageCode,
  NotificationType type,
  String actorName,
  String? commentPreview,
) {
  final preview = commentPreview ?? '';

  if (languageCode.toLowerCase().startsWith('zh')) {
    return switch (type) {
      NotificationType.like => PushMessage(
        '你的影像获得了喜欢',
        '$actorName 喜欢了你的投稿。',
      ),
      NotificationType.comment => PushMessage(
        '有人回复了你的投稿',
        '$actorName 回复：“$preview”',
      ),
      NotificationType.follow => PushMessage(
        '新的关注',
        '$actorName 开始关注你。',
      ),
    };
  }

  return switch (type) {
    NotificationType.like => PushMessage(
      'Your video got a like',
      '$actorName liked your submission.',
    ),
    NotificationType.comment => PushMessage(
      'New reply',
      '$actorName replied: “$preview”',
    ),
    NotificationType.follow => PushMessage(
      'New follower',
      '$actorName started following you.',
    ),
  };
}
