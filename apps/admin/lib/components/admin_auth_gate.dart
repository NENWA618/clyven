import 'package:glyphora_web_l10n/web_l10n.dart';
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
      consumeWebSession();
      await restoreStoredSession();

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
      await adminClient.adminMembership.getWorkspace();

      if (!mounted) return;

      setState(() {
        _loading = false;
        _signedIn = true;
        _authorized = true;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _signedIn = true;
        _authorized = false;
        _error = e is ServerpodClientException
            ? trNow('This Glyphora account is not an active member of the Admin Workspace.', '当前 Glyphora 账号不是 Admin Workspace 的有效成员。')
            : trNow(
                'Could not reach the server. Check your connection and reload.',
                '无法连接服务器，请检查网络后刷新页面。',
              );
      });
    }
  }

  Future<void> _login() async {
    final email = _email.trim().toLowerCase();

    if (email.isEmpty || _password.isEmpty) {
      setState(() {
        _error = trNow('Enter your Glyphora email and password', '请输入 Glyphora 邮箱和密码');
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
          h2([.text('Glyphora Admin')]),
          p([.text(context.tr('Restoring the admin session…', '正在恢复管理员会话…'))]),
        ]),
      ]);
    }

    if (!_authorized) {
      return div(classes: 'admin-auth-screen', [
        div(classes: 'admin-auth-card', [
          div(classes: 'admin-auth-badge', [.text('INTERNAL')]),
          h1([.text('Glyphora Admin')]),
          p([
            .text(
              _signedIn
                  ? context.tr('You are signed in to Glyphora, but this account has no admin access.', '你已经登录 Glyphora，但这个账号没有管理员权限。')
                  : context.tr('Sign in with a Glyphora account that has admin access.', '使用拥有管理员权限的 Glyphora 账号登录。'),
            ),
          ]),
          if (!_signedIn) ...[
            input<String>(
              type: InputType.email,
              attributes: {
                'placeholder': context.tr('Glyphora email', 'Glyphora 邮箱'),
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
                'placeholder': context.tr('Password', '密码'),
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
              [.text(_loginLoading ? context.tr('Signing in…', '登录中…') : context.tr('Sign in to Admin', '登录管理员平台'))],
            ),
          ] else
            button(
              type: ButtonType.button,
              classes: 'admin-secondary-button',
              onClick: _signOut,
              [.text(context.tr('Sign out and switch account', '退出并换一个账号'))],
            ),
          if (_error != null) div(classes: 'admin-error', [.text(_error!)]),
          const LanguageSwitcher(),
          const ThemeToggle(),
        ]),
      ]);
    }

    return component.child;
  }
}
