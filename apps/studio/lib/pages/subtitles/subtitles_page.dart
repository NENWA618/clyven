import 'package:glyphora_backend_client/backend_client.dart';
import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../../services/studio_client.dart';

class SubtitlesPage extends StatefulComponent {
  const SubtitlesPage({super.key});

  @override
  State<SubtitlesPage> createState() => _SubtitlesPageState();
}

class _SubtitlesPageState extends State<SubtitlesPage> {
  final client = studioClient;

  List<Video> videos = [];
  int? selectedVideoId;
  LanguageConfig? selectedLanguage;
  String? selectedScriptCode;

  String languageSearch = '';
  bool showAllLanguages = false;
  bool showVideoPicker = false;
  bool loading = true;
  bool loadingPriorityLanguages = false;
  String? error;

  List<String> activeTrackLanguageCodes = const [];
  final Map<int, String?> videoCoverUrls = <int, String?>{};

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await client.video.getMyVideos();

      if (!mounted) return;

      setState(() {
        videos = result;
        loading = false;
        if (result.isNotEmpty) {
          selectedVideoId ??= result.first.id;
        }
      });

      await _loadVideoCovers(result);
      await _syncLanguagePriorityForSelectedVideo(selectSource: true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> _loadVideoCovers(List<Video> sourceVideos) async {
    final resolved = <int, String?>{};

    await Future.wait(
      sourceVideos.map((video) async {
        final id = video.id;
        if (id == null) return;

        final key = video.coverStorageKey?.trim();
        if (key == null || key.isEmpty) {
          resolved[id] = null;
          return;
        }

        try {
          resolved[id] = await client.video.getVideoUrl(path: key);
        } catch (_) {
          resolved[id] = null;
        }
      }),
    );

    if (!mounted) return;

    setState(() {
      videoCoverUrls
        ..clear()
        ..addAll(resolved);
    });
  }

  Video? get selectedVideo {
    final id = selectedVideoId;
    if (id == null) return null;

    for (final video in videos) {
      if (video.id == id) return video;
    }

    return null;
  }

  LanguageConfig? get sourceLanguage {
    final code = selectedVideo?.languageCode?.trim();
    if (code == null || code.isEmpty) return null;
    return LanguageConfig.findByCode(code);
  }

  List<LanguageConfig> get priorityLanguages {
    final result = <LanguageConfig>[];
    final seen = <String>{};

    void add(LanguageConfig? language) {
      if (language == null) return;
      if (seen.add(language.code)) result.add(language);
    }

    add(sourceLanguage);

    for (final languageCode in activeTrackLanguageCodes) {
      add(LanguageConfig.findByCode(languageCode));
    }

    add(selectedLanguage);

    return result;
  }

  List<LanguageConfig> get filteredLanguages {
    final query = languageSearch.trim().toLowerCase();

    final source = [...LanguageConfig.allLanguages]
      ..sort(
        (left, right) => left.sortKeyOf('zh').compareTo(right.sortKeyOf('zh')),
      );

    final priorityCodes = priorityLanguages.map((item) => item.code).toSet();

    final others = source.where((language) => !priorityCodes.contains(language.code)).toList(growable: false);

    if (query.isEmpty) return others;

    return others
        .where((language) {
          return language.code.toLowerCase().contains(query) ||
              language.nameOf('zh').toLowerCase().contains(query) ||
              language.nameOf('en').toLowerCase().contains(query) ||
              language.nameOf('vi').toLowerCase().contains(query) ||
              language.nameOf('ms').toLowerCase().contains(query);
        })
        .toList(growable: false);
  }

  List<ScriptConfig> get selectedScripts {
    final language = selectedLanguage;
    if (language == null) return const [];

    final codes = <String>{...language.scriptCodes};

    for (final script in ScriptConfig.allScripts) {
      if (script.languageCodes.contains(language.code)) {
        codes.add(script.code);
      }
    }

    return codes.map(ScriptConfig.findByCode).whereType<ScriptConfig>().toList(growable: false);
  }

  Future<void> _selectVideo(Video video) async {
    setState(() {
      selectedVideoId = video.id;
      showVideoPicker = false;
      showAllLanguages = false;
      languageSearch = '';
    });

    await _syncLanguagePriorityForSelectedVideo(selectSource: true);
  }

  Future<void> _syncLanguagePriorityForSelectedVideo({
    required bool selectSource,
  }) async {
    final video = selectedVideo;
    final videoId = video?.id;

    if (video == null || videoId == null) return;

    if (mounted) {
      setState(() {
        loadingPriorityLanguages = true;
      });
    }

    List<String> trackCodes = const [];

    try {
      final tracks = await client.subtitle.getPublishedAvailableTracks(
        videoId: videoId,
      );

      trackCodes = tracks
          .map((track) => track.languageCode.trim())
          .where((languageCode) => languageCode.isNotEmpty)
          .toSet()
          .toList(growable: false);
    } catch (_) {}

    if (!mounted || selectedVideoId != videoId) return;

    final source = sourceLanguage;
    LanguageConfig? nextLanguage;

    if (selectSource && source != null) {
      nextLanguage = source;
    } else if (selectedLanguage != null) {
      nextLanguage = selectedLanguage;
    } else if (trackCodes.isNotEmpty) {
      nextLanguage = LanguageConfig.findByCode(trackCodes.first);
    } else {
      nextLanguage =
          LanguageConfig.findByCode('vi') ??
          (LanguageConfig.allLanguages.isEmpty ? null : LanguageConfig.allLanguages.first);
    }

    setState(() {
      activeTrackLanguageCodes = trackCodes;
      selectedLanguage = nextLanguage;
      loadingPriorityLanguages = false;
      _chooseDefaultScript();
    });
  }

  void _chooseDefaultScript() {
    final scripts = selectedScripts;
    selectedScriptCode = scripts.isEmpty ? null : scripts.first.code;
  }

  void _selectLanguage(LanguageConfig language) {
    setState(() {
      selectedLanguage = language;
      showAllLanguages = false;
      languageSearch = '';
      _chooseDefaultScript();
    });
  }

  void _openEditor(
    BuildContext context,
    LanguageConfig language, {
    String? scriptCode,
  }) {
    final videoId = selectedVideoId;
    if (videoId == null) return;

    final base = '/subtitles/$videoId/${Uri.encodeComponent(language.code)}';

    Router.of(context).push(
      scriptCode == null ? base : '$base/${Uri.encodeComponent(scriptCode)}',
    );
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'subtitle-manager-page',
      [
        div(classes: 'subtitle-manager-header', [
          div([
            p(classes: 'subtitle-manager-kicker', [.text('GLYPHORA STUDIO')]),
            h1([.text('字幕管理')]),
            p([.text('管理当前视频的原文、翻译与文字系统。')]),
          ]),
        ]),

        if (loading)
          div(classes: 'subtitle-manager-state', [.text('正在读取视频…')])
        else if (error != null)
          div(classes: 'subtitle-manager-state is-error', [.text(error!)])
        else if (videos.isEmpty)
          div(classes: 'subtitle-manager-state', [.text('目前没有视频')])
        else ...[
          _currentVideoBar(),
          if (showVideoPicker) _videoPicker(),
          _trackManager(context),
        ],
      ],
    );
  }

  Component _currentVideoBar() {
    final video = selectedVideo;
    if (video == null) {
      return const Component.fragment([]);
    }

    final id = video.id;
    final coverUrl = id == null ? null : videoCoverUrls[id]?.trim();
    final source = sourceLanguage;

    return section(classes: 'subtitle-manager-current-video', [
      div(
        classes: 'subtitle-manager-current-cover ${coverUrl == null || coverUrl.isEmpty ? 'is-empty' : ''}',
        attributes: coverUrl == null || coverUrl.isEmpty
            ? null
            : {
                'style': "background-image:url('${_escapeCssUrl(coverUrl)}')",
              },
        [
          if (coverUrl == null || coverUrl.isEmpty) span([.text(_initial(video.title))]),
        ],
      ),
      div(classes: 'subtitle-manager-current-copy', [
        span(classes: 'subtitle-manager-current-label', [
          .text('CURRENT VIDEO'),
        ]),
        h2([.text(video.title)]),
        div(classes: 'subtitle-manager-current-meta', [
          span([.text(video.authorName)]),
          if (source != null) span([.text('${source.flag} ${source.nameOf('zh')}')]),
          span([.text('${video.durationSeconds}s')]),
        ]),
      ]),
      button(
        type: ButtonType.button,
        classes: 'subtitle-manager-switch-video',
        onClick: () {
          setState(() {
            showVideoPicker = !showVideoPicker;
          });
        },
        [
          span([.text(showVideoPicker ? '收起' : '切换视频')]),
          b([.text(showVideoPicker ? '↑' : '↓')]),
        ],
      ),
    ]);
  }

  Component _videoPicker() {
    return div(classes: 'subtitle-manager-video-picker', [
      div(classes: 'subtitle-manager-video-grid', [
        for (final video in videos) _videoPickerItem(video),
      ]),
    ]);
  }

  Component _videoPickerItem(Video video) {
    final id = video.id;
    final coverUrl = id == null ? null : videoCoverUrls[id]?.trim();
    final selected = selectedVideoId == id;

    return button(
      type: ButtonType.button,
      classes: 'subtitle-manager-video-item ${selected ? 'is-selected' : ''}',
      onClick: () => _selectVideo(video),
      [
        div(
          classes: 'subtitle-manager-video-thumb ${coverUrl == null || coverUrl.isEmpty ? 'is-empty' : ''}',
          attributes: coverUrl == null || coverUrl.isEmpty
              ? null
              : {
                  'style': "background-image:url('${_escapeCssUrl(coverUrl)}')",
                },
          [
            if (coverUrl == null || coverUrl.isEmpty) span([.text(_initial(video.title))]),
          ],
        ),
        div([
          strong([.text(video.title)]),
          span([.text(video.authorName)]),
        ]),
      ],
    );
  }

  Component _trackManager(BuildContext context) {
    final source = sourceLanguage;
    final translations = priorityLanguages.where((item) => item.code != source?.code).toList(growable: false);

    return section(classes: 'subtitle-manager-tracks', [
      div(classes: 'subtitle-manager-section-head', [
        div([
          h2([.text('字幕轨')]),
          p([.text('原文与翻译分开管理，直接进入对应轨道编辑。')]),
        ]),
        button(
          type: ButtonType.button,
          classes: 'subtitle-manager-add-track',
          onClick: () {
            setState(() {
              showAllLanguages = !showAllLanguages;
            });
          },
          [
            span([.text('+')]),
            strong([.text('添加翻译语言')]),
          ],
        ),
      ]),

      if (source != null) ...[
        _trackGroupTitle('原文', 'Original'),
        _trackRow(context, source, isSource: true),
      ],

      if (translations.isNotEmpty) ...[
        _trackGroupTitle('翻译', 'Translations'),
        for (final language in translations) _trackRow(context, language),
      ],

      if (loadingPriorityLanguages)
        div(classes: 'subtitle-manager-state compact', [
          .text('正在读取字幕轨…'),
        ]),

      if (showAllLanguages) _languagePicker(context),
    ]);
  }

  Component _trackGroupTitle(String title, String subtitle) {
    return div(classes: 'subtitle-manager-track-group-title', [
      strong([.text(title)]),
      span([.text(subtitle)]),
    ]);
  }

  Component _trackRow(
    BuildContext context,
    LanguageConfig language, {
    bool isSource = false,
  }) {
    final scripts = _scriptsFor(language);
    final hasTrack = activeTrackLanguageCodes.contains(language.code);
    final selectedScript = selectedLanguage?.code == language.code ? selectedScriptCode : null;

    final scriptLabel = selectedScript == null
        ? (scripts.isEmpty ? 'Legacy / unspecified' : language.scriptNameOf(scripts.first.code, 'zh'))
        : language.scriptNameOf(selectedScript, 'zh');

    final scriptCode = selectedScript ?? (scripts.isEmpty ? null : scripts.first.code);

    return div(classes: 'subtitle-manager-track-row', [
      span(classes: 'subtitle-manager-track-flag', [.text(language.flag)]),
      div(classes: 'subtitle-manager-track-language', [
        div([
          strong([.text(language.nameOf('zh'))]),
          span([.text(language.nameOf('en'))]),
        ]),
        span(
          classes: 'subtitle-manager-track-badge ${isSource ? 'is-source' : 'is-translation'}',
          [
            .text(
              isSource
                  ? '原文'
                  : hasTrack
                  ? '翻译'
                  : '待创建',
            ),
          ],
        ),
      ]),
      button(
        type: ButtonType.button,
        classes: 'subtitle-manager-script-button',
        onClick: scripts.length <= 1 ? null : () => _showScriptMenu(language),
        [
          span([.text(scriptLabel)]),
          if (scriptCode != null) code([.text(scriptCode)]),
        ],
      ),
      button(
        type: ButtonType.button,
        classes: 'subtitle-manager-edit-track',
        onClick: () => _openEditor(context, language, scriptCode: scriptCode),
        [
          span([.text('进入编辑')]),
          b([.text('→')]),
        ],
      ),
    ]);
  }

  List<ScriptConfig> _scriptsFor(LanguageConfig language) {
    final codes = <String>{...language.scriptCodes};

    for (final script in ScriptConfig.allScripts) {
      if (script.languageCodes.contains(language.code)) {
        codes.add(script.code);
      }
    }

    return codes.map(ScriptConfig.findByCode).whereType<ScriptConfig>().toList(growable: false);
  }

  void _showScriptMenu(LanguageConfig language) {
    final scripts = _scriptsFor(language);
    if (scripts.isEmpty) return;

    setState(() {
      selectedLanguage = language;

      final current = selectedScriptCode;
      final currentIndex = current == null ? -1 : scripts.indexWhere((script) => script.code == current);

      final nextIndex = currentIndex < 0 || currentIndex + 1 >= scripts.length ? 0 : currentIndex + 1;

      selectedScriptCode = scripts[nextIndex].code;
    });
  }

  Component _languagePicker(BuildContext context) {
    return div(classes: 'subtitle-manager-language-picker', [
      div(classes: 'subtitle-manager-language-search', [
        span([.text('⌕')]),
        input<String>(
          type: InputType.text,
          attributes: {
            'placeholder': '搜索中文名 / English / code',
            'value': languageSearch,
          },
          events: events<String>(
            onInput: (value) {
              setState(() {
                languageSearch = value;
              });
            },
          ),
        ),
      ]),
      div(classes: 'subtitle-manager-language-grid', [
        for (final item in filteredLanguages)
          button(
            type: ButtonType.button,
            classes: 'subtitle-manager-language-item',
            onClick: () {
              _selectLanguage(item);
              setState(() {
                showAllLanguages = false;
              });
            },
            [
              span([.text(item.flag)]),
              div([
                strong([.text(item.nameOf('zh'))]),
                small([.text(item.nameOf('en'))]),
              ]),
              code([.text(item.code)]),
            ],
          ),
      ]),
    ]);
  }

  String _initial(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? 'C' : trimmed.substring(0, 1).toUpperCase();
  }

  String _escapeCssUrl(String value) {
    return value.replaceAll('\\', '%5C').replaceAll("'", '%27').replaceAll('"', '%22');
  }
}
