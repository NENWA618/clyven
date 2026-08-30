class VideoUploadDraft {
  final String videoPath;
  final String? coverPath;
  final String title;
  final String description;
  final String category;
  final int durationSeconds;

  const VideoUploadDraft({
    required this.videoPath,
    this.coverPath,
    required this.title,
    required this.description,
    required this.category,
    required this.durationSeconds,
  });
}