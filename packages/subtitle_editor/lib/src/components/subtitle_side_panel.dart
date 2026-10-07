import 'package:glyphora_web_l10n/web_l10n.dart';
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
        span(classes: 'subtitle-inspector-eyebrow', [.text(context.tr('TRACK', '字幕轨'))]),
        h3([.text(context.tr('Track info', '字幕轨信息'))]),
      ]),
      div(classes: 'subtitle-inspector-language', [
        span(classes: 'subtitle-inspector-flag', [
          .text(language?.flag ?? '◌'),
        ]),
        div([
          strong([.text(language?.nameOf(context.lang.name) ?? languageCode.toUpperCase())]),
          span([
            .text('${language?.nameOf(context.isZh ? 'en' : 'zh') ?? languageCode} · $languageCode'),
          ]),
        ]),
      ]),
      div(classes: 'subtitle-inspector-cards', [
        div(classes: 'subtitle-inspector-card', [
          span([.text(context.tr('Script', '文字系统'))]),
          strong([
            .text(
              script == null
                  ? context.tr('Not specified', '未指定')
                  : language?.scriptNameOf(script.code, context.lang.name) ??
                        script.nameOf(context.lang.name),
            ),
          ]),
          if (script != null)
            code([.text('${script.code} · ${script.isRtl ? 'RTL' : 'LTR'}')]),
        ]),
        div(classes: 'subtitle-inspector-card', [
          span([.text(context.tr('Subtitle cues', '字幕条目'))]),
          strong([.text('$cueCount')]),
          small([.text(context.tr('Share one timeline', '共享同一时间轴'))]),
        ]),
      ]),
      if (script != null)
        div(classes: 'subtitle-inspector-sample', [
          span([.text(context.tr('SCRIPT SAMPLE', '文字示例'))]),
          p([.text(script.sampleText)]),
        ]),
      div(classes: 'subtitle-inspector-tip', [
        strong([.text(context.tr('Multi-script mode', '多文字模式'))]),
        p([.text(context.tr('Switching scripts does not copy the timeline. Different scripts hang under the same cue.', '切换文字不会复制时间轴。不同文字表示挂在同一个 cue 下。'))]),
      ]),
    ]);
  }
}
