import 'dart:async';
import 'dart:io';

import 'package:clyven_app/core/errors/app_error.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min_gpl/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/video_upload_draft.dart';
import '../../data/models/video_content_type.dart';
import 'video_detail_provider.dart';

enum VideoUploadStatus { waiting, preparing, uploading, success, failed }

class VideoUploadRequest {
  final String userId;
  final String authorName;
  final String videoPath;
  final String title;
  final String description;
  final String category;
  final String seriesTitle;
  final VideoContentType contentType;

  const VideoUploadRequest({
    required this.userId,
    required this.authorName,
    required this.videoPath,
    required this.title,
    required this.description,
    required this.category,
    this.seriesTitle = '',
    this.contentType = VideoContentType.video,
  });
}

class VideoUploadTask {
  final String id;
  final String title;
  final VideoUploadStatus status;
  final String? errorMessage;
  final String? videoId;

  const VideoUploadTask({
    required this.id,
    required this.title,
    required this.status,
    this.errorMessage,
    this.videoId,
  });

  VideoUploadTask copyWith({
    VideoUploadStatus? status,
    String? errorMessage,
    String? videoId,
  }) {
    return VideoUploadTask(
      id: id,
      title: title,
      status: status ?? this.status,
      errorMessage: errorMessage,
      videoId: videoId ?? this.videoId,
    );
  }
}

class VideoUploadQueueNotifier extends Notifier<List<VideoUploadTask>> {
  @override
  List<VideoUploadTask> build() {
    return const [];
  }

  void enqueue(VideoUploadRequest request) {
    final taskId = DateTime.now().microsecondsSinceEpoch.toString();

    final task = VideoUploadTask(
      id: taskId,
      title: request.title,
      status: VideoUploadStatus.waiting,
    );

    state = [task, ...state];

    unawaited(_runUpload(taskId: taskId, request: request));
  }

  Future<void> _runUpload({
    required String taskId,
    required VideoUploadRequest request,
  }) async {
    try {
      _updateTask(taskId, status: VideoUploadStatus.preparing);

      // 1. 整理视频。
      final normalizedPath = await _normalizeVideo(request.videoPath);

      // 2. 读取视频时长。
      final durationSeconds = await _readVideoDuration(normalizedPath);

      if (durationSeconds <= 0) {
        throw const AppException(AppErrorCode.videoDurationUnreadable);
      }

      // 3. 生成封面。
      final coverPath = await _createVideoCover(normalizedPath);

      // 4. 构造上传资料。
      final draft = VideoUploadDraft(
        videoPath: normalizedPath,
        coverPath: coverPath,
        title: request.title,
        description: request.description,
        category: request.category,
        seriesTitle: request.seriesTitle,
        durationSeconds: durationSeconds,
        contentType: request.contentType,
      );

      _updateTask(taskId, status: VideoUploadStatus.uploading);

      // 5. 上传 MP4、封面，
      // 并写入 Serverpod Video。
      final repository = ref.read(videoRepositoryProvider);

      final video = await repository.createVideo(
        userId: request.userId,
        authorName: request.authorName,
        draft: draft,
      );

      _updateTask(taskId, status: VideoUploadStatus.success, videoId: video.id);

      // 上传完成后重新读取投稿列表。
      ref.invalidate(myPublishedVideosProvider);
      ref.invalidate(allPublishedVideosProvider);
      ref.invalidate(publishedShortsProvider);
    } catch (error, stackTrace) {
      debugPrint('Video upload failed: $error');

      debugPrintStack(stackTrace: stackTrace);

      _updateTask(
        taskId,
        status: VideoUploadStatus.failed,
        errorMessage: error.toString(),
      );
    }
  }

  void _updateTask(
    String taskId, {
    required VideoUploadStatus status,
    String? errorMessage,
    String? videoId,
  }) {
    state = [
      for (final task in state)
        if (task.id == taskId)
          task.copyWith(
            status: status,
            errorMessage: errorMessage,
            videoId: videoId,
          )
        else
          task,
    ];
  }

  Future<String> _normalizeVideo(String inputPath) async {
    final inputFile = File(inputPath);

    final outputPath =
        '${inputFile.parent.path}/'
        'normalized-'
        '${DateTime.now().microsecondsSinceEpoch}.mp4';

    final session = await FFmpegKit.executeWithArguments([
      '-y',
      '-fflags',
      '+genpts',
      '-i',
      inputPath,
      '-map',
      '0:v:0',
      '-map',
      '0:a?',
      '-c:v',
      'libx264',
      '-preset',
      'veryfast',
      '-crf',
      '23',
      '-vf',
      'scale=trunc(iw/2)*2:trunc(ih/2)*2',
      '-pix_fmt',
      'yuv420p',
      '-c:a',
      'aac',
      '-b:a',
      '128k',
      '-avoid_negative_ts',
      'make_zero',
      '-movflags',
      '+faststart',
      outputPath,
    ]);

    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      throw const AppException(AppErrorCode.videoNormalizeFailed);
    }

    final outputFile = File(outputPath);

    if (!await outputFile.exists()) {
      throw const AppException(AppErrorCode.normalizedVideoMissing);
    }

    return outputPath;
  }

  Future<int> _readVideoDuration(String path) async {
    final session = await FFprobeKit.getMediaInformation(path);

    final information = session.getMediaInformation();

    if (information == null) {
      return 0;
    }

    final rawDuration = information.getDuration();

    if (rawDuration == null) {
      return 0;
    }

    final seconds = double.tryParse(rawDuration);

    if (seconds == null) {
      return 0;
    }

    return seconds.round();
  }

  Future<String> _createVideoCover(String videoPath) async {
    final videoFile = File(videoPath);

    final outputPath =
        '${videoFile.parent.path}/'
        'cover-'
        '${DateTime.now().microsecondsSinceEpoch}.jpg';

    final session = await FFmpegKit.executeWithArguments([
      '-y',
      '-ss',
      '1',
      '-i',
      videoPath,
      '-frames:v',
      '1',
      '-q:v',
      '2',
      outputPath,
    ]);

    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      throw const AppException(AppErrorCode.coverGenerationFailed);
    }

    final coverFile = File(outputPath);

    if (!await coverFile.exists()) {
      throw const AppException(AppErrorCode.generatedCoverMissing);
    }

    final length = await coverFile.length();

    if (length <= 0) {
      throw const AppException(AppErrorCode.generatedCoverEmpty);
    }

    return outputPath;
  }
}

final videoUploadQueueProvider =
    NotifierProvider<VideoUploadQueueNotifier, List<VideoUploadTask>>(
      VideoUploadQueueNotifier.new,
    );
