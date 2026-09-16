import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class StudioShell extends StatelessComponent {
  const StudioShell({
    required this.child,
    super.key,
  });

  final Component child;

  @override
  Component build(BuildContext context) {
    final activePath = RouteState.of(context).location;

    return div(
      classes: 'studio-shell',
      [
        aside(
          classes: 'studio-sidebar',
          [
            div(
              classes: 'studio-brand',
              [
                div(
                  classes: 'studio-brand-mark',
                  [.text('C')],
                ),
                div(
                  [
                    div(
                      classes: 'studio-brand-name',
                      [.text('Clyven')],
                    ),
                    div(
                      classes: 'studio-brand-label',
                      [.text('Studio')],
                    ),
                  ],
                ),
              ],
            ),
            nav(
              classes: 'studio-nav',
              [
                _navItem(
                  activePath: activePath,
                  path: '/',
                  icon: '⌂',
                  label: 'Dashboard',
                ),
                _navSection('Content'),
                _navItem(
                  activePath: activePath,
                  path: '/videos',
                  icon: '▶',
                  label: 'Videos',
                ),
                _navItem(
                  activePath: activePath,
                  path: '/subtitles',
                  icon: 'CC',
                  label: 'Subtitles',
                ),
                _navSection('Language'),
                _navItem(
                  activePath: activePath,
                  path: '/dictionary',
                  icon: '文',
                  label: 'Dictionary',
                ),
                _navItem(
                  activePath: activePath,
                  path: '/dictionary/import',
                  icon: '↑',
                  label: 'Import',
                ),
                _navItem(
                  activePath: activePath,
                  path: '/nom',
                  icon: '喃',
                  label: 'Nôm Tools',
                ),
                _navSection('Workflow'),
                _navItem(
                  activePath: activePath,
                  path: '/review',
                  icon: '✓',
                  label: 'Review',
                ),
                div(classes: 'studio-nav-spacer', []),
                _navItem(
                  activePath: activePath,
                  path: '/settings',
                  icon: '⚙',
                  label: 'Settings',
                ),
              ],
            ),
          ],
        ),
        div(
          classes: 'studio-main',
          [
            header(
              classes: 'studio-topbar',
              [
                div(
                  classes: 'studio-topbar-title',
                  [.text(_titleForPath(activePath))],
                ),
                div(
                  classes: 'studio-topbar-actions',
                  [
                    span(
                      classes: 'studio-environment',
                      [.text('Production')],
                    ),
                    div(
                      classes: 'studio-avatar',
                      [.text('C')],
                    ),
                  ],
                ),
              ],
            ),
            main_(
              classes: 'studio-content',
              [child],
            ),
          ],
        ),
      ],
    );
  }

  Component _navSection(String label) {
    return div(
      classes: 'studio-nav-section',
      [.text(label)],
    );
  }

  Component _navItem({
    required String activePath,
    required String path,
    required String icon,
    required String label,
  }) {
    final active = path == '/'
        ? activePath == '/'
        : activePath == path || activePath.startsWith('$path/');

    return div(
      classes: 'studio-nav-item${active ? ' active' : ''}',
      [
        Link(
          to: path,
          child: div(
            classes: 'studio-nav-link',
            [
              span(
                classes: 'studio-nav-icon',
                [.text(icon)],
              ),
              span(
                classes: 'studio-nav-label',
                [.text(label)],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _titleForPath(String path) {
    if (path.startsWith('/dictionary/import')) {
      return 'Dictionary Import';
    }

    if (path.startsWith('/dictionary')) {
      return 'Dictionary';
    }

    if (path.startsWith('/subtitles')) {
      return 'Subtitles';
    }

    if (path.startsWith('/videos')) {
      return 'Videos';
    }

    if (path.startsWith('/nom')) {
      return 'Nôm Tools';
    }

    if (path.startsWith('/review')) {
      return 'Review';
    }

    if (path.startsWith('/settings')) {
      return 'Settings';
    }

    return 'Dashboard';
  }
}