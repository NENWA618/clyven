import 'package:glyphora_web_l10n/web_l10n.dart';
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
  String _verificationCode = '';
  String _registrationToken = '';
  dynamic _accountRequestId;
  int _registrationStep = 0;
  static const bool _stagingRegistrationEnabled = bool.fromEnvironment('GLYPHORA_STAGING_REGISTRATION', defaultValue: false);

  bool _loading = true;
  bool _loginLoading = false;
  bool _loggedIn = false;

  String? _error;
  bool _errorIsMissingFields = false;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    try {
      consumeWebSession();
      final restored = await restoreStoredSession();

      if (!mounted) return;

      setState(() {
        _loggedIn = restored;
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
        _errorIsMissingFields = true;
        _error = null;
      });
      return;
    }

    setState(() {
      _loginLoading = true;
      _errorIsMissingFields = false;
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

  Future<void> _registerNext() async {
    if (_loginLoading) return;
    setState(() { _loginLoading = true; _error = null; });
    try {
      if (_registrationStep == 1) {
        final email = _email.trim().toLowerCase();
        if (email.isEmpty || !email.contains('@')) throw StateError('Enter a valid email.');
        _accountRequestId = await studioClient.emailIdp.startRegistration(email: email);
        if (!mounted) return;
        setState(() => _registrationStep = 2);
      } else if (_registrationStep == 2) {
        if (_verificationCode.trim().isEmpty) throw StateError('Enter the email verification code.');
        _registrationToken = await studioClient.emailIdp.verifyRegistrationCode(
          accountRequestId: _accountRequestId,
          verificationCode: _verificationCode.trim(),
        );
        if (!mounted) return;
        setState(() => _registrationStep = 3);
      } else if (_registrationStep == 3) {
        if (_password.length < 8) throw StateError('Password must contain at least 8 characters.');
        final authSuccess = await studioClient.emailIdp.finishRegistration(
          registrationToken: _registrationToken,
          password: _password,
        );
        await studioClient.auth.updateSignedInUser(authSuccess);
        if (!mounted) return;
        setState(() { _loggedIn = true; _password = ''; _registrationStep = 0; });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loginLoading = false);
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
            [.text(context.tr('Restoring your Glyphora session...', '正在恢复 Glyphora 登录会话...'))],
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
                  h2([.text('Glyphora Studio')]),
                  p([
                    .text(context.tr('Sign in once; videos, subtitles, dictionary and import tools share the same session.', '登录一次后，视频、字幕、词典与导入工具共用同一会话。')),
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
                  if (_registrationStep == 2)
                    input<String>(
                      type: InputType.text,
                      attributes: {'placeholder': 'Email verification code', 'autocomplete': 'one-time-code'},
                      events: events<String>(onInput: (value) { _verificationCode = value; }),
                    ),
                  if (_registrationStep == 0 || _registrationStep == 3)
                  input<String>(
                    type: InputType.password,
                    attributes: {
                      'placeholder': 'Password',
                      'autocomplete': _registrationStep == 3 ? 'new-password' : 'current-password',
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
                            if (_registrationStep == 0) { _login(); } else { _registerNext(); }
                          },
                    [
                      .text(_loginLoading ? context.tr('Please wait...', '请稍候...') : _registrationStep == 0 ? context.tr('Sign in to Studio', '登录 Studio') : _registrationStep == 1 ? context.tr('Send verification code', '发送验证码') : _registrationStep == 2 ? context.tr('Verify code', '验证验证码') : context.tr('Create account', '完成注册')),
                    ],
                  ),
                  if (_stagingRegistrationEnabled)
                    button(
                      classes: 'login-button',
                      attributes: _loginLoading ? {'disabled': 'disabled'} : null,
                      onClick: _loginLoading ? null : () { setState(() { _registrationStep = _registrationStep == 0 ? 1 : 0; _error = null; _password = ''; }); },
                      [.text(_registrationStep == 0 ? context.tr('Create staging account', '注册测试账号') : context.tr('Back to sign in', '返回登录'))],
                    ),
                ],
              ),
              if (_errorIsMissingFields)
                div(
                  classes: 'login-error',
                  [.text(context.tr('Enter your email and password', '请输入邮箱和密码'))],
                )
              else if (_error != null)
                div(
                  classes: 'login-error',
                  [.text(_error!)],
                ),
              const LanguageSwitcher(),
              const ThemeToggle(),
            ],
          ),
        ],
      );
    }

    return component.child;
  }
}
