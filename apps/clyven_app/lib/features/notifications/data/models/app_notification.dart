enum AppNotificationType { like, comment, follow }

class AppNotification {
  final String id;
  final AppNotificationType type;
  final String actorName;
  final String? contentPreview;
  final DateTime createdAt;
  final bool isRead;
  final String? videoId;

  const AppNotification({
    required this.id,
    required this.type,
    required this.actorName,
    required this.createdAt,
    required this.isRead,
    this.contentPreview,
    this.videoId,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      actorName: actorName,
      contentPreview: contentPreview,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
      videoId: videoId,
    );
  }
}
