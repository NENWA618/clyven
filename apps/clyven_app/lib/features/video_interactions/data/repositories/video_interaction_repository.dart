import 'package:clyven_backend_client/clyven_backend_client.dart';

import '../models/video_interaction_state.dart';

abstract class VideoInteractionRepository {
  Future<VideoInteractionState> load({
    required String videoId,
    required String userId,
    required int initialLikeCount,
    required int initialFavoriteCount,
  });

  Future<bool> toggleLike({
    required String videoId,
    required String userId,
    required bool currentlyLiked,
  });

  Future<bool> toggleFavorite({
    required String videoId,
    required String userId,
    required bool currentlyFavorited,
  });

  Future<List<String>> loadFavoriteVideoIds({required String userId});
}

class ServerpodVideoInteractionRepository
    implements VideoInteractionRepository {
  final Client client;

  ServerpodVideoInteractionRepository({required this.client});

  final Set<String> _likes = {};

  final Map<String, int> _likeCounts = {};
  final Map<String, int> _favoriteCounts = {};

  String _key({required String userId, required String videoId}) {
    return '$userId::$videoId';
  }

  @override
  Future<VideoInteractionState> load({
    required String videoId,
    required String userId,
    required int initialLikeCount,
    required int initialFavoriteCount,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));

    _likeCounts.putIfAbsent(videoId, () => initialLikeCount);

    _favoriteCounts.putIfAbsent(videoId, () => initialFavoriteCount);

    final key = _key(userId: userId, videoId: videoId);

    final favoriteIds = await client.social.getFavoriteVideoIds();
    return VideoInteractionState(
      likeCount: _likeCounts[videoId] ?? 0,
      favoriteCount: _favoriteCounts[videoId] ?? 0,
      isLiked: _likes.contains(key),
      isFavorited: favoriteIds.contains(int.parse(videoId)),
    );
  }

  @override
  Future<bool> toggleLike({
    required String videoId,
    required String userId,
    required bool currentlyLiked,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final key = _key(userId: userId, videoId: videoId);

    final currentCount = _likeCounts[videoId] ?? 0;

    if (currentlyLiked) {
      _likes.remove(key);

      _likeCounts[videoId] = currentCount > 0 ? currentCount - 1 : 0;

      return false;
    }

    _likes.add(key);

    _likeCounts[videoId] = currentCount + 1;

    return true;
  }

  @override
  Future<bool> toggleFavorite({
    required String videoId,
    required String userId,
    required bool currentlyFavorited,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return client.social.toggleFavorite(int.parse(videoId));
  }

  @override
  Future<List<String>> loadFavoriteVideoIds({required String userId}) async {
    final ids = await client.social.getFavoriteVideoIds();
    return ids.map((id) => id.toString()).toList(growable: false);
  }
}
