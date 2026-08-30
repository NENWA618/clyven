import 'package:glyphora_backend_client/glyphora_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../models/app_user.dart';
import 'auth_repository.dart';

class ServerpodAuthRepository
    implements AuthRepository {
  final Client client;

  late final EmailAuthController
      _emailController =
      EmailAuthController(
    client: client,
    startScreen:
        EmailFlowScreen.login,
  );

  ServerpodAuthRepository({
    required this.client,
  });

  @override
  Future<AppUser?> restoreSession() async {
    await client.auth.initialize();

    if (!client.auth.isAuthenticated) {
      return null;
    }

    return _loadCurrentUser();
  }

  @override
  Future<AppUser> login({
    required String account,
    required String password,
  }) async {
    final email =
        account.trim().toLowerCase();

    if (email.isEmpty) {
      throw StateError(
        '请输入邮箱',
      );
    }

    if (password.isEmpty) {
      throw StateError(
        '请输入密码',
      );
    }

    _emailController.navigateTo(
      EmailFlowScreen.login,
    );

    _emailController
        .emailController
        .text = email;

    _emailController
        .passwordController
        .text = password;

    await _emailController.login();

    if (!_emailController.isAuthenticated) {
      throw StateError(
        _emailController.errorMessage ??
            '邮箱或密码错误',
      );
    }

    return _loadCurrentUser();
  }

  // 真实 Serverpod 注册必须经过邮箱验证码。
  // 暂时保留这个方法只是为了兼容现有 RegisterPage。
  @override
  Future<AppUser> register({
    required String username,
    required String displayName,
    required String password,
  }) {
    throw StateError(
      '真实账号需要先验证邮箱',
    );
  }

  @override
  Future<void> startRegistration({
    required String email,
  }) async {
    final normalizedEmail =
        email.trim().toLowerCase();

    if (normalizedEmail.isEmpty ||
        !normalizedEmail.contains('@')) {
      throw StateError(
        '请输入有效邮箱',
      );
    }

    _emailController.navigateTo(
      EmailFlowScreen.startRegistration,
    );

    _emailController
        .emailController
        .text = normalizedEmail;

    await _emailController
        .startRegistration();

    final error =
        _emailController.errorMessage;

    if (error != null) {
      throw StateError(error);
    }
  }

  @override
  Future<void> verifyRegistrationCode({
    required String code,
  }) async {
    final normalizedCode =
        code.trim();

    if (normalizedCode.isEmpty) {
      throw StateError(
        '请输入验证码',
      );
    }

    _emailController
        .verificationCodeController
        .text = normalizedCode;

    await _emailController
        .verifyRegistrationCode();

    final error =
        _emailController.errorMessage;

    if (error != null) {
      throw StateError(error);
    }
  }

  @override
  Future<AppUser> finishRegistration({
    required String username,
    required String displayName,
    required String password,
  }) async {
    final normalizedUsername =
        username.trim();

    final normalizedDisplayName =
        displayName.trim();

    if (normalizedUsername.isEmpty) {
      throw StateError(
        '用户名不能为空',
      );
    }

    if (normalizedDisplayName.isEmpty) {
      throw StateError(
        '显示名称不能为空',
      );
    }

    // Serverpod Email IdP 默认最低 8 位。
    if (password.length < 8) {
      throw StateError(
        '密码至少需要 8 个字符',
      );
    }

    _emailController
        .passwordController
        .text = password;

    await _emailController
        .finishRegistration();

    if (!_emailController.isAuthenticated) {
      throw StateError(
        _emailController.errorMessage ??
            '注册失败',
      );
    }

    // 注册成功后写入社区用户名。
    await client.userProfileEdit
        .changeUserName(
      normalizedUsername,
    );

    // 写入显示名称。
    await client.userProfileEdit
        .changeFullName(
      normalizedDisplayName,
    );

    return _loadCurrentUser();
  }

  @override
  Future<void> logout() async {
    await client.auth.signOutDevice();
  }

  Future<AppUser> _loadCurrentUser() async {
    final profile =
        await client.userProfileEdit.get();

    final username =
        profile.userName ??
        profile.email ??
        '';

    final displayName =
        profile.fullName ??
        profile.userName ??
        profile.email ??
        '';

    return AppUser(
      id:
          profile.authUserId.toString(),
      username: username,
      displayName: displayName,
      avatarUrl:
          profile.imageUrl?.toString() ??
          '',
    );
  }
}