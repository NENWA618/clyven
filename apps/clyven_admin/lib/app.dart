import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/admin_auth_gate.dart';
import 'components/admin_shell.dart';
import 'pages/subtitles/subtitle_editor_page.dart';
import 'pages/subtitles/subtitles_page.dart';
import 'pages/users_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'admin-app', [
      Router(
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return AdminAuthGate(child: AdminShell(child: child));
            },
            routes: [
              Route(
                path: '/',
                title: 'Users · Clyven Admin',
                builder: (context, state) => const UsersPage(),
              ),
              Route(
                path: '/users',
                title: 'Users · Clyven Admin',
                builder: (context, state) => const UsersPage(),
              ),
              Route(
                path: '/subtitles',
                title: 'Subtitles · Clyven Admin',
                builder: (context, state) => const SubtitlesPage(),
              ),
              Route(
                path: '/subtitles/:videoId/:languageCode/:scriptCode',
                title: 'Subtitle Editor · Clyven Admin',
                builder: (context, state) {
                  final videoId = int.tryParse(state.params['videoId'] ?? '');
                  final languageCode = state.params['languageCode'] ?? '';
                  final scriptCode = state.params['scriptCode'] ?? '';

                  if (videoId == null ||
                      languageCode.isEmpty ||
                      scriptCode.isEmpty) {
                    return div(classes: 'admin-users-state', [
                      .text('无效的字幕编辑参数'),
                    ]);
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
                title: 'Subtitle Editor · Clyven Admin',
                builder: (context, state) {
                  final videoId = int.tryParse(state.params['videoId'] ?? '');
                  final languageCode = state.params['languageCode'] ?? '';

                  if (videoId == null || languageCode.isEmpty) {
                    return div(classes: 'admin-users-state', [
                      .text('无效的字幕编辑参数'),
                    ]);
                  }

                  return SubtitleEditorPage(
                    videoId: videoId,
                    languageCode: languageCode,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
