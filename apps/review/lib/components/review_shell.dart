import 'package:glyphora_web_l10n/web_l10n.dart';
import 'dart:html' as html;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class ReviewShell extends StatefulComponent {
  const ReviewShell({required this.child, super.key});

  final Component child;

  @override
  State<ReviewShell> createState() => _ReviewShellState();
}

class _ReviewShellState extends State<ReviewShell> {
  static const _storageKey = 'glyphora_review_theme';

  bool _isDark = true;

  @override
  void initState() {
    super.initState();

    final saved = html.window.localStorage[_storageKey];
    if (saved == 'light') {
      _isDark = false;
    } else if (saved == 'dark') {
      _isDark = true;
    } else {
      _isDark = html.window.matchMedia('(prefers-color-scheme: dark)').matches;
    }

    _applyTheme();
  }

  void _applyTheme() {
    html.document.documentElement?.setAttribute(
      'data-review-theme',
      _isDark ? 'dark' : 'light',
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });

    html.window.localStorage[_storageKey] = _isDark ? 'dark' : 'light';
    _applyTheme();
  }

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
            button(
              type: ButtonType.button,
              classes: 'review-theme-toggle',
              attributes: {
                'aria-label': _isDark ? context.tr('Switch to light mode', '切换到白天模式') : context.tr('Switch to dark mode', '切换到深夜模式'),
                'title': _isDark ? context.tr('Light mode', '白天模式') : context.tr('Dark mode', '深夜模式'),
              },
              onClick: _toggleTheme,
              [
                span(classes: 'review-theme-icon', [
                  .text(_isDark ? '☀' : '☾'),
                ]),
                span([.text(_isDark ? context.tr('Light mode', '白天模式') : context.tr('Dark mode', '深夜模式'))]),
              ],
            ),
            span(classes: 'glyphora-admin-scope-badge', [.text('REVIEW')]),
          ]),
        ]),
        main_(classes: 'glyphora-admin-content review-content', [
          component.child,
        ]),
      ]),
    ]);
  }
}
