import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/studio_client.dart';

class CommentsManagementPage extends StatefulComponent {
  const CommentsManagementPage({super.key});

  @override
  State<CommentsManagementPage> createState() => _CommentsManagementPageState();
}

class _CommentsManagementPageState extends State<CommentsManagementPage> {
  final client = studioClient;

  bool loadingVideos = true;
  bool loadingComments = false;
  String? error;

  List<Video> videos = [];
  int? selectedVideoId;
  CommentPageDto? commentPage;
  int page = 1;
  int? busyCommentId;
  int? busyReplyId;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      loadingVideos = true;
      error = null;
    });

    try {
      final result = await client.video.getMyVideos();
      final selected = selectedVideoId ?? (result.isNotEmpty ? result.first.id : null);

      setState(() {
        videos = result;
        selectedVideoId = selected;
        loadingVideos = false;
      });

      if (selected != null) {
        await _loadComments(resetPage: true);
      }
    } catch (e) {
      setState(() {
        loadingVideos = false;
        error = e.toString();
      });
    }
  }

  Future<void> _selectVideo(int videoId) async {
    setState(() {
      selectedVideoId = videoId;
      commentPage = null;
      page = 1;
    });
    await _loadComments(resetPage: true);
  }

  Future<void> _loadComments({bool resetPage = false}) async {
    final videoId = selectedVideoId;
    if (videoId == null) {
      return;
    }

    if (resetPage) {
      page = 1;
    }

    setState(() {
      loadingComments = true;
      error = null;
    });

    try {
      final result = await client.comment.loadComments(
        videoId: videoId,
        page: page,
        limit: 20,
      );
      setState(() {
        commentPage = result;
        loadingComments = false;
      });
    } catch (e) {
      setState(() {
        loadingComments = false;
        error = e.toString();
      });
    }
  }

  Future<void> _deleteComment(VideoCommentDto comment) async {
    final videoId = selectedVideoId;
    if (videoId == null) {
      return;
    }

    setState(() {
      busyCommentId = comment.id;
      error = null;
    });

    try {
      await client.comment.deleteManagedComment(
        videoId: videoId,
        commentId: comment.id,
      );
      await _loadComments();
      await _loadVideosSilently();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        busyCommentId = null;
      });
    }
  }

  Future<void> _deleteReply(
    VideoCommentDto comment,
    CommentReplyDto reply,
  ) async {
    final videoId = selectedVideoId;
    if (videoId == null) {
      return;
    }

    setState(() {
      busyReplyId = reply.id;
      error = null;
    });

    try {
      await client.comment.deleteManagedReply(
        videoId: videoId,
        commentId: comment.id,
        replyId: reply.id,
      );
      await _loadComments();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        busyReplyId = null;
      });
    }
  }

  Future<void> _loadVideosSilently() async {
    try {
      final result = await client.video.getMyVideos();
      setState(() {
        videos = result;
      });
    } catch (_) {}
  }

  @override
  Component build(BuildContext context) {
    final selectedVideo = videos.where((video) => video.id == selectedVideoId).firstOrNull;

    return div(
      classes: 'studio-comments-page',
      [
        div(
          classes: 'studio-page-heading',
          [
            div([
              h1([.text('Comments')]),
              p([.text('查看并管理自己视频下的评论与回复。')]),
            ]),
            button(
              classes: 'sv-secondary-button',
              onClick: loadingVideos ? null : _loadVideos,
              [.text('Refresh')],
            ),
          ],
        ),
        if (error != null) div(classes: 'sv-alert sv-alert-error', [.text(error!)]),
        div(
          classes: 'sc-layout',
          [
            aside(
              classes: 'sc-video-list',
              [
                h2([.text('Videos')]),
                if (loadingVideos)
                  p([.text('Loading...')])
                else if (videos.isEmpty)
                  p([.text('没有可管理的视频。')])
                else
                  for (final video in videos)
                    button(
                      classes: 'sc-video-item${video.id == selectedVideoId ? ' active' : ''}',
                      onClick: video.id == null ? null : () => _selectVideo(video.id!),
                      [
                        strong([.text(video.title)]),
                        span([
                          .text(
                            '${video.commentCount} comments · ${video.isPublic ? 'Public' : 'Private'}',
                          ),
                        ]),
                      ],
                    ),
              ],
            ),
            section(
              classes: 'sc-comments-panel',
              [
                h2([
                  .text(
                    selectedVideo == null ? 'Comments' : selectedVideo.title,
                  ),
                ]),
                if (loadingComments)
                  p([.text('正在读取评论...')])
                else if (selectedVideoId == null)
                  div(classes: 'sv-empty', [.text('请选择视频。')])
                else if (commentPage == null || commentPage!.comments.isEmpty)
                  div(classes: 'sv-empty', [.text('这一页没有评论。')])
                else ...[
                  for (final comment in commentPage!.comments) _commentCard(comment),
                  div(
                    classes: 'sc-pagination',
                    [
                      button(
                        classes: 'sv-secondary-button',
                        onClick: page <= 1 || loadingComments
                            ? null
                            : () async {
                                page -= 1;
                                await _loadComments();
                              },
                        [.text('Previous')],
                      ),
                      span([.text('Page $page')]),
                      button(
                        classes: 'sv-secondary-button',
                        onClick: !(commentPage?.hasMore ?? false) || loadingComments
                            ? null
                            : () async {
                                page += 1;
                                await _loadComments();
                              },
                        [.text('Next')],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _commentCard(VideoCommentDto comment) {
    return article(
      classes: 'sc-comment-card',
      [
        div(
          classes: 'sc-comment-head',
          [
            div([
              strong([.text(comment.userName)]),
              span(classes: 'sc-time', [
                .text(_formatDate(comment.createdAt)),
              ]),
            ]),
            button(
              classes: 'sv-danger-button compact',
              onClick: busyCommentId == comment.id ? null : () => _deleteComment(comment),
              [
                .text(
                  busyCommentId == comment.id ? 'Deleting...' : 'Delete',
                ),
              ],
            ),
          ],
        ),
        p(classes: 'sc-comment-content', [.text(comment.content)]),
        div(classes: 'sc-comment-meta', [
          .text('${comment.likeCount} likes · ${comment.replies.length} replies'),
        ]),
        if (comment.replies.isNotEmpty)
          div(
            classes: 'sc-replies',
            [
              for (final reply in comment.replies)
                div(
                  classes: 'sc-reply',
                  [
                    div(
                      classes: 'sc-reply-main',
                      [
                        strong([.text(reply.userName)]),
                        span(classes: 'sc-time', [
                          .text(_formatDate(reply.createdAt)),
                        ]),
                        p([.text(reply.content)]),
                      ],
                    ),
                    button(
                      classes: 'sv-link-danger',
                      onClick: busyReplyId == reply.id ? null : () => _deleteReply(comment, reply),
                      [
                        .text(
                          busyReplyId == reply.id ? 'Deleting...' : 'Delete reply',
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }

  String _formatDate(DateTime value) {
    final local = value.toLocal();
    String two(int value) => value.toString().padLeft(2, '0');

    return '${local.year}-${two(local.month)}-${two(local.day)} '
        '${two(local.hour)}:${two(local.minute)}';
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    for (final value in this) {
      return value;
    }
    return null;
  }
}
