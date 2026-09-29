import 'dart:io';

import 'package:clyven_app/core/errors/app_error.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:serverpod_client/serverpod_client.dart';

import '../models/video_detail.dart';
import '../models/video_upload_draft.dart';
import 'video_repository.dart';

class ServerpodVideoRepository implements VideoRepository {
  final serverpod.Client client;

  ServerpodVideoRepository({required this.client});

  // ============================================================
  // 视频详情
  // ============================================================

  @override
  Future<VideoDetail> loadVideoDetail(String videoId) async {
    final id = int.parse(videoId);

    final video = await client.video.getVideo(id);

    if (video == null) {
      throw const AppException(AppErrorCode.videoNotFound);
    }

    return _toVideoDetailWithUrls(video);
  }

  // ============================================================
  // 创建视频
  // ============================================================

  @override
  Future<VideoDetail> createVideo({
    required String userId,
    required String authorName,
    required VideoUploadDraft draft,
  }) async {
    final safeUserId = userId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');

    final timestamp = DateTime.now().microsecondsSinceEpoch;

    final videoStorageKey = 'videos/$safeUserId/$timestamp.mp4';

    final coverStorageKey = draft.coverPath == null
        ? null
        : 'covers/$safeUserId/$timestamp.jpg';

    await _uploadFile(localPath: draft.videoPath, storageKey: videoStorageKey);

    if (draft.coverPath != null && coverStorageKey != null) {
      await _uploadFile(
        localPath: draft.coverPath!,
        storageKey: coverStorageKey,
      );
    }

    final video = await client.video.create(
      authorId: userId,
      authorName: authorName,
      title: draft.title,
      description: draft.description,
      category: draft.category,
      languageCode: 'auto',
      tags: const [],
      videoStorageKey: videoStorageKey,
      coverStorageKey: coverStorageKey,
      durationSeconds: draft.durationSeconds,
    );

    return _toVideoDetailWithUrls(video);
  }

  // ============================================================
  // 所有用户的视频
  // 首页 / 发现使用
  // ============================================================

  @override
  Future<List<VideoDetail>> loadPublishedVideos() async {
    final videos = await client.video.getVideos();

    final results = <VideoDetail>[];

    for (final video in videos) {
      try {
        final detail = await _toVideoDetailWithUrls(video);

        results.add(detail);
      } catch (_) {
        // 跳过以前保存本地路径、
        // 文件已经失效等旧数据。
      }
    }

    return results;
  }

  // ============================================================
  // 指定用户的视频
  // 我的投稿使用
  // ============================================================

  @override
  Future<List<VideoDetail>> loadUserVideos({required String userId}) async {
    final videos = await client.video.getVideos();

    final userVideos = videos
        .where((video) {
          return video.authorId == userId;
        })
        .toList(growable: false);

    final results = <VideoDetail>[];

    for (final video in userVideos) {
      try {
        final detail = await _toVideoDetailWithUrls(video);

        results.add(detail);
      } catch (_) {
        // 跳过以前保存本地文件路径的旧数据。
      }
    }

    return results;
  }

  // ============================================================
  // 上传文件
  // ============================================================

  Future<void> _uploadFile({
    required String localPath,
    required String storageKey,
  }) async {
    final file = File(localPath);

    if (!await file.exists()) {
      throw AppException(
        AppErrorCode.uploadFileMissing,
        technicalDetails: localPath,
      );
    }

    final fileSize = await file.length();

    if (fileSize <= 0) {
      throw AppException(
        AppErrorCode.uploadFileEmpty,
        technicalDetails: localPath,
      );
    }

    final uploadDescription = await client.video.createUploadDescription(
      path: storageKey,
      fileSize: fileSize,
    );

    if (uploadDescription == null) {
      throw AppException(
        AppErrorCode.uploadDescriptionFailed,
        technicalDetails: storageKey,
      );
    }

    final uploader = FileUploader(uploadDescription);

    final uploaded = await uploader.upload(file.openRead(), fileSize);

    if (!uploaded) {
      throw AppException(
        AppErrorCode.uploadFailed,
        technicalDetails: storageKey,
      );
    }

    final verified = await client.video.verifyUpload(path: storageKey);

    if (!verified) {
      throw AppException(
        AppErrorCode.uploadVerificationFailed,
        technicalDetails: storageKey,
      );
    }
  }

  // ============================================================
  // Serverpod Video -> Flutter VideoDetail
  // ============================================================

  Future<VideoDetail> _toVideoDetailWithUrls(serverpod.Video video) async {
    final rawVideoUrl = await client.video.getVideoUrl(
      path: video.videoStorageKey,
    );

    final videoUrl = rawVideoUrl ?? '';

    if (videoUrl.isEmpty) {
      throw AppException(
        AppErrorCode.videoUrlUnavailable,
        technicalDetails: video.videoStorageKey,
      );
    }

    var coverUrl = '';

    final coverStorageKey = video.coverStorageKey;

    if (coverStorageKey != null && coverStorageKey.isNotEmpty) {
      final rawCoverUrl = await client.video.getVideoUrl(path: coverStorageKey);

      coverUrl = rawCoverUrl ?? '';
    }

    return VideoDetail(
      id: video.id!.toString(),
      title: video.title,
      description: video.description,
      authorId: video.authorId,
      authorName: video.authorName,
      category: video.category,
      tags: video.tags,
      coverUrl: coverUrl,
      videoUrl: videoUrl,
      durationSeconds: video.durationSeconds,
      viewCount: video.viewCount,
      likeCount: video.likeCount,
      favoriteCount: video.favoriteCount,
      commentCount: video.commentCount,
      publishedAt: video.publishedAt ?? video.createdAt,
    );
  }
}
