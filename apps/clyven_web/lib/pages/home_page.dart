import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/web_client.dart';

import '../components/language_category_home_section.dart';

class HomePage extends StatefulComponent {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return div(classes: 'home-page', [
      LanguageCategoryHomeSection(),
      section(classes: 'hero', [
        div(classes: 'hero-copy', [
          span(classes: 'hero-eyebrow', [.text('CLYVEN WEB')]),
          h1([.text('One video. More than one way to read it.')]),
          p([
            .text(
              'Watch ordinary videos while Clyven keeps language, '
              'subtitle and script choices close to the content.',
            ),
          ]),
        ]),
        div(classes: 'hero-badge-stack', [
          span([.text('Video')]),
          span([.text('Subtitles')]),
          span([.text('Scripts')]),
        ]),
      ]),
      div(classes: 'section-heading', [
        div([
          h2([.text('Latest videos')]),
          p([.text('Public videos from Clyven creators.')]),
        ]),
        button(classes: 'secondary-button', onClick: loading ? null : _load, [
          .text(loading ? 'Loading...' : 'Refresh'),
        ]),
      ]),
      if (error != null) div(classes: 'page-message error', [.text(error!)]),
      if (loading)
        div(classes: 'video-grid', [
          for (var i = 0; i < 6; i++) _skeletonCard(),
        ])
      else if (items.isEmpty)
        div(classes: 'empty-state', [
          h3([.text('No public videos yet')]),
          p([.text('Published videos will appear here.')]),
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
              '${video.viewCount} views · '
              '${video.languageCode ?? 'unknown'}',
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
