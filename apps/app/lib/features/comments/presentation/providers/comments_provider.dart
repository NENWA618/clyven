import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/video_comment.dart';
import '../../data/repositories/comment_repository.dart';
import '../../data/repositories/serverpod_comment_repository.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final client = ref.watch(serverpodClientProvider);

  return ServerpodCommentRepository(client: client);
});

class CommentsState {
  final List<VideoComment> comments;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isSubmitting;

  const CommentsState({
    required this.comments,
    required this.page,
    required this.hasMore,
    required this.isLoadingMore,
    required this.isSubmitting,
  });

  CommentsState copyWith({
    List<VideoComment>? comments,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isSubmitting,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class CommentsNotifier extends AsyncNotifier<CommentsState> {
  final String videoId;

  CommentsNotifier(this.videoId);

  CommentRepository get _repository {
    return ref.read(commentRepositoryProvider);
  }

  @override
  Future<CommentsState> build() async {
    final page = await _repository.loadComments(videoId: videoId, page: 1);

    return CommentsState(
      comments: page.comments,
      page: page.page,
      hasMore: page.hasMore,
      isLoadingMore: false,
      isSubmitting: false,
    );
  }

  Future<void> refresh() async {
    final current = state.value;
    state = const AsyncLoading();

    try {
      final page = await _repository.loadComments(videoId: videoId, page: 1);

      state = AsyncData(
        CommentsState(
          comments: page.comments,
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
          isSubmitting: false,
        ),
      );
    } catch (error, stackTrace) {
      if (current != null) {
        state = AsyncData(current);
        return;
      }
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final nextPage = await _repository.loadComments(
        videoId: videoId,
        page: current.page + 1,
      );

      state = AsyncData(
        current.copyWith(
          comments: List.unmodifiable([
            ...current.comments,
            ...nextPage.comments,
          ]),
          page: nextPage.page,
          hasMore: nextPage.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> submitComment(String content) async {
    final current = state.value;
    if (current == null || current.isSubmitting) {
      return;
    }

    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty) {
      return;
    }

    final user = await ref.read(authProvider.future);
    if (user == null) {
      return;
    }

    state = AsyncData(current.copyWith(isSubmitting: true));

    try {
      final created = await _repository.createComment(
        videoId: videoId,
        userName: user.displayName,
        content: normalizedContent,
      );

      state = AsyncData(
        current.copyWith(
          comments: List.unmodifiable([created, ...current.comments]),
          isSubmitting: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isSubmitting: false));
    }
  }

  Future<void> submitReply({
    required String commentId,
    required String content,
  }) async {
    final current = state.value;
    if (current == null || current.isSubmitting) {
      return;
    }

    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty) {
      return;
    }

    final user = await ref.read(authProvider.future);
    if (user == null) {
      return;
    }

    state = AsyncData(current.copyWith(isSubmitting: true));

    try {
      final reply = await _repository.createReply(
        videoId: videoId,
        commentId: commentId,
        userName: user.displayName,
        content: normalizedContent,
      );

      final updatedComments = current.comments
          .map((comment) {
            if (comment.id != commentId) {
              return comment;
            }

            return comment.copyWith(
              replies: List.unmodifiable([...comment.replies, reply]),
            );
          })
          .toList(growable: false);

      state = AsyncData(
        current.copyWith(
          comments: List.unmodifiable(updatedComments),
          isSubmitting: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isSubmitting: false));
    }
  }

  Future<void> toggleLike(String commentId) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final user = await ref.read(authProvider.future);
    if (user == null) {
      return;
    }

    try {
      final updated = await _repository.toggleCommentLike(
        videoId: videoId,
        commentId: commentId,
      );

      final updatedComments = current.comments
          .map((comment) => comment.id == commentId ? updated : comment)
          .toList(growable: false);

      state = AsyncData(
        current.copyWith(comments: List.unmodifiable(updatedComments)),
      );
    } catch (_) {
      // Keep current state when the server rejects the operation.
    }
  }

  Future<void> toggleReplyLike({
    required String commentId,
    required String replyId,
  }) async {
    final current = state.value;
    if (current == null) {
      return;
    }

    final user = await ref.read(authProvider.future);
    if (user == null) {
      return;
    }

    try {
      final updatedReply = await _repository.toggleReplyLike(
        videoId: videoId,
        commentId: commentId,
        replyId: replyId,
      );

      final updatedComments = current.comments
          .map((comment) {
            if (comment.id != commentId) {
              return comment;
            }

            final replies = comment.replies
                .map((reply) => reply.id == replyId ? updatedReply : reply)
                .toList(growable: false);

            return comment.copyWith(replies: List.unmodifiable(replies));
          })
          .toList(growable: false);

      state = AsyncData(
        current.copyWith(comments: List.unmodifiable(updatedComments)),
      );
    } catch (_) {
      // Keep current state when the server rejects the operation.
    }
  }
}

final commentsProvider =
    AsyncNotifierProvider.family<CommentsNotifier, CommentsState, String>(
      CommentsNotifier.new,
    );
