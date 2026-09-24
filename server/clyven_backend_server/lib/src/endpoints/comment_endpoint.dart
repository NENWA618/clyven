import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class CommentEndpoint extends Endpoint {
  String? _currentUserId(Session session) {
    return session.authenticated?.userIdentifier.toString();
  }

  String _requireUserId(Session session) {
    final userId = _currentUserId(session);
    if (userId == null) {
      throw Exception('需要登录后才能执行评论操作');
    }
    return userId;
  }

  String _normalizeContent(String content) {
    final value = content.trim();
    if (value.isEmpty) {
      throw Exception('评论内容不能为空');
    }
    if (value.length > 2000) {
      throw Exception('评论内容不能超过 2000 个字符');
    }
    return value;
  }

  String _normalizeUserName(String userName) {
    final value = userName.trim();
    if (value.isEmpty) {
      return 'Clyven user';
    }
    return value.length > 80 ? value.substring(0, 80) : value;
  }

  Future<Video> _requireVideo(Session session, int videoId) async {
    final video = await Video.db.findById(session, videoId);
    if (video == null) {
      throw Exception('视频不存在');
    }
    return video;
  }

  Future<VideoCommentRow> _requireComment(
    Session session, {
    required int videoId,
    required int commentId,
  }) async {
    final comment = await VideoCommentRow.db.findFirstRow(
      session,
      where: (c) => c.id.equals(commentId) & c.videoId.equals(videoId),
    );
    if (comment == null) {
      throw Exception('评论不存在');
    }
    return comment;
  }

  Future<CommentReplyRow> _requireReply(
    Session session, {
    required int commentId,
    required int replyId,
  }) async {
    final reply = await CommentReplyRow.db.findFirstRow(
      session,
      where: (r) => r.id.equals(replyId) & r.commentId.equals(commentId),
    );
    if (reply == null) {
      throw Exception('回复不存在');
    }
    return reply;
  }

  Future<CommentPageDto> loadComments(
    Session session, {
    required int videoId,
    required int page,
    int limit = 5,
  }) async {
    await _requireVideo(session, videoId);

    final safePage = page < 1 ? 1 : page;
    final safeLimit = limit.clamp(1, 50);
    final offset = (safePage - 1) * safeLimit;

    final rows = await VideoCommentRow.db.find(
      session,
      where: (c) => c.videoId.equals(videoId),
      orderBy: (c) => c.createdAt,
      orderDescending: true,
      limit: safeLimit + 1,
      offset: offset,
    );

    final hasMore = rows.length > safeLimit;
    final pageRows = rows.take(safeLimit).toList(growable: false);

    if (pageRows.isEmpty) {
      return CommentPageDto(
        comments: const [],
        page: safePage,
        hasMore: false,
      );
    }

    final commentIds = pageRows.map((row) => row.id).whereType<int>().toSet();

    final replies = commentIds.isEmpty
        ? <CommentReplyRow>[]
        : await CommentReplyRow.db.find(
            session,
            where: (r) => r.commentId.inSet(commentIds),
            orderBy: (r) => r.createdAt,
          );

    final repliesByComment = <int, List<CommentReplyRow>>{};
    for (final reply in replies) {
      repliesByComment
          .putIfAbsent(reply.commentId, () => <CommentReplyRow>[])
          .add(reply);
    }

    final userId = _currentUserId(session);
    final likedCommentIds = <int>{};
    final likedReplyIds = <int>{};

    if (userId != null) {
      if (commentIds.isNotEmpty) {
        final commentLikes = await CommentLike.db.find(
          session,
          where: (like) =>
              like.userId.equals(userId) & like.commentId.inSet(commentIds),
        );
        likedCommentIds.addAll(
          commentLikes.map((like) => like.commentId),
        );
      }

      final replyIds = replies
          .map((reply) => reply.id)
          .whereType<int>()
          .toSet();

      if (replyIds.isNotEmpty) {
        final replyLikes = await CommentReplyLike.db.find(
          session,
          where: (like) =>
              like.userId.equals(userId) & like.replyId.inSet(replyIds),
        );
        likedReplyIds.addAll(
          replyLikes.map((like) => like.replyId),
        );
      }
    }

    final comments = pageRows
        .map((row) {
          final id = row.id!;
          final commentReplies =
              repliesByComment[id] ?? const <CommentReplyRow>[];

          return VideoCommentDto(
            id: id,
            userId: row.userId,
            userName: row.userName,
            content: row.content,
            createdAt: row.createdAt,
            likeCount: row.likeCount,
            isLiked: likedCommentIds.contains(id),
            replies: commentReplies
                .map((reply) {
                  final replyId = reply.id!;
                  return CommentReplyDto(
                    id: replyId,
                    userId: reply.userId,
                    userName: reply.userName,
                    content: reply.content,
                    createdAt: reply.createdAt,
                    likeCount: reply.likeCount,
                    isLiked: likedReplyIds.contains(replyId),
                  );
                })
                .toList(growable: false),
          );
        })
        .toList(growable: false);

    return CommentPageDto(
      comments: comments,
      page: safePage,
      hasMore: hasMore,
    );
  }

  Future<VideoCommentDto> createComment(
    Session session, {
    required int videoId,
    required String userName,
    required String content,
  }) async {
    final userId = _requireUserId(session);
    final video = await _requireVideo(session, videoId);
    final now = DateTime.now();

    final row = await VideoCommentRow.db.insertRow(
      session,
      VideoCommentRow(
        videoId: videoId,
        userId: userId,
        userName: _normalizeUserName(userName),
        content: _normalizeContent(content),
        likeCount: 0,
        createdAt: now,
      ),
    );

    video.commentCount += 1;
    video.updatedAt = now;
    await Video.db.updateRow(session, video);

    return VideoCommentDto(
      id: row.id!,
      userId: row.userId,
      userName: row.userName,
      content: row.content,
      createdAt: row.createdAt,
      likeCount: row.likeCount,
      isLiked: false,
      replies: const [],
    );
  }

  Future<CommentReplyDto> createReply(
    Session session, {
    required int videoId,
    required int commentId,
    required String userName,
    required String content,
  }) async {
    final userId = _requireUserId(session);

    await _requireComment(
      session,
      videoId: videoId,
      commentId: commentId,
    );

    final row = await CommentReplyRow.db.insertRow(
      session,
      CommentReplyRow(
        commentId: commentId,
        userId: userId,
        userName: _normalizeUserName(userName),
        content: _normalizeContent(content),
        likeCount: 0,
        createdAt: DateTime.now(),
      ),
    );

    return CommentReplyDto(
      id: row.id!,
      userId: row.userId,
      userName: row.userName,
      content: row.content,
      createdAt: row.createdAt,
      likeCount: row.likeCount,
      isLiked: false,
    );
  }

  Future<VideoCommentDto> toggleCommentLike(
    Session session, {
    required int videoId,
    required int commentId,
  }) async {
    final userId = _requireUserId(session);

    final comment = await _requireComment(
      session,
      videoId: videoId,
      commentId: commentId,
    );

    final existing = await CommentLike.db.findFirstRow(
      session,
      where: (like) =>
          like.commentId.equals(commentId) & like.userId.equals(userId),
    );

    final bool liked;
    if (existing == null) {
      await CommentLike.db.insertRow(
        session,
        CommentLike(
          commentId: commentId,
          userId: userId,
          createdAt: DateTime.now(),
        ),
      );
      comment.likeCount += 1;
      liked = true;
    } else {
      await CommentLike.db.deleteRow(session, existing);
      if (comment.likeCount > 0) {
        comment.likeCount -= 1;
      }
      liked = false;
    }

    await VideoCommentRow.db.updateRow(session, comment);

    final replies = await CommentReplyRow.db.find(
      session,
      where: (reply) => reply.commentId.equals(commentId),
      orderBy: (reply) => reply.createdAt,
    );

    final replyIds = replies.map((reply) => reply.id).whereType<int>().toSet();

    final likedReplyIds = <int>{};
    if (replyIds.isNotEmpty) {
      final replyLikes = await CommentReplyLike.db.find(
        session,
        where: (like) =>
            like.userId.equals(userId) & like.replyId.inSet(replyIds),
      );
      likedReplyIds.addAll(
        replyLikes.map((like) => like.replyId),
      );
    }

    return VideoCommentDto(
      id: comment.id!,
      userId: comment.userId,
      userName: comment.userName,
      content: comment.content,
      createdAt: comment.createdAt,
      likeCount: comment.likeCount,
      isLiked: liked,
      replies: replies
          .map((reply) {
            final replyId = reply.id!;
            return CommentReplyDto(
              id: replyId,
              userId: reply.userId,
              userName: reply.userName,
              content: reply.content,
              createdAt: reply.createdAt,
              likeCount: reply.likeCount,
              isLiked: likedReplyIds.contains(replyId),
            );
          })
          .toList(growable: false),
    );
  }

  Future<CommentReplyDto> toggleReplyLike(
    Session session, {
    required int videoId,
    required int commentId,
    required int replyId,
  }) async {
    final userId = _requireUserId(session);

    await _requireComment(
      session,
      videoId: videoId,
      commentId: commentId,
    );

    final reply = await _requireReply(
      session,
      commentId: commentId,
      replyId: replyId,
    );

    final existing = await CommentReplyLike.db.findFirstRow(
      session,
      where: (like) =>
          like.replyId.equals(replyId) & like.userId.equals(userId),
    );

    final bool liked;
    if (existing == null) {
      await CommentReplyLike.db.insertRow(
        session,
        CommentReplyLike(
          replyId: replyId,
          userId: userId,
          createdAt: DateTime.now(),
        ),
      );
      reply.likeCount += 1;
      liked = true;
    } else {
      await CommentReplyLike.db.deleteRow(session, existing);
      if (reply.likeCount > 0) {
        reply.likeCount -= 1;
      }
      liked = false;
    }

    await CommentReplyRow.db.updateRow(session, reply);

    return CommentReplyDto(
      id: reply.id!,
      userId: reply.userId,
      userName: reply.userName,
      content: reply.content,
      createdAt: reply.createdAt,
      likeCount: reply.likeCount,
      isLiked: liked,
    );
  }

  Future<Video> _requireManagedVideo(
    Session session,
    int videoId,
  ) async {
    final userId = _requireUserId(session);
    final video = await _requireVideo(session, videoId);

    if (video.authorId != userId) {
      throw Exception('只能管理自己视频下的评论');
    }

    return video;
  }

  Future<void> deleteManagedComment(
    Session session, {
    required int videoId,
    required int commentId,
  }) async {
    final video = await _requireManagedVideo(session, videoId);
    final comment = await _requireComment(
      session,
      videoId: videoId,
      commentId: commentId,
    );

    final replies = await CommentReplyRow.db.find(
      session,
      where: (row) => row.commentId.equals(commentId),
    );
    final replyIds = replies.map((row) => row.id).whereType<int>().toSet();

    if (replyIds.isNotEmpty) {
      await CommentReplyLike.db.deleteWhere(
        session,
        where: (row) => row.replyId.inSet(replyIds),
      );
    }

    await CommentReplyRow.db.deleteWhere(
      session,
      where: (row) => row.commentId.equals(commentId),
    );
    await CommentLike.db.deleteWhere(
      session,
      where: (row) => row.commentId.equals(commentId),
    );
    await VideoCommentRow.db.deleteRow(session, comment);

    if (video.commentCount > 0) {
      video.commentCount -= 1;
    }
    video.updatedAt = DateTime.now();
    await Video.db.updateRow(session, video);
  }

  Future<void> deleteManagedReply(
    Session session, {
    required int videoId,
    required int commentId,
    required int replyId,
  }) async {
    await _requireManagedVideo(session, videoId);
    await _requireComment(
      session,
      videoId: videoId,
      commentId: commentId,
    );
    final reply = await _requireReply(
      session,
      commentId: commentId,
      replyId: replyId,
    );

    await CommentReplyLike.db.deleteWhere(
      session,
      where: (row) => row.replyId.equals(replyId),
    );
    await CommentReplyRow.db.deleteRow(session, reply);
  }
}
