import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../services/admin_client.dart';

class AdminAuthGate extends StatefulComponent {
  const AdminAuthGate({required this.child, super.key});

  final Component child;

  @override
  State<AdminAuthGate> createState() => _AdminAuthGateState();
}

class _AdminAuthGateState extends State<AdminAuthGate> {
  String _email = '';
  String _password = '';

  bool _loading = true;
  bool _loginLoading = false;
  bool _authorized = false;
  bool _signedIn = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    try {
      await adminClient.auth.initialize();

      if (!mounted) return;

      if (!adminClient.auth.isAuthenticated) {
        setState(() {
          _loading = false;
          _signedIn = false;
          _authorized = false;
        });
        return;
      }

      await _verifyAdmin();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _authorized = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _verifyAdmin() async {
    try {
      await adminClient.admin.ping();

      if (!mounted) return;

      setState(() {
        _loading = false;
        _signedIn = true;
        _authorized = true;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _signedIn = true;
        _authorized = false;
        _error = '当前 Clyven 账号没有管理员权限。';
      });
    }
  }

  Future<void> _login() async {
    final email = _email.trim().toLowerCase();

    if (email.isEmpty || _password.isEmpty) {
      setState(() {
        _error = '请输入 Clyven 邮箱和密码';
      });
      return;
    }

    setState(() {
      _loginLoading = true;
      _error = null;
    });

    try {
      final authSuccess = await adminClient.emailIdp.login(
        email: email,
        password: _password,
      );

      await adminClient.auth.updateSignedInUser(authSuccess);

      if (!mounted) return;

      _password = '';
      await _verifyAdmin();

      if (!mounted) return;
      setState(() {
        _loginLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loginLoading = false;
        _signedIn = false;
        _authorized = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _signOut() async {
    await adminClient.auth.signOutDevice();

    if (!mounted) return;

    setState(() {
      _signedIn = false;
      _authorized = false;
      _error = null;
    });
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(classes: 'admin-auth-screen', [
        div(classes: 'admin-auth-card', [
          h2([.text('Clyven Admin')]),
          p([.text('正在恢复管理员会话…')]),
        ]),
      ]);
    }

    if (!_authorized) {
      return div(classes: 'admin-auth-screen', [
        div(classes: 'admin-auth-card', [
          div(classes: 'admin-auth-badge', [.text('INTERNAL')]),
          h1([.text('Clyven Admin')]),
          p([
            .text(
              _signedIn
                  ? '你已经登录 Clyven，但这个账号没有管理员权限。'
                  : '使用拥有管理员权限的 Clyven 账号登录。',
            ),
          ]),
          if (!_signedIn) ...[
            input<String>(
              type: InputType.email,
              attributes: {
                'placeholder': 'Clyven email',
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
              type: ButtonType.button,
              classes: 'admin-primary-button',
              attributes: _loginLoading ? {'disabled': 'disabled'} : null,
              onClick: _loginLoading ? null : _login,
              [.text(_loginLoading ? '登录中…' : '登录管理员平台')],
            ),
          ] else
            button(
              type: ButtonType.button,
              classes: 'admin-secondary-button',
              onClick: _signOut,
              [.text('退出并换一个账号')],
            ),
          if (_error != null) div(classes: 'admin-error', [.text(_error!)]),
        ]),
      ]);
    }

    return component.child;
  }
}
