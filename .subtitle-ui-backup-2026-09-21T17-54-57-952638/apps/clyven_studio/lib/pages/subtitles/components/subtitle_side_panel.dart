import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleSidePanel extends StatelessComponent {
  const SubtitleSidePanel({
    required this.languageCode,
    required this.cueCount,
    super.key,
  });

  final String languageCode;
  final int cueCount;

  @override
  Component build(BuildContext context) {
    return aside(
      classes: 'subtitle-editor-side',
      [
        div(
          classes: 'subtitle-side-card',
          [
            h3([
              .text('Track'),
            ]),
            div(
              classes: 'subtitle-side-row',
              [
                span([
                  .text('Language'),
                ]),
                strong([
                  .text(languageCode),
                ]),
              ],
            ),
            div(
              classes: 'subtitle-side-row',
              [
                span([
                  .text('Cues'),
                ]),
                strong([
                  .text('$cueCount'),
                ]),
              ],
            ),
          ],
        ),
        div(
          classes: 'subtitle-side-card',
          [
            h3([
              .text('Editor'),
            ]),
            p([
              .text(
                'Subtitle editing workspace',
              ),
            ]),
          ],
        ),
      ],
    );
  }
}