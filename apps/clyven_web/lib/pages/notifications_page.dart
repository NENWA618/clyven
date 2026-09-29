import 'dart:async';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/notification_badge.dart';
import '../services/web_client.dart';

class NotificationsPage extends StatefulComponent {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _loading = true;
  List<AppNotification>? _notifications;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final notifications = await webClient.notification.list();
      if (!mounted) return;
      setState(() {
        _notifications = notifications;
        _loading = false;
      });
      _publishUnreadCount(notifications);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  void _publishUnreadCount(List<AppNotification> notifications) {
    NotificationBadge.instance.update(
      notifications.where((n) => !n.isRead).length,
    );
  }

  Future<void> _markAsRead(AppNotification notification) async {
    if (notification.isRead) return;

    final current = _notifications;
    if (current == null) return;

    final updated = current
        .map(
          (n) => n.id == notification.id
              ? n.copyWith(isRead: true)
              : n,
        )
        .toList();

    setState(() => _notifications = updated);
    _publishUnreadCount(updated);

    try {
      await webClient.notification.markAsRead(notification.id!);
    } catch (_) {
      // Keep the optimistic read state even if the network call fails.
    }
  }

  Future<void> _markAllAsRead() async {
    final current = _notifications;
    if (current == null) return;

    final updated = current.map((n) => n.copyWith(isRead: true)).toList();
    setState(() => _notifications = updated);
    _publishUnreadCount(updated);

    try {
      await webClient.notification.markAllAsRead();
    } catch (_) {
      // Keep the optimistic read state even if the network call fails.
    }
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;
    final notifications = _notifications;
    final hasUnread = notifications?.any((n) => !n.isRead) ?? false;

    return div(classes: 'echoes-page', [
      div(classes: 'echoes-header', [
        div(classes: 'echoes-header-copy', [
          span(classes: 'settings-eyebrow', [.text(l10n.echoesEyebrow)]),
          h1([.text(l10n.navEchoes)]),
        ]),
        if (hasUnread)
          button(
            type: ButtonType.button,
            classes: 'settings-secondary-button',
            onClick: () => unawaited(_markAllAsRead()),
            [.text(l10n.markAllRead)],
          ),
      ]),
      if (_loading)
        div(classes: 'echoes-empty', [.text(l10n.loading)])
      else if (notifications == null)
        div(classes: 'echoes-empty', [.text(l10n.notificationsLoadFailed)])
      else if (notifications.isEmpty)
        div(classes: 'echoes-empty', [
          span(classes: 'echoes-empty-icon', [.text('🔔')]),
          p([.text(l10n.noEchoesYet)]),
        ])
      else
        div(
          classes: 'echoes-list',
          [for (final n in notifications) _item(context, n)],
        ),
    ]);
  }

  Component _item(BuildContext context, AppNotification notification) {
    final l10n = context.l10n;
    final videoId = notification.videoId;

    return div(
      classes: notification.isRead ? 'echoes-item' : 'echoes-item is-unread',
      events: {
        'click': (event) {
          unawaited(_markAsRead(notification));
          if (videoId != null) {
            Router.maybeOf(context)?.push('/watch/$videoId');
          }
        },
      },
      [
        span(
          classes: 'echoes-item-icon echoes-item-icon-${notification.type.name}',
          [.text(_icon(notification.type))],
        ),
        div(classes: 'echoes-item-copy', [
          div(classes: 'echoes-item-title', [.text(_title(notification.type, l10n))]),
          div(classes: 'echoes-item-message', [
            .text(_message(notification, l10n)),
          ]),
          div(classes: 'echoes-item-time', [
            .text(_formatTime(notification.createdAt, l10n)),
          ]),
        ]),
        if (!notification.isRead) span(classes: 'echoes-item-dot', []),
      ],
    );
  }

  String _icon(NotificationType type) {
    return switch (type) {
      NotificationType.like => '❤',
      NotificationType.comment => '💬',
      NotificationType.follow => '➕',
    };
  }

  String _title(NotificationType type, WebStrings l10n) {
    return switch (type) {
      NotificationType.comment => l10n.notificationCommentTitle,
      NotificationType.like => l10n.notificationLikeTitle,
      NotificationType.follow => l10n.notificationFollowTitle,
    };
  }

  String _message(AppNotification notification, WebStrings l10n) {
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

  String _formatTime(DateTime time, WebStrings l10n) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) return l10n.justNow;
    if (difference.inHours < 1) return l10n.minutesAgo(difference.inMinutes);
    if (difference.inDays < 1) return l10n.hoursAgo(difference.inHours);
    return l10n.daysAgo(difference.inDays);
  }
}
