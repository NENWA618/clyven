import 'dart:async';
import 'dart:io';

import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'interactive_subtitle_overlay.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String coverUrl;
  final List<serverpod.SubtitleCueDetail> subtitles;
  final List<serverpod.SubtitleCueDetail> secondarySubtitles;
  final String? subtitleLanguageCode;
  final String? subtitleScriptCode;
  final String? secondarySubtitleLanguageCode;
  final String? secondarySubtitleScriptCode;
  final bool subtitlesEnabled;
  final ValueChanged<int>? onSubtitlePositionChanged;
  final VoidCallback? onSubtitlesPressed;
  final int initialPositionSeconds;
  final int fallbackDurationSeconds;
  final bool compact;
  final void Function(Duration position, Duration duration)? onProgress;

  const NetworkVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.coverUrl,
    required this.subtitles,
    this.secondarySubtitles = const <serverpod.SubtitleCueDetail>[],
    this.subtitleLanguageCode,
    this.subtitleScriptCode,
    this.secondarySubtitleLanguageCode,
    this.secondarySubtitleScriptCode,
    this.subtitlesEnabled = true,
    this.onSubtitlePositionChanged,
    this.onSubtitlesPressed,
    required this.initialPositionSeconds,
    required this.fallbackDurationSeconds,
    this.compact = false,
    this.onProgress,
  });

  @override
  State<NetworkVideoPlayer> createState() {
    return _NetworkVideoPlayerState();
  }
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeFuture;

  final Stopwatch _fallbackClock = Stopwatch();
  Timer? _positionTicker;
  Duration _fallbackBasePosition = Duration.zero;
  int _lastSavedSecond = -1;

  @override
  void initState() {
    super.initState();

    final isNetworkVideo =
        widget.videoUrl.startsWith('http://') ||
        widget.videoUrl.startsWith('https://');

    if (isNetworkVideo) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
    } else {
      _controller = VideoPlayerController.file(File(widget.videoUrl));
    }

    _initializeFuture = _initializePlayer();
    _controller.addListener(_handleProgress);
  }

  serverpod.SubtitleCueDetail? _findActiveSubtitle(
    List<serverpod.SubtitleCueDetail> subtitles,
    Duration position,
  ) {
    final currentMs = position.inMilliseconds;

    for (final detail in subtitles) {
      final cue = detail.cue;

      if (currentMs >= cue.startMs && currentMs < cue.endMs) {
        return detail;
      }
    }

    return null;
  }

  Future<void> _initializePlayer() async {
    await _controller.initialize();
    await _controller.setLooping(false);

    final duration = _effectiveDuration();
    final savedPosition = widget.initialPositionSeconds;

    if (savedPosition <= 0) {
      _fallbackBasePosition = Duration.zero;
      return;
    }

    if (duration.inSeconds > 0 && savedPosition >= duration.inSeconds - 5) {
      _fallbackBasePosition = Duration.zero;
      return;
    }

    final position = Duration(seconds: savedPosition);

    _fallbackBasePosition = position;
    await _controller.seekTo(position);
  }

  Duration _effectiveDuration() {
    final controllerDuration = _controller.value.duration;

    if (controllerDuration.inSeconds > 0) {
      return controllerDuration;
    }

    return Duration(seconds: widget.fallbackDurationSeconds);
  }

  bool get _needsFallbackPosition {
    return _controller.value.duration.inSeconds <= 0 &&
        widget.fallbackDurationSeconds > 0;
  }

  Duration _effectivePosition() {
    if (!_needsFallbackPosition) {
      return _controller.value.position;
    }

    final duration = _effectiveDuration();
    final position = _fallbackBasePosition + _fallbackClock.elapsed;

    if (position > duration) {
      return duration;
    }

    return position;
  }

  void _startPositionTicker() {
    _positionTicker ??= Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!mounted || !_fallbackClock.isRunning) {
        return;
      }

      final position = _effectivePosition();
      _handleProgress();

      if (position >= _effectiveDuration()) {
        _fallbackClock.stop();
      }

      setState(() {});
    });
  }

  void _handleProgress() {
    if (!_controller.value.isInitialized) {
      return;
    }

    final position = _effectivePosition();

    widget.onSubtitlePositionChanged?.call(position.inMilliseconds);
    final duration = _effectiveDuration();
    final second = position.inSeconds;

    if (second <= 0 || second == _lastSavedSecond || second % 5 != 0) {
      return;
    }

    _lastSavedSecond = second;
    widget.onProgress?.call(position, duration);
  }

  @override
  void dispose() {
    _positionTicker?.cancel();
    _fallbackClock.stop();
    _controller.removeListener(_handleProgress);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    final isPhoneSubtitleLayout = MediaQuery.sizeOf(context).width < 600;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: FutureBuilder<void>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildPlayerError();
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoadingCover();
          }

          return ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              final duration = _effectiveDuration();
              final position = _effectivePosition();
              final activeSubtitle = _findActiveSubtitle(
                widget.subtitles,
                position,
              );
              final activeSecondarySubtitle = _findActiveSubtitle(
                widget.secondarySubtitles,
                position,
              );
              final maxMilliseconds = duration.inMilliseconds;
              final positionMilliseconds = position.inMilliseconds.clamp(
                0,
                maxMilliseconds > 0 ? maxMilliseconds : 0,
              );

              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: value.aspectRatio == 0
                            ? 16 / 9
                            : value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _togglePlay,
                      child: const SizedBox.expand(),
                    ),
                  ),
                  if (!widget.compact && widget.onSubtitlesPressed != null)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Material(
                        color: Colors.black.withValues(alpha: 0.52),
                        shape: const CircleBorder(),
                        child: Listener(
                          behavior: HitTestBehavior.opaque,
                          onPointerDown: (_) {
                            widget.onSubtitlesPressed?.call();
                          },
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(
                              widget.subtitlesEnabled
                                  ? Icons.closed_caption_rounded
                                  : Icons.closed_caption_off_rounded,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!widget.compact && !value.isPlaying)
                    Center(
                      child: GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            size: 42,
                            color: Color(0xFF161616),
                          ),
                        ),
                      ),
                    ),
                  if (!widget.compact &&
                      widget.subtitlesEnabled &&
                      (activeSubtitle != null ||
                          activeSecondarySubtitle != null))
                    Positioned(
                      left: isPhoneSubtitleLayout ? 12 : 24,
                      right: isPhoneSubtitleLayout ? 12 : 24,
                      bottom: isPhoneSubtitleLayout ? 52 : 58,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isPhoneSubtitleLayout ? 8 : 12,
                            vertical: isPhoneSubtitleLayout ? 5 : 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.68),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (activeSubtitle != null)
                                InteractiveSubtitleOverlay(
                                  detail: activeSubtitle,
                                  videoPositionMs: position.inMilliseconds,
                                  languageCode:
                                      widget.subtitleLanguageCode ?? 'und',
                                  scriptCode: widget.subtitleScriptCode,
                                ),
                              if (activeSubtitle != null &&
                                  activeSecondarySubtitle != null)
                                SizedBox(height: isPhoneSubtitleLayout ? 2 : 4),
                              if (activeSecondarySubtitle != null)
                                Opacity(
                                  opacity: 0.82,
                                  child: InteractiveSubtitleOverlay(
                                    detail: activeSecondarySubtitle,
                                    videoPositionMs: position.inMilliseconds,
                                    languageCode:
                                        widget.secondarySubtitleLanguageCode ??
                                        'und',
                                    scriptCode:
                                        widget.secondarySubtitleScriptCode,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!widget.compact)
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 10,
                      child: Column(
                        children: [
                          if (maxMilliseconds > 0)
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 5,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max: maxMilliseconds.toDouble(),
                                value: positionMilliseconds.toDouble(),
                                activeColor: accent,
                                inactiveColor: Colors.white24,
                                onChanged: (value) {
                                  final position = Duration(
                                    milliseconds: value.round(),
                                  );

                                  _fallbackBasePosition = position;
                                  _fallbackClock
                                    ..stop()
                                    ..reset();

                                  if (_controller.value.isPlaying &&
                                      _needsFallbackPosition) {
                                    _fallbackClock.start();
                                    _startPositionTicker();
                                  }

                                  _controller.seekTo(position);
                                  setState(() {});
                                },
                              ),
                            )
                          else
                            LinearProgressIndicator(
                              value: 0,
                              minHeight: 4,
                              color: accent,
                              backgroundColor: Colors.white24,
                            ),
                          Row(
                            children: [
                              Text(
                                _playerTime(position),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                ' / ',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                _playerTime(duration),
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.fullscreen_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (widget.compact)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: IgnorePointer(
                        child: LinearProgressIndicator(
                          value: maxMilliseconds > 0
                              ? positionMilliseconds / maxMilliseconds
                              : 0,
                          minHeight: 2,
                          color: accent,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingCover() {
    final isNetworkCover =
        widget.coverUrl.startsWith('http://') ||
        widget.coverUrl.startsWith('https://');
    final accent = Theme.of(context).colorScheme.primary;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget.coverUrl.isEmpty)
          Container(color: Colors.black)
        else if (isNetworkCover)
          Image.network(
            widget.coverUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.black);
            },
          )
        else
          Image.file(
            File(widget.coverUrl),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.black);
            },
          ),
        Container(color: Colors.black38),
        Center(child: CircularProgressIndicator(color: accent)),
      ],
    );
  }

  Widget _buildPlayerError() {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: const Color(0xFF161616),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_disabled_rounded,
              color: Colors.white54,
              size: 38,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.videoCannotPlay,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _togglePlay() async {
    if (_controller.value.isPlaying) {
      if (_needsFallbackPosition) {
        _fallbackBasePosition = _effectivePosition();
        _fallbackClock
          ..stop()
          ..reset();
      }

      _handleProgress();
      await _controller.pause();
    } else {
      if (_needsFallbackPosition) {
        _fallbackClock
          ..reset()
          ..start();
        _startPositionTicker();
      }

      await _controller.play();
    }

    if (mounted) {
      setState(() {});
    }
  }

  String _playerTime(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (duration.inHours > 0) {
      return '${duration.inHours}:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }
}
