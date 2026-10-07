import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../services/review_client.dart';

class ReviewAuthGate extends StatefulComponent {
  const ReviewAuthGate({required this.child, super.key});

  final Component child;

  @override
  State<ReviewAuthGate> createState() => _ReviewAuthGateState();
}

class _ReviewAuthGateState extends State<ReviewAuthGate> {
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

      if (!reviewClient.auth.isAuthenticated) {
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
      await reviewClient.admin.ping();

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
            ? trNow('The Review entry currently requires admin access.', '当前版本的 Review 入口暂时要求管理员权限。')
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
      final authSuccess = await reviewClient.emailIdp.login(
        email: email,
        password: _password,
      );

      await reviewClient.auth.updateSignedInUser(authSuccess);

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
    await reviewClient.auth.signOutDevice();

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
          h2([.text('Glyphora Review')]),
          p([.text(context.tr('Restoring the subtitle review session…', '正在恢复字幕审核会话…'))]),
        ]),
      ]);
    }

    if (!_authorized) {
      return div(classes: 'admin-auth-screen', [
        div(classes: 'admin-auth-card', [
          div(classes: 'admin-auth-badge', [.text('INTERNAL')]),
          h1([.text('Glyphora Review')]),
          p([
            .text(
              _signedIn
                  ? context.tr('You are signed in to Glyphora, but this account has no Review access yet.', '你已经登录 Glyphora，但当前账号还没有 Review 访问权限。')
                  : context.tr('Sign in with an internal subtitle review account.', '使用内部字幕审核账号登录。'),
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
              [.text(_loginLoading ? context.tr('Signing in…', '登录中…') : context.tr('Sign in to Review', '登录 Review'))],
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
        ]),
      ]);
    }

    return component.child;
  }
}
