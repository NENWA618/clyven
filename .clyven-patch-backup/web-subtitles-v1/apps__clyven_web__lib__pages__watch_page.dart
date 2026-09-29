import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/web_client.dart';

class WatchPage extends StatefulComponent {
  const WatchPage({required this.videoId, super.key});

  final int videoId;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  bool loading = true;
  String? error;

  Video? video;
  String? videoUrl;
  String? coverUrl;
  List<SubtitleTrack> subtitleTracks = const [];
  CommentPageDto? comments;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final loadedVideo = await webClient.video.getVideo(component.videoId);
      if (loadedVideo == null) {
        throw Exception('Video not found or not public.');
      }

      final loadedVideoUrl = await webClient.video.getVideoUrl(
        path: loadedVideo.videoStorageKey,
      );

      if (loadedVideoUrl == null || loadedVideoUrl.isEmpty) {
        throw Exception('Video file is unavailable.');
      }

      String? loadedCoverUrl;
      final coverKey = loadedVideo.coverStorageKey;
      if (coverKey != null && coverKey.isNotEmpty) {
        try {
          loadedCoverUrl = await webClient.video.getVideoUrl(path: coverKey);
        } catch (_) {
          loadedCoverUrl = null;
        }
      }

      List<SubtitleTrack> tracks = const [];
      try {
        tracks = await webClient.subtitle.getPublishedAvailableTracks(
          videoId: component.videoId,
        );
      } catch (_) {
        tracks = const [];
      }

      CommentPageDto? loadedComments;
      try {
        loadedComments = await webClient.comment.loadComments(
          videoId: component.videoId,
          page: 1,
          limit: 20,
        );
      } catch (_) {
        loadedComments = null;
      }

      setState(() {
        video = loadedVideo;
        videoUrl = loadedVideoUrl;
        coverUrl = loadedCoverUrl;
        subtitleTracks = tracks;
        comments = loadedComments;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    if (loading) {
      return div(classes: 'watch-loading', [
        div(classes: 'watch-player skeleton-block', []),
        div(classes: 'skeleton-line wide', []),
        div(classes: 'skeleton-line', []),
      ]);
    }

    if (error != null || video == null || videoUrl == null) {
      return div(classes: 'watch-error', [
        h2([.text('Unable to open this video')]),
        p([.text(error ?? 'Unknown error')]),
        Link(
          to: '/',
          child: span(classes: 'primary-link-button', [.text('Back home')]),
        ),
      ]);
    }

    final currentVideo = video!;

    return div(classes: 'watch-page', [
      div(classes: 'watch-layout', [
        div(classes: 'watch-main', [
          div(classes: 'watch-player-shell', [
            dom.video(
              [],
              classes: 'watch-player',
              src: videoUrl!,
              controls: true,
              preload: dom.Preload.metadata,
              attributes: coverUrl == null ? null : {'poster': coverUrl!},
            ),
          ]),
          div(classes: 'watch-title-block', [
            h1([.text(currentVideo.title)]),
            div(classes: 'watch-stats-row', [
              span([.text('${currentVideo.viewCount} views')]),
              span([
                .text(
                  currentVideo.publishedAt == null
                      ? 'Published'
                      : _formatDate(currentVideo.publishedAt!),
                ),
              ]),
            ]),
          ]),
          div(classes: 'watch-author-row', [
            div(classes: 'watch-author-avatar', [
              .text(_initial(currentVideo.authorName)),
            ]),
            div(classes: 'watch-author-copy', [
              strong([.text(currentVideo.authorName)]),
              span([
                .text(
                  currentVideo.languageCode == null
                      ? 'Language not specified'
                      : 'Language: ${currentVideo.languageCode}',
                ),
              ]),
            ]),
            div(classes: 'watch-author-spacer', []),
            button(classes: 'secondary-button', [.text('Follow later')]),
          ]),
          if (currentVideo.description.isNotEmpty)
            div(classes: 'watch-description', [
              .text(currentVideo.description),
            ]),
          _subtitleSummary(),
          _commentsSection(),
        ]),
        aside(classes: 'watch-side', [
          div(classes: 'watch-side-card', [
            strong([.text('Clyven Web v1')]),
            p([
              .text(
                'The browser client is now connected to the same '
                'public video, subtitle and comment data as Clyven.',
              ),
            ]),
          ]),
          div(classes: 'watch-side-card', [
            strong([.text('Next')]),
            p([
              .text(
                'Subtitle switching, multi-script rendering and '
                'word-level interaction will be built on this player.',
              ),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  Component _subtitleSummary() {
    return section(classes: 'watch-section', [
      div(classes: 'watch-section-heading', [
        h2([.text('Subtitles')]),
        span([.text('${subtitleTracks.length} published track(s)')]),
      ]),
      if (subtitleTracks.isEmpty)
        p(classes: 'watch-muted', [
          .text('No published subtitle track is available yet.'),
        ])
      else
        div(classes: 'subtitle-chip-row', [
          for (final track in subtitleTracks)
            span(classes: 'subtitle-chip${track.isDefault ? ' active' : ''}', [
              .text(
                track.defaultScriptCode == null
                    ? '${track.label} · ${track.languageCode}'
                    : '${track.label} · ${track.languageCode} · '
                          '${track.defaultScriptCode}',
              ),
            ]),
        ]),
    ]);
  }

  Component _commentsSection() {
    final data = comments;

    return section(classes: 'watch-section', [
      div(classes: 'watch-section-heading', [
        h2([.text('Comments')]),
        if (video != null) span([.text('${video!.commentCount} total')]),
      ]),
      if (data == null)
        p(classes: 'watch-muted', [.text('Comments are unavailable.')])
      else if (data.comments.isEmpty)
        p(classes: 'watch-muted', [.text('No comments yet.')])
      else
        div(classes: 'public-comment-list', [
          for (final comment in data.comments)
            article(classes: 'public-comment', [
              div(classes: 'public-comment-avatar', [
                .text(_initial(comment.userName)),
              ]),
              div(classes: 'public-comment-copy', [
                div(classes: 'public-comment-head', [
                  strong([.text(comment.userName)]),
                  span([.text(_formatDate(comment.createdAt))]),
                ]),
                p([.text(comment.content)]),
                span(classes: 'public-comment-meta', [
                  .text(
                    '${comment.likeCount} likes · '
                    '${comment.replies.length} replies',
                  ),
                ]),
                if (comment.replies.isNotEmpty)
                  div(classes: 'public-replies', [
                    for (final reply in comment.replies)
                      div(classes: 'public-reply', [
                        strong([.text(reply.userName)]),
                        span([.text(reply.content)]),
                      ]),
                  ]),
              ]),
            ]),
        ]),
    ]);
  }

  String _formatDate(DateTime value) {
    final local = value.toLocal();
    String two(int value) => value.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)}';
  }

  String _initial(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'C';
    }
    return trimmed.substring(0, 1).toUpperCase();
  }
}
