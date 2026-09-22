import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../services/studio_client.dart';

class StudioAuthGate extends StatefulComponent {
  const StudioAuthGate({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  State<StudioAuthGate> createState() => _StudioAuthGateState();
}

class _StudioAuthGateState extends State<StudioAuthGate> {
  String _email = '';
  String _password = '';

  bool _loading = true;
  bool _loginLoading = false;
  bool _loggedIn = false;

  String? _error;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    try {
      await studioClient.auth.initialize();

      if (!mounted) return;

      setState(() {
        _loggedIn = studioClient.auth.isAuthenticated;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loggedIn = false;
        _loading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _login() async {
    final email = _email.trim().toLowerCase();

    if (email.isEmpty || _password.isEmpty) {
      setState(() {
        _error = '请输入邮箱和密码';
      });
      return;
    }

    setState(() {
      _loginLoading = true;
      _error = null;
    });

    try {
      final authSuccess = await studioClient.emailIdp.login(
        email: email,
        password: _password,
      );

      await studioClient.auth.updateSignedInUser(authSuccess);

      if (!mounted) return;

      setState(() {
        _loggedIn = true;
        _loginLoading = false;
        _password = '';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loggedIn = false;
        _loginLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(
        classes: 'studio-page',
        [
          div(
            classes: 'preview-loading',
            [.text('正在恢复 Clyven 登录会话...')],
          ),
        ],
      );
    }

    if (!_loggedIn) {
      return div(
        classes: 'studio-page',
        [
          div(
            classes: 'login-panel',
            [
              div(
                classes: 'login-header',
                [
                  h2([.text('Clyven Studio')]),
                  p([
                    .text('登录一次后，视频、字幕、词典与导入工具共用同一会话。'),
                  ]),
                ],
              ),
              div(
                classes: 'login-fields',
                [
                  input<String>(
                    type: InputType.email,
                    attributes: {
                      'placeholder': 'Email',
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
                      'placeholder': 'Password',
                      'autocomplete': 'current-password',
                    },
                    events: events<String>(
                      onInput: (value) {
                        _password = value;
                      },
                    ),
                  ),
                  button(
                    classes: 'login-button',
                    attributes: _loginLoading
                        ? {
                            'disabled': 'disabled',
                          }
                        : null,
                    onClick: _loginLoading
                        ? null
                        : () {
                            _login();
                          },
                    [
                      .text(_loginLoading ? '登录中...' : '登录 Studio'),
                    ],
                  ),
                ],
              ),
              if (_error != null)
                div(
                  classes: 'login-error',
                  [.text(_error!)],
                ),
            ],
          ),
        ],
      );
    }

    return component.child;
  }
}
