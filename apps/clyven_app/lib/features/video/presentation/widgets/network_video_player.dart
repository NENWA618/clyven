import 'dart:async';
import 'dart:io';

import 'package:clyven_app/core/serverpod/serverpod_client_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/serverpod/feed_diagnostics.dart';
import 'interactive_subtitle_overlay.dart';

class NetworkVideoPlayer extends ConsumerStatefulWidget {
  final int? videoId;
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
  final bool shortsMode;
  final bool autoplay;
  final bool looping;
  final bool active;
  final VoidCallback? onDoubleTap;
  final void Function(Duration position, Duration duration)? onProgress;

  const NetworkVideoPlayer({
    super.key,
    required this.videoId,
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
    this.shortsMode = false,
    this.autoplay = false,
    this.looping = false,
    this.active = true,
    this.onDoubleTap,
    this.onProgress,
  });

  @override
  ConsumerState<NetworkVideoPlayer> createState() {
    return _NetworkVideoPlayerState();
  }
}

class _NetworkVideoPlayerState extends ConsumerState<NetworkVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeFuture;
  bool _controllerCreated = false;
  final Set<VideoPlayerController> _releasedControllers = {};
  int _generation = 0;
  bool _initializationFailed = false;
  bool _reportedNativeError = false;
  Timer? _initializationTimer;
  Completer<void>? _initializationCompleter;
  String _initializationStage = 'resolve_source';

  final Stopwatch _fallbackClock = Stopwatch();
  Timer? _positionTicker;
  Duration _fallbackBasePosition = Duration.zero;
  int _lastSavedSecond = -1;
  OverlayEntry? _fullscreenOverlay;
  Timer? _fullscreenControlsTimer;
  bool _fullscreenControlsVisible = true;

  Timer? _doubleTapHeartTimer;
  bool _showDoubleTapHeart = false;
  int _doubleTapHeartSeed = 0;

  @override
  void initState() {
    super.initState();
    _startPlayer();
  }

  void _startPlayer() {
    final generation = ++_generation;
    _initializationFailed = false;
    _reportedNativeError = false;
    _initializationStage = 'resolve_source';

    feedDiagnostic(
      'PLAYBACK_INITIALIZING postId=${widget.videoId ?? 'unknown'} '
      'host=${Uri.tryParse(widget.videoUrl)?.host ?? ''}',
    );

    final completion = Completer<void>();
    _initializationCompleter = completion;
    _initializeFuture = completion.future;
    _initializationTimer?.cancel();

    void fail(Object error, StackTrace stack) {
      if (completion.isCompleted) return;
      _initializationTimer?.cancel();
      if (mounted && generation == _generation) {
        _initializationFailed = true;
        final reason = error is TimeoutException
            ? 'timeout'
            : error is PlatformException
            ? error.code
            : '${error.runtimeType}';
        feedDiagnostic(
          'PLAYBACK_INIT_FAILED postId=${widget.videoId ?? 'unknown'} '
          'stage=$_initializationStage reason=$reason',
        );
        ++_generation;
        _releaseCurrentController();
      }
      completion.completeError(error, stack);
    }

    _initializationTimer = Timer(const Duration(seconds: 30), () {
      fail(
        TimeoutException('Video initialization timed out'),
        StackTrace.current,
      );
    });

    unawaited(
      _initializePlayer(generation).then((_) {
        if (completion.isCompleted) return;
        _initializationTimer?.cancel();
        if (generation != _generation || _initializationFailed) return;
        feedDiagnostic('PLAYBACK_READY postId=${widget.videoId ?? 'unknown'}');
        completion.complete();
      }, onError: fail),
    );
  }

  bool _isGenerationActive(int generation) {
    return mounted && generation == _generation && !_initializationFailed;
  }

  void _release(VideoPlayerController controller) {
    if (!_releasedControllers.add(controller)) return;
    controller.removeListener(_handleProgress);
    if (_controllerCreated && identical(_controller, controller)) {
      _controllerCreated = false;
    }
    unawaited(
      controller.dispose().catchError((Object error) {
        feedDiagnostic('PLAYBACK_DISPOSE_FAILED reason=${error.runtimeType}');
      }),
    );
  }

  void _releaseCurrentController() {
    if (_controllerCreated) _release(_controller);
  }

  void _cancelInitialization() {
    _initializationTimer?.cancel();
    final completion = _initializationCompleter;
    if (completion != null && !completion.isCompleted) completion.complete();
  }

  void _resetPlayer() {
    _closeFullscreen();
    _cancelInitialization();
    ++_generation;
    _releaseCurrentController();
    _positionTicker?.cancel();
    _positionTicker = null;
    _fallbackClock
      ..stop()
      ..reset();
    _fallbackBasePosition = Duration.zero;
    _lastSavedSecond = -1;
    _startPlayer();
  }

  @override
  void didUpdateWidget(covariant NetworkVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl ||
        widget.videoId != oldWidget.videoId) {
      _resetPlayer();
      return;
    }

    if (widget.looping != oldWidget.looping &&
        _controllerCreated &&
        _controller.value.isInitialized) {
      unawaited(_controller.setLooping(widget.looping));
    }

    if ((widget.active != oldWidget.active ||
            widget.autoplay != oldWidget.autoplay) &&
        _controllerCreated &&
        _controller.value.isInitialized) {
      if (widget.active && widget.autoplay) {
        unawaited(_controller.play());
      } else if (!widget.active) {
        unawaited(_controller.pause());
      }
    }
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

  VideoPlayerController _createController(String source) {
    final isNetworkVideo =
        source.startsWith('http://') || source.startsWith('https://');

    if (isNetworkVideo) {
      return VideoPlayerController.networkUrl(Uri.parse(source));
    }

    return VideoPlayerController.file(File(source));
  }

  Future<String?> _fetchPlaybackManifestUrl() async {
    final videoId = widget.videoId;

    if (videoId == null) {
      return null;
    }

    try {
      final client = ref.read(serverpodClientProvider);
      final manifestUrl = await client.video.getPlaybackManifestUrl(
        videoId: videoId,
      );
      final normalized = manifestUrl?.trim();

      if (normalized == null || normalized.isEmpty) {
        return null;
      }

      return normalized;
    } catch (error, stackTrace) {
      debugPrint('Failed to resolve HLS manifest for video $videoId: $error');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }

  Future<bool> _tryInitializeSource(
    String source,
    int generation, {
    required String sourceKind,
  }) async {
    if (!_isGenerationActive(generation)) return false;

    final controller = _createController(source);
    _controller = controller;
    _controllerCreated = true;
    _initializationStage = 'native_initialize';

    try {
      await controller.initialize();
      if (!_isGenerationActive(generation)) {
        _release(controller);
        return false;
      }

      _initializationStage = 'set_looping';
      await controller.setLooping(widget.looping);
      if (!_isGenerationActive(generation)) {
        _release(controller);
        return false;
      }

      controller.addListener(_handleProgress);
      if (widget.autoplay && widget.active) {
        await controller.play();
      }
      if (kDebugMode) {
        final value = controller.value;
        debugPrint(
          'PLAYBACK_GEOMETRY videoId=${widget.videoId ?? 'unknown'} '
          'SOURCE=$sourceKind SIZE=${value.size.width}x${value.size.height} '
          'ASPECT_RATIO=${value.aspectRatio} '
          'ROTATION=${value.rotationCorrection}',
        );
      }
      return true;
    } catch (error, stackTrace) {
      feedDiagnostic(
        'PLAYBACK_SOURCE_FAILED postId=${widget.videoId ?? 'unknown'} '
        'stage=$_initializationStage reason=${error.runtimeType}',
      );
      debugPrintStack(stackTrace: stackTrace);
      _release(controller);
      return false;
    }
  }

  Future<bool> _waitForTranscodedPlayback(int generation) async {
    for (var attempt = 0; attempt < 24; attempt++) {
      if (!_isGenerationActive(generation)) return false;

      if (attempt > 0) {
        await Future<void>.delayed(const Duration(seconds: 5));
        if (!_isGenerationActive(generation)) return false;
      }

      final manifestUrl = await _fetchPlaybackManifestUrl();
      if (!_isGenerationActive(generation)) return false;
      if (manifestUrl == null) continue;

      if (await _tryInitializeSource(
        manifestUrl,
        generation,
        sourceKind: 'HLS',
      )) {
        return true;
      }
    }
    return false;
  }

  Future<void> _initializePlayer(int generation) async {
    final manifestUrl = await _fetchPlaybackManifestUrl();
    if (!_isGenerationActive(generation)) return;

    var initialized = false;
    if (manifestUrl != null) {
      initialized = await _tryInitializeSource(
        manifestUrl,
        generation,
        sourceKind: 'HLS',
      );
    }
    if (!initialized && _isGenerationActive(generation)) {
      initialized = await _tryInitializeSource(
        widget.videoUrl,
        generation,
        sourceKind: 'ORIGINAL',
      );
    }
    if (!initialized && _isGenerationActive(generation)) {
      initialized = await _waitForTranscodedPlayback(generation);
    }
    if (!_isGenerationActive(generation)) return;

    if (!initialized) {
      throw StateError(
        'Neither the HLS stream nor the original video could be played.',
      );
    }

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
    _initializationStage = 'restore_position';
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
    if (_controller.value.hasError) {
      if (!_reportedNativeError) {
        _reportedNativeError = true;
        final description =
            _controller.value.errorDescription?.toLowerCase() ?? '';
        final reason = description.contains('decoder')
            ? 'decoder'
            : description.contains('source error')
            ? 'source'
            : description.contains('renderer')
            ? 'renderer'
            : 'native';
        feedDiagnostic(
          'PLAYBACK_NATIVE_ERROR postId=${widget.videoId ?? 'unknown'} '
          'reason=$reason',
        );
      }
      return;
    }

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

  void _scheduleFullscreenControlsHide() {
    _fullscreenControlsTimer?.cancel();

    if (!_controller.value.isPlaying) {
      _fullscreenControlsVisible = true;
      _fullscreenOverlay?.markNeedsBuild();
      return;
    }

    _fullscreenControlsTimer = Timer(const Duration(seconds: 3), () {
      if (_fullscreenOverlay == null) return;
      _fullscreenControlsVisible = false;
      _fullscreenOverlay?.markNeedsBuild();
    });
  }

  void _showFullscreenControls() {
    _fullscreenControlsVisible = true;
    _fullscreenOverlay?.markNeedsBuild();
    _scheduleFullscreenControlsHide();
  }

  void _toggleFullscreenControls() {
    _fullscreenControlsVisible = !_fullscreenControlsVisible;
    _fullscreenOverlay?.markNeedsBuild();

    if (_fullscreenControlsVisible) {
      _scheduleFullscreenControlsHide();
    } else {
      _fullscreenControlsTimer?.cancel();
    }
  }

  void _seekFullscreenBy(Duration delta) {
    final duration = _effectiveDuration();
    if (duration <= Duration.zero) return;

    final current = _effectivePosition();
    var target = current + delta;

    if (target < Duration.zero) target = Duration.zero;
    if (target > duration) target = duration;

    _fallbackBasePosition = target;
    _fallbackClock
      ..stop()
      ..reset();

    if (_controller.value.isPlaying && _needsFallbackPosition) {
      _fallbackClock.start();
      _startPositionTicker();
    }

    unawaited(_controller.seekTo(target));
    _showFullscreenControls();
  }

  Future<void> _openFullscreen() async {
    if (!mounted || !_controller.value.isInitialized) return;

    if (_fullscreenOverlay != null) {
      _closeFullscreen();
      return;
    }

    final overlay = Overlay.of(context, rootOverlay: true);

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) {
        return Material(
          color: Colors.black,
          child: ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              final duration = _effectiveDuration();
              final position = _effectivePosition();
              final maxMilliseconds = duration.inMilliseconds;
              final positionMilliseconds = position.inMilliseconds.clamp(
                0,
                maxMilliseconds > 0 ? maxMilliseconds : 0,
              );

              final activeSubtitle = _findActiveSubtitle(
                widget.subtitles,
                position,
              );
              final activeSecondarySubtitle = _findActiveSubtitle(
                widget.secondarySubtitles,
                position,
              );

              final controlsVisible =
                  _fullscreenControlsVisible || !value.isPlaying;

              return Stack(
                fit: StackFit.expand,
                children: [
                  const ColoredBox(color: Colors.black),
                  Center(
                    child: AspectRatio(
                      aspectRatio: value.aspectRatio == 0
                          ? 16 / 9
                          : value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _toggleFullscreenControls,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onDoubleTap: () => _seekFullscreenBy(
                                const Duration(seconds: -10),
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onDoubleTap: () => _seekFullscreenBy(
                                const Duration(seconds: 10),
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.subtitlesEnabled &&
                      (activeSubtitle != null ||
                          activeSecondarySubtitle != null))
                    Positioned(
                      left: 24,
                      right: 24,
                      bottom: controlsVisible ? 96 : 36,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.60),
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
                                const SizedBox(height: 4),
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
                  Center(
                    child: IgnorePointer(
                      ignoring: !controlsVisible,
                      child: AnimatedOpacity(
                        opacity: controlsVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: InkResponse(
                          onTap: () {
                            _togglePlay();
                            _showFullscreenControls();
                          },
                          radius: 44,
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.42),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              value.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    right: 8,
                    top: 8,
                    child: IgnorePointer(
                      ignoring: !controlsVisible,
                      child: AnimatedOpacity(
                        opacity: controlsVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: SafeArea(
                          bottom: false,
                          child: Row(
                            children: [
                              IconButton(
                                tooltip: 'Exit fullscreen',
                                onPressed: _closeFullscreen,
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 4,
                    child: IgnorePointer(
                      ignoring: !controlsVisible,
                      child: AnimatedOpacity(
                        opacity: controlsVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: SafeArea(
                          top: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (maxMilliseconds > 0)
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2.5,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 5,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 10,
                                    ),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: maxMilliseconds.toDouble(),
                                    value: positionMilliseconds.toDouble(),
                                    onChanged: (value) {
                                      final target = Duration(
                                        milliseconds: value.round(),
                                      );

                                      _fallbackBasePosition = target;
                                      _fallbackClock
                                        ..stop()
                                        ..reset();

                                      if (_controller.value.isPlaying &&
                                          _needsFallbackPosition) {
                                        _fallbackClock.start();
                                        _startPositionTicker();
                                      }

                                      unawaited(_controller.seekTo(target));
                                      _showFullscreenControls();
                                    },
                                  ),
                                ),
                              Row(
                                children: [
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    onPressed: () {
                                      _togglePlay();
                                      _showFullscreenControls();
                                    },
                                    icon: Icon(
                                      value.isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    '${_playerTime(position)} / ${_playerTime(duration)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    tooltip: 'Exit fullscreen',
                                    onPressed: _closeFullscreen,
                                    icon: const Icon(
                                      Icons.fullscreen_exit_rounded,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    _fullscreenOverlay = entry;
    overlay.insert(entry);
    _scheduleFullscreenControlsHide();

    try {
      await SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } catch (error, stackTrace) {
      debugPrint('FULLSCREEN_SYSTEM_UI_FAILED: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _closeFullscreen() {
    final entry = _fullscreenOverlay;
    if (entry == null) return;

    _fullscreenControlsTimer?.cancel();
    _fullscreenControlsTimer = null;
    _fullscreenOverlay = null;
    entry.remove();

    unawaited(
      Future<void>(() async {
        try {
          await SystemChrome.setPreferredOrientations(const [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        } catch (error, stackTrace) {
          debugPrint('FULLSCREEN_RESTORE_UI_FAILED: $error');
          debugPrintStack(stackTrace: stackTrace);
        }
      }),
    );
  }

  @override
  void dispose() {
    _doubleTapHeartTimer?.cancel();
    _closeFullscreen();
    _cancelInitialization();
    _positionTicker?.cancel();
    _fallbackClock.stop();
    ++_generation;
    _releaseCurrentController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    final isPhoneSubtitleLayout = MediaQuery.sizeOf(context).width < 600;

    final playerAspectRatio =
        _controllerCreated &&
            _controller.value.isInitialized &&
            !widget.compact &&
            _controller.value.aspectRatio > 0
        ? _controller.value.aspectRatio.clamp(9 / 20, 16 / 9).toDouble()
        : 16 / 9;

    final player = FutureBuilder<void>(
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
            if (value.hasError) return _buildPlayerError();
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
                    onDoubleTap: widget.onDoubleTap == null
                        ? null
                        : _handleShortsDoubleTap,
                    child: const SizedBox.expand(),
                  ),
                ),
                if (widget.shortsMode && widget.onDoubleTap != null)
                  IgnorePointer(
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _showDoubleTapHeart ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,
                        child: TweenAnimationBuilder<double>(
                          key: ValueKey('shorts-heart-$_doubleTapHeartSeed'),
                          tween: Tween<double>(begin: .35, end: 1),
                          duration: const Duration(milliseconds: 420),
                          curve: Curves.elasticOut,
                          builder: (context, scale, child) {
                            return Transform.scale(scale: scale, child: child);
                          },
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 112,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 18),
                            ],
                          ),
                        ),
                      ),
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
                    (activeSubtitle != null || activeSecondarySubtitle != null))
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
                            IconButton(
                              tooltip: 'Fullscreen',
                              visualDensity: VisualDensity.compact,
                              onPressed: _openFullscreen,
                              icon: const Icon(
                                Icons.fullscreen_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
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
    );

    if (widget.shortsMode) {
      return SizedBox.expand(child: player);
    }

    return AspectRatio(aspectRatio: playerAspectRatio, child: player);
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
            TextButton(
              onPressed: () => setState(_resetPlayer),
              child: Text(l10n.reload),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShortsDoubleTap() {
    final callback = widget.onDoubleTap;
    if (callback == null) {
      return;
    }

    callback();

    _doubleTapHeartTimer?.cancel();

    setState(() {
      _showDoubleTapHeart = true;
      _doubleTapHeartSeed++;
    });

    _doubleTapHeartTimer = Timer(const Duration(milliseconds: 520), () {
      if (!mounted) return;

      setState(() {
        _showDoubleTapHeart = false;
      });
    });
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
