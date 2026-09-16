import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/studio_shell.dart';
import 'pages/dashboard_page.dart';
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
                return StudioShell(
                  child: child,
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
                    return const PlaceholderPage(
                      title: 'Subtitles',
                      description: '管理字幕轨、语言版本与字幕编辑。',
                    );
                  },
                ),
                Route(
                  path: '/dictionary',
                  title: 'Dictionary · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Dictionary',
                      description: '搜索与维护词条、释义、字形和例句。',
                    );
                  },
                ),
                Route(
                  path: '/dictionary/import',
                  title: 'Dictionary Import · Clyven Studio',
                  builder: (context, state) {
                    return const PlaceholderPage(
                      title: 'Dictionary Import',
                      description: 'Excel 导入、Preview 与正式写入。',
                    );
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