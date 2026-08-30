class CommentReply {
  final String id;

  final String userId;

  final String userName;

  final String content;

  final DateTime createdAt;

  final int likeCount;

  final bool isLiked;

  const CommentReply({
    required this.id,
    this.userId = '',
    required this.userName,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
  });

  CommentReply copyWith({
    String? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
  }) {
    return CommentReply(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class VideoComment {
  final String id;

  final String userId;

  final String userName;

  final String content;

  final DateTime createdAt;

  final int likeCount;

  final bool isLiked;

  final List<CommentReply> replies;

  const VideoComment({
    required this.id,
    this.userId = '',
    required this.userName,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
    required this.replies,
  });

  VideoComment copyWith({
    String? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
    List<CommentReply>? replies,
  }) {
    return VideoComment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
    );
  }
}

class CommentPage {
  final List<VideoComment> comments;

  final int page;

  final bool hasMore;

  const CommentPage({
    required this.comments,
    required this.page,
    required this.hasMore,
  });
}