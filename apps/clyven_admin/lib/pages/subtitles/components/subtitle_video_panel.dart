import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:jaspr/dom.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

class SubtitleVideoPanel extends StatefulComponent {
  const SubtitleVideoPanel({
    required this.videoUrl,
    required this.captionText,
    required this.captionCueStartMs,
    required this.karaokeSegments,
    required this.onTimeUpdate,
    super.key,
  });

  final String videoUrl;
  final String? captionText;
  final int? captionCueStartMs;
  final List<serverpod.SubtitleKaraokeSegment> karaokeSegments;
  final void Function() onTimeUpdate;

  @override
  State<SubtitleVideoPanel> createState() => _SubtitleVideoPanelState();
}

class _SubtitleVideoPanelState extends State<SubtitleVideoPanel> {
  bool _playing = false;
  bool _captionsVisible = true;

  double _currentTime = 0;
  double _duration = 0;
  double _volume = 1;
  double _playbackRate = 1;

  html.VideoElement? get _video {
    return html.document.getElementById('subtitle-video-player')
        as html.VideoElement?;
  }

  void _syncVideoState() {
    final video = _video;

    if (video == null) {
      return;
    }

    setState(() {
      _currentTime = video.currentTime.toDouble();

      if (video.duration.isFinite) {
        _duration = video.duration.toDouble();
      }

      _volume = video.volume.toDouble();
      _playing = !video.paused;
    });
  }

  void _handleTimeUpdate() {
    final video = _video;

    if (video == null) {
      return;
    }

    setState(() {
      _currentTime = video.currentTime.toDouble();

      if (video.duration.isFinite) {
        _duration = video.duration.toDouble();
      }

      _playing = !video.paused;
    });

    component.onTimeUpdate();
  }

  void _togglePlayback() {
    final video = _video;

    if (video == null) {
      return;
    }

    if (video.paused) {
      video.play();
    } else {
      video.pause();
    }
  }

  void _seekBy(double seconds) {
    final video = _video;

    if (video == null) {
      return;
    }

    final duration = video.duration.toDouble();

    if (!duration.isFinite || duration <= 0) {
      return;
    }

    final nextTime = (video.currentTime.toDouble() + seconds).clamp(
      0.0,
      duration,
    );

    video.currentTime = nextTime.toDouble();

    _syncVideoState();
    component.onTimeUpdate();
  }

  void _seekToProgress(String value) {
    final video = _video;

    if (video == null) {
      return;
    }

    final rawValue = double.tryParse(value);

    if (rawValue == null) {
      return;
    }

    final duration = video.duration.toDouble();

    if (!duration.isFinite || duration <= 0) {
      return;
    }

    video.currentTime = (rawValue / 1000) * duration;

    _syncVideoState();
    component.onTimeUpdate();
  }

  void _changeVolume(String value) {
    final video = _video;

    if (video == null) {
      return;
    }

    final rawValue = double.tryParse(value);

    if (rawValue == null) {
      return;
    }

    final volume = (rawValue / 100).clamp(0.0, 1.0);

    video.volume = volume.toDouble();

    setState(() {
      _volume = volume.toDouble();
    });
  }

  void _cyclePlaybackRate() {
    const speeds = [1.0, 1.25, 1.5, 2.0, 0.75];

    final currentIndex = speeds.indexOf(_playbackRate);

    final nextIndex = currentIndex == -1
        ? 0
        : (currentIndex + 1) % speeds.length;

    final nextRate = speeds[nextIndex];

    final video = _video;

    if (video != null) {
      video.playbackRate = nextRate;
    }

    setState(() {
      _playbackRate = nextRate;
    });
  }

  void _toggleCaptions() {
    setState(() {
      _captionsVisible = !_captionsVisible;
    });
  }

  void _toggleFullscreen() {
    final shell = html.document.getElementById('subtitle-video-shell');

    if (shell == null) {
      return;
    }

    if (html.document.fullscreenElement != null) {
      html.document.exitFullscreen();
    } else {
      shell.requestFullscreen();
    }
  }

  String _formatTime(double seconds) {
    if (!seconds.isFinite || seconds < 0) {
      return '00:00';
    }

    final totalSeconds = seconds.floor();

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final secs = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  String _normalizeCaptionForKaraoke(String value) {
    return value.replaceAll(RegExp(r'\s+'), '').trim();
  }

  bool _karaokeMatchesCaption(String caption) {
    if (component.karaokeSegments.isEmpty) {
      return false;
    }

    final karaokeText = component.karaokeSegments
        .map((segment) => segment.text)
        .join();

    return _normalizeCaptionForKaraoke(karaokeText) ==
        _normalizeCaptionForKaraoke(caption);
  }

  Component _karaokeCaption(
    List<serverpod.SubtitleKaraokeSegment> rawSegments,
    int cueStartMs,
  ) {
    final segments = [...rawSegments]
      ..sort((a, b) => a.position.compareTo(b.position));

    final relativeMs = (_currentTime * 1000).round() - cueStartMs;

    String styleFor(serverpod.SubtitleKaraokeSegment segment) {
      final startMs = segment.startOffsetMs;
      final endMs = segment.endOffsetMs;
      final durationMs = endMs - startMs;

      double progress;

      if (relativeMs <= startMs) {
        progress = 0;
      } else if (relativeMs >= endMs) {
        progress = 1;
      } else if (durationMs <= 0) {
        progress = 1;
      } else {
        progress = (relativeMs - startMs) / durationMs;
      }

      final percent = (progress.clamp(0.0, 1.0) * 100).toStringAsFixed(2);

      return 'background: linear-gradient('
          '90deg, #60a5fa 0%, #60a5fa $percent%, '
          '#ffffff $percent%, #ffffff 100%); '
          '-webkit-background-clip: text; '
          'background-clip: text; '
          'color: transparent;';
    }

    return span(classes: 'subtitle-video-caption', [
      for (final segment in segments)
        span(attributes: {'style': styleFor(segment)}, [.text(segment.text)]),
    ]);
  }

  String _volumeIcon() {
    if (_volume <= 0) {
      return '🔇';
    }

    if (_volume < 0.5) {
      return '🔉';
    }

    return '🔊';
  }

  @override
  Component build(BuildContext context) {
    final duration = _duration;

    final progress = duration <= 0
        ? 0
        : (_currentTime / duration * 1000).round();

    final caption = component.captionText?.trim();

    return div(id: 'subtitle-video-shell', classes: 'subtitle-video-panel', [
      div(classes: 'subtitle-player-stage', [
        dom.video(
          [],
          id: 'subtitle-video-player',
          classes: 'subtitle-video-player',
          src: component.videoUrl,
          controls: false,
          preload: dom.Preload.metadata,
          events: {
            'timeupdate': (_) {
              _handleTimeUpdate();
            },
            'loadedmetadata': (_) {
              _syncVideoState();
            },
            'durationchange': (_) {
              _syncVideoState();
            },
            'play': (_) {
              setState(() {
                _playing = true;
              });
            },
            'pause': (_) {
              setState(() {
                _playing = false;
              });
            },
            'click': (_) {
              _togglePlayback();
            },
          },
        ),

        div(classes: 'subtitle-player-topbar', [
          span(classes: 'subtitle-player-badge', [.text('CLYVEN PREVIEW')]),
        ]),

        if (!_playing)
          button(
            type: ButtonType.button,
            classes: 'subtitle-player-center-play',
            onClick: () {
              _togglePlayback();
            },
            [.text('▶')],
          ),

        if (_captionsVisible && caption != null && caption.isNotEmpty)
          div(classes: 'subtitle-video-caption-layer', [
            if (component.karaokeSegments.isNotEmpty &&
                component.captionCueStartMs != null &&
                _karaokeMatchesCaption(caption))
              _karaokeCaption(
                component.karaokeSegments,
                component.captionCueStartMs!,
              )
            else
              span(classes: 'subtitle-video-caption', [.text(caption)]),
          ]),

        div(classes: 'subtitle-player-controls', [
          div(classes: 'subtitle-player-progress-wrap', [
            input<String>(
              type: InputType.range,
              classes: 'subtitle-player-progress',
              attributes: {
                'min': '0',
                'max': '1000',
                'step': '1',
                'value': '$progress',
                'aria-label': 'Video progress',
              },
              events: events<String>(
                onInput: (value) {
                  _seekToProgress(value);
                },
              ),
            ),
          ]),

          div(classes: 'subtitle-player-control-row', [
            div(classes: 'subtitle-player-control-group', [
              button(
                type: ButtonType.button,
                classes:
                    'subtitle-player-icon-button '
                    'subtitle-player-play-button',
                onClick: () {
                  _togglePlayback();
                },
                [.text(_playing ? '❚❚' : '▶')],
              ),

              button(
                type: ButtonType.button,
                classes: 'subtitle-player-icon-button',
                onClick: () {
                  _seekBy(-10);
                },
                [.text('↶ 10')],
              ),

              button(
                type: ButtonType.button,
                classes: 'subtitle-player-icon-button',
                onClick: () {
                  _seekBy(10);
                },
                [.text('10 ↷')],
              ),

              span(classes: 'subtitle-player-time', [
                .text(
                  '${_formatTime(_currentTime)} / '
                  '${_formatTime(_duration)}',
                ),
              ]),
            ]),

            div(
              classes:
                  'subtitle-player-control-group '
                  'subtitle-player-control-group-right',
              [
                span(classes: 'subtitle-player-volume-icon', [
                  .text(_volumeIcon()),
                ]),

                input<String>(
                  type: InputType.range,
                  classes: 'subtitle-player-volume',
                  attributes: {
                    'min': '0',
                    'max': '100',
                    'step': '1',
                    'value': '${(_volume * 100).round()}',
                    'aria-label': 'Volume',
                  },
                  events: events<String>(
                    onInput: (value) {
                      _changeVolume(value);
                    },
                  ),
                ),

                button(
                  type: ButtonType.button,
                  classes: 'subtitle-player-pill-button',
                  onClick: () {
                    _cyclePlaybackRate();
                  },
                  [.text('${_playbackRate}×')],
                ),

                button(
                  type: ButtonType.button,
                  classes:
                      'subtitle-player-pill-button'
                      '${_captionsVisible ? ' is-active' : ''}',
                  onClick: () {
                    _toggleCaptions();
                  },
                  [.text('CC')],
                ),

                button(
                  type: ButtonType.button,
                  classes: 'subtitle-player-icon-button',
                  onClick: () {
                    _toggleFullscreen();
                  },
                  [.text('⛶')],
                ),
              ],
            ),
          ]),
        ]),
      ]),
    ]);
  }
}
