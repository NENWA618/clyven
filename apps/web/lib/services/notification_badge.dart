import 'dart:async';

class NotificationBadgeState {
  final bool loaded;
  final int unreadCount;

  const NotificationBadgeState({this.loaded = false, this.unreadCount = 0});
}

/// Shared broadcast store so the persistent header bell and the separate
/// echoes page can agree on the unread count (see AuthUiState for why this
/// pattern exists instead of a state-management package).
class NotificationBadge {
  NotificationBadge._();

  static final NotificationBadge instance = NotificationBadge._();

  NotificationBadgeState _state = const NotificationBadgeState();
  final _controller = StreamController<NotificationBadgeState>.broadcast();

  NotificationBadgeState get state => _state;

  Stream<NotificationBadgeState> get stream => _controller.stream;

  void update(int unreadCount) {
    _state = NotificationBadgeState(loaded: true, unreadCount: unreadCount);
    _controller.add(_state);
  }

  void clear() {
    _state = const NotificationBadgeState();
    _controller.add(_state);
  }
}
