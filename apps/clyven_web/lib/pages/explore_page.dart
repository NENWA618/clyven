import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/web_client.dart';


class ExplorePage extends StatefulComponent {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool loading = true;
  String? error;
  List<_FeedVideo> items = const [];

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
      final videos = await webClient.video.getVideos();
      final result = <_FeedVideo>[];

      for (final video in videos) {
        String? coverUrl;

        final coverKey = video.coverStorageKey;
        if (coverKey != null && coverKey.isNotEmpty) {
          try {
            coverUrl = await webClient.video.getVideoUrl(path: coverKey);
          } catch (_) {
            coverUrl = null;
          }
        }

        result.add(_FeedVideo(video: video, coverUrl: coverUrl));
      }

      setState(() {
        items = result;
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
    final l10n = context.l10n;

    return div(classes: 'explore-page', [
      div(classes: 'section-heading', [
        div([
          h2([.text(l10n.latestVideos)]),
          p([.text(l10n.latestVideosSubtitle)]),
        ]),
        button(classes: 'secondary-button', onClick: loading ? null : _load, [
          .text(loading ? l10n.loading : l10n.refresh),
        ]),
      ]),
      if (error != null) div(classes: 'page-message error', [.text(error!)]),
      if (loading)
        div(classes: 'video-grid', [
          for (var i = 0; i < 6; i++) _skeletonCard(),
        ])
      else if (items.isEmpty)
        div(classes: 'empty-state', [
          h3([.text(l10n.noPublicVideos)]),
          p([.text(l10n.noPublicVideosHint)]),
        ])
      else
        div(classes: 'video-grid', [
          for (final item in items) _videoCard(item),
        ]),
    ]);
  }

  Component _videoCard(_FeedVideo item) {
    final video = item.video;
    final id = video.id;

    final card = article(classes: 'video-card', [
      div(
        classes: 'video-card-cover',
        attributes: item.coverUrl == null
            ? null
            : {
                'style':
                    "background-image:url('${_escapeCssUrl(item.coverUrl!)}')",
              },
        [
          if (item.coverUrl == null)
            div(classes: 'video-card-cover-placeholder', [.text('C')]),
          span(classes: 'video-duration', [
            .text(_formatDuration(video.durationSeconds)),
          ]),
        ],
      ),
      div(classes: 'video-card-body', [
        div(classes: 'video-author-avatar', [
          .text(_initial(video.authorName)),
        ]),
        div(classes: 'video-card-copy', [
          h3([.text(video.title)]),
          p(classes: 'video-author', [.text(video.authorName)]),
          p(classes: 'video-stats', [
            .text(
              context.l10n.viewsAndLanguage(
                video.viewCount,
                video.languageCode,
              ),
            ),
          ]),
        ]),
      ]),
    ]);

    if (id == null) {
      return card;
    }

    return Link(to: '/watch/$id', child: card);
  }

  Component _skeletonCard() {
    return div(classes: 'video-card skeleton', [
      div(classes: 'video-card-cover', []),
      div(classes: 'video-card-body', [
        div(classes: 'video-author-avatar', []),
        div(classes: 'video-card-copy', [
          div(classes: 'skeleton-line wide', []),
          div(classes: 'skeleton-line', []),
        ]),
      ]),
    ]);
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  String _initial(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'C';
    }
    return trimmed.substring(0, 1).toUpperCase();
  }

  String _escapeCssUrl(String value) {
    return value.replaceAll("'", r"\'");
  }
}

class _FeedVideo {
  const _FeedVideo({required this.video, required this.coverUrl});

  final Video video;
  final String? coverUrl;
}
