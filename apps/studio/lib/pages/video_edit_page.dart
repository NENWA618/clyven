import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:glyphora_subtitle_editor/subtitle_editor.dart';
import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/studio_client.dart';

class VideoEditPage extends StatefulComponent {
  const VideoEditPage({
    required this.videoId,
    super.key,
  });

  final int videoId;

  @override
  State<VideoEditPage> createState() => _VideoEditPageState();
}

class _VideoEditPageState extends State<VideoEditPage> {
  Video? video;

  bool loading = true;
  bool saving = false;

  String? error;
  String? savedMessage;
  String? videoUrl;

  String title = '';
  String description = '';
  String category = 'general';
  String languageCode = 'auto';
  String tagsText = '';
  bool isPublic = true;

  String languageSearch = '';

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
      final loaded = await studioClient.video.getVideo(component.videoId);

      if (loaded == null) {
        throw Exception(trNow('The video does not exist or this account has no access.', '视频不存在，或当前账号无权访问。'));
      }

      final url = await studioClient.video.getVideoUrl(
        path: loaded.videoStorageKey,
      );

      if (!mounted) return;

      setState(() {
        video = loaded;
        videoUrl = url;
        title = loaded.title;
        description = loaded.description;
        category = loaded.category;
        final loadedLanguageCode = loaded.languageCode?.trim();
        languageCode = loadedLanguageCode == null || loadedLanguageCode.isEmpty
            ? 'auto'
            : loadedLanguageCode.toLowerCase();
        tagsText = loaded.tags.join(',');
        isPublic = loaded.isPublic;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  Future<void> _save() async {
    if (saving) return;

    if (title.trim().isEmpty) {
      setState(() {
        error = trNow('The video title is required', '视频标题不能为空');
        savedMessage = null;
      });
      return;
    }

    final tags = tagsText
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);

    setState(() {
      saving = true;
      error = null;
      savedMessage = null;
    });

    try {
      final updated = await studioClient.video.updateMetadata(
        videoId: component.videoId,
        title: title.trim(),
        description: description.trim(),
        category: category.trim(),
        languageCode: languageCode.trim(),
        tags: tags,
        isPublic: isPublic,
      );

      if (!mounted) return;

      setState(() {
        video = updated;
        savedMessage = trNow('Saved', '已保存');
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  Component _field(
    BuildContext context,
    String label,
    String value,
    String placeholder,
    void Function(String) onChanged,
  ) {
    return div(
      classes: 'sv-field',
      [
        span(classes: 'sv-label', [.text(label)]),
        input<String>(
          type: InputType.text,
          attributes: {
            'value': value,
            'placeholder': placeholder,
          },
          events: events<String>(
            onInput: onChanged,
          ),
        ),
      ],
    );
  }

  Component _languageField(BuildContext context) {
    final query = languageSearch.trim().toLowerCase();

    final matches = LanguageConfig.allLanguages
        .where((language) {
          if (query.isEmpty) return false;

          if (language.code.toLowerCase().contains(query)) {
            return true;
          }

          return language.names.values.any(
            (name) => name.toLowerCase().contains(query),
          );
        })
        .take(20)
        .toList(growable: false);

    final selected = languageCode == 'auto' ? null : LanguageConfig.findByCode(languageCode);

    return div(
      classes: 'sv-field sv-edit-language-field',
      [
        span(classes: 'sv-label', [.text(context.tr('Language', '语言'))]),
        div(
          classes: 'sv-edit-language-current',
          [
            span(classes: 'sv-edit-language-flag', [
              .text(selected?.flag ?? '🌐'),
            ]),
            div([
              strong([
                .text(
                  languageCode == 'auto' ? context.tr('Auto detect', '自动识别') : selected?.nameOf(context.lang.name) ?? languageCode,
                ),
              ]),
              span([
                .text(languageCode),
              ]),
            ]),
          ],
        ),
        input<String>(
          type: InputType.text,
          attributes: {
            'value': languageSearch,
            'placeholder': context.tr('Search language, native name or code...', '搜索语言、本地名称或代码...'),
          },
          events: events<String>(
            onInput: (value) => setState(() => languageSearch = value),
          ),
        ),
        if (query.isNotEmpty)
          div(
            classes: 'sv-edit-language-results',
            [
              if ('auto detect'.contains(query) || 'auto'.contains(query))
                button(
                  classes: 'sv-edit-language-option',
                  onClick: () => setState(() {
                    languageCode = 'auto';
                    languageSearch = '';
                  }),
                  [
                    span([.text('🌐')]),
                    strong([.text(context.tr('Auto detect', '自动识别'))]),
                    small([.text('auto')]),
                  ],
                ),
              for (final language in matches)
                button(
                  classes: 'sv-edit-language-option',
                  onClick: () => setState(() {
                    languageCode = language.code;
                    languageSearch = '';
                  }),
                  [
                    span([.text(language.flag)]),
                    strong([.text(language.nameOf(context.lang.name))]),
                    small([.text(language.code)]),
                  ],
                ),
              if (matches.isEmpty && !('auto detect'.contains(query) || 'auto'.contains(query)))
                div(
                  classes: 'sv-edit-language-empty',
                  [.text(context.tr('No matching language', '没有匹配的语言'))],
                ),
            ],
          ),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    if (loading) {
      return div(
        classes: 'sv-video-edit-page',
        [
          a(
            href: '/videos',
            classes: 'sv-edit-page-back',
            [.text(context.tr('← Videos', '← 视频'))],
          ),
          div(
            classes: 'sv-edit-page-loading',
            [.text(context.tr('Loading video...', '正在加载视频...'))],
          ),
        ],
      );
    }

    if (error != null && video == null) {
      return div(
        classes: 'sv-video-edit-page',
        [
          a(
            href: '/videos',
            classes: 'sv-edit-page-back',
            [.text(context.tr('← Videos', '← 视频'))],
          ),
          div(
            classes: 'sv-edit-page-error',
            [
              h2([.text(context.tr('Unable to open video', '无法打开视频'))]),
              p([.text(error!)]),
            ],
          ),
        ],
      );
    }

    final currentVideo = video!;

    return div(
      classes: 'sv-video-edit-page',
      [
        div(
          classes: 'sv-video-edit-topbar',
          [
            div([
              a(
                href: '/videos',
                classes: 'sv-edit-page-back',
                [.text(context.tr('← Videos', '← 视频'))],
              ),
              h1([.text(currentVideo.title)]),
              p([.text(context.tr('Video details', '视频详情'))]),
            ]),
            div(
              classes: 'sv-video-edit-status',
              [
                if (savedMessage != null)
                  span(classes: 'sv-video-edit-saved', [
                    .text(savedMessage!),
                  ]),
                span(
                  classes: 'sv-visibility ${isPublic ? 'is-public' : 'is-private'}',
                  [.text(isPublic ? context.tr('Public', '公开') : context.tr('Private', '私密'))],
                ),
              ],
            ),
          ],
        ),
        div(
          classes: 'sv-video-edit-layout',
          [
            div(
              classes: 'sv-video-edit-player-column',
              [
                if (videoUrl != null)
                  SubtitleVideoPanel(
                    videoUrl: videoUrl!,
                    captionText: null,
                    captionCueStartMs: null,
                    karaokeSegments: const [],
                    onTimeUpdate: () {},
                  )
                else
                  div(
                    classes: 'sv-video-edit-player-error',
                    [.text(context.tr('Video preview unavailable', '无法预览视频'))],
                  ),
              ],
            ),
            div(
              classes: 'sv-video-edit-form',
              [
                _field(
                  context,
                  context.tr('Title', '标题'),
                  title,
                  context.tr('Video title', '视频标题'),
                  (value) => setState(() => title = value),
                ),
                _field(
                  context,
                  context.tr('Description', '简介'),
                  description,
                  context.tr('Video description', '视频简介'),
                  (value) => setState(() => description = value),
                ),
                div(
                  classes: 'sv-two-columns',
                  [
                    _field(
                      context,
                      context.tr('Category', '分类'),
                      category,
                      'general',
                      (value) => setState(() => category = value),
                    ),
                    _languageField(context),
                  ],
                ),
                _field(
                  context,
                  context.tr('Tags', '标签'),
                  tagsText,
                  'language,vlog,podcast',
                  (value) => setState(() => tagsText = value),
                ),
                div(
                  classes: 'sv-field',
                  [
                    span(classes: 'sv-label', [.text(context.tr('Visibility', '可见性'))]),
                    div(
                      classes: 'sv-segmented',
                      [
                        button(
                          classes: 'sv-segment ${isPublic ? 'active' : ''}',
                          onClick: saving ? null : () => setState(() => isPublic = true),
                          [.text(context.tr('Public', '公开'))],
                        ),
                        button(
                          classes: 'sv-segment ${!isPublic ? 'active' : ''}',
                          onClick: saving ? null : () => setState(() => isPublic = false),
                          [.text(context.tr('Private', '私密'))],
                        ),
                      ],
                    ),
                  ],
                ),
                if (error != null)
                  div(
                    classes: 'sv-upload-message',
                    [.text(error!)],
                  ),
                div(
                  classes: 'sv-video-edit-actions',
                  [
                    a(
                      href: '/videos',
                      classes: 'sv-secondary-button',
                      [.text(context.tr('Cancel', '取消'))],
                    ),
                    button(
                      classes: 'sv-primary-button',
                      attributes: saving ? {'disabled': 'disabled'} : null,
                      onClick: saving ? null : _save,
                      [
                        .text(saving ? context.tr('Saving...', '保存中...') : context.tr('Save changes', '保存更改')),
                      ],
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
}
