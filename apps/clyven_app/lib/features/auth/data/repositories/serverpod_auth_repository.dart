import 'dart:typed_data';

import 'package:clyven_app/core/errors/app_error.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../models/app_user.dart';
import 'auth_repository.dart';

class ServerpodAuthRepository implements AuthRepository {
  final Client client;

  late final EmailAuthController _emailController = EmailAuthController(
    client: client,
    startScreen: EmailFlowScreen.login,
  );

  ServerpodAuthRepository({required this.client});

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
    final email = account.trim().toLowerCase();

    if (email.isEmpty) {
      throw const AppException(AppErrorCode.emailRequired);
    }

    if (password.isEmpty) {
      throw const AppException(AppErrorCode.passwordRequired);
    }

    _emailController.navigateTo(EmailFlowScreen.login);

    _emailController.emailController.text = email;
    _emailController.passwordController.text = password;

    await _emailController.login();

    if (!_emailController.isAuthenticated) {
      throw AppException(
        AppErrorCode.invalidCredentials,
        technicalDetails: _emailController.errorMessage,
      );
    }

    return _loadCurrentUser();
  }

  // Real Serverpod registration must go through email verification first.
  // This method remains only for compatibility with the existing repository API.
  @override
  Future<AppUser> register({
    required String username,
    required String displayName,
    required String password,
  }) {
    throw const AppException(AppErrorCode.emailVerificationRequired);
  }

  @override
  Future<void> startRegistration({required String email}) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      throw const AppException(AppErrorCode.invalidEmail);
    }

    _emailController.navigateTo(EmailFlowScreen.startRegistration);

    _emailController.emailController.text = normalizedEmail;

    await _emailController.startRegistration();

    final error = _emailController.errorMessage;

    if (error != null) {
      throw AppException(
        AppErrorCode.authOperationFailed,
        technicalDetails: error,
      );
    }
  }

  @override
  Future<void> verifyRegistrationCode({required String code}) async {
    final normalizedCode = code.trim();

    if (normalizedCode.isEmpty) {
      throw const AppException(AppErrorCode.verificationCodeRequired);
    }

    _emailController.verificationCodeController.text = normalizedCode;

    await _emailController.verifyRegistrationCode();

    final error = _emailController.errorMessage;

    if (error != null) {
      throw AppException(
        AppErrorCode.invalidVerificationCode,
        technicalDetails: error,
      );
    }
  }

  @override
  Future<AppUser> finishRegistration({
    required String username,
    required String displayName,
    required String password,
  }) async {
    final normalizedUsername = username.trim();
    final normalizedDisplayName = displayName.trim();

    if (normalizedUsername.isEmpty) {
      throw const AppException(AppErrorCode.usernameRequired);
    }

    if (normalizedDisplayName.isEmpty) {
      throw const AppException(AppErrorCode.displayNameRequired);
    }

    if (password.length < 8) {
      throw const AppException(AppErrorCode.passwordTooShort8);
    }

    _emailController.passwordController.text = password;

    await _emailController.finishRegistration();

    if (!_emailController.isAuthenticated) {
      throw AppException(
        AppErrorCode.registrationFailed,
        technicalDetails: _emailController.errorMessage,
      );
    }

    await client.userProfileEdit.changeUserName(normalizedUsername);

    await client.userProfileEdit.changeFullName(normalizedDisplayName);

    return _loadCurrentUser();
  }

  @override
  Future<void> logout() async {
    await client.auth.signOutDevice();
  }

  @override
  Future<AppUser> updateProfile({
    required String username,
    required String displayName,
    Uint8List? avatarBytes,
    bool removeAvatar = false,
  }) async {
    final normalizedUsername = username.trim();
    final normalizedDisplayName = displayName.trim();
    if (normalizedUsername.isEmpty) {
      throw const AppException(AppErrorCode.usernameRequired);
    }
    if (normalizedDisplayName.isEmpty) {
      throw const AppException(AppErrorCode.displayNameRequired);
    }
    await client.userProfileEdit.changeUserName(normalizedUsername);
    await client.userProfileEdit.changeFullName(normalizedDisplayName);
    if (removeAvatar) {
      await client.userProfileEdit.removeUserImage();
    } else if (avatarBytes != null) {
      await client.userProfileEdit.setUserImage(
        ByteData.sublistView(avatarBytes),
      );
    }
    return _loadCurrentUser();
  }

  Future<AppUser> _loadCurrentUser() async {
    final profile = await client.userProfileEdit.get();

    final username = profile.userName ?? profile.email ?? '';
    final displayName =
        profile.fullName ?? profile.userName ?? profile.email ?? '';

    return AppUser(
      id: profile.authUserId.toString(),
      username: username,
      displayName: displayName,
      avatarUrl: profile.imageUrl?.toString() ?? '',
    );
  }
}
