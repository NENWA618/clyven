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


  Future<VideoSeries?> _findSeriesByTitle(
    Session session, {
    required String creatorId,
    required String title,
  }) {
    return VideoSeries.db.findFirstRow(
      session,
      where: (table) =>
          table.creatorId.equals(creatorId) &
          table.title.equals(title),
    );
  }

  Future<int> _nextSeriesPosition(
    Session session,
    int seriesId,
  ) async {
    final videos = await Video.db.find(
      session,
      where: (table) => table.seriesId.equals(seriesId),
    );

    var highest = 0;

    for (final video in videos) {
      final position = video.seriesPosition ?? 0;

      if (position > highest) {
        highest = position;
      }
    }

    return highest + 1;
  }

  Future<VideoSeries> _findOrCreateSeries(
    Session session, {
    required String creatorId,
    required String title,
  }) async {
    final normalizedTitle = title.trim();

    if (normalizedTitle.isEmpty) {
      throw Exception('系列名称不能为空');
    }

    final existing = await _findSeriesByTitle(
      session,
      creatorId: creatorId,
      title: normalizedTitle,
    );

    if (existing != null) {
      return existing;
    }

    final now = DateTime.now().toUtc();

    return VideoSeries.db.insertRow(
      session,
      VideoSeries(
        creatorId: creatorId,
        title: normalizedTitle,
        description: '',
        coverStorageKey: null,
        languageCode: null,
        category: 'general',
        createdAt: now,
        updatedAt: now,
      ),
    );
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
    String? seriesTitle,
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
    final normalizedSeriesTitle = seriesTitle?.trim();
    final storedSeriesTitle =
        normalizedSeriesTitle == null || normalizedSeriesTitle.isEmpty
        ? null
        : normalizedSeriesTitle;

    VideoSeries? series;
    int? seriesPosition;

    if (storedSeriesTitle != null) {
      series = await _findOrCreateSeries(
        session,
        creatorId: currentUserId,
        title: storedSeriesTitle,
      );

      final seriesId = series.id;

      if (seriesId == null) {
        throw Exception('系列创建成功，但没有取得 series id');
      }

      seriesPosition = await _nextSeriesPosition(
        session,
        seriesId,
      );
    }
    final now = DateTime.now().toUtc();

    final video = Video(
      authorId: currentUserId,
      authorName: normalizedAuthorName,
      title: normalizedTitle,
      description: description.trim(),
      seriesTitle: storedSeriesTitle,
      seriesId: series?.id,
      seriesPosition: seriesPosition,
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

    session.log(
      'POST_CREATED postId=${savedVideo.id} ownerId=$currentUserId '
      'type=${savedVideo.contentType.name} status=${savedVideo.status.name} '
      'videoStorageKey=${savedVideo.videoStorageKey} '
      'createdAt=${savedVideo.createdAt.toIso8601String()} '
      'publishedAt=${savedVideo.publishedAt?.toIso8601String()}',
    );
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
    final videos = await Video.db.find(
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

    session.log(
      'FEED_REQUEST viewerUserId=${session.authenticated?.userIdentifier ?? 'anonymous'} '
      'filter=isPublic:true,status:published,contentType:${contentType?.name ?? 'all'} '
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

    final currentUserId = session.authenticated?.userIdentifier.toString();
    final isOwner = currentUserId == video.authorId;

    if (video.status != VideoStatus.published && !isOwner) {
      return null;
    }

    if (video.isPublic || isOwner) {
      return video;
    }

    return null;
  }

  Future<VideoSeries> createSeries(
    Session session, {
    required String title,
    String description = '',
    String? coverStorageKey,
    String? languageCode,
    String category = 'general',
  }) async {
    final userId = _requireUserId(session);
    final normalizedTitle = title.trim();

    if (normalizedTitle.isEmpty) {
      throw Exception('系列名称不能为空');
    }

    final existing = await _findSeriesByTitle(
      session,
      creatorId: userId,
      title: normalizedTitle,
    );

    if (existing != null) {
      return existing;
    }

    final now = DateTime.now().toUtc();

    return VideoSeries.db.insertRow(
      session,
      VideoSeries(
        creatorId: userId,
        title: normalizedTitle,
        description: description.trim(),
        coverStorageKey: coverStorageKey,
        languageCode: languageCode?.trim(),
        category: category.trim().isEmpty ? 'general' : category.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<VideoSeries>> getCreatorSeries(
    Session session, {
    required String creatorId,
  }) async {
    final series = await VideoSeries.db.find(
      session,
      where: (table) => table.creatorId.equals(creatorId),
      orderBy: (table) => table.updatedAt,
      orderDescending: true,
    );

    final currentUserId =
        session.authenticated?.userIdentifier.toString();

    if (currentUserId == creatorId) {
      return series;
    }

    final visible = <VideoSeries>[];

    for (final item in series) {
      final id = item.id;

      if (id == null) {
        continue;
      }

      final publicVideo = await Video.db.findFirstRow(
        session,
        where: (table) =>
            table.seriesId.equals(id) &
            table.isPublic.equals(true) &
            table.status.equals(VideoStatus.published),
      );

      if (publicVideo != null) {
        visible.add(item);
      }
    }

    return visible;
  }
  Future<VideoSeries?> getSeries(
    Session session, {
    required int seriesId,
  }) async {
    final series = await VideoSeries.db.findById(
      session,
      seriesId,
    );

    if (series == null) {
      return null;
    }

    final currentUserId =
        session.authenticated?.userIdentifier.toString();

    if (currentUserId == series.creatorId) {
      return series;
    }

    final publicVideo = await Video.db.findFirstRow(
      session,
      where: (table) =>
          table.seriesId.equals(seriesId) &
          table.isPublic.equals(true) &
          table.status.equals(VideoStatus.published),
    );

    return publicVideo == null ? null : series;
  }
  Future<List<Video>> getSeriesVideos(
    Session session, {
    required int seriesId,
  }) async {
    final series = await VideoSeries.db.findById(
      session,
      seriesId,
    );

    if (series == null) {
      return [];
    }

    final currentUserId =
        session.authenticated?.userIdentifier.toString();

    final isOwner =
        currentUserId == series.creatorId;

    final videos = await Video.db.find(
      session,
      where: isOwner
          ? (table) =>
                table.seriesId.equals(seriesId)
          : (table) =>
                table.seriesId.equals(seriesId) &
                table.isPublic.equals(true) &
                table.status.equals(VideoStatus.published),
    );

    videos.sort((a, b) {
      final aPosition =
          a.seriesPosition ?? 0x7fffffff;
      final bPosition =
          b.seriesPosition ?? 0x7fffffff;

      final result =
          aPosition.compareTo(bPosition);

      if (result != 0) {
        return result;
      }

      return a.createdAt.compareTo(
        b.createdAt,
      );
    });

    return videos;
  }
  Future<Video> setSeriesById(
    Session session, {
    required int videoId,
    required int seriesId,
  }) async {
    final video = await _requireOwnedVideo(
      session,
      videoId,
    );

    final userId = _requireUserId(session);

    final series = await VideoSeries.db.findById(
      session,
      seriesId,
    );

    if (series == null) {
      throw Exception('系列不存在');
    }

    if (series.creatorId != userId) {
      throw Exception('只能把视频移动到自己的系列');
    }

    final position = await _nextSeriesPosition(
      session,
      seriesId,
    );

    video.seriesId = seriesId;
    video.seriesTitle = series.title;
    video.seriesPosition = position;
    video.updatedAt = DateTime.now().toUtc();

    series.updatedAt = video.updatedAt;

    await VideoSeries.db.updateRow(
      session,
      series,
    );

    return Video.db.updateRow(
      session,
      video,
    );
  }

  // 兼容现有手机端。
  // 旧代码仍然可以传 seriesTitle，
  // 后端会自动转换成真正的 VideoSeries。
  Future<Video> setSeries(
    Session session, {
    required int videoId,
    String? seriesTitle,
  }) async {
    final video = await _requireOwnedVideo(
      session,
      videoId,
    );

    final userId = _requireUserId(session);
    final normalizedTitle = seriesTitle?.trim();

    if (normalizedTitle == null ||
        normalizedTitle.isEmpty) {
      video.seriesId = null;
      video.seriesTitle = null;
      video.seriesPosition = null;
      video.updatedAt = DateTime.now().toUtc();

      return Video.db.updateRow(
        session,
        video,
      );
    }

    final series = await _findOrCreateSeries(
      session,
      creatorId: userId,
      title: normalizedTitle,
    );

    final seriesId = series.id;

    if (seriesId == null) {
      throw Exception('系列没有有效 id');
    }

    final position = await _nextSeriesPosition(
      session,
      seriesId,
    );

    video.seriesId = seriesId;
    video.seriesTitle = series.title;
    video.seriesPosition = position;
    video.updatedAt = DateTime.now().toUtc();

    series.updatedAt = video.updatedAt;

    await VideoSeries.db.updateRow(
      session,
      series,
    );

    return Video.db.updateRow(
      session,
      video,
    );
  }

  Future<void> reorderSeriesVideos(
    Session session, {
    required int seriesId,
    required List<int> videoIds,
  }) async {
    final userId = _requireUserId(session);

    final series = await VideoSeries.db.findById(
      session,
      seriesId,
    );

    if (series == null) {
      throw Exception('系列不存在');
    }

    if (series.creatorId != userId) {
      throw Exception('只能调整自己的系列');
    }

    final videos = await Video.db.find(
      session,
      where: (table) =>
          table.seriesId.equals(seriesId),
    );

    final byId = <int, Video>{
      for (final video in videos)
        if (video.id != null)
          video.id!: video,
    };

    if (videoIds.length != byId.length ||
        videoIds.any((id) => !byId.containsKey(id))) {
      throw Exception('系列排序列表与实际视频不一致');
    }

    for (var index = 0;
        index < videoIds.length;
        index++) {
      final video = byId[videoIds[index]]!;

      video.seriesPosition = index + 1;
      video.updatedAt = DateTime.now().toUtc();

      await Video.db.updateRow(
        session,
        video,
      );
    }

    series.updatedAt = DateTime.now().toUtc();

    await VideoSeries.db.updateRow(
      session,
      series,
    );
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
