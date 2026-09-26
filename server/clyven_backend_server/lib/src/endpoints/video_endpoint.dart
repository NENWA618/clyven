import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/asr_job_processor.dart';

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
    required VideoContentType contentType,
    required String languageCode,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    required int durationSeconds,
  }) async {
    final currentUserId = _requireUserId(session);

    final now = DateTime.now().toUtc();

    final video = Video(
      authorId: currentUserId,
      authorName: authorName,
      title: title,
      description: description,
      category: category,
      contentType: contentType,
      languageCode: languageCode,
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

    final savedVideo = await Video.db.insertRow(
      session,
      video,
    );

    if (savedVideo.id == null) {
      throw Exception('视频创建成功，但没有取得 video id');
    }

    session.log(
      'POST_CREATED postId=${savedVideo.id} ownerId=$currentUserId '
      'type=${savedVideo.contentType.name} status=${savedVideo.status.name} '
      'videoStorageKey=${savedVideo.videoStorageKey} '
      'createdAt=${savedVideo.createdAt.toIso8601String()} '
      'publishedAt=${savedVideo.publishedAt?.toIso8601String()}',
    );

    final asrJob = await AsrJob.db.insertRow(
      session,
      AsrJob(
        videoId: savedVideo.id!,
        requestedLanguageCode: languageCode,
        detectedLanguageCode: null,
        provider: 'deepgram',
        status: AsrJobStatus.queued,
        trackId: null,
        errorMessage: null,
        createdAt: now,
        updatedAt: now,
      ),
    );

    if (asrJob.id != null) {
      await const AsrJobProcessor().process(
        session,
        asrJob.id!,
      );
    }

    return savedVideo;
  }

  Future<List<Video>> getVideos(
    Session session, {
    VideoContentType? contentType,
  }) async {
    final videos = await Video.db.find(
      session,
      where: contentType == null
          ? (table) => table.status.equals(VideoStatus.published)
          : (table) =>
                table.status.equals(VideoStatus.published) &
                table.contentType.equals(contentType),
      orderBy: (table) => table.createdAt,
      orderDescending: true,
    );
    session.log(
      'FEED_REQUEST viewerUserId=${session.authenticated?.userIdentifier ?? 'anonymous'} '
      'filter=status:published,contentType:${contentType?.name ?? 'all'} '
      'order=createdAt:desc returnedCount=${videos.length}',
    );
    return videos;
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
    final video = await Video.db.findById(session, id);
    if (video == null) return null;
    if (video.status != VideoStatus.published &&
        video.authorId != session.authenticated?.userIdentifier.toString()) {
      return null;
    }
    return video;
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
