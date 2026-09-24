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
  throw UnsupportedError('Video file selection is only available in the browser.');
}
