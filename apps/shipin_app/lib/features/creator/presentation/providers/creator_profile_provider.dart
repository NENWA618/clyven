import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/creator_profile.dart';
import '../../data/repositories/creator_repository.dart';

final creatorRepositoryProvider =
    Provider<CreatorRepository>((ref) {
  return MockCreatorRepository();
});

final followingCreatorIdsProvider =
    FutureProvider<List<String>>((ref) async {
  final user = await ref.watch(
    authProvider.future,
  );

  if (user == null) {
    return const [];
  }

  final repository = ref.read(
    creatorRepositoryProvider,
  );

  return repository.loadFollowingCreatorIds(
    userId: user.id,
  );
});

class CreatorProfileState {
  final CreatorProfile creator;

  final bool isFollowing;

  final bool isChangingFollow;

  const CreatorProfileState({
    required this.creator,
    required this.isFollowing,
    required this.isChangingFollow,
  });

  CreatorProfileState copyWith({
    CreatorProfile? creator,
    bool? isFollowing,
    bool? isChangingFollow,
  }) {
    return CreatorProfileState(
      creator:
          creator ?? this.creator,
      isFollowing:
          isFollowing ?? this.isFollowing,
      isChangingFollow:
          isChangingFollow ??
          this.isChangingFollow,
    );
  }
}

class CreatorProfileNotifier
    extends AsyncNotifier<
        CreatorProfileState> {
  final String creatorId;

  CreatorProfileNotifier(
    this.creatorId,
  );

  CreatorRepository get _repository {
    return ref.read(
      creatorRepositoryProvider,
    );
  }

  @override
  Future<CreatorProfileState>
      build() async {
    final user = await ref.watch(
      authProvider.future,
    );

    if (user == null) {
      throw StateError(
        '用户尚未登录',
      );
    }

    final creator =
        await _repository
            .loadCreatorProfile(
      creatorId,
    );

    final isFollowing =
        await _repository.isFollowing(
      userId: user.id,
      creatorId: creatorId,
    );

    return CreatorProfileState(
      creator: creator,
      isFollowing: isFollowing,
      isChangingFollow: false,
    );
  }

  Future<void> toggleFollow() async {
    final current = state.value;

    if (current == null) {
      return;
    }

    if (current.isChangingFollow) {
      return;
    }

    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        isChangingFollow: true,
      ),
    );

    try {
      final following =
          await _repository.toggleFollow(
        userId: user.id,
        creatorId: creatorId,
        currentlyFollowing:
            current.isFollowing,
      );

      final oldFollowerCount =
          current.creator.followerCount;

      final newFollowerCount =
          following
              ? oldFollowerCount + 1
              : oldFollowerCount > 0
                  ? oldFollowerCount - 1
                  : 0;

      final updatedCreator =
          CreatorProfile(
        id: current.creator.id,
        name: current.creator.name,
        bio: current.creator.bio,
        avatarUrl:
            current.creator.avatarUrl,
        bannerUrl:
            current.creator.bannerUrl,
        followerCount:
            newFollowerCount,
        followingCount:
            current
                .creator
                .followingCount,
        videoCount:
            current.creator.videoCount,
        totalViewCount:
            current
                .creator
                .totalViewCount,
        videos:
            current.creator.videos,
      );

      state = AsyncData(
        current.copyWith(
          creator: updatedCreator,
          isFollowing: following,
          isChangingFollow: false,
        ),
      );

      ref.invalidate(
        followingCreatorIdsProvider,
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isChangingFollow: false,
        ),
      );
    }
  }

  Future<void> refresh() async {
    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    final current = state.value;

    state = const AsyncLoading();

    try {
      final creator =
          await _repository
              .loadCreatorProfile(
        creatorId,
      );

      final isFollowing =
          await _repository.isFollowing(
        userId: user.id,
        creatorId: creatorId,
      );

      state = AsyncData(
        CreatorProfileState(
          creator: creator,
          isFollowing: isFollowing,
          isChangingFollow: false,
        ),
      );
    } catch (error, stackTrace) {
      if (current != null) {
        state = AsyncData(current);
        return;
      }

      state = AsyncError(
        error,
        stackTrace,
      );
    }
  }
}

final creatorProfileProvider =
    AsyncNotifierProvider.family<
        CreatorProfileNotifier,
        CreatorProfileState,
        String>(
  CreatorProfileNotifier.new,
);