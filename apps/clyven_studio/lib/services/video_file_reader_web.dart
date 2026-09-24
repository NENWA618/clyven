import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

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
  final element = html.document.getElementById(inputId);
  if (element is! html.FileUploadInputElement) {
    throw Exception('找不到视频文件输入框');
  }

  final files = element.files;
  if (files == null || files.isEmpty) {
    return null;
  }

  final file = files.first;
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

Future<int> _readDurationSeconds(html.File file) async {
  final url = html.Url.createObjectUrl(file);
  final video = html.VideoElement()
    ..preload = 'metadata'
    ..src = url;

  try {
    video.load();
    await video.onLoadedMetadata.first.timeout(const Duration(seconds: 20));

    final duration = video.duration;
    if (!duration.isFinite || duration <= 0) {
      throw Exception('无法读取视频时长');
    }

    return duration.ceil();
  } finally {
    html.Url.revokeObjectUrl(url);
  }
}

Stream<List<int>> _openFile(html.File file) async* {
  const chunkSize = 2 * 1024 * 1024;
  var offset = 0;

  while (offset < file.size) {
    final end = (offset + chunkSize) > file.size ? file.size : offset + chunkSize;
    final blob = file.slice(offset, end);
    final reader = html.FileReader();
    reader.readAsArrayBuffer(blob);
    await reader.onLoadEnd.first;

    final result = reader.result;
    if (result is! ByteBuffer) {
      throw Exception('无法读取视频文件');
    }

    yield Uint8List.view(result);
    offset = end;
  }
}
