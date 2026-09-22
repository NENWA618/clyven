import 'dart:async';
import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleSrtImportController {
  SubtitleSrtImportController({
    required this.client,
    required this.videoId,
    required this.languageCode,
    required this.onChanged,
    required this.onImported,
  });

  final Client client;
  final int videoId;
  final String languageCode;

  final void Function() onChanged;
  final Future<void> Function() onImported;

  String? fileName;
  String? content;
  String scriptCode = '';

  SubtitleSrtPreview? preview;

  bool previewing = false;
  bool importing = false;

  String? error;

  bool get hasFile => content != null && content!.isNotEmpty;

  bool get canImport =>
      preview?.canImport == true && scriptCode.trim().isNotEmpty && !importing;

  Future<void> pickFile() async {
    final input = html.FileUploadInputElement()..accept = '.srt';

    input.click();

    await input.onChange.first;

    if (input.files == null || input.files!.isEmpty) {
      return;
    }

    final file = input.files!.first;

    fileName = file.name;
    content = null;
    preview = null;
    error = null;

    onChanged();

    final reader = html.FileReader();

    final completer = Completer<String>();

    reader.onLoad.listen((_) {
      final result = reader.result;

      if (result is String) {
        completer.complete(result);
      } else {
        completer.completeError(Exception('无法读取 SRT 文件'));
      }
    });

    reader.onError.listen((_) {
      completer.completeError(Exception('读取 SRT 文件失败'));
    });

    reader.readAsText(file);

    try {
      content = await completer.future;

      await previewFile();
    } catch (e) {
      error = e.toString();
      onChanged();
    }
  }

  Future<void> previewFile() async {
    final currentContent = content;

    if (currentContent == null || currentContent.isEmpty) {
      error = '请先选择 SRT 文件';
      onChanged();
      return;
    }

    previewing = true;
    error = null;
    preview = null;

    onChanged();

    try {
      preview = await client.subtitle.previewSrtImport(
        videoId: videoId,
        languageCode: languageCode,
        content: currentContent,
      );

      previewing = false;
      onChanged();
    } catch (e) {
      previewing = false;
      error = e.toString();

      onChanged();
    }
  }

  Future<void> confirmReplace() async {
    final currentContent = content;

    if (currentContent == null || currentContent.isEmpty) {
      error = '请先选择 SRT 文件';
      onChanged();
      return;
    }

    if (preview?.canImport != true) {
      error = '当前 SRT 无法导入';
      onChanged();
      return;
    }

    final cleanScriptCode = scriptCode.trim();

    if (cleanScriptCode.isEmpty) {
      error = '请输入 script code';
      onChanged();
      return;
    }

    importing = true;
    error = null;

    onChanged();

    try {
      await client.subtitle.confirmReplaceSrtImport(
        videoId: videoId,
        languageCode: languageCode,
        content: currentContent,
        scriptCode: cleanScriptCode,
      );

      importing = false;

      await onImported();

      reset();
    } catch (e) {
      importing = false;
      error = e.toString();

      onChanged();
    }
  }

  void reset() {
    fileName = null;
    content = null;
    preview = null;
    previewing = false;
    importing = false;
    error = null;

    onChanged();
  }
}
