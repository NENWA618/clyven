import 'dart:developer' as developer;

import 'package:clyven_app/core/errors/app_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/models/video_interaction_state.dart';
import '../../data/repositories/video_interaction_repository.dart';

final videoInteractionRepositoryProvider = Provider<VideoInteractionRepository>(
  (ref) {
    return ServerpodVideoInteractionRepository(
      client: ref.watch(serverpodClientProvider),
    );
  },
);

final favoriteVideoIdsProvider = FutureProvider<List<String>>((ref) async {
  ref.watch(authProvider);
  final user = await ref.watch(authProvider.future);

  if (user == null) {
    return const [];
  }

  final repository = ref.read(videoInteractionRepositoryProvider);

  return repository.loadFavoriteVideoIds(userId: user.id);
});

class VideoInteractionNotifier extends AsyncNotifier<VideoInteractionState> {
  final String videoId;
  int _generation = 0;

  VideoInteractionNotifier(this.videoId);

  VideoInteractionRepository get _repository {
    return ref.read(videoInteractionRepositoryProvider);
  }

  @override
  Future<VideoInteractionState> build() async {
    ++_generation;
    ref.watch(authProvider);
    try {
      final user = await ref.watch(authProvider.future);

      if (user == null) {
        throw const AppException(AppErrorCode.notLoggedIn);
      }

      final video = await ref.read(videoDetailProvider(videoId).future);

      return await _repository.load(
        videoId: videoId,
        userId: user.id,
        initialLikeCount: video.likeCount,
        initialFavoriteCount: video.favoriteCount,
      );
    } catch (error, stackTrace) {
      if (error is! AppException || error.code != AppErrorCode.notLoggedIn) {
        _report('VIDEO_INTERACTION_LOAD_FAILED', error, stackTrace);
      }
      rethrow;
    }
  }

  Future<void> toggleLike() async {
    if (await _readyState() == null) return;
    final current = state.unwrapPrevious().value;

    if (current == null) {
      return;
    }

    if (current.isChangingLike || current.isChangingFavorite) {
      return;
    }

    final user = ref.read(authProvider).value;

    if (user == null) {
      return;
    }

    final optimisticLiked = !current.isLiked;
    final optimisticLikeCount = optimisticLiked
        ? current.likeCount + 1
        : current.likeCount > 0
        ? current.likeCount - 1
        : 0;

    state = AsyncData(
      current.copyWith(
        isLiked: optimisticLiked,
        likeCount: optimisticLikeCount,
        isChangingLike: true,
      ),
    );

    final generation = _generation;

    try {
      final liked = await _repository.toggleLike(
        videoId: videoId,
        userId: user.id,
        currentlyLiked: current.isLiked,
        actorName: user.displayName,
      );
      if (!ref.mounted || generation != _generation) return;

      final resolvedCount = liked == optimisticLiked
          ? optimisticLikeCount
          : liked
          ? optimisticLikeCount + 1
          : optimisticLikeCount > 0
          ? optimisticLikeCount - 1
          : 0;

      state = AsyncData(
        current.copyWith(
          isLiked: liked,
          likeCount: resolvedCount,
          isChangingLike: false,
        ),
      );

      ref.invalidate(videoDetailProvider(videoId));
    } catch (error, stackTrace) {
      _report('VIDEO_LIKE_FAILED', error, stackTrace);
      if (!ref.mounted || generation != _generation) return;

      // Roll back the optimistic UI on failure.
      state = AsyncData(current.copyWith(isChangingLike: false));
    }
  }

  Future<void> toggleFavorite() async {
    if (await _readyState() == null) return;
    final current = state.unwrapPrevious().value;

    if (current == null) {
      return;
    }

    if (current.isChangingLike || current.isChangingFavorite) {
      return;
    }

    final user = ref.read(authProvider).value;

    if (user == null) {
      return;
    }

    final optimisticFavorited = !current.isFavorited;
    final optimisticFavoriteCount = optimisticFavorited
        ? current.favoriteCount + 1
        : current.favoriteCount > 0
        ? current.favoriteCount - 1
        : 0;

    state = AsyncData(
      current.copyWith(
        isFavorited: optimisticFavorited,
        favoriteCount: optimisticFavoriteCount,
        isChangingFavorite: true,
      ),
    );

    final generation = _generation;

    try {
      final favorited = await _repository.toggleFavorite(
        videoId: videoId,
        userId: user.id,
        currentlyFavorited: current.isFavorited,
      );
      if (!ref.mounted || generation != _generation) return;

      final resolvedCount = favorited == optimisticFavorited
          ? optimisticFavoriteCount
          : favorited
          ? optimisticFavoriteCount + 1
          : optimisticFavoriteCount > 0
          ? optimisticFavoriteCount - 1
          : 0;

      state = AsyncData(
        current.copyWith(
          isFavorited: favorited,
          favoriteCount: resolvedCount,
          isChangingFavorite: false,
        ),
      );

      ref.invalidate(videoDetailProvider(videoId));
      ref.invalidate(favoriteVideoIdsProvider);
    } catch (error, stackTrace) {
      _report('VIDEO_FAVORITE_FAILED', error, stackTrace);
      if (!ref.mounted || generation != _generation) return;

      // Roll back the optimistic UI on failure.
      state = AsyncData(current.copyWith(isChangingFavorite: false));
    }
  }

  Future<VideoInteractionState?> _readyState() async {
    try {
      if (state.hasError && ref.read(authProvider).value != null) {
        ref.invalidateSelf();
      }
      // A login dialog can finish before the authenticated interaction load.
      // Await that load instead of silently dropping the first action.
      await future;
      if (!ref.mounted) return null;
      return state.unwrapPrevious().value;
    } catch (error, stackTrace) {
      _report('VIDEO_INTERACTION_ACTION_FAILED', error, stackTrace);
      return null;
    }
  }

  void _report(String event, Object error, StackTrace stackTrace) {
    developer.log(
      '$event videoId=$videoId',
      name: 'video_interactions',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

final videoInteractionProvider =
    AsyncNotifierProvider.family<
      VideoInteractionNotifier,
      VideoInteractionState,
      String
    >(
      VideoInteractionNotifier.new,
      // Authentication/missing-method failures need login or a backend fix,
      // not Riverpod's automatic retry loop. A new action can retry explicitly.
      retry: (retryCount, error) => null,
    );
