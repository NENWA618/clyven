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

  @override
  State<WatchSubtitlePlayer> createState() => _WatchSubtitlePlayerState();
}

class _WatchSubtitlePlayerState extends State<WatchSubtitlePlayer> {
  int _currentMs = 0;

  String get _elementId => 'clyven-watch-video-${component.videoId}';

  html.VideoElement? get _video =>
      html.document.getElementById(_elementId) as html.VideoElement?;

  void _syncTime() {
    final video = _video;
    if (video == null) return;

    final milliseconds = (video.currentTime * 1000).round();
    if (milliseconds == _currentMs) return;

    setState(() {
      _currentMs = milliseconds;
    });

    component.onTimeChanged(milliseconds);
  }

  api.SubtitleCueDetail? _active(List<api.SubtitleCueDetail> details) {
    for (final detail in details) {
      if (_currentMs >= detail.cue.startMs && _currentMs < detail.cue.endMs) {
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

  String _normalize(String value) {
    return value.replaceAll(RegExp(r'\s+'), '').trim();
  }

  bool _karaokeMatches(
    api.SubtitleCueDetail detail,
    List<api.SubtitleKaraokeSegment> segments,
  ) {
    if (segments.isEmpty) return false;
    return _normalize(segments.map((segment) => segment.text).join()) ==
        _normalize(detail.cue.text);
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

    final relativeMs = _currentMs - detail.cue.startMs;

    String styleFor(api.SubtitleKaraokeSegment segment) {
      final duration = segment.endOffsetMs - segment.startOffsetMs;

      double progress;
      if (relativeMs <= segment.startOffsetMs) {
        progress = 0;
      } else if (relativeMs >= segment.endOffsetMs) {
        progress = 1;
      } else if (duration <= 0) {
        progress = 1;
      } else {
        progress = (relativeMs - segment.startOffsetMs) / duration;
      }

      final percent = (progress.clamp(0.0, 1.0) * 100).toStringAsFixed(2);

      final completed = secondary ? '#a7f3d0' : '#60a5fa';
      final pending = secondary ? '#d1d5db' : '#ffffff';

      return 'background: linear-gradient(90deg, '
          '$completed 0%, $completed $percent%, '
          '$pending $percent%, $pending 100%); '
          '-webkit-background-clip: text; '
          'background-clip: text; color: transparent;';
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
    final primary = _active(component.primaryCues);
    final secondary = _active(component.secondaryCues);

    return div(classes: 'watch-player-shell', [
      div(classes: 'watch-player-stage', [
        dom.video(
          [],
          id: _elementId,
          classes: 'watch-video-element',
          src: component.videoUrl,
          controls: true,
          preload: dom.Preload.metadata,
          attributes: {
            if (component.coverUrl.isNotEmpty) 'poster': component.coverUrl,
            'playsinline': '',
          },
          events: {
            'timeupdate': (_) => _syncTime(),
            'seeked': (_) => _syncTime(),
            'loadedmetadata': (_) => _syncTime(),
          },
        ),
        button(
          type: ButtonType.button,
          classes:
              'watch-cc-button'
              '${component.subtitlesEnabled ? ' is-active' : ''}',
          onClick: component.onSubtitleSettings,
          [.text(component.subtitlesEnabled ? 'CC' : 'CC ×')],
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
      ]),
    ]);
  }
}
