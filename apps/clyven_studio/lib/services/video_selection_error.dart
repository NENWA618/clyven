String selectedVideoMissingMessage(String? selectionError) {
  final normalized = selectionError?.trim();

  if (normalized != null && normalized.isNotEmpty) {
    return normalized;
  }

  return '请先选择视频文件';
}
