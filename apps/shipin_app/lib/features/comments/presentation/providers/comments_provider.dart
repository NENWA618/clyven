import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/video_comment.dart';
import '../../data/repositories/comment_repository.dart';

final commentRepositoryProvider =
    Provider<CommentRepository>((ref) {
  return MockCommentRepository();
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
      comments:
          comments ?? this.comments,
      page:
          page ?? this.page,
      hasMore:
          hasMore ?? this.hasMore,
      isLoadingMore:
          isLoadingMore ??
          this.isLoadingMore,
      isSubmitting:
          isSubmitting ??
          this.isSubmitting,
    );
  }
}

class CommentsNotifier
    extends AsyncNotifier<CommentsState> {
  final String videoId;

  CommentsNotifier(
    this.videoId,
  );

  CommentRepository get _repository {
    return ref.read(
      commentRepositoryProvider,
    );
  }

  Future<void> toggleReplyLike({
  required String commentId,
  required String replyId,
}) async {
  final current = state.value;

  if (current == null) {
    return;
  }

  final user = await ref.read(
    authProvider.future,
  );

  if (user == null) {
    return;
  }

  try {
    final updatedReply =
        await _repository.toggleReplyLike(
      videoId: videoId,
      commentId: commentId,
      replyId: replyId,
      userId: user.id,
    );

    final updatedComments =
        current.comments.map(
      (comment) {
        if (comment.id != commentId) {
          return comment;
        }

        final replies =
            comment.replies.map(
          (reply) {
            if (reply.id == replyId) {
              return updatedReply;
            }

            return reply;
          },
        ).toList(
          growable: false,
        );

        return comment.copyWith(
          replies: List.unmodifiable(
            replies,
          ),
        );
      },
    ).toList(
      growable: false,
    );

    state = AsyncData(
      current.copyWith(
        comments: List.unmodifiable(
          updatedComments,
        ),
      ),
    );
  } catch (_) {
    // 失败时保持原状态。
  }
}

@override
Future<CommentsState> build() async {
  final user = await ref.watch(
    authProvider.future,
  );

  final page = await _repository.loadComments(
    videoId: videoId,

    // 游客也能读取评论。
    // __guest__ 不会命中任何真实用户的点赞记录。
    userId: user?.id ?? '__guest__',

    page: 1,
  );

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

  final user = await ref.read(
    authProvider.future,
  );

  state = const AsyncLoading();

  try {
    final page = await _repository.loadComments(
      videoId: videoId,
      userId: user?.id ?? '__guest__',
      page: 1,
    );

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

    state = AsyncError(
      error,
      stackTrace,
    );
  }
}

  Future<void> loadMore() async {
  final current = state.value;

  if (current == null) {
    return;
  }

  if (current.isLoadingMore ||
      !current.hasMore) {
    return;
  }

  final user = await ref.read(
    authProvider.future,
  );

  state = AsyncData(
    current.copyWith(
      isLoadingMore: true,
    ),
  );

  try {
    final nextPage =
        await _repository.loadComments(
      videoId: videoId,
      userId: user?.id ?? '__guest__',
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
    state = AsyncData(
      current.copyWith(
        isLoadingMore: false,
      ),
    );
  }
}

  Future<void> submitComment(
    String content,
  ) async {
    final current = state.value;

    if (current == null ||
        current.isSubmitting) {
      return;
    }

    final normalizedContent =
        content.trim();

    if (normalizedContent.isEmpty) {
      return;
    }

    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        isSubmitting: true,
      ),
    );

    try {
      final created =
          await _repository.createComment(
        videoId: videoId,
        userId: user.id,
        userName: user.displayName,
        content: normalizedContent,
      );

      state = AsyncData(
        current.copyWith(
          comments: List.unmodifiable([
            created,
            ...current.comments,
          ]),
          isSubmitting: false,
        ),
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSubmitting: false,
        ),
      );
    }
  }

  Future<void> submitReply({
    required String commentId,
    required String content,
  }) async {
    final current = state.value;

    if (current == null ||
        current.isSubmitting) {
      return;
    }

    final normalizedContent =
        content.trim();

    if (normalizedContent.isEmpty) {
      return;
    }

    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        isSubmitting: true,
      ),
    );

    try {
      final reply =
          await _repository.createReply(
        videoId: videoId,
        commentId: commentId,
        userId: user.id,
        userName: user.displayName,
        content: normalizedContent,
      );

      final updatedComments =
          current.comments.map(
        (comment) {
          if (comment.id != commentId) {
            return comment;
          }

          return comment.copyWith(
            replies: List.unmodifiable([
              ...comment.replies,
              reply,
            ]),
          );
        },
      ).toList(
        growable: false,
      );

      state = AsyncData(
        current.copyWith(
          comments:
              List.unmodifiable(
            updatedComments,
          ),
          isSubmitting: false,
        ),
      );
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isSubmitting: false,
        ),
      );
    }
  }

  Future<void> toggleLike(
    String commentId,
  ) async {
    final current = state.value;

    if (current == null) {
      return;
    }

    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    try {
      final updated =
          await _repository
              .toggleCommentLike(
        videoId: videoId,
        commentId: commentId,
        userId: user.id,
      );

      final updatedComments =
          current.comments.map(
        (comment) {
          if (comment.id ==
              commentId) {
            return updated;
          }

          return comment;
        },
      ).toList(
        growable: false,
      );

      state = AsyncData(
        current.copyWith(
          comments:
              List.unmodifiable(
            updatedComments,
          ),
        ),
      );
    } catch (_) {
      // 失败时保持原来的评论状态。
    }
  }
}

final commentsProvider =
    AsyncNotifierProvider.family<
        CommentsNotifier,
        CommentsState,
        String>(
  CommentsNotifier.new,
);