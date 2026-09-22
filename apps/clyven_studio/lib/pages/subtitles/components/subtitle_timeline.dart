import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleTimeline extends StatelessComponent {
  const SubtitleTimeline({
    required this.cues,
    required this.currentVideoTimeMs,
    required this.selectedCueId,
    required this.activeCueId,
    required this.timelineZoom,
    required this.durationMs,
    required this.onZoomChanged,
    required this.onTimelineClick,
    required this.onCueMouseDown,
    required this.onCueClick,
    required this.onResizeStart,
    required this.getCueText,
    required this.onCueTextChanged,
    required this.onCueTextSave,
    required this.onPlayheadMouseDown,
    super.key,
  });

  final List<SubtitleCueDetail> cues;

  final int currentVideoTimeMs;
  final int? selectedCueId;
  final int? activeCueId;

  /// 0 means automatic editing view (~30 seconds visible).
  final double timelineZoom;
  final int durationMs;

  final void Function(double value) onZoomChanged;
  final void Function(dynamic event) onTimelineClick;

  final void Function(SubtitleCueDetail detail) onCueMouseDown;
  final void Function(SubtitleCueDetail detail) onCueClick;

  final void Function(
    SubtitleCueDetail detail,
    bool resizeStart,
  )
  onResizeStart;

  final String Function(
    SubtitleCueDetail detail,
  )
  getCueText;

  final void Function(
    SubtitleCueDetail detail,
    String value,
  )
  onCueTextChanged;

  final void Function(
    SubtitleCueDetail detail,
  )
  onCueTextSave;

  final void Function(dynamic event) onPlayheadMouseDown;

  double _defaultZoom() {
    if (durationMs <= 0) {
      return 1;
    }

    return (durationMs / 30000).clamp(1.0, 120.0).toDouble();
  }

  double _effectiveZoom() {
    if (timelineZoom <= 0) {
      return _defaultZoom();
    }

    return timelineZoom.clamp(1.0, 240.0).toDouble();
  }

  double _timelinePercent(int milliseconds) {
    if (durationMs <= 0) {
      return 0;
    }

    return (milliseconds / durationMs * 100).clamp(0, 100).toDouble();
  }

  int _timelineTickIntervalMs(double zoom) {
    if (durationMs <= 0) {
      return 1000;
    }

    final visibleDurationMs = durationMs / zoom;
    final targetInterval = visibleDurationMs / 7;

    const intervals = <int>[
      250,
      500,
      1000,
      2000,
      5000,
      10000,
      15000,
      30000,
      60000,
      120000,
      300000,
      600000,
    ];

    for (final interval in intervals) {
      if (interval >= targetInterval) {
        return interval;
      }
    }

    return intervals.last;
  }

  String _formatTimelineLabel(int milliseconds) {
    if (milliseconds < 1000) {
      return '0.${milliseconds.toString().padLeft(3, '0')}';
    }

    final totalSeconds = milliseconds ~/ 1000;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '$hours:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _formatTime(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final millis = milliseconds % 1000;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }

  String _visibleWindowLabel(double zoom) {
    if (durationMs <= 0) {
      return '—';
    }

    final visibleMs = durationMs / zoom;

    if (visibleMs < 1000) {
      return '${visibleMs.round()}ms';
    }

    if (visibleMs < 60000) {
      return '${(visibleMs / 1000).toStringAsFixed(1)}s';
    }

    return '${(visibleMs / 60000).toStringAsFixed(1)}m';
  }

  @override
  Component build(BuildContext context) {
    final zoom = _effectiveZoom();
    final tickIntervalMs = _timelineTickIntervalMs(zoom);

    return div(
      classes: 'subtitle-timeline-panel',
      [
        div(
          classes: 'subtitle-timeline-header',
          [
            span([
              .text('Timeline'),
            ]),
            div(
              classes: 'subtitle-timeline-controls',
              [
                button(
                  type: ButtonType.button,
                  onClick: zoom <= 1.0
                      ? null
                      : () {
                          onZoomChanged(
                            (zoom / 1.5).clamp(1.0, 240.0).toDouble(),
                          );
                        },
                  [.text('−')],
                ),
                span([
                  .text(
                    '${zoom.toStringAsFixed(1)}× · '
                    '${_visibleWindowLabel(zoom)}',
                  ),
                ]),
                button(
                  type: ButtonType.button,
                  onClick: zoom >= 240.0
                      ? null
                      : () {
                          onZoomChanged(
                            (zoom * 1.5).clamp(1.0, 240.0).toDouble(),
                          );
                        },
                  [.text('+')],
                ),
                button(
                  type: ButtonType.button,
                  onClick: () {
                    onZoomChanged(_defaultZoom());
                  },
                  [.text('30秒窗口')],
                ),
                button(
                  type: ButtonType.button,
                  onClick: () {
                    onZoomChanged(1.0);
                  },
                  [.text('全览')],
                ),
                span(
                  classes: 'subtitle-timeline-time',
                  [
                    .text(
                      '${_formatTime(currentVideoTimeMs)} / '
                      '${_formatTime(durationMs)}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        div(
          classes: 'subtitle-timeline',
          [
            div(
              classes: 'subtitle-timeline-ruler',
              attributes: {
                'style': 'width: ${zoom * 100}%;',
              },
              [
                for (var tickMs = 0; tickMs <= durationMs; tickMs += tickIntervalMs)
                  div(
                    classes: 'subtitle-timeline-tick',
                    attributes: {
                      'style': 'left: ${_timelinePercent(tickMs)}%;',
                    },
                    [
                      span(
                        classes: 'subtitle-timeline-tick-line',
                        [],
                      ),
                      span(
                        classes: 'subtitle-timeline-tick-label',
                        [
                          .text(_formatTimelineLabel(tickMs)),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            div(
              id: 'subtitle-timeline-track',
              classes: 'subtitle-timeline-track',
              attributes: {
                'style': 'width: ${zoom * 100}%;',
              },
              events: {
                'mousedown': (event) {
                  onTimelineClick(event);
                },

                'click': (event) {
                  onTimelineClick(event);
                },
              },
              [
                for (final detail in cues)
                  div(
                    classes:
                        'subtitle-timeline-cue'
                        '${selectedCueId == detail.cue.id ? ' is-selected' : ''}'
                        '${activeCueId == detail.cue.id ? ' is-active' : ''}',
                    attributes: {
                      'style':
                          'left: ${_timelinePercent(detail.cue.startMs)}%; '
                          'width: ${_timelinePercent(detail.cue.endMs) - _timelinePercent(detail.cue.startMs)}%;',
                    },
                    events: {
                      'mousedown': (event) {
                        event.stopPropagation();

                        if ((event.target as dynamic)?.tagName?.toString().toLowerCase() == 'input') {
                          return;
                        }

                        onCueMouseDown(detail);
                      },
                      'click': (event) {
                        event.stopPropagation();

                        if ((event.target as dynamic)?.tagName?.toString().toLowerCase() == 'input') {
                          return;
                        }

                        onCueClick(detail);
                      },
                    },
                    [
                      div(
                        classes: 'subtitle-resize-handle subtitle-resize-left',
                        events: {
                          'mousedown': (event) {
                            event.preventDefault();
                            event.stopPropagation();

                            onResizeStart(
                              detail,
                              true,
                            );
                          },
                          'click': (event) {
                            event.stopPropagation();
                          },
                        },
                        [],
                      ),
                      input<String>(
                        classes:
                            'subtitle-timeline-cue-input'
                            '${selectedCueId == detail.cue.id ? ' is-editable' : ''}',
                        attributes: {
                          'value': getCueText(detail),
                          'aria-label': '直接编辑字幕',
                          if (selectedCueId != detail.cue.id) 'readonly': 'readonly',
                          if (selectedCueId != detail.cue.id) 'tabindex': '-1',
                        },
                        events: {
                          'mousedown': (event) {
                            event.stopPropagation();
                          },
                          'click': (event) {
                            event.stopPropagation();
                          },
                          'input': (event) {
                            final target = event.target as dynamic;
                            final value = target?.value?.toString() ?? '';

                            onCueTextChanged(
                              detail,
                              value,
                            );
                          },
                          'change': (event) {
                            final target = event.target as dynamic;
                            final value = target?.value?.toString() ?? '';

                            onCueTextChanged(
                              detail,
                              value,
                            );
                            onCueTextSave(detail);
                          },
                          'keydown': (event) {
                            if ((event as dynamic).key?.toString() != 'Enter') {
                              return;
                            }

                            event.preventDefault();
                            event.stopPropagation();

                            final target = event.target as dynamic;
                            final value = target?.value?.toString() ?? '';

                            onCueTextChanged(
                              detail,
                              value,
                            );
                            onCueTextSave(detail);
                            target?.blur();
                          },
                        },
                      ),

                      .text(detail.cue.text),
                      div(
                        classes: 'subtitle-resize-handle subtitle-resize-right',
                        events: {
                          'mousedown': (event) {
                            event.preventDefault();
                            event.stopPropagation();

                            onResizeStart(
                              detail,
                              false,
                            );
                          },
                          'click': (event) {
                            event.stopPropagation();
                          },
                        },
                        [],
                      ),
                    ],
                  ),
                div(
                  classes: 'subtitle-timeline-playhead',
                  attributes: {
                    'style': 'left: ${_timelinePercent(currentVideoTimeMs)}%;',
                  },
                  events: {
                    'mousedown': (event) {
                      onPlayheadMouseDown(event);
                    },
                    'click': (event) {
                      event.stopPropagation();
                    },
                  },
                  [],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
