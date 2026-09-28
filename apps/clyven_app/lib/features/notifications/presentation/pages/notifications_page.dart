import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/notification_settings_filter.dart';
import '../providers/notification_provider.dart';
import '../providers/notification_settings_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  static const Color _ink = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationProvider);
    final settings =
        ref.watch(notificationSettingsProvider).value ??
        NotificationSettings(userId: '');
    final l10n = AppLocalizations.of(context)!;
    final visibleNotifications = (notificationsAsync.value ?? const [])
        .where((notification) => settings.isEnabledFor(notification.type))
        .toList(growable: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref, l10n, visibleNotifications),
            Expanded(
              child: notificationsAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(child: Text(l10n.notificationsLoadFailed));
                },
                data: (notifications) {
                  final visible = visibleNotifications;

                  if (visible.isEmpty) {
                    return _buildEmpty(l10n);
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 40),
                    itemCount: visible.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      return _buildItem(context, ref, visible[index], l10n);
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

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    List<AppNotification> notifications,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final hasUnread = notifications.any((notification) {
      return !notification.isRead;
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
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
          ),
          if (hasUnread)
            TextButton(
              onPressed: () {
                ref.read(notificationProvider.notifier).markAllAsRead();
              },
              child: Text(
                l10n.markAllRead,
                style: TextStyle(
                  color: scheme.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmpty(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications_none_rounded,
            size: 45,
            color: Color(0xFFAAA49B),
          ),
          const SizedBox(height: 13),
          Text(
            l10n.noEchoesYet,
            style: const TextStyle(
              color: Color(0xFF77736C),
              fontWeight: FontWeight.w700,
            ),
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
            .markAsRead(notification.id!);

        if (!context.mounted) {
          return;
        }

        if (notification.videoId != null) {
          openGlobalVideo(notification.videoId!.toString());
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
                    ? Colors.white.withValues(alpha: 0.65)
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

  String _title(NotificationType type, AppLocalizations l10n) {
    return switch (type) {
      NotificationType.comment => l10n.notificationCommentTitle,
      NotificationType.like => l10n.notificationLikeTitle,
      NotificationType.follow => l10n.notificationFollowTitle,
    };
  }

  String _message(AppNotification notification, AppLocalizations l10n) {
    return switch (notification.type) {
      NotificationType.comment => l10n.notificationCommentMessage(
        notification.actorName,
        notification.commentPreview ?? '',
      ),
      NotificationType.like => l10n.notificationLikeMessage(
        notification.actorName,
      ),
      NotificationType.follow => l10n.notificationFollowMessage(
        notification.actorName,
      ),
    };
  }

  IconData _icon(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Icons.favorite_rounded;
      case NotificationType.comment:
        return Icons.mode_comment_rounded;
      case NotificationType.follow:
        return Icons.person_add_alt_1_rounded;
    }
  }

  Color _iconColor(BuildContext context, NotificationType type) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    // Dark notification icon backgrounds stay subdued in night mode.
    if (isDark) {
      final darkBase = Theme.of(context).cardColor;

      switch (type) {
        case NotificationType.like:
          return Color.alphaBlend(
            scheme.primary.withValues(alpha: 0.34),
            darkBase,
          );
        case NotificationType.comment:
          return Color.alphaBlend(
            scheme.secondary.withValues(alpha: 0.38),
            darkBase,
          );
        case NotificationType.follow:
          return const Color(0xFF29463E);
      }
    }

    switch (type) {
      case NotificationType.like:
        return scheme.primary;
      case NotificationType.comment:
        return scheme.secondary.withValues(alpha: 0.22);
      case NotificationType.follow:
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
