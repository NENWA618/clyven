import 'package:clyven_app/core/errors/app_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../data/models/user_profile.dart';
import '../../data/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ServerpodProfileRepository(
    client: ref.watch(serverpodClientProvider),
    videoRepository: ref.watch(videoRepositoryProvider),
  );
});

class MyProfileNotifier extends AsyncNotifier<UserProfile> {
  ProfileRepository get _repository {
    return ref.read(profileRepositoryProvider);
  }

  @override
  Future<UserProfile> build() async {
    final user = await ref.watch(authProvider.future);

    if (user == null) {
      throw const AppException(AppErrorCode.notLoggedIn);
    }

    return _repository.loadProfile(
      userId: user.id,
      username: user.username,
      displayName: user.displayName,
      avatarUrl: user.avatarUrl,
    );
  }

  Future<void> refresh() async {
    final user = await ref.read(authProvider.future);

    if (user == null) {
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return _repository.loadProfile(
        userId: user.id,
        username: user.username,
        displayName: user.displayName,
        avatarUrl: user.avatarUrl,
      );
    });
  }

  Future<void> updateBio(String bio) async {
    await _repository.updateBio(bio);
    await refresh();
  }
}

final myProfileProvider = AsyncNotifierProvider<MyProfileNotifier, UserProfile>(
  MyProfileNotifier.new,
);
