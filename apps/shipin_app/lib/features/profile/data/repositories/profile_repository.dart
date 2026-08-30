import '../models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> loadProfile({
    required String userId,
    required String username,
    required String displayName,
    required String avatarUrl,
  });
}

class MockProfileRepository
    implements ProfileRepository {
  const MockProfileRepository();

  @override
  Future<UserProfile> loadProfile({
    required String userId,
    required String username,
    required String displayName,
    required String avatarUrl,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 350),
    );

    return UserProfile(
      id: userId,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      bio: '在这里记录我看见、学习和想留下来的东西。',
      followerCount: 128,
      followingCount: 46,
      videoCount: 3,
      favoriteCount: 27,
      videos: const [
        ProfileVideo(
          id: 'my-video-001',
          title: '第一次记录一座完全陌生的城市',
          coverUrl:
              'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df'
              '?auto=format&fit=crop&w=1200&q=80',
          viewCount: 3280,
          durationSeconds: 754,
        ),
        ProfileVideo(
          id: 'my-video-002',
          title: '我为什么开始记录正在消失的语言',
          coverUrl:
              'https://images.unsplash.com/photo-1455390582262-044cdead277a'
              '?auto=format&fit=crop&w=1200&q=80',
          viewCount: 8140,
          durationSeconds: 1128,
        ),
        ProfileVideo(
          id: 'my-video-003',
          title: '从零开始搭一个大型 Flutter 项目',
          coverUrl:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
              '?auto=format&fit=crop&w=1200&q=80',
          viewCount: 5620,
          durationSeconds: 1840,
        ),
      ],
    );
  }
}