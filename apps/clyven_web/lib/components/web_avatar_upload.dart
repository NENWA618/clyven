import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../l10n/web_l10n.dart';
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
  bool _uploading = false;

  String _email = '';
  String _password = '';
  String? _error;
  String? _avatarUrl;
  String? _displayName;

  @override
  void initState() {
    super.initState();
    unawaited(_restoreSession());
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

      if (!mounted) return;

      setState(() {
        _avatarUrl = profile.imageUrl?.toString();
        _displayName =
            profile.fullName ?? profile.userName ?? profile.email ?? 'Clyven';
        _signedIn = true;
        _loading = false;
        _error = null;
      });
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

  Future<void> _logout() async {
    try {
      await webClient.auth.signOutDevice();
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _signedIn = false;
      _accountOpen = false;
      _avatarUrl = null;
      _displayName = null;
      _email = '';
      _password = '';
      _error = null;
    });
  }

  Future<Uint8List?> _pickImage() async {
    final input = html.FileUploadInputElement()
      ..accept = 'image/jpeg,image/png,image/webp'
      ..multiple = false;

    input.click();
    await input.onChange.first;

    final files = input.files;
    if (files == null || files.isEmpty) {
      return null;
    }

    final file = files.first;

    if (file.size > 10 * 1024 * 1024) {
      html.window.alert(context.l10n.avatarTooLarge);
      return null;
    }

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    final result = reader.result;

    if (result is ByteBuffer) {
      return Uint8List.view(result);
    }

    if (result is Uint8List) {
      return result;
    }

    throw StateError(context.l10n.cannotReadImage);
  }

  Future<void> _uploadAvatar() async {
    if (!_signedIn || _uploading) return;

    final bytes = await _pickImage();
    if (bytes == null || bytes.isEmpty) return;

    setState(() {
      _uploading = true;
      _accountOpen = false;
    });

    try {
      final profile = await webClient.userProfileEdit.setUserImage(
        ByteData.sublistView(bytes),
      );

      if (!mounted) return;

      setState(() {
        _avatarUrl = profile.imageUrl?.toString();
        _uploading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _uploading = false;
        });
      }

      html.window.alert(context.l10n.avatarUploadFailed(error));
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
        onClick: _uploadAvatar,
        [
          .text(
            _uploading ? context.l10n.uploading : context.l10n.changeAvatar,
          ),
        ],
      ),
      button(
        type: ButtonType.button,
        classes: 'web-account-menu-item danger',
        onClick: _logout,
        [.text(context.l10n.signOut)],
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
        classes:
            'web-avatar-upload-button'
            '${_uploading ? ' is-uploading' : ''}',
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
