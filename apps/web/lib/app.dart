import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/client_shell.dart';
import 'components/word_lists_home_section.dart';
import 'l10n/web_l10n.dart';
import 'pages/explore_page.dart';
import 'pages/home_page.dart';
import 'pages/public_profile_page.dart';
import 'pages/search_page.dart';
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
      child: div(classes: 'glyphora-web', [
        Router(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return ClientShell(child: child);
              },
              routes: [
                Route(
                  path: '/',
                  title: 'Glyphora',
                  builder: (context, state) => const HomePage(),
                ),
                Route(
                  path: '/explore',
                  title: 'Explore · Glyphora',
                  builder: (context, state) => const ExplorePage(),
                ),
                Route(
                  path: '/search',
                  title: 'Search · Glyphora',
                  builder: (context, state) => const SearchPage(),
                ),
                Route(
                  path: '/wordlists',
                  title: 'Word lists · Glyphora',
                  builder: (context, state) => const WordListsHomeSection(),
                ),
                Route(
                  path: '/wordlists/:listId',
                  title: 'Word lists · Glyphora',
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
                  title: 'Watch · Glyphora',
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
                  path: '/profile/:userId',
                  title: 'Profile · Glyphora',
                  builder: (context, state) {
                    final userId = state.params['userId'] ?? '';
                    return PublicProfilePage(userId: userId);
                  },
                ),
                Route(
                  path: '/settings',
                  title: 'Settings · Glyphora',
                  builder: (context, state) => const SettingsPage(),
                ),
                Route(
                  path: '/settings/account',
                  title: 'Account & profile · Glyphora',
                  builder: (context, state) => const AccountSettingsPage(),
                ),
                Route(
                  path: '/settings/privacy',
                  title: 'Privacy · Glyphora',
                  builder: (context, state) => const PrivacySettingsPage(),
                ),
                Route(
                  path: '/settings/notifications',
                  title: 'Notifications · Glyphora',
                  builder: (context, state) => const NotificationSettingsPage(),
                ),
                Route(
                  path: '/settings/about',
                  title: 'About · Glyphora',
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
