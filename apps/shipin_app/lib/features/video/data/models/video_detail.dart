class VideoDetail {
  final String id;
  final String title;
  final String description;

  final String authorId;
  final String authorName;

  final String category;
  final List<String> tags;

  final String coverUrl;
  final String videoUrl;

  final int durationSeconds;
  final int viewCount;
  final int likeCount;
  final int favoriteCount;
  final int commentCount;

  final DateTime publishedAt;

  const VideoDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.authorName,
    required this.category,
    required this.tags,
    required this.coverUrl,
    required this.videoUrl,
    required this.durationSeconds,
    required this.viewCount,
    required this.likeCount,
    required this.favoriteCount,
    required this.commentCount,
    required this.publishedAt,
  });
}