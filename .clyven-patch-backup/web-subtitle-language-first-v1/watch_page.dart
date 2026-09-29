import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/watch_subtitle_player.dart';
import '../services/web_client.dart';

enum _SubtitleDisplayMode { overlay, learningPanel }

class _TrackAvailability {
  const _TrackAvailability({required this.track, required this.scriptCodes});

  final api.SubtitleTrack track;
  final List<String> scriptCodes;
}

class _SubtitleSelection {
  const _SubtitleSelection({required this.track, required this.scriptCode});

  final api.SubtitleTrack track;
  final String scriptCode;

  bool sameAs(_SubtitleSelection? other) {
    if (other == null) return false;
    return track.id == other.track.id &&
        track.languageCode == other.track.languageCode &&
        track.variantCode == other.track.variantCode &&
        scriptCode == other.scriptCode;
  }
}

class WatchPage extends StatefulComponent {
  const WatchPage({required this.videoId, super.key});

  final int videoId;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  bool _loading = true;
  String? _error;

  api.Video? _video;
  String _videoUrl = '';
  String _coverUrl = '';

  List<_TrackAvailability> _availability = const [];
  _SubtitleSelection? _primary;
  _SubtitleSelection? _secondary;
  List<api.SubtitleCueDetail> _primaryCues = const [];
  List<api.SubtitleCueDetail> _secondaryCues = const [];

  bool _subtitlesEnabled = true;
  _SubtitleDisplayMode _displayMode = _SubtitleDisplayMode.overlay;
  bool _settingsOpen = false;
  int _currentMs = 0;

  List<api.VideoCommentDto> _comments = const [];

  api.DictionaryEntryDetail? _dictionaryEntry;
  String? _dictionaryTitle;
  bool _dictionaryLoading = false;
  String? _dictionaryError;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final video = await webClient.video.getVideo(component.videoId);

      if (video == null) {
        throw StateError('Video not found');
      }

      final videoUrl =
          await webClient.video.getVideoUrl(path: video.videoStorageKey) ?? '';

      var coverUrl = '';
      final coverKey = video.coverStorageKey;
      if (coverKey != null && coverKey.trim().isNotEmpty) {
        coverUrl = await webClient.video.getVideoUrl(path: coverKey) ?? '';
      }

      final availability = await _loadAvailability();

      _SubtitleSelection? primary;
      if (availability.isNotEmpty) {
        var selectedItem = availability.first;

        for (final item in availability) {
          if (item.track.isDefault) {
            selectedItem = item;
            break;
          }
        }

        primary = _selectionFor(selectedItem);
      }

      final primaryCues = primary == null
          ? <api.SubtitleCueDetail>[]
          : await _loadSelectionCues(primary);

      List<api.VideoCommentDto> comments = const [];
      try {
        final page = await webClient.comment.loadComments(
          videoId: component.videoId,
          page: 1,
          limit: 20,
        );
        comments = page.comments;
      } catch (_) {
        comments = const [];
      }

      if (!mounted) return;

      setState(() {
        _video = video;
        _videoUrl = videoUrl;
        _coverUrl = coverUrl;
        _availability = availability;
        _primary = primary;
        _primaryCues = primaryCues;
        _comments = comments;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = '$error';
        _loading = false;
      });
    }
  }

  Future<List<_TrackAvailability>> _loadAvailability() async {
    final tracks = await webClient.subtitle.getPublishedAvailableTracks(
      videoId: component.videoId,
    );

    final result = <_TrackAvailability>[];

    for (final track in tracks) {
      final details = await webClient.subtitle.getPublishedCueDetails(
        videoId: component.videoId,
        languageCode: track.languageCode,
        scriptCode: null,
      );

      final scripts = <String>[];

      void addScript(String? value) {
        final code = value?.trim();
        if (code == null || code.isEmpty || scripts.contains(code)) return;
        scripts.add(code);
      }

      for (final detail in details) {
        final texts = detail.texts ?? const <api.SubtitleCueText>[];
        for (final text in texts) {
          if (text.text.trim().isNotEmpty) {
            addScript(text.scriptCode);
          }
        }
      }

      if (scripts.isEmpty) {
        final hasLegacyText = details.any(
          (detail) => detail.cue.text.trim().isNotEmpty,
        );
        if (hasLegacyText) {
          addScript(track.defaultScriptCode);
        }
      }

      if (scripts.isEmpty) continue;

      final defaultScript = track.defaultScriptCode?.trim();
      if (defaultScript != null &&
          defaultScript.isNotEmpty &&
          scripts.remove(defaultScript)) {
        scripts.insert(0, defaultScript);
      }

      result.add(_TrackAvailability(track: track, scriptCodes: scripts));
    }

    return result;
  }

  _SubtitleSelection _selectionFor(
    _TrackAvailability item, {
    String? scriptCode,
  }) {
    final requested = scriptCode?.trim();
    final defaultScript = item.track.defaultScriptCode?.trim();

    String selectedScript;
    if (requested != null &&
        requested.isNotEmpty &&
        item.scriptCodes.contains(requested)) {
      selectedScript = requested;
    } else if (defaultScript != null &&
        defaultScript.isNotEmpty &&
        item.scriptCodes.contains(defaultScript)) {
      selectedScript = defaultScript;
    } else {
      selectedScript = item.scriptCodes.first;
    }

    return _SubtitleSelection(track: item.track, scriptCode: selectedScript);
  }

  Future<List<api.SubtitleCueDetail>> _loadSelectionCues(
    _SubtitleSelection selection,
  ) {
    return webClient.subtitle.getPublishedCueDetails(
      videoId: component.videoId,
      languageCode: selection.track.languageCode,
      scriptCode: selection.scriptCode,
    );
  }

  Future<void> _selectPrimary(_SubtitleSelection selection) async {
    if (selection.sameAs(_primary)) return;

    final cues = await _loadSelectionCues(selection);
    if (!mounted) return;

    setState(() {
      _primary = selection;
      _primaryCues = cues;
      _subtitlesEnabled = true;

      if (selection.sameAs(_secondary)) {
        _secondary = null;
        _secondaryCues = const [];
      }
    });
  }

  Future<void> _selectSecondary(_SubtitleSelection selection) async {
    if (selection.sameAs(_primary) || selection.sameAs(_secondary)) return;

    final cues = await _loadSelectionCues(selection);
    if (!mounted) return;

    setState(() {
      _secondary = selection;
      _secondaryCues = cues;
      _subtitlesEnabled = true;
    });
  }

  api.SubtitleCueDetail? _active(List<api.SubtitleCueDetail> details) {
    for (final detail in details) {
      if (_currentMs >= detail.cue.startMs && _currentMs < detail.cue.endMs) {
        return detail;
      }
    }
    return null;
  }

  List<api.SubtitleToken> _visibleTokens(
    api.SubtitleCueDetail detail,
    String scriptCode,
  ) {
    final requestedScript = scriptCode.trim().toLowerCase();

    final tokens = detail.tokens.where((token) {
      final tokenScript = token.scriptCode?.trim().toLowerCase();
      return tokenScript == null ||
          tokenScript.isEmpty ||
          tokenScript == requestedScript;
    }).toList()..sort((a, b) => a.position.compareTo(b.position));

    return tokens;
  }

  Future<void> _openDictionary(api.SubtitleToken token) async {
    final primary = _primary;
    if (primary == null) return;

    setState(() {
      _dictionaryLoading = true;
      _dictionaryError = null;
      _dictionaryEntry = null;
      _dictionaryTitle = token.text;
    });

    try {
      final entryId = token.entryId;
      final normalized = (token.normalizedText ?? token.text).trim();

      final result = entryId != null
          ? await webClient.dictionary.getById(
              entryId: entryId,
              explanationLanguageCode: 'zh',
            )
          : await webClient.dictionary.lookup(
              languageCode: primary.track.languageCode,
              normalizedText: normalized,
              entryType: 'word',
              explanationLanguageCode: 'zh',
            );

      if (!mounted) return;
      setState(() {
        _dictionaryEntry = result;
        _dictionaryLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _dictionaryError = '$error';
        _dictionaryLoading = false;
      });
    }
  }

  void _closeDictionary() {
    setState(() {
      _dictionaryTitle = null;
      _dictionaryEntry = null;
      _dictionaryError = null;
      _dictionaryLoading = false;
    });
  }

  Component _settingsPanel() {
    return div(classes: 'watch-player-settings-layer', [
      div(classes: 'watch-subtitle-settings-card', [
        div(classes: 'watch-subtitle-settings-head', [
          div([
            h2([.text('字幕')]),
            p([.text('选择位置、主字幕、文字系统与第二字幕。')]),
          ]),
          button(
            type: ButtonType.button,
            classes: 'watch-subtitle-close',
            onClick: () {
              setState(() => _settingsOpen = false);
            },
            [.text('×')],
          ),
        ]),
        div(classes: 'watch-subtitle-toolbar', [
          button(
            type: ButtonType.button,
            classes:
                'watch-setting-chip'
                '${!_subtitlesEnabled ? ' is-active' : ''}',
            onClick: () {
              setState(() => _subtitlesEnabled = false);
            },
            [.text('关闭字幕')],
          ),
          button(
            type: ButtonType.button,
            classes:
                'watch-setting-chip'
                '${_displayMode == _SubtitleDisplayMode.overlay ? ' is-active' : ''}',
            onClick: () {
              setState(() {
                _subtitlesEnabled = true;
                _displayMode = _SubtitleDisplayMode.overlay;
              });
            },
            [.text('视频内')],
          ),
          button(
            type: ButtonType.button,
            classes:
                'watch-setting-chip'
                '${_displayMode == _SubtitleDisplayMode.learningPanel ? ' is-active' : ''}',
            onClick: () {
              setState(() {
                _subtitlesEnabled = true;
                _displayMode = _SubtitleDisplayMode.learningPanel;
              });
            },
            [.text('视频下方')],
          ),
        ]),
        h3([.text('主字幕')]),
        for (final item in _availability)
          _languageGroup(item, current: _primary, secondary: false),
        div(classes: 'watch-second-subtitle-title', [
          h3([.text('第二字幕')]),
          if (_secondary != null)
            button(
              type: ButtonType.button,
              classes: 'watch-text-button',
              onClick: () {
                setState(() {
                  _secondary = null;
                  _secondaryCues = const [];
                });
              },
              [.text('关闭')],
            ),
        ]),
        for (final item in _availability)
          _languageGroup(item, current: _secondary, secondary: true),
      ]),
    ]);
  }

  Component _languageGroup(
    _TrackAvailability item, {
    required _SubtitleSelection? current,
    required bool secondary,
  }) {
    final label = item.track.label.trim().isNotEmpty
        ? item.track.label.trim()
        : item.track.languageCode.toUpperCase();

    return div(classes: 'watch-language-group', [
      div(classes: 'watch-language-title', [
        strong([.text(label)]),
        span([.text(item.track.languageCode)]),
        if (item.track.variantCode != null)
          span([.text(item.track.variantCode!)]),
      ]),
      div(classes: 'watch-script-options', [
        for (final scriptCode in item.scriptCodes)
          button(
            type: ButtonType.button,
            classes:
                'watch-script-option'
                '${current?.track.id == item.track.id && current?.scriptCode == scriptCode ? ' is-active' : ''}'
                '${secondary && _primary?.track.id == item.track.id && _primary?.scriptCode == scriptCode ? ' is-disabled' : ''}',
            onClick: () {
              final selection = _selectionFor(item, scriptCode: scriptCode);
              if (secondary) {
                if (!selection.sameAs(_primary)) {
                  _selectSecondary(selection);
                }
              } else {
                _selectPrimary(selection);
              }
            },
            [
              span(classes: 'watch-script-sample', [.text(scriptCode)]),
              span([.text(scriptCode)]),
            ],
          ),
      ]),
    ]);
  }

  Component _learningPanel() {
    final primary = _primary;
    if (primary == null) {
      return div(classes: 'watch-learning-panel empty', [.text('没有可用字幕')]);
    }

    final primaryDetail = _active(_primaryCues);
    final secondaryDetail = _active(_secondaryCues);

    if (primaryDetail == null) {
      return div(classes: 'watch-learning-panel empty', [
        .text('播放到有字幕的位置后，这里会显示逐词内容。'),
      ]);
    }

    final tokens = _visibleTokens(primaryDetail, primary.scriptCode);

    return div(classes: 'watch-learning-panel', [
      div(classes: 'watch-learning-head', [
        span(classes: 'watch-learning-badge', [.text('LEARNING')]),
        span([.text('${primary.track.languageCode} · ${primary.scriptCode}')]),
      ]),
      div(classes: 'watch-learning-sentence', [.text(primaryDetail.cue.text)]),
      if (secondaryDetail != null)
        div(classes: 'watch-learning-secondary', [
          .text(secondaryDetail.cue.text),
        ]),
      if (tokens.isNotEmpty)
        div(classes: 'watch-learning-tokens', [
          for (final token in tokens)
            button(
              type: ButtonType.button,
              classes: 'watch-learning-token',
              onClick: () => _openDictionary(token),
              [.text(token.text)],
            ),
        ])
      else
        div(classes: 'watch-learning-hint', [.text('这条字幕暂时没有逐词 token 数据。')]),
    ]);
  }

  Component _dictionaryModal() {
    final title = _dictionaryTitle;
    if (title == null) return const Component.fragment([]);

    final entry = _dictionaryEntry;

    return div(classes: 'watch-dictionary-modal', [
      div(classes: 'watch-dictionary-card', [
        div(classes: 'watch-dictionary-head', [
          div([
            span(classes: 'watch-dictionary-type', [.text('Dictionary')]),
            h2([.text(title)]),
          ]),
          button(
            type: ButtonType.button,
            classes: 'watch-subtitle-close',
            onClick: _closeDictionary,
            [.text('×')],
          ),
        ]),
        if (_dictionaryLoading)
          p([.text('查询中…')])
        else if (_dictionaryError != null)
          p(classes: 'watch-error-text', [.text('查询失败：$_dictionaryError')])
        else if (entry == null)
          p([.text('暂时没有这个词条的释义。')])
        else if (entry.definitions.isEmpty)
          p([.text('这个词条暂时没有中文释义。')])
        else
          div(classes: 'watch-dictionary-definitions', [
            for (final definition in entry.definitions)
              div(classes: 'watch-dictionary-definition', [
                strong([.text(definition.gloss)]),
                if (definition.definition?.trim().isNotEmpty == true)
                  p([.text(definition.definition!)]),
              ]),
          ]),
      ]),
    ]);
  }

  Component _commentsSection() {
    return section(classes: 'watch-comments', [
      div(classes: 'watch-section-title', [
        h2([.text('Comments')]),
        span([.text('${_comments.length}')]),
      ]),
      if (_comments.isEmpty)
        p(classes: 'watch-muted', [.text('No comments yet.')])
      else
        for (final comment in _comments)
          article(classes: 'watch-comment', [
            div(classes: 'watch-comment-avatar', [
              .text(
                comment.userName.trim().isEmpty
                    ? '?'
                    : comment.userName.trim()[0].toUpperCase(),
              ),
            ]),
            div(classes: 'watch-comment-body', [
              strong([.text(comment.userName)]),
              p([.text(comment.content)]),
              span(classes: 'watch-comment-meta', [
                .text('${comment.likeCount} likes'),
              ]),
              if (comment.replies.isNotEmpty)
                div(classes: 'watch-comment-replies', [
                  for (final reply in comment.replies)
                    p([
                      strong([.text('${reply.userName}: ')]),
                      .text(reply.content),
                    ]),
                ]),
            ]),
          ]),
    ]);
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return div(classes: 'watch-page watch-state-page', [
        div(classes: 'watch-state-card', [
          div(classes: 'watch-spinner', []),
          h2([.text('Loading video…')]),
          p([.text('Loading video, subtitles and comments.')]),
        ]),
      ]);
    }

    if (_error != null || _video == null) {
      return div(classes: 'watch-page watch-state-page', [
        div(classes: 'watch-state-card', [
          h2([.text('Video unavailable')]),
          p([.text(_error ?? 'Unknown error')]),
          a(href: '/', [.text('Back home')]),
        ]),
      ]);
    }

    final video = _video!;

    return div(classes: 'watch-page', [
      div(classes: 'watch-layout', [
        main_(classes: 'watch-main-column', [
          a(href: '/', classes: 'watch-back-link', [.text('← Home')]),
          WatchSubtitlePlayer(
            videoId: component.videoId,
            videoUrl: _videoUrl,
            coverUrl: _coverUrl,
            primaryCues: _primaryCues,
            secondaryCues: _secondaryCues,
            primaryScriptCode: _primary?.scriptCode,
            secondaryScriptCode: _secondary?.scriptCode,
            subtitlesEnabled: _subtitlesEnabled && _primary != null,
            overlayMode: _displayMode == _SubtitleDisplayMode.overlay,
            settingsPanel: _settingsOpen ? _settingsPanel() : null,
            onTimeChanged: (milliseconds) {
              if (_currentMs != milliseconds) {
                setState(() => _currentMs = milliseconds);
              }
            },
            onSubtitleSettings: () {
              setState(() => _settingsOpen = true);
            },
          ),
          if (_subtitlesEnabled &&
              _displayMode == _SubtitleDisplayMode.learningPanel)
            _learningPanel(),
          section(classes: 'watch-video-info', [
            h1([.text(video.title)]),
            div(classes: 'watch-meta-row', [
              span([.text('${video.viewCount} views')]),
              span([.text('${video.likeCount} likes')]),
              if (video.languageCode != null)
                span([.text(video.languageCode!)]),
            ]),
            div(classes: 'watch-author-row', [
              div(classes: 'watch-author-avatar', [
                .text(
                  video.authorName.trim().isEmpty
                      ? '?'
                      : video.authorName.trim()[0].toUpperCase(),
                ),
              ]),
              div([
                strong([.text(video.authorName)]),
                p([.text(video.category)]),
              ]),
            ]),
            if (video.description.trim().isNotEmpty)
              p(classes: 'watch-description', [.text(video.description)]),
            if (video.tags.isNotEmpty)
              div(classes: 'watch-tags', [
                for (final tag in video.tags) span([.text('#$tag')]),
              ]),
          ]),
          _commentsSection(),
        ]),
        aside(classes: 'watch-side-column', [
          div(classes: 'watch-feature-card', [
            span(classes: 'watch-feature-kicker', [.text('CLYVEN SUBTITLES')]),
            h2([.text('字幕已经接上播放器')]),
            p([.text('主字幕、第二字幕、文字系统、卡拉 OK 高亮和学习面板现在都直接跟视频时间同步。')]),
            button(
              type: ButtonType.button,
              classes: 'watch-open-subtitles',
              onClick: () {
                setState(() => _settingsOpen = true);
              },
              [.text('字幕设置')],
            ),
          ]),
          if (_availability.isNotEmpty)
            div(classes: 'watch-track-summary', [
              h3([.text('Available')]),
              for (final item in _availability)
                div(classes: 'watch-track-summary-row', [
                  strong([
                    .text(
                      item.track.label.trim().isNotEmpty
                          ? item.track.label
                          : item.track.languageCode.toUpperCase(),
                    ),
                  ]),
                  span([.text(item.scriptCodes.join(' · '))]),
                ]),
            ]),
        ]),
      ]),
      if (_dictionaryTitle != null) _dictionaryModal(),
    ]);
  }
}
