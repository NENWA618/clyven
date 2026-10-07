import 'package:glyphora_web_l10n/web_l10n.dart';
String selectedVideoMissingMessage(String? selectionError) {
  final normalized = selectionError?.trim();

  if (normalized != null && normalized.isNotEmpty) {
    return normalized;
  }

  return trNow('Select a video file first', '请先选择视频文件');
}
