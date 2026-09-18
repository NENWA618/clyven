import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../auth/presentation/utils/require_login.dart';
import '../../data/models/video_comment.dart';
import '../providers/comments_provider.dart';

class CommentsPage extends ConsumerStatefulWidget {
  final String videoId;
  final bool embedded;
  final VoidCallback? onClose;

  const CommentsPage({
    super.key,
    required this.videoId,
    this.embedded = false,
    this.onClose,
  });

  @override
  ConsumerState<CommentsPage> createState() {
    return _CommentsPageState();
  }
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  static const Color _inkColor = Color(0xFF161616);

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  String? _replyCommentId;
  String? _replyUserName;

  Color get _backgroundColor => Theme.of(context).colorScheme.surface;
  Color get _purpleColor => Theme.of(context).colorScheme.secondary;
  Color get _acidColor => Theme.of(context).colorScheme.primary;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.extentAfter > 400) {
      return;
    }

    ref.read(commentsProvider(widget.videoId).notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(commentsProvider(widget.videoId));

    final content = Column(
      children: [
        _buildHeader(),
        Expanded(
          child: commentsAsync.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return _buildError();
            },
            data: (state) {
              return RefreshIndicator(
                onRefresh: () {
                  return ref
                      .read(commentsProvider(widget.videoId).notifier)
                      .refresh();
                },
                child: _buildComments(state),
              );
            },
          ),
        ),
        _buildComposer(commentsAsync.value),
      ],
    );

    if (widget.embedded) {
      return Material(color: _backgroundColor, child: content);
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(bottom: false, child: content),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.embedded) {
                widget.onClose?.call();
                return;
              }

              Navigator.pop(context);
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE0DBD2)),
              ),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.commentEyebrow,
                  style: TextStyle(
                    color: _purpleColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.discussionHappening,
                  style: const TextStyle(
                    color: _inkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _acidColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComments(CommentsState state) {
    final l10n = AppLocalizations.of(context)!;

    if (state.comments.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 170),
          const Icon(Icons.forum_outlined, size: 42, color: Color(0xFFAAA49B)),
          const SizedBox(height: 12),
          Center(
            child: Text(
              l10n.noDiscussion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF77736C),
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 32),
      itemCount: state.comments.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.comments.length) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: state.isLoadingMore
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const SizedBox(height: 22),
            ),
          );
        }

        final comment = state.comments[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildCommentCard(comment, index),
        );
      },
    );
  }

  Widget _buildCommentCard(VideoComment comment, int index) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFE3DED5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: index.isEven ? _purpleColor : _inkColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  comment.userName.isEmpty
                      ? '?'
                      : comment.userName.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: const TextStyle(
                        color: _inkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _formatTime(comment.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF99938A),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final allowed = await requireLogin(context, ref);

                  if (!allowed || !mounted) {
                    return;
                  }

                  await ref
                      .read(commentsProvider(widget.videoId).notifier)
                      .toggleLike(comment.id);
                },
                child: Column(
                  children: [
                    Icon(
                      comment.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: comment.isLiked
                          ? _purpleColor
                          : const Color(0xFF77736C),
                      size: 20,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      comment.likeCount.toString(),
                      style: const TextStyle(
                        color: Color(0xFF77736C),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            comment.content,
            style: const TextStyle(
              color: Color(0xFF34312D),
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 13),
          GestureDetector(
            onTap: () {
              setState(() {
                _replyCommentId = comment.id;
                _replyUserName = comment.userName;
              });
              _focusNode.requestFocus();
            },
            child: Text(
              l10n.reply,
              style: TextStyle(
                color: _purpleColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (comment.replies.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: const Color(0xFFF0ECE4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: comment.replies.map((reply) {
                  return _buildReply(comment.id, reply);
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReply(String commentId, CommentReply reply) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: _inkColor,
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Text(
              reply.userName.isEmpty ? '?' : reply.userName.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reply.userName,
                  style: const TextStyle(
                    color: _inkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reply.content,
                  style: const TextStyle(
                    color: Color(0xFF4F4B45),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final allowed = await requireLogin(context, ref);

              if (!allowed || !mounted) {
                return;
              }

              await ref
                  .read(commentsProvider(widget.videoId).notifier)
                  .toggleReplyLike(commentId: commentId, replyId: reply.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Icon(
                    reply.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: reply.isLiked
                        ? _purpleColor
                        : const Color(0xFF77736C),
                    size: 16,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reply.likeCount.toString(),
                    style: const TextStyle(
                      color: Color(0xFF77736C),
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer(CommentsState? state) {
    final l10n = AppLocalizations.of(context)!;
    final replying = _replyCommentId != null;

    return Container(
      decoration: const BoxDecoration(
        color: _inkColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (replying)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.replyingTo(_replyUserName ?? ''),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _replyCommentId = null;
                            _replyUserName = null;
                          });
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white54,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      maxLines: 4,
                      minLines: 1,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: replying
                            ? l10n.writeReplyHint
                            : l10n.leaveEchoHint,
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.white10,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  GestureDetector(
                    onTap: state?.isSubmitting == true ? null : _send,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: _acidColor,
                        shape: BoxShape.circle,
                      ),
                      child: state?.isSubmitting == true
                          ? const Padding(
                              padding: EdgeInsets.all(13),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: _inkColor,
                              ),
                            )
                          : const Icon(
                              Icons.arrow_upward_rounded,
                              color: _inkColor,
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    final allowed = await requireLogin(context, ref);

    if (!allowed || !mounted) {
      return;
    }

    final notifier = ref.read(commentsProvider(widget.videoId).notifier);

    if (_replyCommentId != null) {
      await notifier.submitReply(commentId: _replyCommentId!, content: text);
    } else {
      await notifier.submitComment(text);
    }

    if (!mounted) {
      return;
    }

    _controller.clear();

    setState(() {
      _replyCommentId = null;
      _replyUserName = null;
    });

    _focusNode.unfocus();
  }

  Widget _buildError() {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: FilledButton(
        onPressed: () {
          ref.invalidate(commentsProvider(widget.videoId));
        },
        child: Text(l10n.reloadComments),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    }

    if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes);
    }

    if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours);
    }

    if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    }

    final localeName = Localizations.localeOf(context).toString();
    return DateFormat.yMd(localeName).format(time);
  }
}
