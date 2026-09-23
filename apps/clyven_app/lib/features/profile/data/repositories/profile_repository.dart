import 'package:clyven_backend_client/clyven_backend_client.dart';

import '../../../video/data/repositories/video_repository.dart';
import '../models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> loadProfile({
    required String userId,
    required String username,
    required String displayName,
    required String avatarUrl,
  });
  Future<void> updateBio(String bio);
}

class ServerpodProfileRepository implements ProfileRepository {
  final Client client;
  final VideoRepository videoRepository;

  const ServerpodProfileRepository({
    required this.client,
    required this.videoRepository,
  });

  @override
  Future<UserProfile> loadProfile({
    required String userId,
    required String username,
    required String displayName,
    required String avatarUrl,
  }) async {
    final videos = await videoRepository.loadUserVideos(userId: userId);
    ProfileStats? stats;
    try {
      stats = await client.social.getMyProfileStats();
    } catch (_) {
      // The Flutter client can be updated before the Serverpod deployment.
      // Keep the profile usable with authenticated identity and persisted
      // videos; social counts become available after the server migration.
    }
    return UserProfile(
      id: userId,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      bio: stats?.bio ?? '',
      followerCount: stats?.followerCount ?? 0,
      followingCount: stats?.followingCount ?? 0,
      videoCount: stats?.videoCount ?? videos.length,
      favoriteCount: stats?.favoriteCount ?? 0,
      videos: videos
          .map(
            (video) => ProfileVideo(
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
  Future<void> updateBio(String bio) async {
    await client.social.updateBio(bio);
  }
}
