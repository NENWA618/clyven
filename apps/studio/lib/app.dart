import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/studio_shell.dart';
import 'components/studio_auth_gate.dart';
import 'pages/dictionary/dictionary_import_page.dart';
import 'pages/subtitles/subtitles_page.dart';
import 'package:glyphora_subtitle_editor/subtitle_editor.dart';
import 'pages/dashboard_page.dart';
import 'pages/dictionary_page.dart';
import 'pages/home.dart';
import 'pages/placeholder_page.dart';
import 'pages/video_management_page.dart';
import 'pages/video_edit_page.dart';
import 'pages/comments_management_page.dart';
import 'services/studio_client.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return WebLocaleRoot(
      child: div(
      classes: 'app',
      [
        Router(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return StudioAuthGate(
                  child: StudioShell(
                    child: child,
                  ),
                );
              },
              routes: [
                Route(
                  path: '/',
                  title: 'Dashboard · Glyphora Studio',
                  builder: (context, state) {
                    return const DashboardPage();
                  },
                ),
                Route(
                  path: '/videos/:videoId/edit',
                  title: 'Edit video · Glyphora Studio',
                  builder: (context, state) {
                    final videoId = int.tryParse(
                      state.params['videoId'] ?? '',
                    );

                    if (videoId == null) {
                      return PlaceholderPage(
                        title: context.tr('Edit video', '编辑视频'),
                        description: context.tr('Invalid video ID.', '无效的视频 ID。'),
                      );
                    }

                    return VideoEditPage(videoId: videoId);
                  },
                ),
                Route(
                  path: '/videos',
                  title: 'Videos · Glyphora Studio',
                  builder: (context, state) {
                    return const VideoManagementPage();
                  },
                ),
                Route(
                  path: '/comments',
                  title: 'Comments · Glyphora Studio',
                  builder: (context, state) {
                    return const CommentsManagementPage();
                  },
                ),
                Route(
                  path: '/subtitles',
                  title: 'Subtitles · Glyphora Studio',
                  builder: (context, state) {
                    return const SubtitlesPage();
                  },
                ),
                Route(
                  path: '/subtitles/:videoId/:languageCode/:scriptCode',
                  title: 'Subtitle Editor · Glyphora Studio',
                  builder: (context, state) {
                    final videoId = int.tryParse(
                      state.params['videoId'] ?? '',
                    );
                    final languageCode = state.params['languageCode'] ?? '';
                    final scriptCode = state.params['scriptCode'] ?? '';

                    if (videoId == null || languageCode.isEmpty || scriptCode.isEmpty) {
                      return PlaceholderPage(
                        title: context.tr('Subtitle Editor', '字幕编辑器'),
                        description: context.tr('Invalid video, language or script parameters.', '无效的视频、语言或文字参数。'),
                      );
                    }

                    return SubtitleEditorPage(
                      client: studioClient,
                      videoId: videoId,
                      languageCode: languageCode,
                      scriptCode: scriptCode,
                    );
                  },
                ),
                Route(
                  path: '/subtitles/:videoId/:languageCode',
                  title: 'Subtitle Editor · Glyphora Studio',
                  builder: (context, state) {
                    final videoId = int.tryParse(
                      state.params['videoId'] ?? '',
                    );
                    final languageCode = state.params['languageCode'] ?? '';

                    if (videoId == null || languageCode.isEmpty) {
                      return PlaceholderPage(
                        title: context.tr('Subtitle Editor', '字幕编辑器'),
                        description: context.tr('Invalid video or language parameters.', '无效的视频或语言参数。'),
                      );
                    }

                    return SubtitleEditorPage(
                      client: studioClient,
                      videoId: videoId,
                      languageCode: languageCode,
                    );
                  },
                ),
                Route(
                  path: '/dictionary',
                  title: 'Dictionary · Glyphora Studio',
                  builder: (context, state) {
                    return const DictionaryPage();
                  },
                ),
                Route(
                  path: '/dictionary/import',
                  title: 'Dictionary Import · Glyphora Studio',
                  builder: (context, state) {
                    return const DictionaryImportPage();
                  },
                ),
                Route(
                  path: '/nom',
                  title: 'Nôm Tools · Glyphora Studio',
                  builder: (context, state) {
                    return PlaceholderPage(
                      title: context.tr('Nôm Tools', '喃字工具'),
                      description: context.tr('Content tools for Quốc ngữ and Nôm.', '国语字与喃字内容工具。'),
                    );
                  },
                ),
                Route(
                  path: '/review',
                  title: 'Review · Glyphora Studio',
                  builder: (context, state) {
                    return PlaceholderPage(
                      title: context.tr('Review', '审核'),
                      description: context.tr('Review subtitles, dictionary entries and published content.', '审核字幕、词典与发布内容。'),
                    );
                  },
                ),
                Route(
                  path: '/settings',
                  title: 'Settings · Glyphora Studio',
                  builder: (context, state) {
                    return PlaceholderPage(
                      title: context.tr('Settings', '设置'),
                      description: context.tr('Studio and language resource settings.', 'Studio 与语言资源配置。'),
                    );
                  },
                ),
                Route(
                  path: '/workbench',
                  title: 'Legacy Workbench · Glyphora Studio',
                  builder: (context, state) {
                    return const Home();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    );
  }
}
