import 'package:glyphora_web_l10n/web_l10n.dart';
import 'dart:async';

const Set<String> allowedVideoExtensions = {
  'mp4',
  'mov',
  'm4v',
  'webm',
  'mkv',
  'avi',
};

String videoFileExtension(String fileName) {
  final dot = fileName.lastIndexOf('.');

  if (dot < 0 || dot == fileName.length - 1) {
    return '';
  }

  final raw = fileName.substring(dot + 1).toLowerCase();
  return raw.replaceAll(RegExp(r'[^a-z0-9]'), '');
}

void validateVideoMetadata({
  required String fileName,
  required int fileSize,
  required num durationSeconds,
  required List<int> coverBytes,
}) {
  if (fileSize <= 0) {
    throw Exception(trNow('The video file is empty', '视频文件为空'));
  }

  final extension = videoFileExtension(fileName);

  if (!allowedVideoExtensions.contains(extension)) {
    throw Exception(
      trNow(
        'Unsupported video format .$extension. '
        'Allowed: ${allowedVideoExtensions.join(', ')}',
        '不支持的视频格式 .$extension。'
        '目前允许：${allowedVideoExtensions.join(', ')}',
      ),
    );
  }

  if (durationSeconds <= 0) {
    throw Exception(trNow('Could not read the video duration; the file may be corrupt or malformed', '无法读取视频时长，文件可能损坏或格式异常'));
  }

  if (coverBytes.isEmpty) {
    throw Exception(trNow('Could not generate a cover; the file may be corrupt or the browser cannot decode it', '无法生成视频封面，文件可能损坏或浏览器无法解码'));
  }
}

typedef RetryDelay = Future<void> Function(Duration duration);

Future<T> retryAsync<T>({
  required Future<T> Function(int attempt) action,
  int attempts = 3,
  RetryDelay delay = Future<void>.delayed,
  void Function(int attempt)? onAttempt,
  void Function(int attempt, Object error)? onRetry,
}) async {
  if (attempts <= 0) {
    throw ArgumentError.value(attempts, 'attempts', 'must be greater than 0');
  }

  Object? lastError;
  StackTrace? lastStackTrace;

  for (var attempt = 1; attempt <= attempts; attempt++) {
    onAttempt?.call(attempt);

    try {
      return await action(attempt);
    } catch (error, stackTrace) {
      lastError = error;
      lastStackTrace = stackTrace;

      if (attempt >= attempts) break;

      onRetry?.call(attempt, error);
      await delay(Duration(seconds: attempt * 2));
    }
  }

  Error.throwWithStackTrace(
    lastError ?? StateError(trNow('Unknown upload error', '未知上传错误')),
    lastStackTrace ?? StackTrace.current,
  );
}
