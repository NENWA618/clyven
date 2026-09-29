import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/web_client.dart';

class RecommendedVideos extends StatefulComponent {
  const RecommendedVideos({required this.currentVideoId, super.key});

  final int currentVideoId;

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _Recommendation {
  const _Recommendation({required this.video, required this.coverUrl});

  final api.Video video;
  final String? coverUrl;
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  bool _loading = true;
  String? _error;
  List<_Recommendation> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  int _score(api.Video video, api.Video? current) {
    if (current == null) {
      return video.viewCount;
    }

    var score = 0;

    final currentLanguage = current.languageCode?.trim().toLowerCase();
    final videoLanguage = video.languageCode?.trim().toLowerCase();

    if (currentLanguage != null &&
        currentLanguage.isNotEmpty &&
        currentLanguage == videoLanguage) {
      score += 100000;
    }

    if (current.category.trim().isNotEmpty &&
        current.category == video.category) {
      score += 50000;
    }

    final currentTags = current.tags
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .toSet();

    final videoTags = video.tags
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .toSet();

    score += currentTags.intersection(videoTags).length * 10000;
    score += video.viewCount.clamp(0, 9999);

    return score;
  }

  Future<void> _load() async {
    try {
      final videos = await webClient.video.getVideos();

      api.Video? current;

      for (final video in videos) {
        if (video.id == component.currentVideoId) {
          current = video;
          break;
        }
      }

      final candidates = videos
          .where(
            (video) => video.id != null && video.id != component.currentVideoId,
          )
          .toList();

      candidates.sort((a, b) {
        final scoreCompare = _score(b, current).compareTo(_score(a, current));

        if (scoreCompare != 0) {
          return scoreCompare;
        }

        final viewsCompare = b.viewCount.compareTo(a.viewCount);

        if (viewsCompare != 0) {
          return viewsCompare;
        }

        return b.createdAt.compareTo(a.createdAt);
      });

      final selected = candidates.take(8).toList();
      final items = <_Recommendation>[];

      for (final video in selected) {
        String? coverUrl;

        final coverKey = video.coverStorageKey?.trim();

        if (coverKey != null && coverKey.isNotEmpty) {
          try {
            coverUrl = await webClient.video.getVideoUrl(path: coverKey);
          } catch (_) {
            coverUrl = null;
          }
        }

        items.add(_Recommendation(video: video, coverUrl: coverUrl));
      }

      if (!mounted) return;

      setState(() {
        _items = items;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  String _duration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _views(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M views';
    }

    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K views';
    }

    return '$count views';
  }

  Component _thumbnail(_Recommendation item) {
    final video = item.video;
    final coverUrl = item.coverUrl;

    return div(
      classes:
          'recommended-video-thumb'
          '${coverUrl == null ? ' no-cover' : ''}',
      attributes: {
        if (coverUrl != null)
          'style':
              "background-image:url('${coverUrl.replaceAll("'", "%27")}');",
      },
      [
        if (coverUrl == null)
          span(classes: 'recommended-video-placeholder', [.text('CLYVEN')]),
        span(classes: 'recommended-video-duration', [
          .text(_duration(video.durationSeconds)),
        ]),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return section(classes: 'recommended-section', [
        div(classes: 'recommended-header', [
          h2([.text('推荐视频')]),
        ]),
        div(classes: 'recommended-loading', [.text('正在加载推荐视频…')]),
      ]);
    }

    if (_error != null) {
      return section(classes: 'recommended-section', [
        div(classes: 'recommended-header', [
          h2([.text('推荐视频')]),
        ]),
      ]);
    }

    if (_items.isEmpty) {
      return section(classes: 'recommended-section', [
        div(classes: 'recommended-header', [
          h2([.text('推荐视频')]),
        ]),
        div(classes: 'recommended-empty', [.text('暂时没有其他公开视频')]),
      ]);
    }

    return section(classes: 'recommended-section', [
      div(classes: 'recommended-header', [
        h2([.text('推荐视频')]),
      ]),
      div(classes: 'recommended-grid', [
        for (final item in _items)
          a(
            href: '/watch/${item.video.id}',
            classes: 'recommended-video-card',
            [
              _thumbnail(item),
              div(classes: 'recommended-video-info', [
                h3(classes: 'recommended-video-title', [
                  .text(item.video.title),
                ]),
                div(classes: 'recommended-video-author', [
                  .text(item.video.authorName),
                ]),
                div(classes: 'recommended-video-meta', [
                  span([.text(_views(item.video.viewCount))]),
                  if (item.video.languageCode != null &&
                      item.video.languageCode!.trim().isNotEmpty)
                    span([.text(item.video.languageCode!.toUpperCase())]),
                ]),
              ]),
            ],
          ),
      ]),
    ]);
  }
}
