import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/presentation/pages/video_detail_page.dart';
import '../../data/models/app_notification.dart';
import '../providers/notification_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({
    super.key,
  });

  static const Color _background = Color(0xFFF4F1EA);
  static const Color _ink = Color(0xFF161616);
  static const Color _purple = Color(0xFF7657FF);
  static const Color _acid = Color(0xFFE5FF58);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final notificationsAsync = ref.watch(notificationProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l10n),
            Expanded(
              child: notificationsAsync.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (
                  error,
                  stackTrace,
                ) {
                  return Center(
                    child: Text(l10n.notificationsLoadFailed),
                  );
                },
                data: (notifications) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      10,
                      18,
                      40,
                    ),
                    itemCount: notifications.length,
                    separatorBuilder: (
                      context,
                      index,
                    ) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return _buildItem(
                        context,
                        ref,
                        notifications[index],
                        l10n,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        22,
        20,
        18,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.echoesEyebrow,
                style: const TextStyle(
                  color: _purple,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.navEchoes,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    WidgetRef ref,
    AppNotification notification,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () async {
        await ref
            .read(notificationProvider.notifier)
            .markAsRead(notification.id);

        if (!context.mounted) {
          return;
        }

        if (notification.videoId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VideoDetailPage(
                  videoId: notification.videoId!,
                );
              },
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.white.withOpacity(0.65)
              : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: notification.isRead
                ? const Color(0xFFE3DED5)
                : _purple,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _iconColor(notification.type),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _icon(notification.type),
                color: _ink,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title(notification.type, l10n),
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _message(notification, l10n),
                    style: const TextStyle(
                      color: Color(0xFF77736C),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatTime(
                      notification.createdAt,
                      l10n,
                    ),
                    style: const TextStyle(
                      color: Color(0xFFAAA49B),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _purple,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _title(
    AppNotificationType type,
    AppLocalizations l10n,
  ) {
    return switch (type) {
      AppNotificationType.comment => l10n.notificationCommentTitle,
      AppNotificationType.like => l10n.notificationLikeTitle,
      AppNotificationType.follow => l10n.notificationFollowTitle,
    };
  }

  String _message(
    AppNotification notification,
    AppLocalizations l10n,
  ) {
    return switch (notification.type) {
      AppNotificationType.comment => l10n.notificationCommentMessage(
          notification.actorName,
          notification.contentPreview ?? '',
        ),
      AppNotificationType.like => l10n.notificationLikeMessage(
          notification.actorName,
        ),
      AppNotificationType.follow => l10n.notificationFollowMessage(
          notification.actorName,
        ),
    };
  }

  IconData _icon(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.like:
        return Icons.favorite_rounded;
      case AppNotificationType.comment:
        return Icons.mode_comment_rounded;
      case AppNotificationType.follow:
        return Icons.person_add_alt_1_rounded;
    }
  }

  Color _iconColor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.like:
        return _acid;
      case AppNotificationType.comment:
        return const Color(0xFFDCD3FF);
      case AppNotificationType.follow:
        return const Color(0xFFD7EEE3);
    }
  }

  String _formatTime(
    DateTime time,
    AppLocalizations l10n,
  ) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    }

    if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes);
    }

    if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours);
    }

    return l10n.daysAgo(difference.inDays);
  }
}
