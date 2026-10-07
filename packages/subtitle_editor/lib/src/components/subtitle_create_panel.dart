import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleCreatePanel extends StatelessComponent {
  const SubtitleCreatePanel({
    required this.startTime,
    required this.endTime,
    required this.subtitleText,
    required this.creating,
    required this.error,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onTextChanged,
    required this.onUseCurrentStart,
    required this.onUseCurrentEnd,
    required this.onCreate,
    super.key,
  });

  final String startTime;
  final String endTime;
  final String subtitleText;

  final bool creating;
  final String? error;

  final void Function(String value) onStartChanged;
  final void Function(String value) onEndChanged;
  final void Function(String value) onTextChanged;

  final void Function() onUseCurrentStart;
  final void Function() onUseCurrentEnd;
  final void Function() onCreate;

  @override
  Component build(BuildContext context) {
    return div(classes: 'subtitle-create-panel', [
      div(classes: 'subtitle-create-header', [
        h3([.text(context.tr('Add subtitle', '添加字幕'))]),
        p([.text(context.tr('Add a new subtitle cue', '新增一条字幕 Cue'))]),
      ]),
      div(classes: 'subtitle-create-fields', [
        label([
          span([.text(context.tr('Start', '开始'))]),
          input<String>(
            attributes: {'value': startTime, 'placeholder': '00:00.000'},
            events: events<String>(onInput: onStartChanged),
          ),
          button(type: ButtonType.button, onClick: onUseCurrentStart, [
            .text(context.tr('Use current', '使用当前时间')),
          ]),
        ]),
        label([
          span([.text(context.tr('End', '结束'))]),
          input<String>(
            attributes: {'value': endTime, 'placeholder': '00:03.000'},
            events: events<String>(onInput: onEndChanged),
          ),
          button(type: ButtonType.button, onClick: onUseCurrentEnd, [
            .text(context.tr('Use current', '使用当前时间')),
          ]),
        ]),
        label(classes: 'subtitle-create-text-field', [
          span([.text(context.tr('Subtitle', '字幕'))]),
          input<String>(
            attributes: {'value': subtitleText, 'placeholder': context.tr('Enter subtitle text...', '输入字幕内容...')},
            events: events<String>(onInput: onTextChanged),
          ),
        ]),
        button(
          classes: 'subtitle-create-button',
          attributes: creating ? {'disabled': 'disabled'} : null,
          onClick: creating
              ? null
              : () {
                  onCreate();
                },
          [.text(creating ? context.tr('Adding...', '添加中...') : context.tr('+ Add subtitle', '+ 添加字幕'))],
        ),
      ]),
      if (error != null) div(classes: 'subtitle-save-error', [.text(error!)]),
    ]);
  }
}
