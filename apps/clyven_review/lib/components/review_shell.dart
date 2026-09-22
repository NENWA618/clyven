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
  static const _storageKey = 'clyven_review_theme';

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

    return div(classes: 'clyven-admin-shell review-shell', [
      aside(classes: 'clyven-admin-sidebar review-sidebar', [
        div(classes: 'clyven-admin-brand', [
          div(classes: 'clyven-admin-brand-mark', [.text('C')]),
          div([
            strong([.text('Clyven Review')]),
            span([.text('Subtitle Staff Workspace')]),
          ]),
        ]),
        nav(classes: 'clyven-admin-nav', [
          Link(
            to: '/',
            child: div(
              classes:
                  'clyven-admin-nav-item${path == '/' || path.startsWith('/tasks/') ? ' is-active' : ''}',
              [
                span(classes: 'clyven-admin-nav-icon', [.text('CC')]),
                span([.text('工作队列')]),
              ],
            ),
          ),
        ]),
      ]),
      div(classes: 'clyven-admin-main review-main', [
        header(classes: 'clyven-admin-topbar review-topbar', [
          div([
            span(classes: 'clyven-admin-kicker', [.text('CLYVEN INTERNAL')]),
            h1([.text('字幕工作队列')]),
          ]),
          div(classes: 'review-topbar-actions', [
            button(
              type: ButtonType.button,
              classes: 'review-theme-toggle',
              attributes: {
                'aria-label': _isDark ? '切换到白天模式' : '切换到深夜模式',
                'title': _isDark ? '白天模式' : '深夜模式',
              },
              onClick: _toggleTheme,
              [
                span(classes: 'review-theme-icon', [
                  .text(_isDark ? '☀' : '☾'),
                ]),
                span([.text(_isDark ? '白天模式' : '深夜模式')]),
              ],
            ),
            span(classes: 'clyven-admin-scope-badge', [.text('REVIEW')]),
          ]),
        ]),
        main_(classes: 'clyven-admin-content review-content', [
          component.child,
        ]),
      ]),
    ]);
  }
}
