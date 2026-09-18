import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/app_notification.dart';
import '../providers/notification_provider.dart';

import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  static const Color _ink = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, l10n),
            Expanded(
              child: notificationsAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(child: Text(l10n.notificationsLoadFailed));
                },
                data: (notifications) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 40),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
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

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.echoesEyebrow,
                style: TextStyle(
                  color: scheme.secondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.navEchoes,
                style: TextStyle(
                  color: scheme.onSurface,
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
    final scheme = Theme.of(context).colorScheme;
    final secondary = scheme.secondary;
    final isDark = scheme.brightness == Brightness.dark;
    final nightCardColor = Theme.of(context).cardColor;

    return GestureDetector(
      onTap: () async {
        await ref
            .read(notificationProvider.notifier)
            .markAsRead(notification.id);

        if (!context.mounted) {
          return;
        }

        if (notification.videoId != null) {
          openGlobalVideo(notification.videoId!);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? (notification.isRead
                    ? nightCardColor
                    : Color.alphaBlend(
                        secondary.withValues(alpha: 0.055),
                        nightCardColor,
                      ))
              : (notification.isRead
                    ? Colors.white.withOpacity(0.65)
                    : Colors.white),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: notification.isRead
                ? (isDark ? const Color(0xFF383838) : const Color(0xFFE3DED5))
                : secondary,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _iconColor(context, notification.type),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _icon(notification.type),
                color: isDark ? scheme.onSurface : _ink,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title(notification.type, l10n),
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _message(notification, l10n),
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFFBEB9B0)
                          : const Color(0xFF77736C),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatTime(notification.createdAt, l10n),
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF8F8A83)
                          : const Color(0xFFAAA49B),
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
                decoration: BoxDecoration(
                  color: secondary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _title(AppNotificationType type, AppLocalizations l10n) {
    return switch (type) {
      AppNotificationType.comment => l10n.notificationCommentTitle,
      AppNotificationType.like => l10n.notificationLikeTitle,
      AppNotificationType.follow => l10n.notificationFollowTitle,
    };
  }

  String _message(AppNotification notification, AppLocalizations l10n) {
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

  Color _iconColor(BuildContext context, AppNotificationType type) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    // Dark notification icon backgrounds stay subdued in night mode.
    if (isDark) {
      final darkBase = Theme.of(context).cardColor;

      switch (type) {
        case AppNotificationType.like:
          return Color.alphaBlend(
            scheme.primary.withValues(alpha: 0.34),
            darkBase,
          );
        case AppNotificationType.comment:
          return Color.alphaBlend(
            scheme.secondary.withValues(alpha: 0.38),
            darkBase,
          );
        case AppNotificationType.follow:
          return const Color(0xFF29463E);
      }
    }

    switch (type) {
      case AppNotificationType.like:
        return scheme.primary;
      case AppNotificationType.comment:
        return scheme.secondary.withValues(alpha: 0.22);
      case AppNotificationType.follow:
        return const Color(0xFFD7EEE3);
    }
  }

  String _formatTime(DateTime time, AppLocalizations l10n) {
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
