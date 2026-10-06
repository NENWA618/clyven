import 'package:glyphora_app/l10n/app_localizations.dart';
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:flutter/material.dart';

/// Shared presentation helpers for [AppNotification], used by both the echoes
/// page and the home notification dropdown.
extension NotificationLabels on AppNotification {
  IconData get icon => switch (type) {
    NotificationType.like => Icons.favorite_rounded,
    NotificationType.comment => Icons.mode_comment_rounded,
    NotificationType.follow => Icons.person_add_alt_1_rounded,
  };

  String title(AppLocalizations l10n) => switch (type) {
    NotificationType.comment => l10n.notificationCommentTitle,
    NotificationType.like => l10n.notificationLikeTitle,
    NotificationType.follow => l10n.notificationFollowTitle,
  };

  String message(AppLocalizations l10n) => switch (type) {
    NotificationType.comment => l10n.notificationCommentMessage(
      actorName,
      commentPreview ?? '',
    ),
    NotificationType.like => l10n.notificationLikeMessage(actorName),
    NotificationType.follow => l10n.notificationFollowMessage(actorName),
  };

  String timeAgo(AppLocalizations l10n) {
    final difference = DateTime.now().difference(createdAt);

    if (difference.inMinutes < 1) return l10n.justNow;
    if (difference.inHours < 1) return l10n.minutesAgo(difference.inMinutes);
    if (difference.inDays < 1) return l10n.hoursAgo(difference.inHours);
    return l10n.daysAgo(difference.inDays);
  }
}
