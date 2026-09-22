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
          _item(activePath: path, path: '/users', icon: '◎', label: '用户管理'),
          _item(
            activePath: path,
            path: '/subtitles',
            icon: 'CC',
            label: '全部字幕',
          ),
        ]),
      ]),
      div(classes: 'clyven-admin-main', [
        header(classes: 'clyven-admin-topbar', [
          div([
            span(classes: 'clyven-admin-kicker', [.text('CLYVEN INTERNAL')]),
            h1([.text(_title(path))]),
          ]),
          span(classes: 'clyven-admin-scope-badge', [.text('ADMIN')]),
        ]),
        main_(classes: 'clyven-admin-content', [child]),
      ]),
    ]);
  }

  Component _item({
    required String activePath,
    required String path,
    required String icon,
    required String label,
  }) {
    final active = activePath == path || activePath.startsWith('$path/');

    return Link(
      to: path,
      child: div(
        classes: 'clyven-admin-nav-item${active ? ' is-active' : ''}',
        [
          span(classes: 'clyven-admin-nav-icon', [.text(icon)]),
          span([.text(label)]),
        ],
      ),
    );
  }

  String _title(String path) {
    if (path.startsWith('/subtitles')) {
      return '字幕人工校对';
    }

    return '用户管理';
  }
}
