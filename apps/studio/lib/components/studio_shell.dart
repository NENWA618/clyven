import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'upload_status_bar.dart';

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
                      [.text('Glyphora')],
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
                  label: context.tr('Dashboard', '概览'),
                ),
                _navSection(context.tr('Content', '内容')),
                _navItem(
                  activePath: activePath,
                  path: '/videos',
                  icon: '▶',
                  label: context.tr('Videos', '视频'),
                ),
                _navItem(
                  activePath: activePath,
                  path: '/comments',
                  icon: '☰',
                  label: context.tr('Comments', '评论'),
                ),
                _navItem(
                  activePath: activePath,
                  path: '/subtitles',
                  icon: 'CC',
                  label: context.tr('Subtitles', '字幕'),
                ),
                _navSection(context.tr('Language', '语言')),
                _navItem(
                  activePath: activePath,
                  path: '/dictionary',
                  icon: '文',
                  label: context.tr('Dictionary', '词典'),
                ),
                _navItem(
                  activePath: activePath,
                  path: '/dictionary/import',
                  icon: '↑',
                  label: context.tr('Import', '导入'),
                ),
                _navItem(
                  activePath: activePath,
                  path: '/nom',
                  icon: '喃',
                  label: context.tr('Nôm Tools', '喃字工具'),
                ),
                _navSection(context.tr('Workflow', '工作流')),
                _navItem(
                  activePath: activePath,
                  path: '/review',
                  icon: '✓',
                  label: context.tr('Review', '审核'),
                ),
                div(classes: 'studio-nav-spacer', []),
                _navItem(
                  activePath: activePath,
                  path: '/settings',
                  icon: '⚙',
                  label: context.tr('Settings', '设置'),
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
                  [.text(_titleForPath(context, activePath))],
                ),
                div(
                  classes: 'studio-topbar-actions',
                  [
                    const LanguageSwitcher(),
                    span(
                      classes: 'studio-environment',
                      [.text(context.tr('Production', '生产环境'))],
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
            const UploadStatusBar(),
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
    final active = path == '/' ? activePath == '/' : activePath == path || activePath.startsWith('$path/');

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

  String _titleForPath(BuildContext context, String path) {
    if (path.startsWith('/dictionary/import')) {
      return context.tr('Dictionary Import', '词典导入');
    }

    if (path.startsWith('/dictionary')) {
      return context.tr('Dictionary', '词典');
    }

    if (path.startsWith('/subtitles')) {
      return context.tr('Subtitles', '字幕');
    }

    if (path.startsWith('/videos')) {
      return context.tr('Videos', '视频');
    }
    if (path.startsWith('/comments')) {
      return context.tr('Comments', '评论');
    }

    if (path.startsWith('/nom')) {
      return context.tr('Nôm Tools', '喃字工具');
    }

    if (path.startsWith('/review')) {
      return context.tr('Review', '审核');
    }

    if (path.startsWith('/settings')) {
      return context.tr('Settings', '设置');
    }

    return context.tr('Dashboard', '概览');
  }
}
