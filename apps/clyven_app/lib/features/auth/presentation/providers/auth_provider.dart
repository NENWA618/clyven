import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/models/app_user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/mock_auth_repository.dart';
import '../../data/repositories/serverpod_auth_repository.dart';

// true  = 使用本地 Mock 账号
// false = 使用真正 Serverpod 账号
const bool _useMockAuth = false;

final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  if (_useMockAuth) {
    return MockAuthRepository();
  }

  final client = ref.read(
    serverpodClientProvider,
  );

  return ServerpodAuthRepository(
    client: client,
  );
});

class AuthNotifier
    extends AsyncNotifier<AppUser?> {
  AuthRepository get _repository {
    return ref.read(
      authRepositoryProvider,
    );
  }

  @override
  Future<AppUser?> build() async {
    return _repository.restoreSession();
  }

  Future<void> login({
    required String account,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () {
        return _repository.login(
          account: account,
          password: password,
        );
      },
    );
  }

  // 暂时兼容旧 RegisterPage。
  Future<void> register({
    required String username,
    required String displayName,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () {
        return _repository.register(
          username: username,
          displayName: displayName,
          password: password,
        );
      },
    );
  }

  Future<bool> startRegistration({
    required String email,
  }) async {
    final previousUser = state.value;

    state = const AsyncLoading();

    try {
      await _repository.startRegistration(
        email: email,
      );

      state = AsyncData(
        previousUser,
      );

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(
        error,
        stackTrace,
      );

      return false;
    }
  }

  Future<bool> verifyRegistrationCode({
    required String code,
  }) async {
    final previousUser = state.value;

    state = const AsyncLoading();

    try {
      await _repository.verifyRegistrationCode(
        code: code,
      );

      state = AsyncData(
        previousUser,
      );

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(
        error,
        stackTrace,
      );

      return false;
    }
  }

  Future<bool> finishRegistration({
    required String username,
    required String displayName,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      final user =
          await _repository.finishRegistration(
        username: username,
        displayName: displayName,
        password: password,
      );

      state = AsyncData(user);

      return true;
    } catch (error, stackTrace) {
      state = AsyncError(
        error,
        stackTrace,
      );

      return false;
    }
  }

  Future<void> logout() async {
    final previous = state.value;

    state = const AsyncLoading();

    try {
      await _repository.logout();

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(
        error,
        stackTrace,
      );

      if (previous != null) {
        state = AsyncData(previous);
      }
    }
  }
}

final authProvider =
    AsyncNotifierProvider<
        AuthNotifier,
        AppUser?>(
  AuthNotifier.new,
);