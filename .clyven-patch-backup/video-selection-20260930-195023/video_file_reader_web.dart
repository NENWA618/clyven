import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

class SelectedVideoFile {
  SelectedVideoFile({
    required this.name,
    required this.size,
    required this.durationSeconds,
    required this.coverBytes,
    required this.openRead,
  });

  final String name;
  final int size;
  final int durationSeconds;
  final Uint8List coverBytes;
  final Stream<List<int>> Function() openRead;
}

Future<SelectedVideoFile?> readSelectedVideoFile(String inputId) async {
  final element = web.document.getElementById(inputId);

  if (element is! web.HTMLInputElement) {
    throw Exception('找不到视频文件输入框');
  }

  final files = element.files;

  if (files == null || files.length == 0) {
    return null;
  }

  final file = files.item(0);

  if (file == null) {
    return null;
  }

  if (file.size <= 0) {
    throw Exception('视频文件不能为空');
  }

  final metadata = await _readMetadataAndCover(file);

  return SelectedVideoFile(
    name: file.name,
    size: file.size,
    durationSeconds: metadata.durationSeconds,
    coverBytes: metadata.coverBytes,
    openRead: () => _openFile(file),
  );
}

Future<_VideoMetadata> _readMetadataAndCover(web.File file) async {
  final url = web.URL.createObjectURL(file);

  final video = web.HTMLVideoElement()
    ..preload = 'auto'
    ..muted = true
    ..src = url;

  try {
    final metadataCompleter = _EventCompleter();

    video.onloadedmetadata = ((web.Event event) {
      metadataCompleter.complete();
    }).toJS;

    video.onerror = ((web.Event event) {
      metadataCompleter.completeError(
        Exception('无法读取视频资料'),
      );
    }).toJS;

    video.load();

    await metadataCompleter.future.timeout(
      const Duration(seconds: 20),
    );

    final duration = video.duration;

    if (!duration.isFinite || duration <= 0) {
      throw Exception('无法读取视频时长');
    }

    if (video.videoWidth <= 0 || video.videoHeight <= 0) {
      throw Exception('无法读取视频尺寸');
    }

    final seekCompleter = _EventCompleter();

    video.onseeked = ((web.Event event) {
      seekCompleter.complete();
    }).toJS;

    video.onerror = ((web.Event event) {
      seekCompleter.completeError(
        Exception('无法生成视频封面'),
      );
    }).toJS;

    final targetSecond = duration > 2 ? 1.0 : duration / 2;
    video.currentTime = targetSecond;

    await seekCompleter.future.timeout(
      const Duration(seconds: 20),
    );

    final sourceWidth = video.videoWidth;
    final sourceHeight = video.videoHeight;
    const maxWidth = 1280;
    final scale = sourceWidth > maxWidth ? maxWidth / sourceWidth : 1.0;
    final coverWidth = (sourceWidth * scale).round();
    final coverHeight = (sourceHeight * scale).round();

    final canvas = web.HTMLCanvasElement()
      ..width = coverWidth
      ..height = coverHeight;

    final context = canvas.getContext('2d');

    if (context is! web.CanvasRenderingContext2D) {
      throw Exception('浏览器无法创建视频封面画布');
    }

    context.drawImage(
      video,
      0,
      0,
      coverWidth.toDouble(),
      coverHeight.toDouble(),
    );

    final dataUrl = canvas.toDataURL('image/jpeg');
    final commaIndex = dataUrl.indexOf(',');

    if (commaIndex < 0) {
      throw Exception('视频封面编码失败');
    }

    final coverBytes = base64Decode(dataUrl.substring(commaIndex + 1));

    if (coverBytes.isEmpty) {
      throw Exception('生成的视频封面为空');
    }

    return _VideoMetadata(
      durationSeconds: duration.ceil(),
      coverBytes: coverBytes,
    );
  } finally {
    video.removeAttribute('src');
    video.load();
    web.URL.revokeObjectURL(url);
  }
}

Stream<List<int>> _openFile(web.File file) async* {
  const chunkSize = 2 * 1024 * 1024;
  var offset = 0;

  while (offset < file.size) {
    final end = (offset + chunkSize) > file.size
        ? file.size
        : offset + chunkSize;

    final blob = file.slice(offset, end);

    final jsBuffer = await blob.arrayBuffer().toDart;
    final buffer = jsBuffer.toDart;
    final bytes = buffer.asUint8List();

    if (bytes.isEmpty && end > offset) {
      throw Exception('视频文件读取到空数据块');
    }

    yield bytes;

    offset = end;
  }
}

class _VideoMetadata {
  const _VideoMetadata({
    required this.durationSeconds,
    required this.coverBytes,
  });

  final int durationSeconds;
  final Uint8List coverBytes;
}

class _EventCompleter {
  final _completer = Completer<void>();

  Future<void> get future => _completer.future;

  void complete() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  void completeError(Object error) {
    if (!_completer.isCompleted) {
      _completer.completeError(error);
    }
  }
}
