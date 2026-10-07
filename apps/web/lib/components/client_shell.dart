import 'dart:html' as html;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/studio_handoff.dart';
import 'notification_bell.dart';
import 'search_box.dart';
import 'web_avatar_upload.dart';

class ClientShell extends StatelessComponent {
  static const studioUrl = String.fromEnvironment(
    'GLYPHORA_STUDIO_URL',
    defaultValue: 'http://localhost:8083',
  );
  const ClientShell({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) {
    final path = RouteState.of(context).location;
    final l10n = context.l10n;
    final preference = WebL10n.of(context).preference;

    return div(classes: 'client-shell', [
      header(classes: 'client-header', [
        div(classes: 'client-header-inner', [
          Link(
            to: '/',
            child: div(classes: 'client-brand', [
              div(classes: 'client-brand-mark', [.text('C')]),
              div(classes: 'client-brand-copy', [
                strong([.text('Glyphora')]),
                span([.text(l10n.brandTagline)]),
              ]),
            ]),
          ),
          nav(classes: 'client-nav', [
            Link(
              to: '/',
              child: span(
                classes: 'client-nav-link${path == '/' ? ' active' : ''}',
                [.text(l10n.navHome)],
              ),
            ),
            Link(
              to: '/explore',
              child: span(
                classes:
                    'client-nav-link${path == '/explore' ? ' active' : ''}',
                [.text(l10n.navExplore)],
              ),
            ),
          ]),
          div(classes: 'client-header-actions', [
            a(href: studioUrl, events: {
              'click': (event) {
                final dynamic e = event;
                e.preventDefault();
                html.window.location.href = withPreferenceHandoff(
                  studioUrlWithSession(studioUrl),
                  preference,
                );
              },
            }, [
              span(classes: 'studio-entry-button', [.text(l10n.studio)]),
            ]),
            const SearchBox(),
            const LanguageSwitcher(),
            const ThemeToggle(),
            const NotificationBell(),
            WebAvatarUpload(),
          ]),
        ]),
      ]),
      main_(classes: 'client-main', [child]),
    ]);
  }
}
