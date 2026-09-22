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
            h1([.text('Dashboard')]),
            p([.text('Clyven 内容与语言资产总览。')]),
          ],
        ),
        div(
          classes: 'dashboard-grid',
          [
            _card(
              title: 'Videos',
              value: '—',
              description: '已发布与草稿视频',
            ),
            _card(
              title: 'Subtitles',
              value: '—',
              description: '字幕轨与语言版本',
            ),
            _card(
              title: 'Dictionary',
              value: '835+',
              description: '越南语词典内容',
            ),
            _card(
              title: 'Review',
              value: '—',
              description: '等待审核的内容',
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
