import 'video_content_type.dart';

class VideoUploadDraft {
  final String videoPath;
  final String? coverPath;
  final String title;
  final String description;
  final String category;
  final String seriesTitle;
  final int durationSeconds;
  final VideoContentType contentType;

  const VideoUploadDraft({
    required this.videoPath,
    this.coverPath,
    required this.title,
    required this.description,
    required this.category,
    this.seriesTitle = '',
    required this.durationSeconds,
    this.contentType = VideoContentType.video,
  });
}
