import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../l10n/web_l10n.dart';
import '../services/auth_ui_state.dart';
import '../services/web_client.dart';

class WebAvatarUpload extends StatefulComponent {
  const WebAvatarUpload({super.key});

  @override
  State<WebAvatarUpload> createState() => _WebAvatarUploadState();
}

class _WebAvatarUploadState extends State<WebAvatarUpload> {
  bool _loading = true;
  bool _signedIn = false;
  bool _loginOpen = false;
  bool _accountOpen = false;
  bool _loginLoading = false;

  String _email = '';
  String _password = '';
  String? _error;
  String? _avatarUrl;
  String? _displayName;

  StreamSubscription<AuthUiSnapshot>? _authSub;

  @override
  void initState() {
    super.initState();
    _authSub = AuthUiState.instance.stream.listen((snapshot) {
      if (!mounted) return;

      setState(() {
        _signedIn = snapshot.signedIn;
        _avatarUrl = snapshot.avatarUrl;
        _displayName = snapshot.displayName;
        _loading = false;
        _accountOpen = false;
      });
    });
    unawaited(_restoreSession());
  }

  @override
  void dispose() {
    unawaited(_authSub?.cancel());
    super.dispose();
  }

  Future<void> _restoreSession() async {
    try {
      await webClient.auth.initialize();

      if (!webClient.auth.isAuthenticated) {
        if (!mounted) return;

        setState(() {
          _signedIn = false;
          _loading = false;
        });
        return;
      }

      await _loadProfile();
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _signedIn = false;
        _loading = false;
      });
    }
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await webClient.userProfileEdit.get();
      final avatarUrl = profile.imageUrl?.toString();
      final displayName =
          profile.fullName ?? profile.userName ?? profile.email ?? 'Clyven';

      if (!mounted) return;

      setState(() {
        _avatarUrl = avatarUrl;
        _displayName = displayName;
        _signedIn = true;
        _loading = false;
        _error = null;
      });

      AuthUiState.instance.update(
        AuthUiSnapshot(
          signedIn: true,
          avatarUrl: avatarUrl,
          displayName: displayName,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _signedIn = webClient.auth.isAuthenticated;
        _loading = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _login() async {
    final email = _email.trim().toLowerCase();

    if (email.isEmpty || _password.isEmpty) {
      setState(() {
        _error = context.l10n.enterEmailAndPassword;
      });
      return;
    }

    setState(() {
      _loginLoading = true;
      _error = null;
    });

    try {
      final authSuccess = await webClient.emailIdp.login(
        email: email,
        password: _password,
      );

      await webClient.auth.updateSignedInUser(authSuccess);

      if (!mounted) return;

      setState(() {
        _password = '';
        _loginOpen = false;
        _loginLoading = false;
        _signedIn = true;
      });

      await _loadProfile();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loginLoading = false;
        _signedIn = false;
        _error = context.l10n.loginFailed(error);
      });
    }
  }

  Component _avatarVisual() {
    final avatarUrl = _avatarUrl?.trim();

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      final safeUrl = avatarUrl.replaceAll("'", '%27');

      return span(
        classes: 'web-avatar-upload-image',
        attributes: {'style': "background-image:url('$safeUrl');"},
        [],
      );
    }

    final name = _displayName?.trim();
    final initial = name != null && name.isNotEmpty
        ? name.substring(0, 1).toUpperCase()
        : 'C';

    return span(classes: 'web-avatar-upload-placeholder', [.text(initial)]);
  }

  Component _loginModal() {
    return div(classes: 'web-auth-overlay', [
      div(classes: 'web-auth-dialog', [
        div(classes: 'web-auth-dialog-head', [
          div([
            h2([.text(context.l10n.signInToClyven)]),
            p([.text(context.l10n.signInBenefits)]),
          ]),
          button(
            type: ButtonType.button,
            classes: 'web-auth-close',
            onClick: () {
              setState(() {
                _loginOpen = false;
                _error = null;
              });
            },
            [.text('×')],
          ),
        ]),
        div(classes: 'web-auth-fields', [
          input<String>(
            type: InputType.email,
            attributes: {
              'placeholder': context.l10n.email,
              'autocomplete': 'email',
            },
            events: events<String>(
              onInput: (value) {
                _email = value;
              },
            ),
          ),
          input<String>(
            type: InputType.password,
            attributes: {
              'placeholder': context.l10n.password,
              'autocomplete': 'current-password',
            },
            events: events<String>(
              onInput: (value) {
                _password = value;
              },
            ),
          ),
          button(
            type: ButtonType.button,
            classes: 'web-auth-submit',
            attributes: _loginLoading ? {'disabled': 'disabled'} : null,
            onClick: _loginLoading ? null : _login,
            [
              .text(
                _loginLoading ? context.l10n.signingIn : context.l10n.signIn,
              ),
            ],
          ),
          if (_error != null) div(classes: 'web-auth-error', [.text(_error!)]),
        ]),
      ]),
    ]);
  }

  Component _accountMenu() {
    return div(classes: 'web-account-menu', [
      if (_displayName != null)
        div(classes: 'web-account-menu-name', [.text(_displayName!)]),
      button(
        type: ButtonType.button,
        classes: 'web-account-menu-item',
        onClick: () {
          setState(() => _accountOpen = false);
          Router.maybeOf(context)?.push('/wordlists');
        },
        [.text(context.l10n.wordLists)],
      ),
      button(
        type: ButtonType.button,
        classes: 'web-account-menu-item',
        onClick: () {
          setState(() => _accountOpen = false);
          Router.maybeOf(context)?.push('/settings');
        },
        [.text(context.l10n.settings)],
      ),
    ]);
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(classes: 'web-auth-control is-loading', [
        span(classes: 'web-auth-loading-dot', []),
      ]);
    }

    if (!_signedIn) {
      return div(classes: 'web-auth-control', [
        button(
          type: ButtonType.button,
          classes: 'web-auth-login-trigger',
          onClick: () {
            setState(() {
              _loginOpen = true;
              _accountOpen = false;
              _error = null;
            });
          },
          [.text(context.l10n.signIn)],
        ),
        if (_loginOpen) _loginModal(),
      ]);
    }

    return div(classes: 'web-auth-control', [
      button(
        type: ButtonType.button,
        classes: 'web-avatar-upload-button',
        attributes: {
          'title': context.l10n.account,
          'aria-label': context.l10n.openAccountMenu,
        },
        onClick: () {
          setState(() {
            _accountOpen = !_accountOpen;
          });
        },
        [_avatarVisual()],
      ),
      if (_accountOpen) _accountMenu(),
    ]);
  }
}
