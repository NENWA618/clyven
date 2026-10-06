import '../models/video_comment.dart';

abstract class CommentRepository {
  Future<CommentPage> loadComments({
    required String videoId,
    required int page,
    int limit = 5,
  });

  Future<VideoComment> createComment({
    required String videoId,
    required String userName,
    required String content,
  });

  Future<CommentReply> createReply({
    required String videoId,
    required String commentId,
    required String userName,
    required String content,
  });

  Future<VideoComment> toggleCommentLike({
    required String videoId,
    required String commentId,
  });

  Future<CommentReply> toggleReplyLike({
    required String videoId,
    required String commentId,
    required String replyId,
  });
}
