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
    required this.onPlayheadMouseDown,
    super.key,
  });

  final List<SubtitleCueDetail> cues;

  final int currentVideoTimeMs;
  final int? selectedCueId;
  final int? activeCueId;

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

  final void Function(dynamic event) onPlayheadMouseDown;

  double _timelinePercent(int milliseconds) {
    if (durationMs <= 0) {
      return 0;
    }

    return (milliseconds / durationMs * 100)
        .clamp(
          0,
          100,
        )
        .toDouble();
  }

  int _timelineTickIntervalMs() {
    if (timelineZoom >= 6.0) {
      return 5000;
    }

    if (timelineZoom >= 3.0) {
      return 10000;
    }

    if (timelineZoom >= 1.5) {
      return 20000;
    }

    return 30000;
  }

  String _formatTimelineLabel(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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

  @override
  Component build(BuildContext context) {
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
                  onClick: timelineZoom <= 1.0
                      ? null
                      : () {
                          onZoomChanged(
                            (timelineZoom - 0.5).clamp(1.0, 8.0).toDouble(),
                          );
                        },
                  [
                    .text('−'),
                  ],
                ),
                span([
                  .text('${timelineZoom.toStringAsFixed(1)}×'),
                ]),
                button(
                  type: ButtonType.button,
                  onClick: timelineZoom >= 8.0
                      ? null
                      : () {
                          onZoomChanged(
                            (timelineZoom + 0.5).clamp(1.0, 8.0).toDouble(),
                          );
                        },
                  [
                    .text('+'),
                  ],
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
                'style': 'width: ${timelineZoom * 100}%;',
              },
              [
                for (var tickMs = 0; tickMs <= durationMs; tickMs += _timelineTickIntervalMs())
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
                          .text(
                            _formatTimelineLabel(tickMs),
                          ),
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
                'style': 'width: ${timelineZoom * 100}%;',
              },
              events: {
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
                      'mousedown': (_) {
                        onCueMouseDown(detail);
                      },
                      'click': (event) {
                        event.stopPropagation();
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
