import 'dart:async';

class AuthUiSnapshot {
  final bool signedIn;
  final String? avatarUrl;
  final String? displayName;

  const AuthUiSnapshot({
    required this.signedIn,
    this.avatarUrl,
    this.displayName,
  });

  static const signedOut = AuthUiSnapshot(signedIn: false);
}

/// Jaspr has no shared state-management package, and `ClientShell` (which
/// hosts the header) stays mounted across route changes while each page is a
/// separate component instance. This small broadcast store lets a settings
/// page push a profile change (new avatar/display name, sign-out) so the
/// persistent header can reflect it immediately.
class AuthUiState {
  AuthUiState._();

  static final AuthUiState instance = AuthUiState._();

  AuthUiSnapshot _snapshot = AuthUiSnapshot.signedOut;
  final _controller = StreamController<AuthUiSnapshot>.broadcast();

  AuthUiSnapshot get snapshot => _snapshot;

  Stream<AuthUiSnapshot> get stream => _controller.stream;

  void update(AuthUiSnapshot snapshot) {
    _snapshot = snapshot;
    _controller.add(snapshot);
  }

  void signOut() => update(AuthUiSnapshot.signedOut);
}
