import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/asr_job_processor.dart';
import '../services/video_transcode_service.dart';

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

  Future<Video> _requireOwnedVideo(
    Session session,
    int videoId,
  ) async {
    final userId = _requireUserId(session);
    final video = await Video.db.findById(session, videoId);

    if (video == null) {
      throw Exception('视频不存在');
    }

    if (video.authorId != userId) {
      throw Exception('只能管理自己上传的视频');
    }

    return video;
  }

  Future<String> getCurrentUserId(Session session) async {
    return _requireUserId(session);
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
    required bool isPublic,
  }) async {
    final currentUserId = _requireUserId(session);
    _requireOwnedUploadPath(
      userId: currentUserId,
      path: videoStorageKey,
    );

    if (coverStorageKey != null) {
      _requireOwnedUploadPath(
        userId: currentUserId,
        path: coverStorageKey,
      );
    }

    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) {
      throw Exception('视频标题不能为空');
    }

    final normalizedAuthorName = authorName.trim().isEmpty
        ? currentUserId
        : authorName.trim();

    final now = DateTime.now();

    final video = Video(
      authorId: currentUserId,
      authorName: normalizedAuthorName,
      title: normalizedTitle,
      description: description.trim(),
      category: category.trim().isEmpty ? 'general' : category.trim(),
      contentType: contentType,
      languageCode: languageCode.trim().isEmpty ? 'auto' : languageCode.trim(),
      tags: tags,
      videoStorageKey: videoStorageKey,
      coverStorageKey: coverStorageKey,
      durationSeconds: durationSeconds,
      viewCount: 0,
      likeCount: 0,
      favoriteCount: 0,
      commentCount: 0,
      status: VideoStatus.published,
      isPublic: isPublic,
      publishedAt: isPublic ? now : null,
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
    try {
      await const VideoTranscodeService().ensure(
        session,
        savedVideo,
      );
    } catch (error, stackTrace) {
      print('[Clyven Transcoder] Failed to start job: $error');
      print(stackTrace);
    }

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
    return Video.db.find(
      session,
      where: contentType == null
          ? (table) =>
                table.isPublic.equals(true) &
                table.status.equals(VideoStatus.published)
          : (table) =>
                table.isPublic.equals(true) &
                table.status.equals(VideoStatus.published) &
                table.contentType.equals(contentType),
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
    final video = await Video.db.findById(session, id);

    if (video == null) {
      return null;
    }

    if (video.isPublic) {
      return video;
    }

    final currentUserId = session.authenticated?.userIdentifier.toString();
    if (currentUserId == video.authorId) {
      return video;
    }

    return null;
  }

  Future<Video> setVisibility(
    Session session, {
    required int videoId,
    required bool isPublic,
  }) async {
    final video = await _requireOwnedVideo(session, videoId);

    if (video.isPublic == isPublic) {
      return video;
    }

    final now = DateTime.now();
    video.isPublic = isPublic;
    video.updatedAt = now;

    if (isPublic && video.publishedAt == null) {
      video.publishedAt = now;
    }

    return Video.db.updateRow(session, video);
  }

  Future<void> deleteVideo(
    Session session, {
    required int videoId,
  }) async {
    final video = await _requireOwnedVideo(session, videoId);

    final comments = await VideoCommentRow.db.find(
      session,
      where: (row) => row.videoId.equals(videoId),
    );
    final commentIds = comments.map((row) => row.id).whereType<int>().toSet();

    if (commentIds.isNotEmpty) {
      final replies = await CommentReplyRow.db.find(
        session,
        where: (row) => row.commentId.inSet(commentIds),
      );
      final replyIds = replies.map((row) => row.id).whereType<int>().toSet();

      if (replyIds.isNotEmpty) {
        await CommentReplyLike.db.deleteWhere(
          session,
          where: (row) => row.replyId.inSet(replyIds),
        );
      }

      await CommentReplyRow.db.deleteWhere(
        session,
        where: (row) => row.commentId.inSet(commentIds),
      );
      await CommentLike.db.deleteWhere(
        session,
        where: (row) => row.commentId.inSet(commentIds),
      );
    }

    await VideoCommentRow.db.deleteWhere(
      session,
      where: (row) => row.videoId.equals(videoId),
    );

    final reviewTasks = await SubtitleReviewTask.db.find(
      session,
      where: (row) => row.videoId.equals(videoId),
    );
    final taskIds = reviewTasks.map((row) => row.id).whereType<int>().toSet();

    if (taskIds.isNotEmpty) {
      await SubtitleReviewEvent.db.deleteWhere(
        session,
        where: (row) => row.taskId.inSet(taskIds),
      );
    }

    await SubtitleReviewTask.db.deleteWhere(
      session,
      where: (row) => row.videoId.equals(videoId),
    );

    final tracks = await SubtitleTrack.db.find(
      session,
      where: (row) => row.videoId.equals(videoId),
    );
    final trackIds = tracks.map((row) => row.id).whereType<int>().toSet();

    if (trackIds.isNotEmpty) {
      final cues = await SubtitleCue.db.find(
        session,
        where: (row) => row.trackId.inSet(trackIds),
      );
      final cueIds = cues.map((row) => row.id).whereType<int>().toSet();

      if (cueIds.isNotEmpty) {
        await SubtitleKaraokeSegment.db.deleteWhere(
          session,
          where: (row) => row.cueId.inSet(cueIds),
        );
        await SubtitlePhrase.db.deleteWhere(
          session,
          where: (row) => row.cueId.inSet(cueIds),
        );
        await SubtitleToken.db.deleteWhere(
          session,
          where: (row) => row.cueId.inSet(cueIds),
        );
        await SubtitleCueText.db.deleteWhere(
          session,
          where: (row) => row.cueId.inSet(cueIds),
        );
      }

      await SubtitleCue.db.deleteWhere(
        session,
        where: (row) => row.trackId.inSet(trackIds),
      );
      await SubtitlePublishState.db.deleteWhere(
        session,
        where: (row) => row.trackId.inSet(trackIds),
      );
    }

    await AsrJob.db.deleteWhere(
      session,
      where: (row) => row.videoId.equals(videoId),
    );
    await SubtitleTrack.db.deleteWhere(
      session,
      where: (row) => row.videoId.equals(videoId),
    );
    await Video.db.deleteRow(session, video);

    await session.storage.deleteFile(
      storageId: 'public',
      path: video.videoStorageKey,
    );

    final coverStorageKey = video.coverStorageKey;
    if (coverStorageKey != null && coverStorageKey.isNotEmpty) {
      await session.storage.deleteFile(
        storageId: 'public',
        path: coverStorageKey,
      );
    }
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
    Video? video = await Video.db.findFirstRow(
      session,
      where: (table) => table.videoStorageKey.equals(path),
    );

    video ??= await Video.db.findFirstRow(
      session,
      where: (table) => table.coverStorageKey.equals(path),
    );

    if (video != null && !video.isPublic) {
      final currentUserId = session.authenticated?.userIdentifier.toString();
      if (currentUserId != video.authorId) {
        return null;
      }
    }

    final uri = await session.storage.getPublicUrl(
      storageId: 'public',
      path: path,
    );

    return uri?.toString();
  }

  Future<String?> getPlaybackManifestUrl(
    Session session, {
    required int videoId,
  }) async {
    final video = await Video.db.findById(
      session,
      videoId,
    );

    if (video == null) {
      return null;
    }

    try {
      final updated = await const VideoTranscodeService().ensure(
        session,
        video,
      );

      if (updated.transcodeState != 'SUCCEEDED') {
        return null;
      }

      final manifestKey = updated.hlsManifestStorageKey?.trim();

      if (manifestKey == null || manifestKey.isEmpty) {
        return null;
      }

      final uri = await session.storage.getPublicUrl(
        storageId: 'public',
        path: manifestKey,
      );

      return uri?.toString();
    } catch (error, stackTrace) {
      print('[Clyven Transcoder] Playback manifest unavailable: $error');
      print(stackTrace);
      return null;
    }
  }
}
