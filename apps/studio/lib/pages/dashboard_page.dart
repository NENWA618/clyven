import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class DashboardPage extends StatelessComponent {
  const DashboardPage({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'dashboard-page',
      [
        div(
          classes: 'page-heading',
          [
            h1([.text(context.tr('Dashboard', '概览'))]),
            p([.text(context.tr('Overview of Glyphora content and language assets.', 'Glyphora 内容与语言资产总览。'))]),
          ],
        ),
        div(
          classes: 'dashboard-grid',
          [
            _card(
              title: context.tr('Videos', '视频'),
              value: '—',
              description: context.tr('Published and draft videos', '已发布与草稿视频'),
            ),
            _card(
              title: context.tr('Subtitles', '字幕'),
              value: '—',
              description: context.tr('Subtitle tracks and language versions', '字幕轨与语言版本'),
            ),
            _card(
              title: context.tr('Dictionary', '词典'),
              value: '835+',
              description: context.tr('Vietnamese dictionary entries', '越南语词典内容'),
            ),
            _card(
              title: context.tr('Review', '审核'),
              value: '—',
              description: context.tr('Content awaiting review', '等待审核的内容'),
            ),
          ],
        ),
      ],
    );
  }

  Component _card({
    required String title,
    required String value,
    required String description,
  }) {
    return div(
      classes: 'dashboard-card',
      [
        div(
          classes: 'dashboard-card-title',
          [.text(title)],
        ),
        div(
          classes: 'dashboard-card-value',
          [.text(value)],
        ),
        div(
          classes: 'dashboard-card-description',
          [.text(description)],
        ),
      ],
    );
  }
}
