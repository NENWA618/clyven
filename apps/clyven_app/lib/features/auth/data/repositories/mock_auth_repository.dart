import 'package:clyven_app/core/errors/app_error.dart';

import '../models/app_user.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  AppUser? _currentUser;

  String? _pendingEmail;
  bool _registrationVerified = false;

  final Map<String, String> _passwords = {'cheng': '123456'};

  final Map<String, AppUser> _users = {
    'cheng': const AppUser(
      id: 'user-001',
      username: 'cheng',
      displayName: 'Cheng',
      avatarUrl: '',
    ),
  };

  @override
  Future<AppUser?> restoreSession() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return _currentUser;
  }

  @override
  Future<AppUser> login({
    required String account,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final normalizedAccount = account.trim().toLowerCase();

    if (normalizedAccount.isEmpty || password.isEmpty) {
      throw const AppException(AppErrorCode.accountAndPasswordRequired);
    }

    final savedPassword = _passwords[normalizedAccount];
    final user = _users[normalizedAccount];

    if (savedPassword == null || user == null || savedPassword != password) {
      throw const AppException(AppErrorCode.invalidCredentials);
    }

    _currentUser = user;
    return user;
  }

  @override
  Future<AppUser> register({
    required String username,
    required String displayName,
    required String password,
  }) async {
    return _createUser(
      username: username,
      displayName: displayName,
      password: password,
    );
  }

  @override
  Future<void> startRegistration({required String email}) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      throw const AppException(AppErrorCode.invalidEmail);
    }

    _pendingEmail = normalizedEmail;
    _registrationVerified = false;

    // Mock mode uses a fixed verification code: 123456.
  }

  @override
  Future<void> verifyRegistrationCode({required String code}) async {
    if (_pendingEmail == null) {
      throw const AppException(AppErrorCode.registrationNotStarted);
    }

    if (code.trim() != '123456') {
      throw const AppException(AppErrorCode.invalidVerificationCode);
    }

    _registrationVerified = true;
  }

  @override
  Future<AppUser> finishRegistration({
    required String username,
    required String displayName,
    required String password,
  }) async {
    if (_pendingEmail == null) {
      throw const AppException(AppErrorCode.registrationEmailRequired);
    }

    if (!_registrationVerified) {
      throw const AppException(AppErrorCode.emailVerificationPending);
    }

    final user = await _createUser(
      username: username,
      displayName: displayName,
      password: password,
      email: _pendingEmail,
    );

    _pendingEmail = null;
    _registrationVerified = false;

    return user;
  }

  Future<AppUser> _createUser({
    required String username,
    required String displayName,
    required String password,
    String? email,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final normalizedUsername = username.trim().toLowerCase();
    final normalizedDisplayName = displayName.trim();

    if (normalizedUsername.isEmpty) {
      throw const AppException(AppErrorCode.usernameRequired);
    }

    if (normalizedDisplayName.isEmpty) {
      throw const AppException(AppErrorCode.displayNameRequired);
    }

    if (password.length < 6) {
      throw const AppException(AppErrorCode.passwordTooShort6);
    }

    if (_users.containsKey(normalizedUsername)) {
      throw const AppException(AppErrorCode.usernameTaken);
    }

    final user = AppUser(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      username: normalizedUsername,
      displayName: normalizedDisplayName,
      avatarUrl: '',
    );

    _users[normalizedUsername] = user;
    _passwords[normalizedUsername] = password;

    if (email != null) {
      final normalizedEmail = email.trim().toLowerCase();
      _users[normalizedEmail] = user;
      _passwords[normalizedEmail] = password;
    }

    _currentUser = user;
    return user;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _currentUser = null;
  }
}
