import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class PlaceholderPage extends StatelessComponent {
  const PlaceholderPage({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'placeholder-page',
      [
        div(
          classes: 'page-heading',
          [
            h1([.text(title)]),
            p([.text(description)]),
          ],
        ),
        div(
          classes: 'placeholder-card',
          [
            .text(context.tr('This workspace will be connected next.', '该工作区即将接入。')),
          ],
        ),
      ],
    );
  }
}
