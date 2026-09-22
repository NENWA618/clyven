import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

Future<Uint8List?> readSelectedExcelFile(
  String elementId,
) async {
  final element = html.document.querySelector(
    '#$elementId',
  );

  if (element is! html.FileUploadInputElement) {
    return null;
  }

  final files = element.files;

  if (files == null || files.isEmpty) {
    return null;
  }

  final file = files.first;
  final reader = html.FileReader();
  final completer = Completer<Uint8List?>();

  reader.onLoad.first.then((_) {
    final result = reader.result;

    if (result is Uint8List) {
      completer.complete(result);
    } else if (result is ByteBuffer) {
      completer.complete(
        result.asUint8List(),
      );
    } else {
      completer.completeError(
        StateError(
          '无法读取 Excel 文件内容：${result.runtimeType}',
        ),
      );
    }
  });

  reader.onError.first.then((_) {
    if (!completer.isCompleted) {
      completer.completeError(
        StateError(
          '读取 Excel 文件失败',
        ),
      );
    }
  });

  reader.readAsArrayBuffer(file);

  return completer.future;
}
