import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/client_shell.dart';
import 'l10n/web_l10n.dart';
import 'pages/explore_page.dart';
import 'pages/home_page.dart';
import 'pages/notifications_page.dart';
import 'pages/settings/about_page.dart';
import 'pages/settings/account_settings_page.dart';
import 'pages/settings/notification_settings_page.dart';
import 'pages/settings/privacy_settings_page.dart';
import 'pages/settings/settings_page.dart';
import 'pages/watch_page.dart';
import 'pages/word_list_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return WebLocaleRoot(
      child: div(classes: 'clyven-web', [
        Router(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return ClientShell(child: child);
              },
              routes: [
                Route(
                  path: '/',
                  title: 'Clyven',
                  builder: (context, state) => const HomePage(),
                ),
                Route(
                  path: '/explore',
                  title: 'Explore · Clyven',
                  builder: (context, state) => const ExplorePage(),
                ),
                Route(
                  path: '/wordlists/:listId',
                  title: 'Word lists · Clyven',
                  builder: (context, state) {
                    final id = int.tryParse(state.params['listId'] ?? '');
                    if (id == null) {
                      return div(classes: 'page-message error', [
                        .text(context.l10n.wordListNotFound),
                      ]);
                    }
                    return WordListPage(listId: id);
                  },
                ),
                Route(
                  path: '/watch/:videoId',
                  title: 'Watch · Clyven',
                  builder: (context, state) {
                    final id = int.tryParse(state.params['videoId'] ?? '');
                    if (id == null) {
                      return div(classes: 'page-message error', [
                        .text(context.l10n.invalidVideoId),
                      ]);
                    }
                    return WatchPage(videoId: id);
                  },
                ),
                Route(
                  path: '/notifications',
                  title: 'Echoes · Clyven',
                  builder: (context, state) => const NotificationsPage(),
                ),
                Route(
                  path: '/settings',
                  title: 'Settings · Clyven',
                  builder: (context, state) => const SettingsPage(),
                ),
                Route(
                  path: '/settings/account',
                  title: 'Account & profile · Clyven',
                  builder: (context, state) => const AccountSettingsPage(),
                ),
                Route(
                  path: '/settings/privacy',
                  title: 'Privacy · Clyven',
                  builder: (context, state) => const PrivacySettingsPage(),
                ),
                Route(
                  path: '/settings/notifications',
                  title: 'Notifications · Clyven',
                  builder: (context, state) => const NotificationSettingsPage(),
                ),
                Route(
                  path: '/settings/about',
                  title: 'About · Clyven',
                  builder: (context, state) => const AboutPage(),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
