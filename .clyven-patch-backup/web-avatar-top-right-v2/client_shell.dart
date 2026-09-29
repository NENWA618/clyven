import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'web_avatar_upload.dart';

class ClientShell extends StatelessComponent {
  static const studioUrl = String.fromEnvironment(
    'CLYVEN_STUDIO_URL',
    defaultValue: 'http://localhost:8083',
  );
  const ClientShell({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) {
    final path = RouteState.of(context).location;

    return div(classes: 'client-shell', [
      header(classes: 'client-header', [
        div(classes: 'client-header-inner', [
          Link(
            to: '/',
            child: div(classes: 'client-brand', [
              div(classes: 'client-brand-mark', [.text('C')]),
              div(classes: 'client-brand-copy', [
                strong([.text('Clyven')]),
                span([.text('Watch across languages')]),
              ]),
            ]),
          ),
          nav(classes: 'client-nav', [
            Link(
              to: '/',
              child: span(
                classes: 'client-nav-link${path == '/' ? ' active' : ''}',
                [.text('Home')],
              ),
            ),
            span(classes: 'client-nav-link muted', [.text('Explore')]),
            span(classes: 'client-nav-link muted', [.text('Languages')]),
          ]),
          div(classes: 'client-header-actions', [
            a(href: studioUrl, [
              span(classes: 'studio-entry-button', [.text('Studio')]),
            ]),
            div(classes: 'client-search-placeholder', [
              .text('Search coming next'),
            ]),
            div(classes: 'client-avatar', [.text('C')]),
          ]),
        ]),
        WebAvatarUpload(),
      ]),
      main_(classes: 'client-main', [child]),
    ]);
  }
}
