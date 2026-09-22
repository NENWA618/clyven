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
            .text('This workspace will be connected next.'),
          ],
        ),
      ],
    );
  }
}
