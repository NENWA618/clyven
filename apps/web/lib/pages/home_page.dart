import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../components/language_category_home_section.dart';
import '../l10n/web_l10n.dart';

class HomePage extends StatelessComponent {
  const HomePage({super.key});

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    return div(classes: 'home-page', [
      section(classes: 'hero', [
        div(classes: 'hero-copy', [
          span(classes: 'hero-eyebrow', [.text('GLYPHORA WEB')]),
          h1([.text(l10n.heroTitle)]),
          p([.text(l10n.heroBody)]),
        ]),
        div(classes: 'hero-badge-stack', [
          span([.text(l10n.badgeVideo)]),
          span([.text(l10n.badgeSubtitles)]),
          span([.text(l10n.badgeScripts)]),
        ]),
      ]),
      LanguageCategoryHomeSection(),
    ]);
  }
}
