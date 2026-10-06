import 'dart:async';

import 'package:glyphora_backend_client/backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/web_client.dart';

class PublicProfilePage extends StatefulComponent {
  const PublicProfilePage({required this.userId, super.key});

  final String userId;

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  bool _loading = true;
  String? _error;
  String _displayName = '';
  String? _avatarUrl;

  List<_ProfileVideo> _videos = const [];
  List<_ProfileSeries> _series = const [];
  List<_ProfileVideo> _independentVideos = const [];

  final Set<int> _expandedSeriesIds = <int>{};

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final profile = await webClient.social.getExistingUserProfile(
        component.userId,
      );
      final videos = await webClient.video.getVideos();

      final creatorVideos = videos
          .where(
            (video) =>
                video.authorId == component.userId && video.isPublic == true,
          )
          .toList(growable: false);

      final fallbackName = creatorVideos.isNotEmpty
          ? creatorVideos.first.authorName
          : component.userId;

      final profileVideos = <_ProfileVideo>[];

      for (final video in creatorVideos) {
        String? coverUrl;
        final coverKey = video.coverStorageKey;

        if (coverKey != null && coverKey.trim().isNotEmpty) {
          try {
            coverUrl = await webClient.video.getVideoUrl(path: coverKey);
          } catch (_) {
            coverUrl = null;
          }
        }

        profileVideos.add(_ProfileVideo(video: video, coverUrl: coverUrl));
      }

      final grouped = <int, List<_ProfileVideo>>{};
      final independent = <_ProfileVideo>[];

      for (final item in profileVideos) {
        final seriesId = item.video.seriesId;
        if (seriesId == null) {
          independent.add(item);
          continue;
        }

        grouped.putIfAbsent(seriesId, () => <_ProfileVideo>[]).add(item);
      }

      final series = <_ProfileSeries>[];

      for (final entry in grouped.entries) {
        final episodes = entry.value
          ..sort((a, b) {
            final aPosition = a.video.seriesPosition ?? 1 << 30;
            final bPosition = b.video.seriesPosition ?? 1 << 30;
            final byPosition = aPosition.compareTo(bPosition);
            if (byPosition != 0) return byPosition;

            return (a.video.id ?? 0).compareTo(b.video.id ?? 0);
          });

        final title = episodes
            .map((item) => item.video.seriesTitle?.trim() ?? '')
            .firstWhere(
              (value) => value.isNotEmpty,
              orElse: () => 'Series ${entry.key}',
            );

        series.add(
          _ProfileSeries(
            id: entry.key,
            title: title,
            episodes: List<_ProfileVideo>.unmodifiable(episodes),
          ),
        );
      }

      series.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );

      if (!mounted) return;

      setState(() {
        _displayName = profile?['displayName'] ?? fallbackName;

        final rawAvatar = profile?['avatarUrl']?.trim();
        _avatarUrl = rawAvatar == null || rawAvatar.isEmpty ? null : rawAvatar;

        _videos = List<_ProfileVideo>.unmodifiable(profileVideos);
        _series = List<_ProfileSeries>.unmodifiable(series);
        _independentVideos = List<_ProfileVideo>.unmodifiable(independent);
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(classes: 'public-profile-page', [
        div(classes: 'page-message', [.text('Loading...')]),
      ]);
    }

    if (_error != null) {
      return div(classes: 'public-profile-page', [
        div(classes: 'page-message error', [.text(_error!)]),
      ]);
    }

    final avatarUrl = _avatarUrl;
    final hasSeries = _series.isNotEmpty;
    final hasIndependentVideos = _independentVideos.isNotEmpty;

    return div(classes: 'public-profile-page public-profile-page-v2', [
      section(classes: 'public-profile-hero public-profile-hero-v2', [
        div(classes: 'public-profile-identity', [
          if (avatarUrl != null)
            div(
              classes: 'public-profile-avatar has-image',
              attributes: {
                'style': "background-image:url('${_escapeCssUrl(avatarUrl)}')",
              },
              [],
            )
          else
            div(classes: 'public-profile-avatar', [
              .text(_initial(_displayName)),
            ]),
          div(classes: 'public-profile-copy', [
            p(classes: 'public-profile-eyebrow', [.text('CREATOR')]),
            h1([.text(_displayName)]),
            div(classes: 'public-profile-stats', [
              _stat('${_videos.length}', 'videos'),
              _stat('${_series.length}', 'series'),
            ]),
          ]),
        ]),
      ]),
      if (_videos.isEmpty)
        section(classes: 'public-profile-empty', [
          div(classes: 'page-message', [.text('No public videos yet.')]),
        ])
      else ...[
        if (hasSeries)
          section(classes: 'public-profile-section public-profile-series', [
            _sectionHeading(
              'Series',
              '${_series.length} ${_series.length == 1 ? 'series' : 'series'}',
            ),
            div(classes: 'public-profile-series-list', [
              for (final series in _series) _seriesCard(series),
            ]),
          ]),
        if (hasIndependentVideos)
          section(classes: 'public-profile-section public-profile-videos', [
            _sectionHeading(
              hasSeries ? 'Independent videos' : 'Videos',
              '${_independentVideos.length} '
              '${_independentVideos.length == 1 ? 'video' : 'videos'}',
            ),
            _videoGrid(_independentVideos),
          ]),
      ],
    ]);
  }

  Component _stat(String value, String label) {
    return div(classes: 'public-profile-stat', [
      strong([.text(value)]),
      span([.text(label)]),
    ]);
  }

  Component _sectionHeading(String title, String meta) {
    return div(classes: 'public-profile-section-heading', [
      h2([.text(title)]),
      span([.text(meta)]),
    ]);
  }

  Component _seriesCard(_ProfileSeries series) {
    final expanded = _expandedSeriesIds.contains(series.id);
    final coverUrl = series.coverUrl;

    return article(
      classes: 'public-profile-series-card${expanded ? ' is-expanded' : ''}',
      [
        button(
          type: ButtonType.button,
          classes: 'public-profile-series-toggle',
          onClick: () => _toggleSeries(series.id),
          [
            div(
              classes: 'public-profile-series-cover',
              attributes: coverUrl == null
                  ? null
                  : {
                      'style':
                          "background-image:url('${_escapeCssUrl(coverUrl)}')",
                    },
              [
                if (coverUrl == null)
                  span(classes: 'public-profile-series-cover-placeholder', [
                    .text(_initial(series.title)),
                  ]),
                span(classes: 'public-profile-series-badge', [
                  .text('${series.episodes.length} episodes'),
                ]),
              ],
            ),
            div(classes: 'public-profile-series-copy', [
              p(classes: 'public-profile-series-kicker', [.text('SERIES')]),
              h3([.text(series.title)]),
              p([.text(_seriesPreview(series))]),
            ]),
            span(
              classes:
                  'public-profile-series-chevron'
                  '${expanded ? ' is-expanded' : ''}',
              [.text('›')],
            ),
          ],
        ),
        if (expanded)
          div(classes: 'public-profile-series-episodes', [
            _videoGrid(series.episodes),
          ]),
      ],
    );
  }

  Component _videoGrid(List<_ProfileVideo> videos) {
    return div(classes: 'public-profile-video-grid', [
      for (final item in videos)
        if (item.video.id != null) _videoCard(item),
    ]);
  }

  Component _videoCard(_ProfileVideo item) {
    final video = item.video;
    final coverUrl = item.coverUrl;

    return a(
      href: '/watch/${video.id}',
      classes: 'public-profile-video-card-v2',
      [
        div(
          classes: 'public-profile-video-cover',
          attributes: coverUrl == null
              ? null
              : {'style': "background-image:url('${_escapeCssUrl(coverUrl)}')"},
          [
            if (coverUrl == null)
              span(classes: 'public-profile-video-cover-placeholder', [
                .text(_initial(video.title)),
              ]),
            span(classes: 'public-profile-video-duration', [
              .text(_formatDuration(video.durationSeconds)),
            ]),
          ],
        ),
        div(classes: 'public-profile-video-body', [
          h3([.text(video.title)]),
          p([
            .text(
              '${video.viewCount} ${video.viewCount == 1 ? 'view' : 'views'}',
            ),
          ]),
        ]),
      ],
    );
  }

  void _toggleSeries(int seriesId) {
    setState(() {
      if (_expandedSeriesIds.contains(seriesId)) {
        _expandedSeriesIds.remove(seriesId);
      } else {
        _expandedSeriesIds.add(seriesId);
      }
    });
  }

  String _seriesPreview(_ProfileSeries series) {
    final titles = series.episodes
        .take(2)
        .map((item) => item.video.title.trim())
        .where((title) => title.isNotEmpty)
        .toList(growable: false);

    if (titles.isEmpty) return '${series.episodes.length} episodes';

    final suffix = series.episodes.length > 2 ? ' · …' : '';
    return '${titles.join(' · ')}$suffix';
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
    return trimmed.isEmpty ? 'C' : trimmed.substring(0, 1).toUpperCase();
  }

  String _escapeCssUrl(String value) {
    return value
        .replaceAll('\\', '%5C')
        .replaceAll("'", '%27')
        .replaceAll('"', '%22');
  }
}

class _ProfileVideo {
  const _ProfileVideo({required this.video, required this.coverUrl});

  final api.Video video;
  final String? coverUrl;
}

class _ProfileSeries {
  const _ProfileSeries({
    required this.id,
    required this.title,
    required this.episodes,
  });

  final int id;
  final String title;
  final List<_ProfileVideo> episodes;

  String? get coverUrl {
    for (final episode in episodes) {
      final value = episode.coverUrl?.trim();
      if (value != null && value.isNotEmpty) return value;
    }

    return null;
  }
}
