import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/studio_shell.dart';
import 'components/studio_auth_gate.dart';
import 'pages/dictionary/dictionary_import_page.dart';
import 'pages/subtitles/subtitles_page.dart';
import 'pages/subtitles/subtitle_editor_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/dictionary_page.dart';
import 'pages/home.dart';
import 'pages/placeholder_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(
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
                  title: 'Dashboard · Clyven Studio',
                  builder: (context, state) {
                    return const DashboardPage();
                  },
                ),
                Route(
                  path: '/videos',
                  title: 'Videos · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Videos',
                      description: '管理视频、状态、封面与发布信息。',
                    );
                  },
                ),
                Route(
                  path: '/subtitles',
                  title: 'Subtitles · Clyven Studio',
                  builder: (context, state) {
                    return const SubtitlesPage();
                  },
                ),
                Route(
                  path: '/subtitles/:videoId/:languageCode/:scriptCode',
                  title: 'Subtitle Editor · Clyven Studio',
                  builder: (context, state) {
                    final videoId = int.tryParse(
                      state.params['videoId'] ?? '',
                    );
                    final languageCode = state.params['languageCode'] ?? '';
                    final scriptCode = state.params['scriptCode'] ?? '';

                    if (videoId == null || languageCode.isEmpty || scriptCode.isEmpty) {
                      return const PlaceholderPage(
                        title: 'Subtitle Editor',
                        description: '无效的视频、语言或文字参数。',
                      );
                    }

                    return SubtitleEditorPage(
                      videoId: videoId,
                      languageCode: languageCode,
                      scriptCode: scriptCode,
                    );
                  },
                ),
                Route(
                  path: '/subtitles/:videoId/:languageCode',
                  title: 'Subtitle Editor · Clyven Studio',
                  builder: (context, state) {
                    final videoId = int.tryParse(
                      state.params['videoId'] ?? '',
                    );
                    final languageCode = state.params['languageCode'] ?? '';

                    if (videoId == null || languageCode.isEmpty) {
                      return const PlaceholderPage(
                        title: 'Subtitle Editor',
                        description: '无效的视频或语言参数。',
                      );
                    }

                    return SubtitleEditorPage(
                      videoId: videoId,
                      languageCode: languageCode,
                    );
                  },
                ),
                Route(
                  path: '/dictionary',
                  title: 'Dictionary · Clyven Studio',
                  builder: (context, state) {
                    return const DictionaryPage();
                  },
                ),
                Route(
                  path: '/dictionary/import',
                  title: 'Dictionary Import · Clyven Studio',
                  builder: (context, state) {
                    return const DictionaryImportPage();
                  },
                ),
                Route(
                  path: '/nom',
                  title: 'Nôm Tools · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Nôm Tools',
                      description: '国语字与喃字内容工具。',
                    );
                  },
                ),
                Route(
                  path: '/review',
                  title: 'Review · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Review',
                      description: '审核字幕、词典与发布内容。',
                    );
                  },
                ),
                Route(
                  path: '/settings',
                  title: 'Settings · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Settings',
                      description: 'Studio 与语言资源配置。',
                    );
                  },
                ),
                Route(
                  path: '/workbench',
                  title: 'Legacy Workbench · Clyven Studio',
                  builder: (context, state) {
                    return const Home();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
