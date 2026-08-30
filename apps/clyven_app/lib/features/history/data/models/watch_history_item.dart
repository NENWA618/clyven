class WatchHistoryItem {
  final String videoId;
  final String title;
  final String coverUrl;
  final String authorName;

  final int positionSeconds;
  final int durationSeconds;

  final DateTime watchedAt;

  const WatchHistoryItem({
    required this.videoId,
    required this.title,
    required this.coverUrl,
    required this.authorName,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.watchedAt,
  });

  double get progress {
    if (durationSeconds <= 0) {
      return 0;
    }

    return (positionSeconds / durationSeconds)
        .clamp(0.0, 1.0);
  }

  WatchHistoryItem copyWith({
    String? videoId,
    String? title,
    String? coverUrl,
    String? authorName,
    int? positionSeconds,
    int? durationSeconds,
    DateTime? watchedAt,
  }) {
    return WatchHistoryItem(
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      authorName:
          authorName ?? this.authorName,
      positionSeconds:
          positionSeconds ??
          this.positionSeconds,
      durationSeconds:
          durationSeconds ??
          this.durationSeconds,
      watchedAt:
          watchedAt ?? this.watchedAt,
    );
  }
}