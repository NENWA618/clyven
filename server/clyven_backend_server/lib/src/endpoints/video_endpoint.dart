import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class VideoEndpoint extends Endpoint {
  String _requireUserId(Session session) {
    final auth = session.authenticated;

    if (auth == null) {
      throw Exception('需要登录后才能管理视频');
    }

    return auth.userIdentifier.toString();
  }

  String _safeUserId(String userId) {
    return userId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
  }

  void _requireOwnedUploadPath({
    required String userId,
    required String path,
  }) {
    final safeUserId = _safeUserId(userId);

    final ownsVideoPath = path.startsWith('videos/$safeUserId/');
    final ownsCoverPath = path.startsWith('covers/$safeUserId/');

    if (!ownsVideoPath && !ownsCoverPath) {
      throw Exception('只能上传到自己账号名下的存储路径');
    }
  }

  Future<Video> create(
    Session session, {
    required String authorId,
    required String authorName,
    required String title,
    required String description,
    required String category,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    required int durationSeconds,
  }) async {
    final currentUserId = _requireUserId(session);

    final now = DateTime.now();

    final video = Video(
      authorId: currentUserId,
      authorName: authorName,
      title: title,
      description: description,
      category: category,
      tags: tags,
      videoStorageKey: videoStorageKey,
      coverStorageKey: coverStorageKey,
      durationSeconds: durationSeconds,
      viewCount: 0,
      likeCount: 0,
      favoriteCount: 0,
      commentCount: 0,
      status: VideoStatus.published,
      publishedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    return Video.db.insertRow(session, video);
  }

  Future<List<Video>> getVideos(Session session) async {
    return Video.db.find(
      session,
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
  }

  Future<List<Video>> getMyVideos(Session session) async {
    final userId = _requireUserId(session);

    return Video.db.find(
      session,
      where: (table) => table.authorId.equals(userId),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
  }

  Future<Video?> getVideo(
    Session session,
    int id,
  ) async {
    return Video.db.findById(session, id);
  }

  Future<String?> createUploadDescription(
    Session session, {
    required String path,
    required int fileSize,
  }) async {
    final userId = _requireUserId(session);
    _requireOwnedUploadPath(userId: userId, path: path);

    return session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
      maxFileSize: 1024 * 1024 * 1024,
      contentLength: fileSize,
      preventOverwrite: true,
    );
  }

  Future<bool> verifyUpload(
    Session session, {
    required String path,
  }) async {
    final userId = _requireUserId(session);
    _requireOwnedUploadPath(userId: userId, path: path);

    return session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }

  Future<String?> getVideoUrl(
    Session session, {
    required String path,
  }) async {
    final uri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: path,
    );

    return uri?.toString();
  }
}
