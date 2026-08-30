import '../models/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> restoreSession();

  Future<AppUser> login({
    required String account,
    required String password,
  });

  // 暂时保留旧注册接口，
  // 让现有 RegisterPage 在改造前不会直接编译报错。
  Future<AppUser> register({
    required String username,
    required String displayName,
    required String password,
  });

  Future<void> startRegistration({
    required String email,
  });

  Future<void> verifyRegistrationCode({
    required String code,
  });

  Future<AppUser> finishRegistration({
    required String username,
    required String displayName,
    required String password,
  });

  Future<void> logout();
}