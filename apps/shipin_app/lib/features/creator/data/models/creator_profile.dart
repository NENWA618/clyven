class CreatorVideoPreview {
  final String id;
  final String title;
  final String coverUrl;
  final int viewCount;
  final int durationSeconds;

  const CreatorVideoPreview({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.viewCount,
    required this.durationSeconds,
  });
}

class CreatorProfile {
  final String id;
  final String name;
  final String bio;

  final String avatarUrl;
  final String bannerUrl;

  final int followerCount;
  final int followingCount;
  final int videoCount;
  final int totalViewCount;

  final List<CreatorVideoPreview> videos;

  const CreatorProfile({
    required this.id,
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.bannerUrl,
    required this.followerCount,
    required this.followingCount,
    required this.videoCount,
    required this.totalViewCount,
    required this.videos,
  });
}