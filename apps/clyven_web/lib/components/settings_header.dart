import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class SettingsHeader extends StatelessComponent {
  const SettingsHeader({
    required this.eyebrow,
    required this.title,
    this.backTo = '/settings',
    super.key,
  });

  final String eyebrow;
  final String title;
  final String backTo;

  @override
  Component build(BuildContext context) {
    return div(classes: 'settings-header', [
      Link(
        to: backTo,
        classes: 'settings-back-button',
        child: span([.text('←')]),
      ),
      div(classes: 'settings-header-copy', [
        div(classes: 'settings-eyebrow', [.text(eyebrow)]),
        h1([.text(title)]),
      ]),
    ]);
  }
}
