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
    required String actorName,
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

  @override
  Future<VideoInteractionState> load({
    required String videoId,
    required String userId,
    required int initialLikeCount,
    required int initialFavoriteCount,
  }) async {
    final likedIds = await client.social.getLikedVideoIds();
    final favoriteIds = await client.social.getFavoriteVideoIds();
    final id = int.parse(videoId);

    return VideoInteractionState(
      likeCount: initialLikeCount,
      favoriteCount: initialFavoriteCount,
      isLiked: likedIds.contains(id),
      isFavorited: favoriteIds.contains(id),
    );
  }

  @override
  Future<bool> toggleLike({
    required String videoId,
    required String userId,
    required bool currentlyLiked,
    required String actorName,
  }) {
    return client.social.toggleLike(int.parse(videoId), actorName: actorName);
  }

  @override
  Future<bool> toggleFavorite({
    required String videoId,
    required String userId,
    required bool currentlyFavorited,
  }) {
    return client.social.toggleFavorite(int.parse(videoId));
  }

  @override
  Future<List<String>> loadFavoriteVideoIds({required String userId}) async {
    final ids = await client.social.getFavoriteVideoIds();
    return ids.map((id) => id.toString()).toList(growable: false);
  }
}
