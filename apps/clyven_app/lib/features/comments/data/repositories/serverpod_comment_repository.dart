import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

import '../models/video_comment.dart';
import 'comment_repository.dart';

class ServerpodCommentRepository implements CommentRepository {
  final serverpod.Client client;

  const ServerpodCommentRepository({required this.client});

  int _videoId(String value) {
    final id = int.tryParse(value);
    if (id == null) {
      throw StateError('评论只支持真实 Serverpod 视频 ID：$value');
    }
    return id;
  }

  int _entityId(String value, String label) {
    final id = int.tryParse(value);
    if (id == null) {
      throw StateError('$label ID 无效：$value');
    }
    return id;
  }

  @override
  Future<CommentPage> loadComments({
    required String videoId,
    required int page,
    int limit = 5,
  }) async {
    final result = await client.comment.loadComments(
      videoId: _videoId(videoId),
      page: page,
      limit: limit,
    );

    return CommentPage(
      comments: result.comments.map(_toVideoComment).toList(growable: false),
      page: result.page,
      hasMore: result.hasMore,
    );
  }

  @override
  Future<VideoComment> createComment({
    required String videoId,
    required String userName,
    required String content,
  }) async {
    final result = await client.comment.createComment(
      videoId: _videoId(videoId),
      userName: userName,
      content: content,
    );
    return _toVideoComment(result);
  }

  @override
  Future<CommentReply> createReply({
    required String videoId,
    required String commentId,
    required String userName,
    required String content,
  }) async {
    final result = await client.comment.createReply(
      videoId: _videoId(videoId),
      commentId: _entityId(commentId, 'comment'),
      userName: userName,
      content: content,
    );
    return _toReply(result);
  }

  @override
  Future<VideoComment> toggleCommentLike({
    required String videoId,
    required String commentId,
  }) async {
    final result = await client.comment.toggleCommentLike(
      videoId: _videoId(videoId),
      commentId: _entityId(commentId, 'comment'),
    );
    return _toVideoComment(result);
  }

  @override
  Future<CommentReply> toggleReplyLike({
    required String videoId,
    required String commentId,
    required String replyId,
  }) async {
    final result = await client.comment.toggleReplyLike(
      videoId: _videoId(videoId),
      commentId: _entityId(commentId, 'comment'),
      replyId: _entityId(replyId, 'reply'),
    );
    return _toReply(result);
  }

  VideoComment _toVideoComment(serverpod.VideoCommentDto value) {
    return VideoComment(
      id: value.id.toString(),
      userId: value.userId,
      userName: value.userName,
      content: value.content,
      createdAt: value.createdAt,
      likeCount: value.likeCount,
      isLiked: value.isLiked,
      replies: value.replies.map(_toReply).toList(growable: false),
    );
  }

  CommentReply _toReply(serverpod.CommentReplyDto value) {
    return CommentReply(
      id: value.id.toString(),
      userId: value.userId,
      userName: value.userName,
      content: value.content,
      createdAt: value.createdAt,
      likeCount: value.likeCount,
      isLiked: value.isLiked,
    );
  }
}
