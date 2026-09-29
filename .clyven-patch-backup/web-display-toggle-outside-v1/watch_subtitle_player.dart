import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

class WatchSubtitlePlayer extends StatefulComponent {
  const WatchSubtitlePlayer({
    required this.videoId,
    required this.videoUrl,
    required this.coverUrl,
    required this.primaryCues,
    required this.secondaryCues,
    required this.primaryScriptCode,
    required this.secondaryScriptCode,
    required this.subtitlesEnabled,
    required this.overlayMode,
    required this.onTimeChanged,
    required this.onSubtitleSettings,
    this.settingsPanel,
    super.key,
  });

  final int videoId;
  final String videoUrl;
  final String coverUrl;

  final List<api.SubtitleCueDetail> primaryCues;
  final List<api.SubtitleCueDetail> secondaryCues;

  final String? primaryScriptCode;
  final String? secondaryScriptCode;

  final bool subtitlesEnabled;
  final bool overlayMode;

  final void Function(int milliseconds) onTimeChanged;
  final void Function() onSubtitleSettings;

  /// Rendered inside the player stage, not as a page-level modal.
  final Component? settingsPanel;

  @override
  State<WatchSubtitlePlayer> createState() => _WatchSubtitlePlayerState();
}

class _WatchSubtitlePlayerState extends State<WatchSubtitlePlayer> {
  bool _playing = false;

  double _currentTime = 0;
  double _duration = 0;
  double _volume = 1;
  double _playbackRate = 1;

  String get _videoElementId => 'clyven-watch-video-${component.videoId}';
  String get _shellElementId => 'clyven-watch-shell-${component.videoId}';

  html.VideoElement? get _video =>
      html.document.getElementById(_videoElementId) as html.VideoElement?;

  void _syncVideoState({bool notifyParent = true}) {
    final video = _video;
    if (video == null) return;

    final currentTime = video.currentTime.toDouble();
    final duration = video.duration.isFinite ? video.duration.toDouble() : 0.0;
    final volume = video.volume.toDouble();
    final playing = !video.paused;

    setState(() {
      _currentTime = currentTime;
      _duration = duration;
      _volume = volume;
      _playing = playing;
    });

    if (notifyParent) {
      component.onTimeChanged((currentTime * 1000).round());
    }
  }

  void _togglePlayback() {
    final video = _video;
    if (video == null) return;

    if (video.paused) {
      video.play();
    } else {
      video.pause();
    }
  }

  void _seekBy(double seconds) {
    final video = _video;
    if (video == null) return;

    final duration = video.duration.toDouble();
    if (!duration.isFinite || duration <= 0) return;

    video.currentTime = (video.currentTime.toDouble() + seconds)
        .clamp(0.0, duration)
        .toDouble();

    _syncVideoState();
  }

  void _seekToProgress(String value) {
    final video = _video;
    if (video == null) return;

    final rawValue = double.tryParse(value);
    if (rawValue == null) return;

    final duration = video.duration.toDouble();
    if (!duration.isFinite || duration <= 0) return;

    video.currentTime = (rawValue / 1000) * duration;
    _syncVideoState();
  }

  void _changeVolume(String value) {
    final video = _video;
    if (video == null) return;

    final rawValue = double.tryParse(value);
    if (rawValue == null) return;

    final volume = (rawValue / 100).clamp(0.0, 1.0).toDouble();
    video.volume = volume;

    setState(() {
      _volume = volume;
    });
  }

  void _toggleMute() {
    final video = _video;
    if (video == null) return;

    if (video.volume > 0) {
      video.volume = 0;
    } else {
      video.volume = 1;
    }

    _syncVideoState(notifyParent: false);
  }

  void _cyclePlaybackRate() {
    const speeds = <double>[1.0, 1.25, 1.5, 2.0, 0.75];

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

  void _toggleFullscreen() {
    final shell = html.document.getElementById(_shellElementId);
    if (shell == null) return;

    if (html.document.fullscreenElement != null) {
      html.document.exitFullscreen();
    } else {
      shell.requestFullscreen();
    }
  }

  String _formatTime(double seconds) {
    if (!seconds.isFinite || seconds < 0) return '00:00';

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

  String _volumeIcon() {
    if (_volume <= 0) return '🔇';
    if (_volume < 0.5) return '🔉';
    return '🔊';
  }

  api.SubtitleCueDetail? _active(List<api.SubtitleCueDetail> details) {
    final currentMs = (_currentTime * 1000).round();

    for (final detail in details) {
      if (currentMs >= detail.cue.startMs && currentMs < detail.cue.endMs) {
        return detail;
      }
    }

    return null;
  }

  List<api.SubtitleKaraokeSegment> _segments(
    api.SubtitleCueDetail detail,
    String? scriptCode,
  ) {
    final requested = scriptCode?.trim().toLowerCase();
    final raw = detail.karaokeSegments ?? const <api.SubtitleKaraokeSegment>[];

    final result = raw.where((segment) {
      if (requested == null || requested.isEmpty) return true;

      final segmentScript = segment.scriptCode?.trim().toLowerCase();

      return segmentScript == null ||
          segmentScript.isEmpty ||
          segmentScript == requested;
    }).toList()..sort((a, b) => a.position.compareTo(b.position));

    return result;
  }

  String _normalizeCaptionForKaraoke(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  bool _karaokeMatches(
    api.SubtitleCueDetail detail,
    List<api.SubtitleKaraokeSegment> segments,
  ) {
    if (segments.isEmpty) return false;

    final karaokeText = segments.map((segment) => segment.text).join();

    return _normalizeCaptionForKaraoke(karaokeText) ==
        _normalizeCaptionForKaraoke(detail.cue.text);
  }

  Component _caption(
    api.SubtitleCueDetail detail,
    String? scriptCode, {
    bool secondary = false,
  }) {
    final segments = _segments(detail, scriptCode);

    if (!_karaokeMatches(detail, segments)) {
      return span(
        classes:
            'watch-caption-text${secondary ? ' watch-caption-secondary' : ''}',
        [.text(detail.cue.text)],
      );
    }

    final currentMs = (_currentTime * 1000).round();
    final relativeMs = currentMs - detail.cue.startMs;

    String styleFor(api.SubtitleKaraokeSegment segment) {
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

      final completed = secondary ? '#a7f3d0' : '#60a5fa';
      final pending = secondary ? '#d1d5db' : '#ffffff';

      return 'background: linear-gradient(90deg, '
          '$completed 0%, $completed $percent%, '
          '$pending $percent%, $pending 100%); '
          '-webkit-background-clip: text; '
          'background-clip: text; '
          'color: transparent;';
    }

    return span(
      classes:
          'watch-caption-text watch-caption-karaoke'
          '${secondary ? ' watch-caption-secondary' : ''}',
      [
        for (final segment in segments)
          span(attributes: {'style': styleFor(segment)}, [.text(segment.text)]),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    final duration = _duration;
    final progress = duration <= 0
        ? 0
        : (_currentTime / duration * 1000).round();

    final primary = _active(component.primaryCues);
    final secondary = _active(component.secondaryCues);

    return div(id: _shellElementId, classes: 'watch-player-shell studio-player', [
      div(classes: 'watch-player-stage', [
        dom.video(
          [],
          id: _videoElementId,
          classes: 'watch-video-element',
          src: component.videoUrl,
          controls: false,
          preload: dom.Preload.metadata,
          attributes: {
            if (component.coverUrl.isNotEmpty) 'poster': component.coverUrl,
            'playsinline': '',
          },
          events: {
            'timeupdate': (_) => _syncVideoState(),
            'loadedmetadata': (_) => _syncVideoState(),
            'durationchange': (_) => _syncVideoState(),
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
            'click': (_) => _togglePlayback(),
          },
        ),

        div(classes: 'watch-player-topbar', [
          span(classes: 'watch-player-badge', [.text('CLYVEN')]),
        ]),

        if (!_playing)
          button(
            type: ButtonType.button,
            classes: 'watch-player-center-play',
            onClick: _togglePlayback,
            [.text('▶')],
          ),

        if (component.subtitlesEnabled &&
            component.overlayMode &&
            (primary != null || secondary != null))
          div(classes: 'watch-caption-layer', [
            if (primary != null) _caption(primary, component.primaryScriptCode),
            if (primary != null && secondary != null)
              div(classes: 'watch-caption-gap', []),
            if (secondary != null)
              _caption(
                secondary,
                component.secondaryScriptCode,
                secondary: true,
              ),
          ]),

        div(classes: 'watch-player-controls', [
          div(classes: 'watch-player-progress-wrap', [
            input<String>(
              type: InputType.range,
              classes: 'watch-player-progress',
              attributes: {
                'min': '0',
                'max': '1000',
                'step': '1',
                'value': '$progress',
                'aria-label': 'Video progress',
              },
              events: events<String>(onInput: _seekToProgress),
            ),
          ]),
          div(classes: 'watch-player-control-row', [
            div(classes: 'watch-player-control-group', [
              button(
                type: ButtonType.button,
                classes: 'watch-player-icon-button watch-player-play-button',
                onClick: _togglePlayback,
                [.text(_playing ? '❚❚' : '▶')],
              ),
              button(
                type: ButtonType.button,
                classes: 'watch-player-icon-button',
                onClick: () => _seekBy(-10),
                [.text('↶ 10')],
              ),
              button(
                type: ButtonType.button,
                classes: 'watch-player-icon-button',
                onClick: () => _seekBy(10),
                [.text('10 ↷')],
              ),
              span(classes: 'watch-player-time', [
                .text(
                  '${_formatTime(_currentTime)} / ${_formatTime(_duration)}',
                ),
              ]),
            ]),
            div(
              classes:
                  'watch-player-control-group watch-player-control-group-right',
              [
                button(
                  type: ButtonType.button,
                  classes: 'watch-player-volume-button',
                  onClick: _toggleMute,
                  [.text(_volumeIcon())],
                ),
                input<String>(
                  type: InputType.range,
                  classes: 'watch-player-volume',
                  attributes: {
                    'min': '0',
                    'max': '100',
                    'step': '1',
                    'value': '${(_volume * 100).round()}',
                    'aria-label': 'Volume',
                  },
                  events: events<String>(onInput: _changeVolume),
                ),
                button(
                  type: ButtonType.button,
                  classes: 'watch-player-pill-button',
                  onClick: _cyclePlaybackRate,
                  [.text('${_playbackRate}×')],
                ),
                button(
                  type: ButtonType.button,
                  classes:
                      'watch-player-pill-button'
                      '${component.subtitlesEnabled ? ' is-active' : ''}',
                  onClick: component.onSubtitleSettings,
                  [.text('CC')],
                ),
                button(
                  type: ButtonType.button,
                  classes: 'watch-player-icon-button',
                  onClick: _toggleFullscreen,
                  [.text('⛶')],
                ),
              ],
            ),
          ]),
        ]),

        if (component.settingsPanel != null) component.settingsPanel!,
      ]),
    ]);
  }
}
