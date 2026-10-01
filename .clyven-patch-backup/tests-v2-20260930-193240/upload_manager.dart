import 'dart:async';

import 'package:clyven_backend_client/clyven_backend_client.dart';

import 'studio_client.dart';
import 'video_file_reader.dart';

typedef StudioUploadListener = void Function();

enum StudioUploadStage {
  uploading,
  verifying,
  processing,
  completed,
  failed,
}

class StudioUploadTask {
  StudioUploadTask({
    required this.fileName,
    required this.fileSize,
  });

  final String fileName;
  final int fileSize;

  int uploadedBytes = 0;
  int attempt = 1;
  StudioUploadStage stage = StudioUploadStage.uploading;
  String? error;

  double get progress {
    if (fileSize <= 0) return 0;
    return (uploadedBytes / fileSize).clamp(0, 1);
  }

  bool get isActive =>
      stage == StudioUploadStage.uploading ||
      stage == StudioUploadStage.verifying ||
      stage == StudioUploadStage.processing;
}

class StudioUploadManager {
  final client = studioClient;
  final List<StudioUploadListener> _listeners = [];

  static const int _maxUploadAttempts = 3;
  static const Duration _uploadTimeout = Duration(hours: 2);

  static const Set<String> _allowedVideoExtensions = {
    'mp4',
    'mov',
    'm4v',
    'webm',
    'mkv',
    'avi',
  };

  StudioUploadTask? task;

  bool get busy => task?.isActive ?? false;

  void addListener(StudioUploadListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(StudioUploadListener listener) {
    _listeners.remove(listener);
  }

  void _notify() {
    for (final listener in List<StudioUploadListener>.from(_listeners)) {
      listener();
    }
  }

  String _extensionFor(String fileName) {
    final dot = fileName.lastIndexOf('.');

    if (dot < 0 || dot == fileName.length - 1) {
      return '';
    }

    final raw = fileName.substring(dot + 1).toLowerCase();
    return raw.replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  void _validateVideoFile(SelectedVideoFile file) {
    if (file.size <= 0) {
      throw Exception('视频文件为空');
    }

    final extension = _extensionFor(file.name);

    if (!_allowedVideoExtensions.contains(extension)) {
      throw Exception(
        '不支持的视频格式 .$extension。'
        '目前允许：${_allowedVideoExtensions.join(', ')}',
      );
    }

    if (file.durationSeconds <= 0) {
      throw Exception('无法读取视频时长，文件可能损坏或格式异常');
    }

    if (file.coverBytes.isEmpty) {
      throw Exception('无法生成视频封面，文件可能损坏或浏览器无法解码');
    }
  }

  Stream<List<int>> _trackProgress(
    Stream<List<int>> source,
    StudioUploadTask currentTask,
  ) async* {
    await for (final chunk in source) {
      currentTask.uploadedBytes += chunk.length;

      if (currentTask.uploadedBytes > currentTask.fileSize) {
        currentTask.uploadedBytes = currentTask.fileSize;
      }

      _notify();
      yield chunk;
    }
  }

  Future<T> _retry<T>(
    Future<T> Function(int attempt) action, {
    required StudioUploadTask currentTask,
    int attempts = _maxUploadAttempts,
  }) async {
    Object? lastError;
    StackTrace? lastStackTrace;

    for (var attempt = 1; attempt <= attempts; attempt++) {
      currentTask.attempt = attempt;
      currentTask.error = null;
      _notify();

      try {
        return await action(attempt);
      } catch (error, stackTrace) {
        lastError = error;
        lastStackTrace = stackTrace;

        if (attempt >= attempts) {
          break;
        }

        currentTask.error = '第 $attempt 次失败，准备自动重试：$error';
        _notify();

        await Future<void>.delayed(
          Duration(seconds: attempt * 2),
        );
      }
    }

    Error.throwWithStackTrace(
      lastError ?? Exception('未知上传错误'),
      lastStackTrace ?? StackTrace.current,
    );
  }

  Future<void> _uploadCover({
    required String storageKey,
    required List<int> bytes,
    required StudioUploadTask currentTask,
  }) async {
    if (bytes.isEmpty) {
      throw Exception('生成的视频封面为空');
    }

    await _retry<void>(
      (attempt) async {
        final uploadDescription = await client.video.createUploadDescription(
          path: storageKey,
          fileSize: bytes.length,
        );

        if (uploadDescription == null) {
          throw Exception('无法创建封面上传任务');
        }

        final uploader = FileUploader(uploadDescription);

        final uploaded = await uploader
            .upload(
              Stream<List<int>>.value(bytes),
              bytes.length,
            )
            .timeout(_uploadTimeout);

        if (!uploaded) {
          throw Exception('视频封面上传失败');
        }

        final verified = await client.video.verifyUpload(path: storageKey);

        if (!verified) {
          throw Exception('视频封面上传完成，但服务器校验失败');
        }
      },
      currentTask: currentTask,
    );
  }

  Future<void> startUpload({
    required SelectedVideoFile file,
    required String title,
    required String description,
    required String category,
    required String languageCode,
    required List<String> tags,
    required bool isPublic,
  }) async {
    if (busy) {
      throw StateError('当前已有视频正在上传');
    }

    _validateVideoFile(file);

    final normalizedTitle = title.trim();

    if (normalizedTitle.isEmpty) {
      throw Exception('视频标题不能为空');
    }

    final currentTask = StudioUploadTask(
      fileName: file.name,
      fileSize: file.size,
    );

    task = currentTask;
    _notify();

    try {
      final userId = await client.video.getCurrentUserId();
      final profile = await client.userProfileEdit.get();
      final creatorName = (profile.fullName ?? profile.userName ?? profile.email ?? userId).trim();

      final safeUserId = userId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');

      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final extension = _extensionFor(file.name);

      final storageKey = 'videos/$safeUserId/$timestamp.$extension';
      final coverStorageKey = 'covers/$safeUserId/$timestamp.jpg';

      await _retry<void>(
        (attempt) async {
          currentTask.stage = StudioUploadStage.uploading;
          currentTask.uploadedBytes = 0;
          _notify();

          final uploadDescription = await client.video.createUploadDescription(
            path: storageKey,
            fileSize: file.size,
          );

          if (uploadDescription == null) {
            throw Exception('无法创建上传任务');
          }

          final uploader = FileUploader(uploadDescription);

          final uploaded = await uploader
              .upload(
                _trackProgress(
                  file.openRead(),
                  currentTask,
                ),
                file.size,
              )
              .timeout(_uploadTimeout);

          if (!uploaded) {
            throw Exception('视频上传失败');
          }

          currentTask.uploadedBytes = file.size;
          currentTask.stage = StudioUploadStage.verifying;
          _notify();

          final verified = await client.video.verifyUpload(path: storageKey);

          if (!verified) {
            throw Exception('视频上传完成，但服务器校验失败');
          }
        },
        currentTask: currentTask,
      );

      await _uploadCover(
        storageKey: coverStorageKey,
        bytes: file.coverBytes,
        currentTask: currentTask,
      );

      currentTask.stage = StudioUploadStage.processing;
      currentTask.error = null;
      _notify();

      await client.video.create(
        authorId: userId,
        authorName: creatorName.isEmpty ? userId : creatorName,
        title: normalizedTitle,
        description: description.trim(),
        category: category.trim().isEmpty ? 'general' : category.trim(),
        contentType: VideoContentType.video,
        languageCode: languageCode.trim().isEmpty ? 'auto' : languageCode.trim(),
        tags: tags,
        videoStorageKey: storageKey,
        coverStorageKey: coverStorageKey,
        durationSeconds: file.durationSeconds,
        isPublic: isPublic,
      );

      currentTask.stage = StudioUploadStage.completed;
      currentTask.error = null;
      _notify();
    } catch (e) {
      currentTask.error = e.toString();
      currentTask.stage = StudioUploadStage.failed;
      _notify();
    }
  }

  void clearFinished() {
    if (task == null || task!.isActive) {
      return;
    }

    task = null;
    _notify();
  }
}

final studioUploadManager = StudioUploadManager();
