import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/video_detail.dart';
import '../providers/video_detail_provider.dart';
import '../../../comments/presentation/pages/comments_page.dart';
import '../../../creator/presentation/pages/creator_profile_page.dart';
import '../../../video_interactions/presentation/providers/video_interaction_provider.dart';
import '../../../history/presentation/providers/watch_history_provider.dart';
import '../../../creator/presentation/providers/creator_profile_provider.dart';
import '../../../auth/presentation/utils/require_login.dart';

class VideoDetailPage extends ConsumerWidget {
  final String videoId;

  const VideoDetailPage({
    super.key,
    required this.videoId,
  });

  static const Color _backgroundColor = Color(0xFFF4F1EA);
  static const Color _inkColor = Color(0xFF161616);
  static const Color _purpleColor = Color(0xFF7657FF);
  static const Color _acidColor = Color(0xFFE5FF58);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoAsync = ref.watch(
      videoDetailProvider(videoId),
    );

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: videoAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 42,
                          color: _inkColor,
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          '视频加载失败',
                          style: TextStyle(
                            color: _inkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            ref.invalidate(
                              videoDetailProvider(videoId),
                            );
                          },
                          child: const Text('重新加载'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        data: (video) {
          return _buildContent(
            context,
            ref,
            video,
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    VideoDetail video,
  ) {

    final historyItem = ref.watch(
      watchHistoryItemProvider(video.id),
    );

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildTopBar(context),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
                child: _NetworkVideoPlayer(
  videoUrl: video.videoUrl,
  coverUrl: video.coverUrl,
  initialPositionSeconds:
      historyItem?.positionSeconds ?? 0,
  fallbackDurationSeconds:
      video.durationSeconds,
                onProgress: (
                  position,
                  duration,
                ) {
                  ref
                      .read(
                        watchHistoryProvider.notifier,
                      )
                      .saveProgress(
                        videoId: video.id,
                        title: video.title,
                        coverUrl: video.coverUrl,
                        authorName: video.authorName,
                        positionSeconds:
                            position.inSeconds,
                        durationSeconds:
                            duration.inSeconds > 0
                                ? duration.inSeconds
                                : video.durationSeconds,
                      );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _buildVideoInformation(video),
          ),

          SliverToBoxAdapter(
            child: _buildActions(
              context,
              ref,
              video,
            ),
          ),

          SliverToBoxAdapter(
            child: _buildCreator(
              context,
              ref,
              video,
            ),
          ),

          SliverToBoxAdapter(
            child: _buildDescription(video),
          ),

          SliverToBoxAdapter(
            child: _buildTags(video),
          ),

          SliverToBoxAdapter(
            child: _buildCommentEntry(
              context,
              video,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 70),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        14,
        10,
        14,
        12,
      ),
      child: Row(
        children: [
          _SquareButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FRAME',
                  style: TextStyle(
                    color: Color(0xFF77736C),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '正在观看',
                  style: TextStyle(
                    color: _inkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          _SquareButton(
            icon: Icons.more_horiz_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInformation(VideoDetail video) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _acidColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  video.category,
                  style: const TextStyle(
                    color: _inkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const Spacer(),

              Text(
                _formatDate(video.publishedAt),
                style: const TextStyle(
                  color: Color(0xFF8A857D),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            video.title,
            style: const TextStyle(
              color: _inkColor,
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              const Icon(
                Icons.play_circle_outline_rounded,
                size: 16,
                color: Color(0xFF77736C),
              ),

              const SizedBox(width: 5),

              Text(
                '${_formatCount(video.viewCount)} 次观看',
                style: const TextStyle(
                  color: Color(0xFF77736C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 14),

              Container(
                width: 3,
                height: 3,
                decoration: const BoxDecoration(
                  color: Color(0xFFAAA49B),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 14),

              Text(
                _formatDuration(video.durationSeconds),
                style: const TextStyle(
                  color: Color(0xFF77736C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildActions(
  BuildContext context,
  WidgetRef ref,
  VideoDetail video,
) {
  final interactionAsync = ref.watch(
    videoInteractionProvider(
      video.id,
    ),
  );

  final interaction =
      interactionAsync.value;

  final likeCount =
      interaction?.likeCount ??
      video.likeCount;

  final favoriteCount =
      interaction?.favoriteCount ??
      video.favoriteCount;

  final isLiked =
      interaction?.isLiked ?? false;

  final isFavorited =
      interaction?.isFavorited ?? false;

  return Padding(
    padding: const EdgeInsets.fromLTRB(
      20,
      24,
      20,
      0,
    ),
    child: Container(
      height: 82,
      decoration: BoxDecoration(
        color: _inkColor,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _ActionButton(
            icon: isLiked
                ? Icons.favorite_rounded
                : Icons
                    .favorite_border_rounded,
            value:
                _formatCount(likeCount),
            label: '喜欢',
            onTap: () async {
  final state = interactionAsync.value;

  if (state?.isChangingLike == true) {
    return;
  }

  final allowed = await requireLogin(
    context,
    ref,
  );

  if (!allowed || !context.mounted) {
    return;
  }

  await ref
      .read(
        videoInteractionProvider(
          video.id,
        ).notifier,
      )
      .toggleLike();
},
          ),

          _ActionButton(
            icon: isFavorited
                ? Icons.bookmark_rounded
                : Icons
                    .bookmark_border_rounded,
            value: _formatCount(
              favoriteCount,
            ),
            label: '收藏',
            onTap: () async {
  final state = interactionAsync.value;

  if (state?.isChangingFavorite == true) {
    return;
  }

  final allowed = await requireLogin(
    context,
    ref,
  );

  if (!allowed || !context.mounted) {
    return;
  }

  await ref
      .read(
        videoInteractionProvider(
          video.id,
        ).notifier,
      )
      .toggleFavorite();
},
          ),

          _ActionButton(
            icon: Icons
                .mode_comment_outlined,
            value: _formatCount(
              video.commentCount,
            ),
            label: '讨论',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CommentsPage(
                      videoId: video.id,
                    );
                  },
                ),
              );
            },
          ),

          _ActionButton(
            icon: Icons.ios_share_rounded,
            value: '',
            label: '分享',
            onTap: () {
              _shareVideo(video);
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildCreator(
  BuildContext context,
  WidgetRef ref,
  VideoDetail video,
) {
  final creatorAsync = ref.watch(
    creatorProfileProvider(
      video.authorId,
    ),
  );

  final creatorState =
      creatorAsync.value;

  final isFollowing =
      creatorState?.isFollowing ?? false;

  final isChangingFollow =
      creatorState?.isChangingFollow ??
      creatorAsync.isLoading;

  return Padding(
    padding: const EdgeInsets.fromLTRB(
      20,
      28,
      20,
      0,
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CreatorProfilePage(
                creatorId: video.authorId,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(24),
          border: Border.all(
            color:
                const Color(0xFFE3DED5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _purpleColor,
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                video.authorName.isEmpty
                    ? '?'
                    : video.authorName
                        .substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CREATOR',
                    style: TextStyle(
                      color:
                          Color(0xFF99938A),
                      fontSize: 9,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    video.authorName,
                    style: const TextStyle(
                      color: _inkColor,
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              behavior:
                  HitTestBehavior.opaque,
              onTap: () async {
  if (creatorState == null) {
    return;
  }

  if (isChangingFollow) {
    return;
  }

  final allowed = await requireLogin(
    context,
    ref,
  );

  if (!allowed || !context.mounted) {
    return;
  }

  await ref
      .read(
        creatorProfileProvider(
          video.authorId,
        ).notifier,
      )
      .toggleFollow();
},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _acidColor,
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  isChangingFollow
                      ? '处理中'
                      : isFollowing
                          ? '已关注'
                          : '关注',
                  style: const TextStyle(
                    color: _inkColor,
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildDescription(VideoDetail video) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        30,
        20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ABOUT THIS FRAME',
            style: TextStyle(
              color: _purpleColor,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.7,
            ),
          ),

          const SizedBox(height: 11),

          Text(
            video.description,
            style: const TextStyle(
              color: Color(0xFF393632),
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(VideoDetail video) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        0,
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: video.tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFCAC5BB),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '# $tag',
              style: const TextStyle(
                color: Color(0xFF5E5A54),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

Widget _buildCommentEntry(
  BuildContext context,
  VideoDetail video,
) {
      return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        34,
        20,
        0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CommentsPage(
                  videoId: video.id,
                );
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E3DA),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: _inkColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.forum_outlined,
                  color: _acidColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '进入讨论',
                      style: TextStyle(
                        color: _inkColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '${_formatCount(video.commentCount)} 条讨论正在这里发生',
                      style: const TextStyle(
                        color: Color(0xFF77736C),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_rounded,
                color: _inkColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareVideo(
  VideoDetail video,
) async {
  await SharePlus.instance.share(
    ShareParams(
      title: video.title,
      subject: video.title,
      text:
          '${video.title}\n'
          '${video.authorName}\n\n'
          '${video.videoUrl}',
    ),
  );
}

  static String _formatCount(int value) {
    if (value >= 10000) {
      final result = value / 10000;

      if (result >= 10) {
        return '${result.toStringAsFixed(0)}万';
      }

      return '${result.toStringAsFixed(1)}万';
    }

    if (value >= 1000) {
      final result = value / 1000;
      return '${result.toStringAsFixed(1)}k';
    }

    return value.toString();
  }

  static String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);

    final hours = duration.inHours;

    final minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final remainingSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$remainingSeconds';
    }

    return '${duration.inMinutes}:$remainingSeconds';
  }

  static String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.'
        '${date.day.toString().padLeft(2, '0')}';
  }
}

class _NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String coverUrl;
  final int initialPositionSeconds;
  final int fallbackDurationSeconds;

  final void Function(
    Duration position,
    Duration duration,
  )? onProgress;

  const _NetworkVideoPlayer({
    required this.videoUrl,
    required this.coverUrl,
    required this.initialPositionSeconds,
    required this.fallbackDurationSeconds,
    this.onProgress,
  });

  @override
  State<_NetworkVideoPlayer> createState() {
    return _NetworkVideoPlayerState();
  }
}

class _NetworkVideoPlayerState
    extends State<_NetworkVideoPlayer> {
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
      _controller =
          VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
    } else {
      _controller =
          VideoPlayerController.file(
        File(widget.videoUrl),
      );
    }

    _initializeFuture = _initializePlayer();

    _controller.addListener(
      _handleProgress,
    );
  }

  Future<void> _initializePlayer() async {
  await _controller.initialize();

  await _controller.setLooping(false);

  final duration =
      _effectiveDuration();

  final savedPosition =
      widget.initialPositionSeconds;

  if (savedPosition <= 0) {
    _fallbackBasePosition =
        Duration.zero;

    return;
  }

  if (duration.inSeconds > 0 &&
      savedPosition >=
          duration.inSeconds - 5) {
    _fallbackBasePosition =
        Duration.zero;

    return;
  }

  final position = Duration(
    seconds: savedPosition,
  );

  _fallbackBasePosition =
      position;

  await _controller.seekTo(
    position,
  );
}

  Duration _effectiveDuration() {
  final controllerDuration =
      _controller.value.duration;

  // video_player 能拿到至少 1 秒，
  // 才认为它的 duration 有效。
  if (controllerDuration.inSeconds > 0) {
    return controllerDuration;
  }

  return Duration(
    seconds: widget.fallbackDurationSeconds,
  );
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

  final position =
      _fallbackBasePosition +
      _fallbackClock.elapsed;

  if (position > duration) {
    return duration;
  }

  return position;
}

void _startPositionTicker() {
  _positionTicker ??=
      Timer.periodic(
    const Duration(
      milliseconds: 250,
    ),
    (_) {
      if (!mounted ||
          !_fallbackClock.isRunning) {
        return;
      }

      final position =
          _effectivePosition();

      _handleProgress();

      if (position >=
          _effectiveDuration()) {
        _fallbackClock.stop();
      }

      setState(() {});
    },
  );
}

  void _handleProgress() {
  if (!_controller.value.isInitialized) {
    return;
  }

  final position =
      _effectivePosition();

  final duration =
      _effectiveDuration();

  final second =
      position.inSeconds;

  if (second <= 0) {
    return;
  }

  if (second == _lastSavedSecond) {
    return;
  }

  if (second % 5 != 0) {
    return;
  }

  _lastSavedSecond = second;

  widget.onProgress?.call(
    position,
    duration,
  );
}

  @override
  void dispose() {
    _positionTicker?.cancel();

    _fallbackClock.stop();

    _controller.removeListener(
      _handleProgress,
    );

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(28),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: FutureBuilder<void>(
          future: _initializeFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _buildPlayerError();
            }

            if (snapshot.connectionState !=
                ConnectionState.done) {
              return _buildLoadingCover();
            }

            return ValueListenableBuilder<
                VideoPlayerValue>(
              valueListenable: _controller,
              builder: (
                context,
                value,
                child,
              ) {
                final duration =
    _effectiveDuration();

final position =
    _effectivePosition();

final maxMilliseconds =
    duration.inMilliseconds;

final positionMilliseconds =
    position.inMilliseconds.clamp(
  0,
  maxMilliseconds > 0
      ? maxMilliseconds
      : 0,
);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.black,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio:
                              value.aspectRatio ==
                                      0
                                  ? 16 / 9
                                  : value
                                      .aspectRatio,
                          child:
                              VideoPlayer(
                            _controller,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      behavior:
                          HitTestBehavior
                              .opaque,
                      onTap: _togglePlay,
                      child: Container(
                        color:
                            Colors.transparent,
                      ),
                    ),

                    if (!value.isPlaying)
                      Center(
                        child:
                            GestureDetector(
                          onTap:
                              _togglePlay,
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white
                                  .withOpacity(
                                0.92,
                              ),
                              shape: BoxShape
                                  .circle,
                            ),
                            child:
                                const Icon(
                              Icons
                                  .play_arrow_rounded,
                              size: 42,
                              color: Color(
                                0xFF161616,
                              ),
                            ),
                          ),
                        ),
                      ),

                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 10,
                      child: Column(
                        children: [
                          if (maxMilliseconds >
                              0)
                            SliderTheme(
                              data: SliderTheme
                                  .of(context)
                                  .copyWith(
                                trackHeight: 4,
                                thumbShape:
                                    const RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      5,
                                ),
                                overlayShape:
                                    const RoundSliderOverlayShape(
                                  overlayRadius:
                                      12,
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max:
                                    maxMilliseconds
                                        .toDouble(),
                                value:
                                    positionMilliseconds
                                        .toDouble(),
                                activeColor:
                                    const Color(
                                  0xFFE5FF58,
                                ),
                                inactiveColor:
                                    Colors
                                        .white24,
                                onChanged: (value) {
  final position = Duration(
    milliseconds:
        value.round(),
  );

  _fallbackBasePosition =
      position;

  _fallbackClock
    ..stop()
    ..reset();

  if (_controller.value.isPlaying &&
      _needsFallbackPosition) {
    _fallbackClock.start();

    _startPositionTicker();
  }

  _controller.seekTo(
    position,
  );

  setState(() {});
},
                              ),
                            )
                          else
                            const LinearProgressIndicator(
                              value: 0,
                              minHeight: 4,
                              color: Color(
                                0xFFE5FF58,
                              ),
                              backgroundColor:
                                  Colors
                                      .white24,
                            ),

                          Row(
                            children: [
                              Text(
                                _playerTime(
                                  position,
                                ),
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                              ),

                              const Text(
                                ' / ',
                                style:
                                    TextStyle(
                                  color: Colors
                                      .white54,
                                  fontSize: 10,
                                ),
                              ),

                              Text(
                                _playerTime(
                                  duration,
                                ),
                                style:
                                    const TextStyle(
                                  color: Colors
                                      .white54,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                              ),

                              const Spacer(),

                              const Icon(
                                Icons
                                    .fullscreen_rounded,
                                color:
                                    Colors.white,
                                size: 23,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingCover() {
  final isNetworkCover =
      widget.coverUrl.startsWith('http://') ||
      widget.coverUrl.startsWith('https://');

  return Stack(
    fit: StackFit.expand,
    children: [
      if (widget.coverUrl.isEmpty)
        Container(
          color: Colors.black,
        )
      else if (isNetworkCover)
        Image.network(
          widget.coverUrl,
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return Container(
              color: Colors.black,
            );
          },
        )
      else
        Image.file(
          File(widget.coverUrl),
          fit: BoxFit.cover,
          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return Container(
              color: Colors.black,
            );
          },
        ),

      Container(
        color: Colors.black38,
      ),

      const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFE5FF58),
        ),
      ),
    ],
  );
}

  Widget _buildPlayerError() {
    return Container(
      color: const Color(
        0xFF161616,
      ),
      child: const Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Icon(
              Icons
                  .play_disabled_rounded,
              color: Colors.white54,
              size: 38,
            ),
            SizedBox(height: 10),
            Text(
              '视频暂时无法播放',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _togglePlay() async {
  if (_controller.value.isPlaying) {
    if (_needsFallbackPosition) {
      _fallbackBasePosition =
          _effectivePosition();

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

  String _playerTime(
    Duration duration,
  ) {
    final minutes =
        duration.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0');

    final seconds =
        duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');

    if (duration.inHours > 0) {
      return '${duration.inHours}:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFE5FF58),
              size: 21,
            ),

            const SizedBox(height: 5),

            Text(
              value.isEmpty ? label : value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),

            if (value.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SquareButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.72),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE0DBD2),
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF161616),
          size: 21,
        ),
      ),
    );
  }
}