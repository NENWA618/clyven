import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/client_shell.dart';
import 'pages/home_page.dart';
import 'pages/watch_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'clyven-web', [
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
                path: '/watch/:videoId',
                title: 'Watch · Clyven',
                builder: (context, state) {
                  final id = int.tryParse(state.params['videoId'] ?? '');
                  if (id == null) {
                    return div(classes: 'page-message error', [
                      .text('Invalid video id.'),
                    ]);
                  }
                  return WatchPage(videoId: id);
                },
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
