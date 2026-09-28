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
      return 'mp4';
    }

    final raw = fileName.substring(dot + 1).toLowerCase();
    final safe = raw.replaceAll(RegExp(r'[^a-z0-9]'), '');

    return safe.isEmpty ? 'mp4' : safe;
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

  Future<void> startUpload({
    required SelectedVideoFile file,
    required String title,
    required String description,
    required String category,
    required String languageCode,
    required List<String> tags,
    required String authorName,
    required bool isPublic,
  }) async {
    if (busy) {
      throw StateError('当前已有视频正在上传');
    }

    final currentTask = StudioUploadTask(
      fileName: file.name,
      fileSize: file.size,
    );

    task = currentTask;
    _notify();

    try {
      final userId = await client.video.getCurrentUserId();

      final safeUserId =
          userId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');

      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final extension = _extensionFor(file.name);

      final storageKey =
          'videos/$safeUserId/$timestamp.$extension';

      final uploadDescription =
          await client.video.createUploadDescription(
        path: storageKey,
        fileSize: file.size,
      );

      if (uploadDescription == null) {
        throw Exception('无法创建上传任务');
      }

      final uploader = FileUploader(uploadDescription);

      final uploaded = await uploader.upload(
        _trackProgress(
          file.openRead(),
          currentTask,
        ),
        file.size,
      );

      if (!uploaded) {
        throw Exception('视频上传失败');
      }

      currentTask.uploadedBytes = file.size;
      currentTask.stage = StudioUploadStage.verifying;
      _notify();

      final verified =
          await client.video.verifyUpload(path: storageKey);

      if (!verified) {
        throw Exception('视频上传完成，但服务器校验失败');
      }

      currentTask.stage = StudioUploadStage.processing;
      _notify();

      await client.video.create(
        authorId: userId,
        authorName:
            authorName.trim().isEmpty ? userId : authorName.trim(),
        title: title.trim(),
        description: description.trim(),
        category:
            category.trim().isEmpty ? 'general' : category.trim(),
        contentType: VideoContentType.video,
        languageCode:
            languageCode.trim().isEmpty
                ? 'auto'
                : languageCode.trim(),
        tags: tags,
        videoStorageKey: storageKey,
        coverStorageKey: null,
        durationSeconds: file.durationSeconds,
        isPublic: isPublic,
      );

      currentTask.stage = StudioUploadStage.completed;
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