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
        h3([.text('Add subtitle')]),
        p([.text('新增一条字幕 Cue')]),
      ]),
      div(classes: 'subtitle-create-fields', [
        label([
          span([.text('Start')]),
          input<String>(
            attributes: {'value': startTime, 'placeholder': '00:00.000'},
            events: events<String>(onInput: onStartChanged),
          ),
          button(type: ButtonType.button, onClick: onUseCurrentStart, [
            .text('Use current'),
          ]),
        ]),
        label([
          span([.text('End')]),
          input<String>(
            attributes: {'value': endTime, 'placeholder': '00:03.000'},
            events: events<String>(onInput: onEndChanged),
          ),
          button(type: ButtonType.button, onClick: onUseCurrentEnd, [
            .text('Use current'),
          ]),
        ]),
        label(classes: 'subtitle-create-text-field', [
          span([.text('Subtitle')]),
          input<String>(
            attributes: {'value': subtitleText, 'placeholder': '输入字幕内容...'},
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
          [.text(creating ? 'Adding...' : '+ Add subtitle')],
        ),
      ]),
      if (error != null) div(classes: 'subtitle-save-error', [.text(error!)]),
    ]);
  }
}
