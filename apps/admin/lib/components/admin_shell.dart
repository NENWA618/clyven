import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class AdminShell extends StatelessComponent {
  const AdminShell({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) {
    final path = RouteState.of(context).location;
    final pageTitle = path == '/script-conversion'
        ? context.tr('Script Conversion', '文字转换')
        : path == '/members'
        ? context.tr('Members & Permissions', '成员与权限')
        : context.tr('User Management', '用户管理');

    return div(classes: 'glyphora-admin-shell', [
      aside(classes: 'glyphora-admin-sidebar', [
        div(classes: 'glyphora-admin-brand', [
          div(classes: 'glyphora-admin-brand-mark', [.text('C')]),
          div([
            strong([.text('Glyphora Admin')]),
            span([.text(context.tr('Internal Console', '内部控制台'))]),
          ]),
        ]),
        nav(classes: 'glyphora-admin-nav', [
          Link(
            to: '/users',
            child: div(
              classes:
                  'glyphora-admin-nav-item${path == '/users' || path == '/' ? ' is-active' : ''}',
              [
                span(classes: 'glyphora-admin-nav-icon', [.text('U')]),
                span([.text(context.tr('User Management', '用户管理'))]),
              ],
            ),
          ),
          Link(
            to: '/members',
            child: div(
              classes:
                  'glyphora-admin-nav-item${path == '/members' ? ' is-active' : ''}',
              [
                span(classes: 'glyphora-admin-nav-icon', [.text('M')]),
                span([.text(context.tr('Members & Permissions', '成员与权限'))]),
              ],
            ),
          ),
          Link(
            to: '/script-conversion',
            child: div(
              classes:
                  'glyphora-admin-nav-item${path == '/script-conversion' ? ' is-active' : ''}',
              [
                span(classes: 'glyphora-admin-nav-icon', [.text('SC')]),
                span([.text(context.tr('Script Conversion', '文字转换'))]),
              ],
            ),
          ),
        ]),
      ]),
      div(classes: 'glyphora-admin-main', [
        header(classes: 'glyphora-admin-topbar', [
          div([
            span(classes: 'glyphora-admin-kicker', [.text(context.tr('GLYPHORA INTERNAL', 'GLYPHORA 内部'))]),
            h1([.text(pageTitle)]),
          ]),
          div(classes: 'review-topbar-actions', [
            const LanguageSwitcher(),
            span(classes: 'glyphora-admin-scope-badge', [.text('ADMIN')]),
          ]),
        ]),
        main_(classes: 'glyphora-admin-content', [child]),
      ]),
    ]);
  }
}
