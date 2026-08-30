class ProfileVideo {
  final String id;
  final String title;
  final String coverUrl;
  final int viewCount;
  final int durationSeconds;

  const ProfileVideo({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.viewCount,
    required this.durationSeconds,
  });
}

class UserProfile {
  final String id;
  final String username;
  final String displayName;
  final String avatarUrl;
  final String bio;

  final int followerCount;
  final int followingCount;
  final int videoCount;
  final int favoriteCount;

  final List<ProfileVideo> videos;

  const UserProfile({
    required this.id,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    required this.bio,
    required this.followerCount,
    required this.followingCount,
    required this.videoCount,
    required this.favoriteCount,
    required this.videos,
  });
}