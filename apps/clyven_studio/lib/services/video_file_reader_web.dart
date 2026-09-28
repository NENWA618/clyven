import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;


class SelectedVideoFile {
  SelectedVideoFile({
    required this.name,
    required this.size,
    required this.durationSeconds,
    required this.openRead,
  });

  final String name;
  final int size;
  final int durationSeconds;
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

  final durationSeconds = await _readDurationSeconds(file);

  return SelectedVideoFile(
    name: file.name,
    size: file.size,
    durationSeconds: durationSeconds,
    openRead: () => _openFile(file),
  );
}

Future<int> _readDurationSeconds(web.File file) async {
  final url = web.URL.createObjectURL(file);

  final video = web.HTMLVideoElement()
    ..preload = 'metadata'
    ..src = url;

  try {
    final completer = _MetadataCompleter();

    video.onloadedmetadata = ((web.Event event) {
      completer.complete();
    }).toJS;

    video.onerror = ((web.Event event) {
      completer.completeError(
        Exception('无法读取视频时长'),
      );
    }).toJS;

    video.load();

    await completer.future.timeout(
      const Duration(seconds: 20),
    );

    final duration = video.duration;

    if (!duration.isFinite || duration <= 0) {
      throw Exception('无法读取视频时长');
    }

    return duration.ceil();
  } finally {
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

class _MetadataCompleter {
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