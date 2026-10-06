import 'dart:html' as html;
import 'package:glyphora_backend_client/backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/web_client.dart';

enum _SearchTab { videos, subtitles, users }

class SearchPage extends StatefulComponent {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool loading = false;
  String? error;
  String query = '';

  List<_SearchVideo> videoResults = const [];
  List<_SubtitleMatch> subtitleResults = const [];
  List<_SearchUser> userResults = const [];

  _SearchTab _selectedTab = _SearchTab.videos;

  _SubtitleMatch? _activeClip;
  String _activeClipUrl = '';
  bool _clipLoading = false;
  String? _clipError;

  final Set<int> _expandedSubtitleVideoIds = <int>{};

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) _syncFromRoute();
    });
  }

  void _syncFromRoute() {
    final location = RouteState.of(context).location;
    final nextQuery =
        Uri.tryParse(location)?.queryParameters['q']?.trim() ?? '';

    if (nextQuery == query &&
        (loading ||
            videoResults.isNotEmpty ||
            subtitleResults.isNotEmpty ||
            userResults.isNotEmpty)) {
      return;
    }

    if (nextQuery.isEmpty) {
      setState(() {
        query = '';
        videoResults = const [];
        subtitleResults = const [];
        userResults = const [];
        userResults = const [];
        userResults = const [];
        error = null;
        loading = false;
      });
      return;
    }

    _search(nextQuery);
  }

  Future<void> _search(String rawQuery) async {
    final nextQuery = rawQuery.trim();
    final keyword = nextQuery.toLowerCase();

    if (keyword.isEmpty) return;

    setState(() {
      query = nextQuery;
      videoResults = const [];
      subtitleResults = const [];
      userResults = const [];
      error = null;
      loading = true;
    });

    try {
      final videos = await webClient.video.getVideos();

      final matchedVideos = <_SearchVideo>[];
      final matchedSubtitles = <_SubtitleMatch>[];
      for (final video in videos) {
        final videoId = video.id;
        if (videoId == null) continue;

        String? subtitleCoverUrl;
        final subtitleCoverKey = video.coverStorageKey;

        if (subtitleCoverKey != null && subtitleCoverKey.isNotEmpty) {
          try {
            subtitleCoverUrl = await webClient.video.getVideoUrl(
              path: subtitleCoverKey,
            );
          } catch (_) {
            subtitleCoverUrl = null;
          }
        }
        final videoMatches = _videoMatches(video, keyword);

        if (videoMatches) {
          String? coverUrl;

          final coverKey = video.coverStorageKey;
          if (coverKey != null && coverKey.isNotEmpty) {
            try {
              coverUrl = await webClient.video.getVideoUrl(path: coverKey);
            } catch (_) {
              coverUrl = null;
            }
          }

          matchedVideos.add(_SearchVideo(video: video, coverUrl: coverUrl));
        }

        // Subtitle Search v1 deliberately uses the existing published subtitle
        // APIs. A dedicated server-side search endpoint can replace this later.
        try {
          final tracks = await webClient.subtitle.getPublishedAvailableTracks(
            videoId: videoId,
          );

          for (final track in tracks) {
            final details = await webClient.subtitle.getPublishedCueDetails(
              videoId: videoId,
              languageCode: track.languageCode,
              scriptCode: null,
            );

            for (final detail in details) {
              final candidates = <_SubtitleCandidate>[];

              final legacyText = detail.cue.text.trim();
              if (legacyText.isNotEmpty) {
                candidates.add(
                  _SubtitleCandidate(
                    text: legacyText,
                    scriptCode: track.defaultScriptCode,
                  ),
                );
              }

              final texts = detail.texts ?? const <api.SubtitleCueText>[];

              for (final text in texts) {
                final value = text.text.trim();
                if (value.isEmpty) continue;

                candidates.add(
                  _SubtitleCandidate(text: value, scriptCode: text.scriptCode),
                );
              }

              final seenTexts = <String>{};

              for (final candidate in candidates) {
                final normalized = candidate.text.toLowerCase();

                if (!normalized.contains(keyword)) continue;

                final dedupeKey =
                    '${detail.cue.startMs}|'
                    '${detail.cue.endMs}|'
                    '${track.languageCode}|'
                    '${candidate.scriptCode ?? ''}|'
                    '$normalized';

                if (!seenTexts.add(dedupeKey)) continue;

                matchedSubtitles.add(
                  _SubtitleMatch(
                    video: video,
                    coverUrl: subtitleCoverUrl,
                    track: track,
                    text: candidate.text,
                    scriptCode: candidate.scriptCode,
                    startMs: detail.cue.startMs,
                    endMs: detail.cue.endMs,
                    isOriginal: _isOriginalTrack(video, track),
                  ),
                );
              }
            }
          }
        } catch (_) {
          // A subtitle failure on one video must not destroy all search results.
        }
      }

      matchedSubtitles.sort((a, b) {
        final byVideo = a.video.title.toLowerCase().compareTo(
          b.video.title.toLowerCase(),
        );

        if (byVideo != 0) return byVideo;
        return a.startMs.compareTo(b.startMs);
      });
      final matchedUsers = await _loadUserResults(videos, keyword);

      if (!mounted) return;

      setState(() {
        videoResults = matchedVideos;
        subtitleResults = matchedSubtitles;
        userResults = matchedUsers;
        if (matchedVideos.isNotEmpty) {
          _selectedTab = _SearchTab.videos;
        } else if (matchedSubtitles.isNotEmpty) {
          _selectedTab = _SearchTab.subtitles;
        } else if (matchedUsers.isNotEmpty) {
          _selectedTab = _SearchTab.users;
        }
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<List<_SearchUser>> _loadUserResults(
    List<api.Video> videos,
    String keyword,
  ) async {
    final counts = <String, int>{};

    for (final video in videos) {
      counts.update(video.authorId, (value) => value + 1, ifAbsent: () => 1);
    }

    try {
      final profiles = await webClient.social.searchExistingUserProfiles(
        keyword,
        limit: 30,
      );

      final profileUsers = profiles
          .map((profile) {
            final userId = profile['userId'] ?? '';
            final displayName = profile['displayName'] ?? userId;
            final avatarUrl = profile['avatarUrl'];

            return _SearchUser(
              userId: userId,
              displayName: displayName,
              avatarUrl: avatarUrl == null || avatarUrl.trim().isEmpty
                  ? null
                  : avatarUrl.trim(),
              videoCount: counts[userId] ?? 0,
            );
          })
          .where((user) => user.userId.isNotEmpty)
          .toList(growable: false);

      // The existing Auth profile search can legitimately return an empty list
      // even when published videos still identify a matching author. In that
      // case, keep user search useful by falling back to published authors.
      if (profileUsers.isNotEmpty) {
        return profileUsers;
      }

      return _fallbackUserResults(videos, keyword);
    } catch (_) {
      return _fallbackUserResults(videos, keyword);
    }
  }

  List<_SearchUser> _fallbackUserResults(
    List<api.Video> videos,
    String keyword,
  ) {
    final normalized = keyword.trim().toLowerCase();
    final grouped = <String, _SearchUser>{};

    for (final video in videos) {
      final name = video.authorName.trim().isEmpty
          ? video.authorId
          : video.authorName.trim();

      if (!name.toLowerCase().contains(normalized)) continue;

      final current = grouped[video.authorId];

      grouped[video.authorId] = _SearchUser(
        userId: video.authorId,
        displayName: name,
        avatarUrl: null,
        videoCount: (current?.videoCount ?? 0) + 1,
      );
    }

    return grouped.values.toList(growable: false);
  }

  bool _videoMatches(api.Video video, String keyword) {
    final normalizedKeyword = keyword.trim().toLowerCase();

    if (normalizedKeyword.isEmpty) return false;

    final searchableValues = <String>[
      video.title,
      video.authorName,
      video.category,
      context.l10n.topic(video.category),
      video.description,
      if (video.languageCode != null) video.languageCode!,
      ...video.tags,
    ];

    return searchableValues.any(
      (value) => value.trim().toLowerCase().contains(normalizedKeyword),
    );
  }

  bool _isOriginalTrack(api.Video video, api.SubtitleTrack track) {
    final videoLanguage = video.languageCode?.trim().toLowerCase();
    final trackLanguage = track.languageCode.trim().toLowerCase();

    if (videoLanguage != null && videoLanguage.isNotEmpty) {
      return videoLanguage == trackLanguage;
    }

    // Fallback for old videos that have no source-language metadata yet.
    return track.isDefault;
  }

  html.VideoElement? get _clipVideo =>
      html.document.getElementById('glyphora-search-clip-player')
          as html.VideoElement?;

  Future<void> _openClip(_SubtitleMatch item) async {
    setState(() {
      _activeClip = item;
      _activeClipUrl = '';
      _clipLoading = true;
      _clipError = null;
    });

    try {
      final url = await webClient.video.getVideoUrl(
        path: item.video.videoStorageKey,
      );

      if (!mounted) return;

      if (url == null || url.trim().isEmpty) {
        throw StateError('Video URL is unavailable');
      }

      setState(() {
        _activeClipUrl = url.trim();
        _clipLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _clipError = '$e';
        _clipLoading = false;
      });
    }
  }

  void _closeClip() {
    _clipVideo?.pause();

    setState(() {
      _activeClip = null;
      _activeClipUrl = '';
      _clipLoading = false;
      _clipError = null;
    });
  }

  void _startClip() {
    final clip = _activeClip;
    final video = _clipVideo;

    if (clip == null || video == null) return;

    video.currentTime = clip.startMs / 1000;
    video.play();
  }

  void _enforceClipBounds() {
    final clip = _activeClip;
    final video = _clipVideo;

    if (clip == null || video == null) return;

    final startSeconds = clip.startMs / 1000;
    final endSeconds = clip.endMs / 1000;
    final current = video.currentTime.toDouble();

    if (current < startSeconds - 0.15) {
      video.currentTime = startSeconds;
      return;
    }

    if (current >= endSeconds) {
      // Search clips loop only inside the subtitle time range.
      video.currentTime = startSeconds;
      video.play();
    }
  }

  void _toggleClipPlayback() {
    final clip = _activeClip;
    final video = _clipVideo;

    if (clip == null || video == null) return;

    final startSeconds = clip.startMs / 1000;
    final endSeconds = clip.endMs / 1000;
    final current = video.currentTime.toDouble();

    if (current < startSeconds || current >= endSeconds) {
      video.currentTime = startSeconds;
    }

    if (video.paused) {
      video.play();
    } else {
      video.pause();
    }
  }

  Component _clipModal() {
    final clip = _activeClip;
    if (clip == null) return const Component.fragment([]);

    return div(
      classes: 'search-clip-modal',
      events: {'click': (_) => _closeClip()},
      [
        div(
          classes: 'search-clip-card',
          events: {
            'click': (event) {
              event.stopPropagation();
            },
          },
          [
            div(classes: 'search-clip-head', [
              div([
                span(
                  classes:
                      'subtitle-search-kind '
                      '${clip.isOriginal ? 'is-original' : 'is-translation'}',
                  [
                    .text(
                      clip.isOriginal
                          ? context.l10n.originalSubtitle
                          : context.l10n.translatedSubtitle,
                    ),
                  ],
                ),
                h3([.text(clip.video.title)]),
              ]),
              button(
                type: ButtonType.button,
                classes: 'search-clip-close',
                onClick: _closeClip,
                [.text('×')],
              ),
            ]),
            if (_clipLoading)
              div(classes: 'search-clip-state', [.text(context.l10n.loading)])
            else if (_clipError != null)
              div(classes: 'search-clip-state error', [.text(_clipError!)])
            else if (_activeClipUrl.isNotEmpty) ...[
              div(classes: 'search-clip-video-wrap', [
                dom.video(
                  [],
                  id: 'glyphora-search-clip-player',
                  classes: 'search-clip-video',
                  src: _activeClipUrl,
                  controls: false,
                  preload: dom.Preload.metadata,
                  attributes: const {'playsinline': ''},
                  events: {
                    'loadedmetadata': (_) => _startClip(),
                    'timeupdate': (_) => _enforceClipBounds(),
                    'ended': (_) => _startClip(),
                    'click': (_) => _toggleClipPlayback(),
                  },
                ),
                button(
                  type: ButtonType.button,
                  classes: 'search-clip-replay',
                  onClick: _startClip,
                  [.text('↻')],
                ),
              ]),
              div(classes: 'search-clip-caption', [
                p([.text(clip.text)]),
                span([
                  .text(
                    '${_formatTimestamp(clip.startMs)} – '
                    '${_formatTimestamp(clip.endMs)}',
                  ),
                ]),
              ]),
            ],
          ],
        ),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    final currentQuery =
        Uri.tryParse(
          RouteState.of(context).location,
        )?.queryParameters['q']?.trim() ??
        '';

    if (currentQuery != query && !loading) {
      Future.microtask(() {
        if (mounted) _syncFromRoute();
      });
    }

    final hasAnyResults = videoResults.isNotEmpty || subtitleResults.isNotEmpty;

    return div(classes: 'search-page', [
      div(classes: 'search-page-heading', [
        h1([.text(l10n.searchTitle)]),
        if (query.isNotEmpty)
          p([.text(l10n.searchResultsFor(query))])
        else
          p([.text(l10n.searchPageHint)]),
      ]),
      if (query.isEmpty)
        div(classes: 'empty-state search-empty-state', [
          h3([.text(l10n.searchPrompt)]),
          p([.text(l10n.searchPageHint)]),
        ])
      else if (loading)
        div(classes: 'search-loading-block', [
          div(classes: 'page-message', [
            .text(l10n.searchingVideosAndSubtitles),
          ]),
          div(classes: 'video-grid', [
            for (var i = 0; i < 4; i++) _skeletonCard(),
          ]),
        ])
      else if (error != null)
        div(classes: 'page-message error', [
          h3([.text(l10n.searchLoadFailed)]),
          p([.text(error!)]),
        ])
      else if (!hasAnyResults)
        div(classes: 'empty-state search-empty-state', [
          h3([.text(l10n.searchNoResults)]),
          p([.text(l10n.searchNoResultsHint(query))]),
        ])
      else ...[
        _searchTabs(),
        if (_selectedTab == _SearchTab.videos)
          if (videoResults.isEmpty)
            div(classes: 'empty-state search-tab-empty', [
              h3([.text(l10n.searchNoResults)]),
            ])
          else
            div(classes: 'video-grid search-tab-content', [
              for (final item in videoResults) _videoCard(item),
            ])
        else if (_selectedTab == _SearchTab.subtitles)
          if (subtitleResults.isEmpty)
            div(classes: 'empty-state search-tab-empty', [
              h3([.text(l10n.searchNoResults)]),
            ])
          else
            div(classes: 'subtitle-video-group-list search-tab-content', [
              for (final group in _subtitleGroups()) _subtitleVideoGroup(group),
            ])
        else if (userResults.isEmpty)
          div(classes: 'empty-state search-tab-empty', [
            h3([.text(l10n.searchNoResults)]),
          ])
        else
          div(classes: 'search-user-list search-tab-content', [
            for (final user in userResults) _userCard(user),
          ]),
      ],
      if (_activeClip != null) _clipModal(),
    ]);
  }

  Component _searchTabs() {
    return div(classes: 'search-tabs', [
      button(
        type: ButtonType.button,
        classes:
            'search-tab'
            '${_selectedTab == _SearchTab.videos ? ' is-active' : ''}',
        onClick: () {
          setState(() {
            _selectedTab = _SearchTab.videos;
          });
        },
        [
          span([.text(context.l10n.searchVideosSection)]),
          span(classes: 'search-tab-count', [.text('${videoResults.length}')]),
        ],
      ),
      button(
        type: ButtonType.button,
        classes:
            'search-tab'
            '${_selectedTab == _SearchTab.subtitles ? ' is-active' : ''}',
        onClick: () {
          setState(() {
            _selectedTab = _SearchTab.subtitles;
          });
        },
        [
          span([.text(context.l10n.subtitleMatches)]),
          span(classes: 'search-tab-count', [
            .text('${subtitleResults.length}'),
          ]),
        ],
      ),
      button(
        type: ButtonType.button,
        classes:
            'search-tab'
            '${_selectedTab == _SearchTab.users ? ' is-active' : ''}',
        onClick: () {
          setState(() {
            _selectedTab = _SearchTab.users;
          });
        },
        [
          span([.text(context.l10n.searchUsersSection)]),
          span(classes: 'search-tab-count', [.text('${userResults.length}')]),
        ],
      ),
    ]);
  }

  void _toggleSubtitleVideoGroup(int videoId) {
    setState(() {
      if (_expandedSubtitleVideoIds.contains(videoId)) {
        _expandedSubtitleVideoIds.remove(videoId);
      } else {
        _expandedSubtitleVideoIds.add(videoId);
      }
    });
  }

  List<_SubtitleVideoGroup> _subtitleGroups() {
    final groups = <int, _SubtitleVideoGroup>{};

    for (final item in subtitleResults) {
      final videoId = item.video.id;
      if (videoId == null) continue;

      final existing = groups[videoId];

      if (existing == null) {
        groups[videoId] = _SubtitleVideoGroup(
          video: item.video,
          coverUrl: item.coverUrl,
          matches: [item],
        );
      } else {
        existing.matches.add(item);
      }
    }

    final result = groups.values.toList();

    for (final group in result) {
      group.matches.sort((a, b) => a.startMs.compareTo(b.startMs));
    }

    result.sort(
      (a, b) =>
          a.video.title.toLowerCase().compareTo(b.video.title.toLowerCase()),
    );

    return result;
  }

  Component _subtitleVideoGroup(_SubtitleVideoGroup group) {
    final videoId = group.video.id;
    if (videoId == null) {
      return const Component.fragment([]);
    }

    final expanded = _expandedSubtitleVideoIds.contains(videoId);

    final original = group.matches.where((item) => item.isOriginal).toList();

    final translated = group.matches.where((item) => !item.isOriginal).toList();

    return section(
      classes:
          'subtitle-video-group'
          '${expanded ? ' is-expanded' : ''}',
      [
        button(
          type: ButtonType.button,
          classes: 'subtitle-video-group-toggle',
          onClick: () => _toggleSubtitleVideoGroup(videoId),
          [
            span(
              classes:
                  'subtitle-video-group-chevron'
                  '${expanded ? ' is-expanded' : ''}',
              [.text('▶')],
            ),
            div(
              classes: 'subtitle-video-group-cover',
              attributes: group.coverUrl == null
                  ? null
                  : {
                      'style':
                          "background-image:url('${_escapeCssUrl(group.coverUrl!)}')",
                    },
              [
                if (group.coverUrl == null)
                  span(classes: 'subtitle-video-group-cover-placeholder', [
                    .text(_initial(group.video.authorName)),
                  ]),
              ],
            ),
            div(classes: 'subtitle-video-group-copy', [
              h3([.text(group.video.title)]),
              p([.text(group.video.authorName)]),
            ]),
            span(classes: 'subtitle-video-group-count', [
              .text('${group.matches.length} matches'),
            ]),
          ],
        ),
        if (expanded)
          div(classes: 'subtitle-video-group-body', [
            if (original.isNotEmpty)
              _subtitleKindGroup(
                context.l10n.originalSubtitle,
                original,
                original: true,
              ),
            if (translated.isNotEmpty)
              _subtitleKindGroup(
                context.l10n.translatedSubtitle,
                translated,
                original: false,
              ),
          ]),
      ],
    );
  }

  Component _subtitleKindGroup(
    String label,
    List<_SubtitleMatch> matches, {
    required bool original,
  }) {
    return div(classes: 'subtitle-kind-group', [
      div(classes: 'subtitle-kind-group-head', [
        span(
          classes:
              'subtitle-search-kind '
              '${original ? 'is-original' : 'is-translation'}',
          [.text(label)],
        ),
        span(classes: 'subtitle-kind-count', [.text('${matches.length}')]),
      ]),
      div(classes: 'subtitle-kind-clips', [
        for (final item in matches) _subtitleClipRow(item),
      ]),
    ]);
  }

  Component _subtitleClipRow(_SubtitleMatch item) {
    return button(
      type: ButtonType.button,
      classes: 'subtitle-clip-row',
      onClick: () => _openClip(item),
      [
        span(classes: 'subtitle-clip-time', [
          .text(_formatTimestamp(item.startMs)),
        ]),
        div(classes: 'subtitle-clip-copy', [
          p([.text(item.text)]),
          span([
            .text(
              [
                item.track.label.trim().isNotEmpty
                    ? item.track.label
                    : item.track.languageCode.toUpperCase(),
                if (item.scriptCode?.trim().isNotEmpty == true)
                  item.scriptCode!.trim(),
              ].join(' · '),
            ),
          ]),
        ]),
        span(classes: 'subtitle-clip-play', [.text('▶')]),
      ],
    );
  }

  Component _userCard(_SearchUser user) {
    final avatarUrl = user.avatarUrl?.trim();

    final avatar = avatarUrl != null && avatarUrl.isNotEmpty
        ? div(
            classes: 'search-user-avatar has-image',
            attributes: {
              'style': "background-image:url('${_escapeCssUrl(avatarUrl)}')",
            },
            [],
          )
        : div(classes: 'search-user-avatar', [
            .text(_initial(user.displayName)),
          ]);

    return Link(
      to: '/profile/${Uri.encodeComponent(user.userId)}',
      child: article(classes: 'search-user-card is-clickable', [
        avatar,
        div(classes: 'search-user-copy', [
          h3([.text(user.displayName)]),
          p([
            .text(
              '${user.videoCount} '
              '${user.videoCount == 1 ? 'video' : 'videos'}',
            ),
          ]),
        ]),
        span(classes: 'search-user-arrow', [.text('›')]),
      ]),
    );
  }

  Component _videoCard(_SearchVideo item) {
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
              '${context.l10n.topic(video.category)} · '
              '${context.l10n.viewsAndLanguage(video.viewCount, video.languageCode)}',
            ),
          ]),
        ]),
      ]),
    ]);

    if (id == null) return card;
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

  String _formatTimestamp(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _initial(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? 'C' : trimmed.substring(0, 1).toUpperCase();
  }

  String _escapeCssUrl(String value) {
    return value.replaceAll("'", r"\'");
  }
}

class _SearchUser {
  const _SearchUser({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    required this.videoCount,
  });

  final String userId;
  final String displayName;
  final String? avatarUrl;
  final int videoCount;
}

class _SearchVideo {
  const _SearchVideo({required this.video, required this.coverUrl});

  final api.Video video;
  final String? coverUrl;
}

class _SubtitleVideoGroup {
  _SubtitleVideoGroup({
    required this.video,
    required this.coverUrl,
    required this.matches,
  });

  final api.Video video;
  final String? coverUrl;
  final List<_SubtitleMatch> matches;
}

class _SubtitleMatch {
  const _SubtitleMatch({
    required this.video,
    required this.coverUrl,
    required this.track,
    required this.text,
    required this.scriptCode,
    required this.startMs,
    required this.endMs,
    required this.isOriginal,
  });

  final api.Video video;
  final String? coverUrl;
  final api.SubtitleTrack track;
  final String text;
  final String? scriptCode;
  final int startMs;
  final int endMs;
  final bool isOriginal;
}

class _SubtitleCandidate {
  const _SubtitleCandidate({required this.text, required this.scriptCode});

  final String text;
  final String? scriptCode;
}
