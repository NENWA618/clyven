import '../models/creator_profile.dart';

abstract class CreatorRepository {
  Future<CreatorProfile> loadCreatorProfile(
    String creatorId,
  );

  Future<bool> isFollowing({
    required String userId,
    required String creatorId,
  });

  Future<List<String>> loadFollowingCreatorIds({
    required String userId,
  });

  Future<bool> toggleFollow({
    required String userId,
    required String creatorId,
    required bool currentlyFollowing,
  });
}

class MockCreatorRepository
    implements CreatorRepository {
  final Set<String> _following = {};

  String _followKey({
    required String userId,
    required String creatorId,
  }) {
    return '$userId::$creatorId';
  }

  @override
  Future<CreatorProfile> loadCreatorProfile(
    String creatorId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    switch (creatorId) {
      case 'creator-001':
        return const CreatorProfile(
          id: 'creator-001',
          name: '边界记录室',
          bio: '记录城市、边界、铁路以及那些容易被忽略的空间。',
          avatarUrl: '',
          bannerUrl:
              'https://images.unsplash.com/photo-1473445361085-b9a07f55608b'
              '?auto=format&fit=crop&w=1600&q=80',
          followerCount: 12800,
          followingCount: 42,
          videoCount: 28,
          totalViewCount: 680000,
          videos: [
            CreatorVideoPreview(
              id: 'video-001',
              title: '沿着城市边界走了一整天',
              coverUrl:
                  'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 32800,
              durationSeconds: 754,
            ),
            CreatorVideoPreview(
              id: 'creator-001-video-002',
              title: '一条铁路如何改变一座小城',
              coverUrl:
                  'https://images.unsplash.com/photo-1516939884455-1445c8652f83'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 18600,
              durationSeconds: 1280,
            ),
          ],
        );

      case 'creator-002':
        return const CreatorProfile(
          id: 'creator-002',
          name: '未完成实验室',
          bio: '记录编程、设计与各种没有标准答案的实验。',
          avatarUrl: '',
          bannerUrl:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
              '?auto=format&fit=crop&w=1600&q=80',
          followerCount: 24600,
          followingCount: 31,
          videoCount: 41,
          totalViewCount: 1260000,
          videos: [
            CreatorVideoPreview(
              id: 'video-002',
              title: '从零开始搭一个大型 Flutter 项目',
              coverUrl:
                  'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 56200,
              durationSeconds: 1840,
            ),
            CreatorVideoPreview(
              id: 'creator-002-video-002',
              title: '为什么大型 App 不能只有 UI 层',
              coverUrl:
                  'https://images.unsplash.com/photo-1555066931-4365d14bab8c'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 34900,
              durationSeconds: 1320,
            ),
          ],
        );

      case 'creator-004':
        return const CreatorProfile(
          id: 'creator-004',
          name: '远岸频道',
          bio: '海岸、公路、岛屿，以及那些距离城市很远的地方。',
          avatarUrl: '',
          bannerUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
              '?auto=format&fit=crop&w=1600&q=80',
          followerCount: 9700,
          followingCount: 18,
          videoCount: 19,
          totalViewCount: 430000,
          videos: [
            CreatorVideoPreview(
              id: 'video-004',
              title: '沿着海岸线走到公路尽头',
              coverUrl:
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 21800,
              durationSeconds: 1460,
            ),
            CreatorVideoPreview(
              id: 'creator-004-video-002',
              title: '凌晨五点的渔港',
              coverUrl:
                  'https://images.unsplash.com/photo-1498623116890-37e912163d5d'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 17300,
              durationSeconds: 965,
            ),
          ],
        );

      case 'creator-003':
      default:
        return const CreatorProfile(
          id: 'creator-003',
          name: '语言群岛',
          bio: '记录语言、文字以及不同文化留下来的声音。',
          avatarUrl: '',
          bannerUrl:
              'https://images.unsplash.com/photo-1455390582262-044cdead277a'
              '?auto=format&fit=crop&w=1600&q=80',
          followerCount: 31800,
          followingCount: 56,
          videoCount: 36,
          totalViewCount: 1740000,
          videos: [
            CreatorVideoPreview(
              id: 'video-003',
              title: '一门语言消失之前，我们还能留下什么',
              coverUrl:
                  'https://images.unsplash.com/photo-1455390582262-044cdead277a'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 81400,
              durationSeconds: 1128,
            ),
            CreatorVideoPreview(
              id: 'featured-001',
              title: '穿过铁路与语言交界的地方',
              coverUrl:
                  'https://images.unsplash.com/photo-1474487548417-781cb71495f3'
                  '?auto=format&fit=crop&w=1200&q=80',
              viewCount: 126000,
              durationSeconds: 1650,
            ),
          ],
        );
    }
  }

  @override
  Future<bool> isFollowing({
    required String userId,
    required String creatorId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    return _following.contains(
      _followKey(
        userId: userId,
        creatorId: creatorId,
      ),
    );
  }

  @override
  Future<List<String>> loadFollowingCreatorIds({
    required String userId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    final prefix = '$userId::';

    return _following
        .where((key) {
          return key.startsWith(prefix);
        })
        .map((key) {
          return key.substring(
            prefix.length,
          );
        })
        .toList(growable: false);
  }

  @override
  Future<bool> toggleFollow({
    required String userId,
    required String creatorId,
    required bool currentlyFollowing,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    final key = _followKey(
      userId: userId,
      creatorId: creatorId,
    );

    if (currentlyFollowing) {
      _following.remove(key);

      return false;
    }

    _following.add(key);

    return true;
  }
}