import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../subtitle_editor_utils.dart';
import '../subtitle_karaoke_controller.dart';

class SubtitleKaraokeEditor extends StatelessComponent {
  const SubtitleKaraokeEditor({
    required this.detail,
    required this.drafts,
    required this.currentVideoTimeMs,
    required this.saving,
    required this.error,
    required this.onGenerateFromSubtitle,
    required this.onClear,
    required this.onAdd,
    required this.onDelete,
    required this.onTextChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onUseCurrentStart,
    required this.onUseCurrentEnd,
    required this.onSeekVideo,
    required this.onSave,
    super.key,
  });

  final SubtitleCueDetail detail;
  final List<KaraokeSegmentDraft> drafts;
  final int currentVideoTimeMs;
  final bool saving;
  final String? error;

  final void Function() onGenerateFromSubtitle;
  final void Function() onClear;
  final void Function() onAdd;
  final void Function(int index) onDelete;
  final void Function(int index, String value) onTextChanged;
  final void Function(int index, String value) onStartChanged;
  final void Function(int index, String value) onEndChanged;
  final void Function(int index) onUseCurrentStart;
  final void Function(int index) onUseCurrentEnd;
  final void Function(int milliseconds) onSeekVideo;
  final void Function() onSave;

  int get _durationMs => detail.cue.endMs - detail.cue.startMs;

  int? _startMs(int index) {
    if (index < 0 || index >= drafts.length) return null;
    return parseSubtitleTime(drafts[index].startTime);
  }

  int? _endMs(int index) {
    if (index < 0 || index >= drafts.length) return null;
    return parseSubtitleTime(drafts[index].endTime);
  }

  double _percent(int milliseconds) {
    if (_durationMs <= 0) return 0;

    return (milliseconds / _durationMs * 100).clamp(0, 100).toDouble();
  }

  int _previousEndMs(int index) {
    if (index <= 0) return 0;
    return _endMs(index - 1) ?? 0;
  }

  int _nextStartMs(int index) {
    if (index >= drafts.length - 1) return _durationMs;
    return _startMs(index + 1) ?? _durationMs;
  }

  int _safeStartMax(int index, int endMs) {
    final candidate = endMs - 10;
    final min = _previousEndMs(index);
    return candidate < min ? min : candidate;
  }

  int _safeEndMin(int index, int startMs) {
    final candidate = startMs + 10;
    final max = _nextStartMs(index);
    return candidate > max ? max : candidate;
  }

  String _shortTime(int milliseconds) {
    return '${(milliseconds / 1000).toStringAsFixed(2)}s';
  }

  @override
  Component build(BuildContext context) {
    final durationMs = _durationMs;

    final insideCue = currentVideoTimeMs >= detail.cue.startMs && currentVideoTimeMs <= detail.cue.endMs;

    final relativeCurrentMs = insideCue ? currentVideoTimeMs - detail.cue.startMs : 0;

    return div(
      classes: 'subtitle-karaoke-editor',
      [
        div(
          classes: 'subtitle-karaoke-header',
          [
            div(
              [
                h3(
                  classes: 'subtitle-karaoke-title',
                  [.text('Karaoke timing')],
                ),
                p(
                  classes: 'subtitle-karaoke-description',
                  [
                    .text(
                      '每一个色块就是一个 Karaoke 片段。'
                      '先看它在 cue 的哪一段，再拖 Start / End 调整；'
                      '精确时间输入仍可用于最后微调。',
                    ),
                  ],
                ),
              ],
            ),
            div(
              classes: 'subtitle-karaoke-header-actions',
              [
                button(
                  type: ButtonType.button,
                  classes: 'subtitle-karaoke-secondary-button',
                  onClick: onGenerateFromSubtitle,
                  [.text('从字幕生成')],
                ),
                button(
                  type: ButtonType.button,
                  classes: 'subtitle-karaoke-secondary-button',
                  onClick: onClear,
                  [.text('清空')],
                ),
              ],
            ),
          ],
        ),
        div(
          classes: 'subtitle-karaoke-status',
          [
            span(
              [
                .text(
                  'Cue ${formatSubtitleTime(detail.cue.startMs)}'
                  ' → ${formatSubtitleTime(detail.cue.endMs)}'
                  ' · ${formatSubtitleTime(durationMs)}',
                ),
              ],
            ),
            span(
              classes: insideCue ? 'subtitle-karaoke-current is-inside' : 'subtitle-karaoke-current',
              [
                .text(
                  insideCue ? '当前 +${formatSubtitleTime(relativeCurrentMs)}' : '当前播放位置不在这条字幕内',
                ),
              ],
            ),
          ],
        ),
        if (drafts.isNotEmpty && durationMs > 0)
          div(
            classes: 'subtitle-karaoke-visual',
            [
              div(
                classes: 'subtitle-karaoke-visual-ruler',
                [
                  for (final fraction in const [0.0, 0.25, 0.5, 0.75, 1.0])
                    div(
                      classes: 'subtitle-karaoke-ruler-mark',
                      attributes: {
                        'style': 'left: ${fraction * 100}%;',
                      },
                      [
                        span(
                          classes: 'subtitle-karaoke-ruler-line',
                          [],
                        ),
                        span(
                          classes: 'subtitle-karaoke-ruler-label',
                          [
                            .text(
                              _shortTime(
                                (durationMs * fraction).round(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
              div(
                classes: 'subtitle-karaoke-visual-track',
                [
                  for (var index = 0; index < drafts.length; index++) _visualSegment(index),
                  if (insideCue)
                    div(
                      classes: 'subtitle-karaoke-playhead',
                      attributes: {
                        'style': 'left: ${_percent(relativeCurrentMs)}%;',
                      },
                      [],
                    ),
                ],
              ),
              div(
                classes: 'subtitle-karaoke-visual-legend',
                [
                  .text(
                    '色块位置 = 片段时间；'
                    '下方每一行的 #编号与这里完全对应。',
                  ),
                ],
              ),
            ],
          ),
        if (drafts.isEmpty)
          div(
            classes: 'subtitle-karaoke-empty',
            [
              .text(
                '还没有 Karaoke 片段。'
                '可以从当前字幕自动生成初始片段，或者手动添加。',
              ),
            ],
          )
        else
          div(
            classes: 'subtitle-karaoke-segments',
            [
              for (var index = 0; index < drafts.length; index++)
                _segmentRow(
                  index,
                  drafts[index],
                  insideCue,
                ),
            ],
          ),
        div(
          classes: 'subtitle-karaoke-footer',
          [
            button(
              type: ButtonType.button,
              classes: 'subtitle-karaoke-add-button',
              onClick: onAdd,
              [.text('+ 添加片段')],
            ),
            button(
              type: ButtonType.button,
              classes: 'subtitle-karaoke-save-button',
              attributes: saving ? {'disabled': 'disabled'} : null,
              onClick: saving ? null : onSave,
              [
                .text(
                  saving ? 'Saving...' : '保存 Karaoke',
                ),
              ],
            ),
            if (error != null)
              span(
                classes: 'subtitle-save-error',
                [.text(error!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _visualSegment(int index) {
    final startMs = _startMs(index);
    final endMs = _endMs(index);
    final draft = drafts[index];

    if (startMs == null || endMs == null || endMs <= startMs || _durationMs <= 0) {
      return div(
        classes: 'subtitle-karaoke-visual-segment is-invalid',
        [.text('#${index + 1} ${draft.text}')],
      );
    }

    final left = _percent(startMs);
    final width = (_percent(endMs) - left).clamp(0.4, 100).toDouble();

    return div(
      classes: 'subtitle-karaoke-visual-segment',
      attributes: {
        'style': 'left: $left%; width: $width%;',
        'title':
            '#${index + 1} ${draft.text} · '
            '${draft.startTime} → ${draft.endTime}',
      },
      events: {
        'click': (event) {
          event.preventDefault();
          event.stopPropagation();
          onSeekVideo(detail.cue.startMs + startMs);
        },
      },
      [
        span(
          classes: 'subtitle-karaoke-visual-index',
          [.text('#${index + 1}')],
        ),
        span(
          classes: 'subtitle-karaoke-visual-text',
          [
            .text(
              draft.text.trim().isEmpty ? '空片段' : draft.text,
            ),
          ],
        ),
      ],
    );
  }

  Component _segmentRow(
    int index,
    KaraokeSegmentDraft draft,
    bool insideCue,
  ) {
    final startMs = _startMs(index);
    final endMs = _endMs(index);

    final validRange = startMs != null && endMs != null && endMs > startMs && _durationMs > 0;

    final previousEnd = _previousEndMs(index);
    final nextStart = _nextStartMs(index);

    final startMax = validRange ? _safeStartMax(index, endMs) : _durationMs;

    final endMin = validRange ? _safeEndMin(index, startMs) : 0;

    return div(
      classes: 'subtitle-karaoke-segment-card',
      [
        div(
          classes: 'subtitle-karaoke-segment-row',
          [
            span(
              classes: 'subtitle-karaoke-index',
              [.text('${index + 1}')],
            ),
            label(
              classes: 'subtitle-karaoke-text-field',
              [
                span([.text('片段')]),
                input<String>(
                  attributes: {
                    'value': draft.text,
                    'placeholder': '文字 / 音节 / 字',
                  },
                  events: events<String>(
                    onInput: (value) {
                      onTextChanged(index, value);
                    },
                  ),
                ),
              ],
            ),
            label(
              classes: 'subtitle-karaoke-time-field',
              [
                span([.text('Start')]),
                input<String>(
                  attributes: {
                    'value': draft.startTime,
                    'placeholder': '00:00.000',
                  },
                  events: events<String>(
                    onInput: (value) {
                      onStartChanged(index, value);
                    },
                  ),
                ),
              ],
            ),
            button(
              type: ButtonType.button,
              classes: 'subtitle-karaoke-now-button',
              attributes: insideCue ? null : {'disabled': 'disabled'},
              onClick: insideCue ? () => onUseCurrentStart(index) : null,
              [.text('当前→Start')],
            ),
            label(
              classes: 'subtitle-karaoke-time-field',
              [
                span([.text('End')]),
                input<String>(
                  attributes: {
                    'value': draft.endTime,
                    'placeholder': '00:00.000',
                  },
                  events: events<String>(
                    onInput: (value) {
                      onEndChanged(index, value);
                    },
                  ),
                ),
              ],
            ),
            button(
              type: ButtonType.button,
              classes: 'subtitle-karaoke-now-button',
              attributes: insideCue ? null : {'disabled': 'disabled'},
              onClick: insideCue ? () => onUseCurrentEnd(index) : null,
              [.text('当前→End')],
            ),
            button(
              type: ButtonType.button,
              classes: 'subtitle-karaoke-delete-button',
              onClick: () => onDelete(index),
              [.text('删除')],
            ),
          ],
        ),
        if (validRange)
          div(
            classes: 'subtitle-karaoke-range-editor',
            [
              div(
                classes: 'subtitle-karaoke-range-summary',
                [
                  span(
                    [
                      .text(
                        '#${index + 1} · '
                        '${draft.text.trim().isEmpty ? '空片段' : draft.text}',
                      ),
                    ],
                  ),
                  span(
                    [
                      .text(
                        '${_shortTime(startMs)} → '
                        '${_shortTime(endMs)}',
                      ),
                    ],
                  ),
                ],
              ),
              div(
                classes: 'subtitle-karaoke-range-row',
                [
                  span(
                    classes: 'subtitle-karaoke-range-label',
                    [.text('Start')],
                  ),
                  input<String>(
                    type: InputType.range,
                    classes: 'subtitle-karaoke-range',
                    attributes: {
                      'min': '$previousEnd',
                      'max': '$startMax',
                      'step': '10',
                      'value': '$startMs',
                    },
                    events: events<String>(
                      onInput: (value) {
                        final milliseconds = int.tryParse(value);

                        if (milliseconds == null) return;

                        onStartChanged(
                          index,
                          formatSubtitleTime(milliseconds),
                        );
                      },
                    ),
                  ),
                  span(
                    classes: 'subtitle-karaoke-range-value',
                    [.text(_shortTime(startMs))],
                  ),
                ],
              ),
              div(
                classes: 'subtitle-karaoke-range-row',
                [
                  span(
                    classes: 'subtitle-karaoke-range-label',
                    [.text('End')],
                  ),
                  input<String>(
                    type: InputType.range,
                    classes: 'subtitle-karaoke-range',
                    attributes: {
                      'min': '$endMin',
                      'max': '$nextStart',
                      'step': '10',
                      'value': '$endMs',
                    },
                    events: events<String>(
                      onInput: (value) {
                        final milliseconds = int.tryParse(value);

                        if (milliseconds == null) return;

                        onEndChanged(
                          index,
                          formatSubtitleTime(milliseconds),
                        );
                      },
                    ),
                  ),
                  span(
                    classes: 'subtitle-karaoke-range-value',
                    [.text(_shortTime(endMs))],
                  ),
                ],
              ),
            ],
          )
        else
          div(
            classes: 'subtitle-karaoke-range-error',
            [
              .text(
                '时间格式无效，先把 Start / End 修成有效时间后'
                '就会出现可视化拖杆。',
              ),
            ],
          ),
      ],
    );
  }
}
