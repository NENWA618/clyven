import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class ReviewShell extends StatelessComponent {
  const ReviewShell({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) {
    final path = RouteState.of(context).location;

    return div(classes: 'glyphora-admin-shell review-shell', [
      aside(classes: 'glyphora-admin-sidebar review-sidebar', [
        div(classes: 'glyphora-admin-brand', [
          div(classes: 'glyphora-admin-brand-mark', [.text('C')]),
          div([
            strong([.text('Glyphora Review')]),
            span([.text(context.tr('Subtitle Staff Workspace', '字幕工作人员工作台'))]),
          ]),
        ]),
        nav(classes: 'glyphora-admin-nav', [
          Link(
            to: '/',
            child: div(
              classes:
                  'glyphora-admin-nav-item${path == '/' || path.startsWith('/tasks/') ? ' is-active' : ''}',
              [
                span(classes: 'glyphora-admin-nav-icon', [.text('CC')]),
                span([.text(context.tr('Work Queue', '工作队列'))]),
              ],
            ),
          ),
        ]),
      ]),
      div(classes: 'glyphora-admin-main review-main', [
        header(classes: 'glyphora-admin-topbar review-topbar', [
          div([
            span(classes: 'glyphora-admin-kicker', [.text(context.tr('GLYPHORA INTERNAL', 'GLYPHORA 内部'))]),
            h1([.text(context.tr('Subtitle Work Queue', '字幕工作队列'))]),
          ]),
          div(classes: 'review-topbar-actions', [
            const LanguageSwitcher(),
            const ThemeToggle(),
            span(classes: 'glyphora-admin-scope-badge', [.text('REVIEW')]),
          ]),
        ]),
        main_(classes: 'glyphora-admin-content review-content', [
          child,
        ]),
      ]),
    ]);
  }
}
