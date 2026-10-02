import 'dart:async';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/auth_ui_state.dart';
import '../services/notification_badge.dart';
import '../services/web_client.dart';

const String _bellSvg =
    '<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">'
    '<path d="M12 2.75a5.25 5.25 0 0 0-5.25 5.25v2.69c0 .5-.16.99-.46 1.39l-1.36 1.82c-.9 1.2-.32 2.94 1.13 3.36 3.86 1.12 8.01 1.12 11.88 0 1.45-.42 2.03-2.16 1.13-3.36l-1.36-1.82c-.3-.4-.46-.89-.46-1.39V8a5.25 5.25 0 0 0-5.25-5.25Z" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>'
    '<path d="M9.5 19.5a2.5 2.5 0 0 0 5 0" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>'
    '</svg>';

/// Header bell that opens an in-page notifications dropdown, with a real
/// unread dot backed by the notification endpoint.
class NotificationBell extends StatefulComponent {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  bool _hasUnread = false;
  bool _open = false;
  bool _loading = false;
  List<AppNotification>? _notifications;
  StreamSubscription<AuthUiSnapshot>? _authSub;
  StreamSubscription<NotificationBadgeState>? _badgeSub;

  @override
  void initState() {
    super.initState();

    _badgeSub = NotificationBadge.instance.stream.listen((state) {
      if (!mounted) return;
      setState(() => _hasUnread = state.unreadCount > 0);
    });

    _authSub = AuthUiState.instance.stream.listen((snapshot) {
      if (snapshot.signedIn) {
        unawaited(_refresh());
      } else if (mounted) {
        NotificationBadge.instance.clear();
      }
    });

    if (AuthUiState.instance.snapshot.signedIn) {
      unawaited(_refresh());
    }
  }

  @override
  void dispose() {
    unawaited(_authSub?.cancel());
    unawaited(_badgeSub?.cancel());
    super.dispose();
  }

  Future<void> _refresh() async {
    try {
      final notifications = await webClient.notification.list();
      final unread = notifications.where((n) => !n.isRead).length;
      NotificationBadge.instance.update(unread);
    } catch (_) {
      // Keep the current badge state if the fetch fails.
    }
  }

  Future<void> _toggle() async {
    setState(() => _open = !_open);
    if (!_open) return;

    setState(() => _loading = _notifications == null);
    try {
      final notifications = await webClient.notification.list();
      if (!mounted) return;
      setState(() {
        _notifications = notifications;
        _loading = false;
      });
      NotificationBadge.instance.update(
        notifications.where((n) => !n.isRead).length,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _markAsRead(AppNotification notification) async {
    final current = _notifications;
    if (current == null || notification.isRead) return;

    final updated = current
        .map((n) => n.id == notification.id ? n.copyWith(isRead: true) : n)
        .toList();
    setState(() => _notifications = updated);
    NotificationBadge.instance.update(updated.where((n) => !n.isRead).length);

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
    NotificationBadge.instance.update(0);

    try {
      await webClient.notification.markAllAsRead();
    } catch (_) {
      // Keep the optimistic read state even if the network call fails.
    }
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    return div(classes: 'notification-bell-control', [
      button(
        type: ButtonType.button,
        classes: 'notification-bell-button',
        attributes: {
          'title': l10n.navEchoes,
          'aria-label': l10n.openNotifications,
        },
        onClick: () => unawaited(_toggle()),
        [
          span(classes: 'notification-bell-icon', [RawText(_bellSvg)]),
          if (_hasUnread) span(classes: 'notification-bell-dot', []),
        ],
      ),
      if (_open) ...[
        div(
          classes: 'notification-dropdown-backdrop',
          events: {'click': (_) => setState(() => _open = false)},
          [],
        ),
        _dropdown(context),
      ],
    ]);
  }

  Component _dropdown(BuildContext context) {
    final l10n = context.l10n;
    final notifications = _notifications;
    final hasUnread = notifications?.any((n) => !n.isRead) ?? false;

    return div(classes: 'notification-dropdown', [
      div(classes: 'notification-dropdown-head', [
        strong([.text(l10n.navEchoes)]),
        if (hasUnread)
          button(
            type: ButtonType.button,
            classes: 'notification-dropdown-action',
            onClick: () => unawaited(_markAllAsRead()),
            [.text(l10n.markAllRead)],
          ),
      ]),
      if (_loading)
        div(classes: 'notification-dropdown-empty', [.text(l10n.loading)])
      else if (notifications == null)
        div(classes: 'notification-dropdown-empty', [
          .text(l10n.notificationsLoadFailed),
        ])
      else if (notifications.isEmpty)
        div(classes: 'notification-dropdown-empty', [.text(l10n.noEchoesYet)])
      else
        div(classes: 'notification-dropdown-list', [
          for (final n in notifications) _item(context, n),
        ]),
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
            setState(() => _open = false);
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
          div(classes: 'echoes-item-title', [
            .text(_title(notification.type, l10n)),
          ]),
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
    final difference = DateTime.now().difference(time);

    if (difference.inMinutes < 1) return l10n.justNow;
    if (difference.inHours < 1) return l10n.minutesAgo(difference.inMinutes);
    if (difference.inDays < 1) return l10n.hoursAgo(difference.inHours);
    return l10n.daysAgo(difference.inDays);
  }
}
