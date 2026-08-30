import '../models/app_user.dart';
import 'auth_repository.dart';

class MockAuthRepository
    implements AuthRepository {
  AppUser? _currentUser;

  String? _pendingEmail;
  bool _registrationVerified = false;

  final Map<String, String> _passwords = {
    'cheng': '123456',
  };

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
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return _currentUser;
  }

  @override
  Future<AppUser> login({
    required String account,
    required String password,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    final normalizedAccount =
        account.trim().toLowerCase();

    if (normalizedAccount.isEmpty ||
        password.isEmpty) {
      throw StateError(
        '账号和密码不能为空',
      );
    }

    final savedPassword =
        _passwords[normalizedAccount];

    final user =
        _users[normalizedAccount];

    if (savedPassword == null ||
        user == null ||
        savedPassword != password) {
      throw StateError(
        '账号或密码错误',
      );
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

    _pendingEmail = normalizedEmail;
    _registrationVerified = false;

    // Mock 模式固定使用 123456。
  }

  @override
  Future<void> verifyRegistrationCode({
    required String code,
  }) async {
    if (_pendingEmail == null) {
      throw StateError(
        '请先开始注册',
      );
    }

    if (code.trim() != '123456') {
      throw StateError(
        '验证码错误',
      );
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
      throw StateError(
        '请先填写邮箱',
      );
    }

    if (!_registrationVerified) {
      throw StateError(
        '请先验证邮箱',
      );
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
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    final normalizedUsername =
        username.trim().toLowerCase();

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

    if (password.length < 6) {
      throw StateError(
        '密码至少需要 6 个字符',
      );
    }

    if (_users.containsKey(
      normalizedUsername,
    )) {
      throw StateError(
        '这个用户名已经被使用',
      );
    }

    final user = AppUser(
      id:
          'user-${DateTime.now().microsecondsSinceEpoch}',
      username: normalizedUsername,
      displayName: normalizedDisplayName,
      avatarUrl: '',
    );

    _users[normalizedUsername] = user;
    _passwords[normalizedUsername] =
        password;

    if (email != null) {
      final normalizedEmail =
          email.trim().toLowerCase();

      _users[normalizedEmail] = user;
      _passwords[normalizedEmail] =
          password;
    }

    _currentUser = user;

    return user;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    _currentUser = null;
  }
}