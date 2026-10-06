import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/settings_header.dart';
import '../../l10n/web_l10n.dart';

class AboutPage extends StatelessComponent {
  const AboutPage({super.key});

  // Keep in sync with the version field in pubspec.yaml.
  static const String _version = '1.0.0';

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    return div(classes: 'settings-page', [
      SettingsHeader(eyebrow: l10n.settingsEyebrow, title: l10n.about),
      div(classes: 'about-brand', [
        div(classes: 'about-brand-bar', []),
        div(classes: 'about-brand-name', [.text('GLYPHORA')]),
        div(classes: 'about-brand-version', [
          .text(l10n.aboutVersion(_version)),
        ]),
      ]),
      div(classes: 'settings-card', [
        p([.text(l10n.aboutAppDescription)]),
      ]),
      div(classes: 'about-copyright', [.text(l10n.aboutCopyright)]),
    ]);
  }
}
