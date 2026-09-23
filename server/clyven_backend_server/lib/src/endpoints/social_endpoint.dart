import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SocialEndpoint extends Endpoint {
  String _userId(Session session) {
    final auth = session.authenticated;
    if (auth == null) throw Exception('需要登录');
    return auth.userIdentifier.toString();
  }

  Future<ProfileStats> getMyProfileStats(Session session) async {
    final userId = _userId(session);
    return _profileStats(session, userId);
  }

  Future<ProfileStats> getProfileStats(
    Session session,
    String creatorId,
  ) async {
    _userId(session);
    return _profileStats(session, creatorId);
  }

  Future<ProfileStats> _profileStats(Session session, String userId) async {
    final profile = await AppProfile.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(userId),
    );
    final videos = await Video.db.find(
      session,
      where: (row) => row.authorId.equals(userId),
    );
    return ProfileStats(
      followerCount: await CreatorFollow.db.count(
        session,
        where: (row) => row.creatorId.equals(userId),
      ),
      followingCount: await CreatorFollow.db.count(
        session,
        where: (row) => row.followerId.equals(userId),
      ),
      videoCount: videos.length,
      favoriteCount: await VideoFavorite.db.count(
        session,
        where: (row) => row.userId.equals(userId),
      ),
      totalViewCount: videos.fold(0, (sum, video) => sum + video.viewCount),
      bio: profile?.bio ?? '',
    );
  }

  Future<String> updateBio(Session session, String bio) async {
    final userId = _userId(session);
    final normalized = bio.trim();
    if (normalized.length > 300) throw Exception('简介不能超过 300 字');
    final current = await AppProfile.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(userId),
    );
    if (current == null) {
      await AppProfile.db.insertRow(
        session,
        AppProfile(userId: userId, bio: normalized, updatedAt: DateTime.now()),
      );
    } else {
      await AppProfile.db.updateRow(
        session,
        current.copyWith(bio: normalized, updatedAt: DateTime.now()),
      );
    }
    return normalized;
  }

  Future<bool> isFollowing(Session session, String creatorId) async {
    final userId = _userId(session);
    if (userId == creatorId) return false;
    return await CreatorFollow.db.findFirstRow(
          session,
          where: (row) =>
              row.followerId.equals(userId) & row.creatorId.equals(creatorId),
        ) !=
        null;
  }

  Future<bool> toggleFollow(Session session, String creatorId) async {
    final userId = _userId(session);
    if (userId == creatorId) throw Exception('不能关注自己');
    final current = await CreatorFollow.db.findFirstRow(
      session,
      where: (row) =>
          row.followerId.equals(userId) & row.creatorId.equals(creatorId),
    );
    if (current != null) {
      await CreatorFollow.db.deleteRow(session, current);
      return false;
    }
    await CreatorFollow.db.insertRow(
      session,
      CreatorFollow(
        followerId: userId,
        creatorId: creatorId,
        createdAt: DateTime.now(),
      ),
    );
    return true;
  }

  Future<List<String>> getFollowingCreatorIds(Session session) async {
    final userId = _userId(session);
    final rows = await CreatorFollow.db.find(
      session,
      where: (row) => row.followerId.equals(userId),
      orderBy: (row) => row.createdAt,
      orderDescending: true,
    );
    return rows.map((row) => row.creatorId).toList(growable: false);
  }

  Future<bool> toggleFavorite(Session session, int videoId) async {
    final userId = _userId(session);
    final current = await VideoFavorite.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(userId) & row.videoId.equals(videoId),
    );
    if (current != null) {
      await VideoFavorite.db.deleteRow(session, current);
      return false;
    }
    await VideoFavorite.db.insertRow(
      session,
      VideoFavorite(
        userId: userId,
        videoId: videoId,
        createdAt: DateTime.now(),
      ),
    );
    return true;
  }

  Future<List<int>> getFavoriteVideoIds(Session session) async {
    final userId = _userId(session);
    final rows = await VideoFavorite.db.find(
      session,
      where: (row) => row.userId.equals(userId),
      orderBy: (row) => row.createdAt,
      orderDescending: true,
    );
    return rows.map((row) => row.videoId).toList(growable: false);
  }

  Future<List<WatchHistory>> getWatchHistory(Session session) async {
    final userId = _userId(session);
    return WatchHistory.db.find(
      session,
      where: (row) => row.userId.equals(userId),
      orderBy: (row) => row.watchedAt,
      orderDescending: true,
    );
  }

  Future<WatchHistory> saveWatchProgress(
    Session session,
    int videoId,
    int positionSeconds,
  ) async {
    final userId = _userId(session);
    final current = await WatchHistory.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(userId) & row.videoId.equals(videoId),
    );
    final value = current == null
        ? WatchHistory(
            userId: userId,
            videoId: videoId,
            positionSeconds: positionSeconds,
            watchedAt: DateTime.now(),
          )
        : current.copyWith(
            positionSeconds: positionSeconds,
            watchedAt: DateTime.now(),
          );
    return current == null
        ? WatchHistory.db.insertRow(session, value)
        : WatchHistory.db.updateRow(session, value);
  }

  Future<void> removeWatchHistory(Session session, int videoId) async {
    final userId = _userId(session);
    await WatchHistory.db.deleteWhere(
      session,
      where: (row) => row.userId.equals(userId) & row.videoId.equals(videoId),
    );
  }

  Future<void> clearWatchHistory(Session session) async {
    final userId = _userId(session);
    await WatchHistory.db.deleteWhere(
      session,
      where: (row) => row.userId.equals(userId),
    );
  }
}
