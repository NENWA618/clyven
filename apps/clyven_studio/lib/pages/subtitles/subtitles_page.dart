import 'package:clyven_backend_client/clyven_backend_client.dart';
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
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    selectedLanguage =
        LanguageConfig.findByCode('vi') ??
        (LanguageConfig.allLanguages.isEmpty ? null : LanguageConfig.allLanguages.first);
    _chooseDefaultScript();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await client.video.getMyVideos();
      setState(() {
        videos = result;
        loading = false;
        if (result.isNotEmpty) {
          selectedVideoId ??= result.first.id;
        }
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Video? get selectedVideo {
    final id = selectedVideoId;
    if (id == null) return null;
    for (final video in videos) {
      if (video.id == id) return video;
    }
    return null;
  }

  List<LanguageConfig> get filteredLanguages {
    final query = languageSearch.trim().toLowerCase();
    final source = [...LanguageConfig.allLanguages]..sort((a, b) => a.sortKeyOf('zh').compareTo(b.sortKeyOf('zh')));

    if (query.isEmpty) return source;

    return source
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

  void _chooseDefaultScript() {
    final scripts = selectedScripts;
    selectedScriptCode = scripts.isEmpty ? null : scripts.first.code;
  }

  void _selectLanguage(LanguageConfig language) {
    setState(() {
      selectedLanguage = language;
      _chooseDefaultScript();
    });
  }

  void _openEditor(BuildContext context) {
    final videoId = selectedVideoId;
    final language = selectedLanguage;
    if (videoId == null || language == null) return;

    final base = '/subtitles/$videoId/${Uri.encodeComponent(language.code)}';
    final scriptCode = selectedScriptCode;

    Router.of(context).push(
      scriptCode == null ? base : '$base/${Uri.encodeComponent(scriptCode)}',
    );
  }

  @override
  Component build(BuildContext context) {
    final language = selectedLanguage;
    final scripts = selectedScripts;

    return div(
      classes: 'subtitle-hub-v2',
      [
        div(
          classes: 'subtitle-hub-hero',
          [
            div([
              p(classes: 'subtitle-hub-kicker', [.text('CLYVEN STUDIO')]),
              h1([.text('Subtitle Studio')]),
              p(classes: 'subtitle-hub-lead', [
                .text('一条时间轴，多语言、多文字表示。先选择视频，再决定语言与文字系统。'),
              ]),
            ]),
            div(classes: 'subtitle-hub-model', [
              span([.text('Video')]),
              b([.text('→')]),
              span([.text('Language')]),
              b([.text('→')]),
              span([.text('Script')]),
              b([.text('→')]),
              span([.text('Cue timeline')]),
            ]),
          ],
        ),

        if (loading)
          div(classes: 'subtitle-hub-state', [.text('正在读取视频…')])
        else if (error != null)
          div(classes: 'subtitle-hub-state is-error', [.text(error!)])
        else if (videos.isEmpty)
          div(classes: 'subtitle-hub-state', [.text('目前没有视频')])
        else
          div(
            classes: 'subtitle-hub-grid',
            [
              section(
                classes: 'subtitle-hub-section subtitle-video-section',
                [
                  _sectionHeader('01', '选择视频', '字幕轨始终属于一个具体视频。'),
                  div(classes: 'subtitle-video-stack', [
                    for (final video in videos)
                      button(
                        type: ButtonType.button,
                        classes: 'subtitle-video-choice ${selectedVideoId == video.id ? 'is-selected' : ''}',
                        onClick: () {
                          setState(() {
                            selectedVideoId = video.id;
                          });
                        },
                        [
                          span(classes: 'subtitle-video-choice-index', [
                            .text('#${video.id}'),
                          ]),
                          div(classes: 'subtitle-video-choice-copy', [
                            strong([.text(video.title)]),
                            span([.text(video.authorName)]),
                          ]),
                          span(classes: 'subtitle-choice-check', [.text('✓')]),
                        ],
                      ),
                  ]),
                ],
              ),

              section(
                classes: 'subtitle-hub-section subtitle-language-section',
                [
                  _sectionHeader('02', '选择语言', '直接读取 Glyphora 共享语言库，不再手填 language code。'),
                  div(classes: 'subtitle-language-search', [
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
                  div(classes: 'subtitle-language-grid-v2', [
                    for (final item in filteredLanguages)
                      button(
                        type: ButtonType.button,
                        classes: 'subtitle-language-choice ${language?.code == item.code ? 'is-selected' : ''}',
                        onClick: () => _selectLanguage(item),
                        [
                          span(classes: 'subtitle-language-flag', [.text(item.flag)]),
                          div(classes: 'subtitle-language-copy', [
                            strong([.text(item.nameOf('zh'))]),
                            span([.text(item.nameOf('en'))]),
                          ]),
                          code([.text(item.code)]),
                        ],
                      ),
                  ]),
                ],
              ),

              section(
                classes: 'subtitle-hub-section subtitle-script-section',
                [
                  _sectionHeader('03', '选择文字', '只显示当前语言在共享语言库中登记的文字系统。'),
                  if (language == null)
                    div(classes: 'subtitle-script-empty', [.text('先选择语言')])
                  else if (scripts.isEmpty)
                    div(classes: 'subtitle-script-empty', [
                      strong([.text(language.nameOf('zh'))]),
                      span([.text(' 的语言库目前还没有登记文字系统。仍可打开旧式语言轨。')]),
                    ])
                  else
                    div(classes: 'subtitle-script-grid-v2', [
                      for (final script in scripts)
                        button(
                          type: ButtonType.button,
                          classes: 'subtitle-script-choice ${selectedScriptCode == script.code ? 'is-selected' : ''}',
                          onClick: () {
                            setState(() {
                              selectedScriptCode = script.code;
                            });
                          },
                          [
                            div(classes: 'subtitle-script-card-top', [
                              span(classes: 'subtitle-script-sample', [
                                .text(script.sampleText),
                              ]),
                              code([.text(script.code)]),
                            ]),
                            strong([
                              .text(language.scriptNameOf(script.code, 'zh')),
                            ]),
                            span([
                              .text(script.isRtl ? 'RTL · 从右到左' : 'LTR · 从左到右'),
                            ]),
                          ],
                        ),
                    ]),
                  if (language != null && language.hasVariants)
                    div(classes: 'subtitle-variant-note', [
                      span(classes: 'subtitle-variant-note-icon', [.text('↳')]),
                      div([
                        strong([.text('语言变体已在语言库中登记')]),
                        p([
                          .text(
                            language.variants.map((variant) => variant.nameOf('zh')).join(' · '),
                          ),
                        ]),
                        small([
                          .text('当前 cy 后端轨道查询仍以 languageCode 为主，因此这里先展示，不伪造 variant 路由。'),
                        ]),
                      ]),
                    ]),
                ],
              ),
            ],
          ),

        if (!loading && error == null && videos.isNotEmpty)
          div(classes: 'subtitle-launch-dock', [
            div(classes: 'subtitle-launch-summary', [
              div([
                span([.text('VIDEO')]),
                strong([.text(selectedVideo?.title ?? '—')]),
              ]),
              div([
                span([.text('LANGUAGE')]),
                strong([
                  .text(
                    language == null ? '—' : '${language.flag} ${language.nameOf('zh')} · ${language.code}',
                  ),
                ]),
              ]),
              div([
                span([.text('SCRIPT')]),
                strong([
                  .text(
                    selectedScriptCode == null
                        ? 'Legacy / unspecified'
                        : '${language?.scriptNameOf(selectedScriptCode!, 'zh') ?? selectedScriptCode} · $selectedScriptCode',
                  ),
                ]),
              ]),
            ]),
            button(
              type: ButtonType.button,
              classes: 'subtitle-launch-button',
              onClick: selectedVideoId == null || language == null ? null : () => _openEditor(context),
              [
                span([.text('进入字幕工作台')]),
                b([.text('→')]),
              ],
            ),
          ]),
      ],
    );
  }

  Component _sectionHeader(String step, String title, String description) {
    return div(classes: 'subtitle-section-heading', [
      span(classes: 'subtitle-section-number', [.text(step)]),
      div([
        h2([.text(title)]),
        p([.text(description)]),
      ]),
    ]);
  }
}
