import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleSidePanel extends StatelessComponent {
  const SubtitleSidePanel({
    required this.languageCode,
    required this.cueCount,
    this.scriptCode,
    super.key,
  });

  final String languageCode;
  final String? scriptCode;
  final int cueCount;

  @override
  Component build(BuildContext context) {
    final language = LanguageConfig.findByCode(languageCode);
    final script = scriptCode == null
        ? null
        : ScriptConfig.findByCode(scriptCode!);

    return aside(classes: 'subtitle-editor-side subtitle-inspector-v2', [
      div(classes: 'subtitle-inspector-head', [
        span(classes: 'subtitle-inspector-eyebrow', [.text('TRACK')]),
        h3([.text('字幕轨信息')]),
      ]),
      div(classes: 'subtitle-inspector-language', [
        span(classes: 'subtitle-inspector-flag', [
          .text(language?.flag ?? '◌'),
        ]),
        div([
          strong([.text(language?.nameOf('zh') ?? languageCode.toUpperCase())]),
          span([
            .text('${language?.nameOf('en') ?? languageCode} · $languageCode'),
          ]),
        ]),
      ]),
      div(classes: 'subtitle-inspector-cards', [
        div(classes: 'subtitle-inspector-card', [
          span([.text('文字系统')]),
          strong([
            .text(
              script == null
                  ? '未指定'
                  : language?.scriptNameOf(script.code, 'zh') ??
                        script.nameOf('zh'),
            ),
          ]),
          if (script != null)
            code([.text('${script.code} · ${script.isRtl ? 'RTL' : 'LTR'}')]),
        ]),
        div(classes: 'subtitle-inspector-card', [
          span([.text('字幕条目')]),
          strong([.text('$cueCount')]),
          small([.text('共享同一时间轴')]),
        ]),
      ]),
      if (script != null)
        div(classes: 'subtitle-inspector-sample', [
          span([.text('SCRIPT SAMPLE')]),
          p([.text(script.sampleText)]),
        ]),
      div(classes: 'subtitle-inspector-tip', [
        strong([.text('多文字模式')]),
        p([.text('切换文字不会复制时间轴。不同文字表示挂在同一个 cue 下。')]),
      ]),
    ]);
  }
}
