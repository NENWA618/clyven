import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../data/models/video_interaction_state.dart';
import '../../data/repositories/video_interaction_repository.dart';

final videoInteractionRepositoryProvider =
    Provider<VideoInteractionRepository>((ref) {
  return MockVideoInteractionRepository();
});

final favoriteVideoIdsProvider =
    FutureProvider<List<String>>((ref) async {
  final user = await ref.watch(
    authProvider.future,
  );

  if (user == null) {
    return const [];
  }

  final repository = ref.read(
    videoInteractionRepositoryProvider,
  );

  return repository.loadFavoriteVideoIds(
    userId: user.id,
  );
});

class VideoInteractionNotifier
    extends AsyncNotifier<VideoInteractionState> {
  final String videoId;

  VideoInteractionNotifier(
    this.videoId,
  );

  VideoInteractionRepository get _repository {
    return ref.read(
      videoInteractionRepositoryProvider,
    );
  }

  @override
  Future<VideoInteractionState> build() async {
    final user = await ref.watch(
      authProvider.future,
    );

    if (user == null) {
      throw StateError(
        '用户尚未登录',
      );
    }

    final video = await ref.watch(
      videoDetailProvider(
        videoId,
      ).future,
    );

    return _repository.load(
      videoId: videoId,
      userId: user.id,
      initialLikeCount: video.likeCount,
      initialFavoriteCount:
          video.favoriteCount,
    );
  }

  Future<void> toggleLike() async {
    final current = state.value;

    if (current == null) {
      return;
    }

    if (current.isChangingLike) {
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
        isChangingLike: true,
      ),
    );

    try {
      final liked =
          await _repository.toggleLike(
        videoId: videoId,
        userId: user.id,
        currentlyLiked:
            current.isLiked,
      );

      state = AsyncData(
        current.copyWith(
          isLiked: liked,
          likeCount: liked
              ? current.likeCount + 1
              : current.likeCount > 0
                  ? current.likeCount - 1
                  : 0,
          isChangingLike: false,
        ),
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isChangingLike: false,
        ),
      );
    }
  }

  Future<void> toggleFavorite() async {
    final current = state.value;

    if (current == null) {
      return;
    }

    if (current.isChangingFavorite) {
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
        isChangingFavorite: true,
      ),
    );

    try {
      final favorited =
          await _repository.toggleFavorite(
        videoId: videoId,
        userId: user.id,
        currentlyFavorited:
            current.isFavorited,
      );

      state = AsyncData(
        current.copyWith(
          isFavorited: favorited,
          favoriteCount: favorited
              ? current.favoriteCount + 1
              : current.favoriteCount > 0
                  ? current.favoriteCount - 1
                  : 0,
          isChangingFavorite: false,
        ),
      );

      ref.invalidate(
        favoriteVideoIdsProvider,
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isChangingFavorite: false,
        ),
      );
    }
  }
}

final videoInteractionProvider =
    AsyncNotifierProvider.family<
        VideoInteractionNotifier,
        VideoInteractionState,
        String>(
  VideoInteractionNotifier.new,
);