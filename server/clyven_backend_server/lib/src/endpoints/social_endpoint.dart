import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' as auth_core;

import '../generated/protocol.dart';
import '../services/notification_service.dart';

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

  Future<bool> toggleFollow(
    Session session,
    String creatorId, {
    String actorName = 'Clyven user',
  }) async {
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
    await createNotification(
      session,
      recipientId: creatorId,
      actorId: userId,
      actorName: actorName,
      type: NotificationType.follow,
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
    return session.db.transaction((transaction) async {
      // Lock before reading membership so concurrent toggles cannot lose updates.
      final video = await Video.db.findById(
        session,
        videoId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (video == null) throw StateError('Video $videoId does not exist');
      final current = await VideoFavorite.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(userId) & row.videoId.equals(videoId),
        transaction: transaction,
      );

      if (current != null) {
        await VideoFavorite.db.deleteRow(
          session,
          current,
          transaction: transaction,
        );
      } else {
        await VideoFavorite.db.insertRow(
          session,
          VideoFavorite(
            userId: userId,
            videoId: videoId,
            createdAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      }
      // Recount also repairs counts left stale by older endpoint versions.
      video.favoriteCount = await VideoFavorite.db.count(
        session,
        where: (row) => row.videoId.equals(videoId),
        transaction: transaction,
      );
      await Video.db.updateRow(
        session,
        video,
        columns: (row) => [row.favoriteCount],
        transaction: transaction,
      );
      return current == null;
    });
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

  Future<bool> toggleLike(
    Session session,
    int videoId, {
    String actorName = 'Clyven user',
  }) async {
    final userId = _userId(session);
    return session.db.transaction((transaction) async {
      final video = await Video.db.findById(
        session,
        videoId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (video == null) throw StateError('Video $videoId does not exist');
      final current = await VideoLike.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(userId) & row.videoId.equals(videoId),
        transaction: transaction,
      );

      if (current != null) {
        await VideoLike.db.deleteRow(
          session,
          current,
          transaction: transaction,
        );
      } else {
        await VideoLike.db.insertRow(
          session,
          VideoLike(
            userId: userId,
            videoId: videoId,
            createdAt: DateTime.now(),
          ),
          transaction: transaction,
        );
        await createNotification(
          session,
          recipientId: video.authorId,
          actorId: userId,
          actorName: actorName,
          type: NotificationType.like,
          videoId: videoId,
          transaction: transaction,
        );
      }
      video.likeCount = await VideoLike.db.count(
        session,
        where: (row) => row.videoId.equals(videoId),
        transaction: transaction,
      );
      await Video.db.updateRow(
        session,
        video,
        columns: (row) => [row.likeCount],
        transaction: transaction,
      );
      return current == null;
    });
  }

  Future<List<int>> getLikedVideoIds(Session session) async {
    final userId = _userId(session);
    final rows = await VideoLike.db.find(
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

  Future<List<Map<String, String>>> searchExistingUserProfiles(
    Session session,
    String query, {
    required int limit,
  }) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const [];

    final profiles = await auth_core.AuthServices.instance.userProfiles.admin
        .listUserProfiles(
          session,
          limit: 500,
        );

    final result = <Map<String, String>>[];

    for (final profile in profiles) {
      final displayName = (
        profile.fullName ??
        profile.userName ??
        profile.authUserId.toString()
      ).trim();

      final userName = (profile.userName ?? '').trim();

      if (!displayName.toLowerCase().contains(normalized) &&
          !userName.toLowerCase().contains(normalized)) {
        continue;
      }

      result.add({
        'userId': profile.authUserId.toString(),
        'displayName': displayName,
        'avatarUrl': profile.imageUrl?.toString() ?? '',
      });

      if (result.length >= limit) break;
    }

    return result;
  }

  Future<Map<String, String>?> getExistingUserProfile(
    Session session,
    String userId,
  ) async {
    final profiles = await auth_core.AuthServices.instance.userProfiles.admin
        .listUserProfiles(
          session,
          limit: 1000,
        );

    for (final profile in profiles) {
      if (profile.authUserId.toString() != userId) continue;

      return {
        'userId': profile.authUserId.toString(),
        'displayName': (
          profile.fullName ??
          profile.userName ??
          profile.authUserId.toString()
        ).trim(),
        'avatarUrl': profile.imageUrl?.toString() ?? '',
      };
    }

    return null;
  }
}
