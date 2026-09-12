import 'package:clyven_app/core/errors/app_error.dart';

import '../models/video_comment.dart';

abstract class CommentRepository {
  Future<CommentPage> loadComments({
    required String videoId,
    required String userId,
    required int page,
    int limit = 5,
  });

  Future<VideoComment> createComment({
    required String videoId,
    required String userId,
    required String userName,
    required String content,
  });

  Future<CommentReply> createReply({
    required String videoId,
    required String commentId,
    required String userId,
    required String userName,
    required String content,
  });

  Future<VideoComment> toggleCommentLike({
    required String videoId,
    required String commentId,
    required String userId,
  });

  Future<CommentReply> toggleReplyLike({
    required String videoId,
    required String commentId,
    required String replyId,
    required String userId,
  });
}

class MockCommentRepository
    implements CommentRepository {
  final Map<String, List<VideoComment>> _store = {};
  final Set<String> _commentLikes = {};
  final Set<String> _replyLikes = {};

  String _likeKey({
    required String userId,
    required String commentId,
  }) {
    return '$userId::$commentId';
  }

  String _replyLikeKey({
    required String userId,
    required String replyId,
  }) {
    return '$userId::$replyId';
  }

  void _ensureSeeded(
    String videoId,
  ) {
    if (_store.containsKey(videoId)) {
      return;
    }

    final now = DateTime.now();

    _store[videoId] = [
      VideoComment(
        id: '$videoId-comment-001',
        userId: 'seed-user-001',
        userName: '凌晨观察员',
        content:
            '这个切入角度很好，尤其是中间那一段让我重新理解了这个主题。',
        createdAt: now.subtract(
          const Duration(minutes: 12),
        ),
        likeCount: 128,
        isLiked: false,
        replies: [
          CommentReply(
            id: '$videoId-reply-001',
            userId: 'seed-user-002',
            userName: '远岸信号',
            content:
                '我也是，原本完全没有注意过这一点。',
            createdAt: now.subtract(
              const Duration(minutes: 8),
            ),
            likeCount: 18,
            isLiked: false,
          ),
        ],
      ),
      VideoComment(
        id: '$videoId-comment-002',
        userId: 'seed-user-003',
        userName: '纸上轨道',
        content:
            '画面节奏很舒服，没有为了信息量故意剪得特别快。',
        createdAt: now.subtract(
          const Duration(minutes: 36),
        ),
        likeCount: 86,
        isLiked: false,
        replies: const [],
      ),
      VideoComment(
        id: '$videoId-comment-003',
        userId: 'seed-user-004',
        userName: '语言漫游者',
        content:
            '希望之后能继续做这种长一点的内容，很多细节值得慢慢讲。',
        createdAt: now.subtract(
          const Duration(hours: 1),
        ),
        likeCount: 63,
        isLiked: false,
        replies: const [],
      ),
      VideoComment(
        id: '$videoId-comment-004',
        userId: 'seed-user-005',
        userName: '未命名频道',
        content:
            '已经收藏，准备晚上再完整看一遍。',
        createdAt: now.subtract(
          const Duration(hours: 2),
        ),
        likeCount: 45,
        isLiked: false,
        replies: const [],
      ),
      VideoComment(
        id: '$videoId-comment-005',
        userId: 'seed-user-006',
        userName: '北纬三度',
        content:
            '这种内容很适合配合地图或者时间线一起看。',
        createdAt: now.subtract(
          const Duration(hours: 3),
        ),
        likeCount: 31,
        isLiked: false,
        replies: const [],
      ),
      VideoComment(
        id: '$videoId-comment-006',
        userId: 'seed-user-007',
        userName: '缓慢加载中',
        content:
            '第一次刷到这个频道，内容比我预想的完整很多。',
        createdAt: now.subtract(
          const Duration(hours: 5),
        ),
        likeCount: 27,
        isLiked: false,
        replies: const [],
      ),
      VideoComment(
        id: '$videoId-comment-007',
        userId: 'seed-user-008',
        userName: '雨后窗口',
        content:
            '最后那个镜头很喜欢，有一种纪录片结束后的余韵。',
        createdAt: now.subtract(
          const Duration(hours: 8),
        ),
        likeCount: 19,
        isLiked: false,
        replies: const [],
      ),
    ];
  }

  List<VideoComment> _commentsFor(
    String videoId,
  ) {
    _ensureSeeded(videoId);
    return _store[videoId]!;
  }

  @override
  Future<CommentPage> loadComments({
    required String videoId,
    required String userId,
    required int page,
    int limit = 5,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    final comments = _commentsFor(videoId);
    final start = (page - 1) * limit;

    if (start >= comments.length) {
      return CommentPage(
        comments: const [],
        page: page,
        hasMore: false,
      );
    }

    final end = (start + limit) > comments.length
        ? comments.length
        : start + limit;

    final pageComments = comments
        .sublist(start, end)
        .map(
          (comment) {
            final liked = _commentLikes.contains(
              _likeKey(
                userId: userId,
                commentId: comment.id,
              ),
            );

            final replies = comment.replies
                .map(
                  (reply) {
                    final replyLiked = _replyLikes.contains(
                      _replyLikeKey(
                        userId: userId,
                        replyId: reply.id,
                      ),
                    );

                    return reply.copyWith(
                      isLiked: replyLiked,
                    );
                  },
                )
                .toList(growable: false);

            return comment.copyWith(
              isLiked: liked,
              replies: List.unmodifiable(replies),
            );
          },
        )
        .toList(growable: false);

    return CommentPage(
      comments: List.unmodifiable(pageComments),
      page: page,
      hasMore: end < comments.length,
    );
  }

  @override
  Future<VideoComment> createComment({
    required String videoId,
    required String userId,
    required String userName,
    required String content,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final normalizedContent = content.trim();

    if (normalizedContent.isEmpty) {
      throw const AppException(
        AppErrorCode.commentEmpty,
      );
    }

    final comment = VideoComment(
      id: 'comment-${DateTime.now().microsecondsSinceEpoch}',
      userId: userId,
      userName: userName,
      content: normalizedContent,
      createdAt: DateTime.now(),
      likeCount: 0,
      isLiked: false,
      replies: const [],
    );

    _commentsFor(videoId).insert(
      0,
      comment,
    );

    return comment;
  }

  @override
  Future<CommentReply> createReply({
    required String videoId,
    required String commentId,
    required String userId,
    required String userName,
    required String content,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final normalizedContent = content.trim();

    if (normalizedContent.isEmpty) {
      throw const AppException(
        AppErrorCode.replyEmpty,
      );
    }

    final comments = _commentsFor(videoId);
    final index = comments.indexWhere(
      (comment) => comment.id == commentId,
    );

    if (index == -1) {
      throw const AppException(
        AppErrorCode.commentNotFound,
      );
    }

    final reply = CommentReply(
      id: 'reply-${DateTime.now().microsecondsSinceEpoch}',
      userId: userId,
      userName: userName,
      content: normalizedContent,
      createdAt: DateTime.now(),
      likeCount: 0,
      isLiked: false,
    );

    final comment = comments[index];

    comments[index] = comment.copyWith(
      replies: List.unmodifiable([
        ...comment.replies,
        reply,
      ]),
    );

    return reply;
  }

  @override
  Future<VideoComment> toggleCommentLike({
    required String videoId,
    required String commentId,
    required String userId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    final comments = _commentsFor(videoId);
    final index = comments.indexWhere(
      (comment) => comment.id == commentId,
    );

    if (index == -1) {
      throw const AppException(
        AppErrorCode.commentNotFound,
      );
    }

    final comment = comments[index];
    final key = _likeKey(
      userId: userId,
      commentId: commentId,
    );

    final currentlyLiked = _commentLikes.contains(key);
    final bool liked;

    if (currentlyLiked) {
      _commentLikes.remove(key);
      liked = false;
    } else {
      _commentLikes.add(key);
      liked = true;
    }

    final newLikeCount = liked
        ? comment.likeCount + 1
        : comment.likeCount > 0
            ? comment.likeCount - 1
            : 0;

    final storedComment = comment.copyWith(
      likeCount: newLikeCount,
      isLiked: false,
    );

    comments[index] = storedComment;

    return storedComment.copyWith(
      isLiked: liked,
    );
  }

  @override
  Future<CommentReply> toggleReplyLike({
    required String videoId,
    required String commentId,
    required String replyId,
    required String userId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    final comments = _commentsFor(videoId);
    final commentIndex = comments.indexWhere(
      (comment) => comment.id == commentId,
    );

    if (commentIndex == -1) {
      throw const AppException(
        AppErrorCode.commentNotFound,
      );
    }

    final comment = comments[commentIndex];
    final replyIndex = comment.replies.indexWhere(
      (reply) => reply.id == replyId,
    );

    if (replyIndex == -1) {
      throw const AppException(
        AppErrorCode.replyNotFound,
      );
    }

    final reply = comment.replies[replyIndex];
    final key = _replyLikeKey(
      userId: userId,
      replyId: replyId,
    );

    final currentlyLiked = _replyLikes.contains(key);
    final bool liked;

    if (currentlyLiked) {
      _replyLikes.remove(key);
      liked = false;
    } else {
      _replyLikes.add(key);
      liked = true;
    }

    final newLikeCount = liked
        ? reply.likeCount + 1
        : reply.likeCount > 0
            ? reply.likeCount - 1
            : 0;

    final storedReply = reply.copyWith(
      likeCount: newLikeCount,
      isLiked: false,
    );

    final updatedReplies = [
      ...comment.replies,
    ];

    updatedReplies[replyIndex] = storedReply;

    comments[commentIndex] = comment.copyWith(
      replies: List.unmodifiable(updatedReplies),
    );

    return storedReply.copyWith(
      isLiked: liked,
    );
  }
}
