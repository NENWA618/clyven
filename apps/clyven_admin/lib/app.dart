import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/admin_auth_gate.dart';
import 'components/admin_shell.dart';
import 'pages/users_page.dart';
import 'pages/script_conversion_page.dart';

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
                path: '/script-conversion',
                title: 'Script Conversion - Clyven Admin',
                builder: (context, state) => const ScriptConversionPage(),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
