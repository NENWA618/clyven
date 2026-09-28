import 'dart:async';

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

/// Header bell linking to the echoes/notifications feed, with a real unread
/// dot backed by the notification endpoint.
class NotificationBell extends StatefulComponent {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  bool _hasUnread = false;
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

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    return Link(
      to: '/notifications',
      classes: 'notification-bell-button',
      attributes: {
        'title': l10n.navEchoes,
        'aria-label': l10n.openNotifications,
      },
      child: Component.fragment([
        span(classes: 'notification-bell-icon', [RawText(_bellSvg)]),
        if (_hasUnread) span(classes: 'notification-bell-dot', []),
      ]),
    );
  }
}
