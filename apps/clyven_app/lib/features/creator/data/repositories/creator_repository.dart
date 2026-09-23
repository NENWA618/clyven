import 'package:clyven_backend_client/clyven_backend_client.dart';

import '../../../video/data/repositories/video_repository.dart';
import '../models/creator_profile.dart';

abstract class CreatorRepository {
  Future<CreatorProfile> loadCreatorProfile(String creatorId);
  Future<bool> isFollowing({required String userId, required String creatorId});
  Future<List<String>> loadFollowingCreatorIds({required String userId});
  Future<bool> toggleFollow({
    required String userId,
    required String creatorId,
    required bool currentlyFollowing,
  });
}

class ServerpodCreatorRepository implements CreatorRepository {
  final Client client;
  final VideoRepository videoRepository;

  const ServerpodCreatorRepository({
    required this.client,
    required this.videoRepository,
  });

  @override
  Future<CreatorProfile> loadCreatorProfile(String creatorId) async {
    final stats = await client.social.getProfileStats(creatorId);
    final videos = await videoRepository.loadUserVideos(userId: creatorId);
    final name = videos.isEmpty ? creatorId : videos.first.authorName;
    return CreatorProfile(
      id: creatorId,
      name: name,
      bio: stats.bio,
      avatarUrl: '',
      bannerUrl: videos.isEmpty ? '' : videos.first.coverUrl,
      followerCount: stats.followerCount,
      followingCount: stats.followingCount,
      videoCount: stats.videoCount,
      totalViewCount: stats.totalViewCount,
      videos: videos
          .map(
            (video) => CreatorVideoPreview(
              id: video.id,
              title: video.title,
              coverUrl: video.coverUrl,
              viewCount: video.viewCount,
              durationSeconds: video.durationSeconds,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<bool> isFollowing({
    required String userId,
    required String creatorId,
  }) async {
    if (userId == creatorId) return false;
    return client.social.isFollowing(creatorId);
  }

  @override
  Future<List<String>> loadFollowingCreatorIds({required String userId}) {
    return client.social.getFollowingCreatorIds();
  }

  @override
  Future<bool> toggleFollow({
    required String userId,
    required String creatorId,
    required bool currentlyFollowing,
  }) {
    if (userId == creatorId) throw StateError('不能关注自己');
    return client.social.toggleFollow(creatorId);
  }
}
