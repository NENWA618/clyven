import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class AdminShell extends StatelessComponent {
  const AdminShell({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) {
    final path = RouteState.of(context).location;

    return div(classes: 'clyven-admin-shell', [
      aside(classes: 'clyven-admin-sidebar', [
        div(classes: 'clyven-admin-brand', [
          div(classes: 'clyven-admin-brand-mark', [.text('C')]),
          div([
            strong([.text('Clyven Admin')]),
            span([.text('Internal Console')]),
          ]),
        ]),
        nav(classes: 'clyven-admin-nav', [
          Link(
            to: '/users',
            child: div(
              classes:
                  'clyven-admin-nav-item${path == '/users' || path == '/' ? ' is-active' : ''}',
              [
                span(classes: 'clyven-admin-nav-icon', [.text('◎')]),
                span([.text('用户管理')]),
              ],
            ),
          ),
        ]),
      ]),
      div(classes: 'clyven-admin-main', [
        header(classes: 'clyven-admin-topbar', [
          div([
            span(classes: 'clyven-admin-kicker', [.text('CLYVEN INTERNAL')]),
            h1([.text('用户管理')]),
          ]),
          span(classes: 'clyven-admin-scope-badge', [.text('ADMIN')]),
        ]),
        main_(classes: 'clyven-admin-content', [child]),
      ]),
    ]);
  }
}
