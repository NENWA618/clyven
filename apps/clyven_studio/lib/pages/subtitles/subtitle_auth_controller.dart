import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

class SubtitleAuthController {
  SubtitleAuthController({
    required this.client,
    required this.onChanged,
  });

  final Client client;
  final void Function() onChanged;

  String loginEmail = '';
  String loginPassword = '';

  bool loggedIn = false;
  bool loading = false;

  String? error;

  Future<void> restoreLogin() async {
    try {
      await client.auth.initialize();

      loggedIn = client.auth.isAuthenticated;
      onChanged();
    } catch (_) {
      loggedIn = false;
      onChanged();
    }
  }

  Future<void> login() async {
    if (loginEmail.trim().isEmpty || loginPassword.isEmpty) {
      error = '请输入邮箱和密码';
      onChanged();
      return;
    }

    loading = true;
    error = null;
    onChanged();

    try {
      final authSuccess = await client.emailIdp.login(
        email: loginEmail.trim().toLowerCase(),
        password: loginPassword,
      );

      await client.auth.updateSignedInUser(
        authSuccess,
      );

      loggedIn = true;
      loading = false;
      loginPassword = '';

      onChanged();
    } catch (e) {
      loggedIn = false;
      loading = false;
      error = e.toString();

      onChanged();
    }
  }
}
