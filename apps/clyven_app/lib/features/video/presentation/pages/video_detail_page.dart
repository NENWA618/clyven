import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../auth/presentation/utils/require_login.dart';
import '../../../comments/presentation/pages/comments_page.dart';
import '../../../creator/presentation/pages/creator_profile_page.dart';
import '../../../creator/presentation/providers/creator_profile_provider.dart';
import '../../../history/presentation/providers/watch_history_provider.dart';
import '../../../subtitle/presentation/providers/subtitle_provider.dart';
import '../../../subtitle/data/models/subtitle_playback_state.dart';
import '../../../subtitle/presentation/providers/subtitle_playback_provider.dart';
import '../../../subtitle/presentation/widgets/subtitle_settings_sheet.dart';
import '../../../subtitle/presentation/widgets/subtitle_learning_panel.dart';
import '../../../video_interactions/presentation/providers/video_interaction_provider.dart';
import '../../data/models/video_detail.dart';
import '../providers/video_detail_provider.dart';
import '../controllers/global_video_player_controller.dart';
import '../widgets/network_video_player.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

class VideoDetailPage extends ConsumerStatefulWidget {
  final String videoId;
  final bool hosted;
  final bool miniMode;
  final VoidCallback? onMinimize;
  final VoidCallback? onExpand;
  final VoidCallback? onClose;

  const VideoDetailPage({
    super.key,
    required this.videoId,
    this.hosted = false,
    this.miniMode = false,
    this.onMinimize,
    this.onExpand,
    this.onClose,
  });

  @override
  ConsumerState<VideoDetailPage> createState() {
    return _VideoDetailPageState();
  }
}

class _VideoDetailPageState extends ConsumerState<VideoDetailPage> {
  final Set<String> _recordedViewVideoIds = <String>{};
  final Set<String> _recordedEngagedViewVideoIds = <String>{};
  bool _showSeries = false;
  static const Color _inkColor = Color(0xFF161616);

  final GlobalKey _persistentPlayerKey = GlobalKey(
    debugLabel: 'clyven-persistent-video-player',
  );

  bool _showComments = false;

  final ValueNotifier<int> _subtitlePositionMs = ValueNotifier<int>(0);

  Future<void> _recordViewIfNeeded(VideoDetail video, Duration position) async {
    final numericVideoId = int.tryParse(video.id);

    if (numericVideoId == null) {
      return;
    }

    // position > 0 代表已经真正开始播放。
    if (position > Duration.zero && !_recordedViewVideoIds.contains(video.id)) {
      _recordedViewVideoIds.add(video.id);

      try {
        final client = ref.read(serverpodClientProvider);

        await client.video.recordView(videoId: numericVideoId);

        ref.invalidate(videoDetailProvider(video.id));

        final seriesId = video.seriesId;

        if (seriesId != null) {
          ref.invalidate(seriesVideosProvider(seriesId));
        }
      } catch (error) {
        _recordedViewVideoIds.remove(video.id);

        debugPrint('[Clyven View] recordView failed: $error');
      }
    }

    // 5 秒才算 engaged view。
    if (position.inSeconds >= 5 &&
        !_recordedEngagedViewVideoIds.contains(video.id)) {
      _recordedEngagedViewVideoIds.add(video.id);

      try {
        final client = ref.read(serverpodClientProvider);

        await client.video.recordEngagedView(videoId: numericVideoId);

        ref.invalidate(videoDetailProvider(video.id));

        final seriesId = video.seriesId;

        if (seriesId != null) {
          ref.invalidate(seriesVideosProvider(seriesId));
        }
      } catch (error) {
        _recordedEngagedViewVideoIds.remove(video.id);

        debugPrint('[Clyven View] recordEngagedView failed: $error');
      }
    }
  }

  @override
  void dispose() {
    _subtitlePositionMs.dispose();
    super.dispose();
  }

  void _openComments() {
    if (_showComments) {
      return;
    }

    setState(() {
      _showSeries = false;
      _showComments = true;
    });
  }

  void _closeComments() {
    if (!_showComments) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _showComments = false;
    });

    ref.invalidate(videoDetailProvider(widget.videoId));
  }

  void _openSeries() {
    if (_showSeries) return;

    setState(() {
      _showComments = false;
      _showSeries = true;
    });
  }

  void _closeSeries() {
    if (!_showSeries) return;

    setState(() {
      _showSeries = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final videoId = widget.videoId;

    final videoAsync = ref.watch(videoDetailProvider(videoId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: videoAsync.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return SafeArea(
            child: Column(
              children: [
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
                        Text(
                          l10n.videoLoadFailed,
                          style: const TextStyle(
                            color: _inkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            ref.invalidate(videoDetailProvider(videoId));
                          },
                          child: Text(l10n.reload),
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
          if (widget.miniMode) {
            return _buildMiniContent(context, ref, video, l10n);
          }

          return _buildContent(context, ref, video, l10n);
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    VideoDetail video,
    AppLocalizations l10n,
  ) {
    final historyItem = ref.watch(watchHistoryItemProvider(video.id));

    final numericVideoId = int.tryParse(video.id);

    final subtitleAvailability = numericVideoId == null
        ? <SubtitleTrackAvailability>[]
        : ref.watch(subtitleTrackAvailabilityProvider(numericVideoId)).value ??
              <SubtitleTrackAvailability>[];

    final subtitleTracks = [
      for (final item in subtitleAvailability) item.track,
    ];

    final subtitleState = ref.watch(subtitlePlaybackProvider(video.id));

    final primarySelection = _normalizeSubtitleSelection(
      resolvePrimarySubtitleSelection(subtitleTracks, subtitleState),
      subtitleAvailability,
    );

    final secondarySelection = _normalizeSubtitleSelection(
      resolveSecondarySubtitleSelection(subtitleTracks, subtitleState),
      subtitleAvailability,
    );

    final primarySubtitleAsync =
        numericVideoId == null || primarySelection == null
        ? null
        : ref.watch(
            subtitleProvider((
              videoId: numericVideoId,
              languageCode: primarySelection.languageCode,
              scriptCode: primarySelection.scriptCode,
            )),
          );

    final secondarySubtitleAsync =
        numericVideoId == null || secondarySelection == null
        ? null
        : ref.watch(
            subtitleProvider((
              videoId: numericVideoId,
              languageCode: secondarySelection.languageCode,
              scriptCode: secondarySelection.scriptCode,
            )),
          );

    final subtitles =
        primarySubtitleAsync?.value ?? <serverpod.SubtitleCueDetail>[];
    final secondarySubtitles =
        secondarySubtitleAsync?.value ?? <serverpod.SubtitleCueDetail>[];

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, viewport) => Column(
          children: [
            ConstrainedBox(
              // Keep space for details and the optional learning panel. Column
              // otherwise gives the player's original aspect ratio infinite height.
              constraints: BoxConstraints(maxHeight: viewport.maxHeight * 0.6),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragEnd: widget.hosted
                    ? (details) {
                        final velocity = details.primaryVelocity ?? 0;

                        if (velocity > 450) {
                          widget.onMinimize?.call();
                        }
                      }
                    : null,
                child: Stack(
                  children: [
                    _buildPersistentPlayer(
                      ref,
                      video,
                      subtitles,
                      historyItem?.positionSeconds ?? 0,
                      secondarySubtitles: secondarySubtitles,
                      subtitleLanguageCode: primarySelection?.languageCode,
                      subtitleScriptCode: primarySelection?.scriptCode,
                      secondarySubtitleLanguageCode:
                          secondarySelection?.languageCode,
                      secondarySubtitleScriptCode:
                          secondarySelection?.scriptCode,
                      subtitlesEnabled:
                          subtitleState.enabled && primarySelection != null,
                      hideSubtitleOverlay:
                          subtitleState.displayMode ==
                          SubtitleDisplayMode.learningPanel,
                      onSubtitlePositionChanged: (milliseconds) {
                        _subtitlePositionMs.value = milliseconds;
                      },
                      onSubtitlesPressed: subtitleAvailability.isEmpty
                          ? null
                          : () {
                              showClyvenSubtitleSettingsSheet(
                                context: context,
                                videoId: video.id,
                                availability: subtitleAvailability,
                              );
                            },
                    ),
                    if (widget.hosted)
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Material(
                          color: Colors.black.withValues(alpha: 0.52),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: widget.onMinimize,
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                                size: 29,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (subtitleState.enabled &&
                subtitleState.displayMode ==
                    SubtitleDisplayMode.learningPanel &&
                primarySelection != null)
              Flexible(
                child: ValueListenableBuilder<int>(
                  valueListenable: _subtitlePositionMs,
                  builder: (context, milliseconds, child) {
                    final primaryDetail = _findActiveSubtitleForLearning(
                      subtitles,
                      milliseconds,
                    );

                    final secondaryDetail = _findActiveSubtitleForLearning(
                      secondarySubtitles,
                      milliseconds,
                    );

                    return SubtitleLearningPanel(
                      primaryDetail: primaryDetail,
                      secondaryDetail: secondaryDetail,
                      primaryLanguageCode: primarySelection.languageCode,
                      primaryScriptCode: primarySelection.scriptCode,
                      secondaryLanguageCode: secondarySelection?.languageCode,
                      secondaryScriptCode: secondarySelection?.scriptCode,
                      videoPositionMs: milliseconds,
                    );
                  },
                ),
              ),
            Expanded(
              child: _showComments
                  ? CommentsPage(
                      key: ValueKey('embedded-comments-${video.id}'),
                      videoId: video.id,
                      embedded: true,
                      onClose: _closeComments,
                    )
                  : _showSeries
                  ? _buildFullSeriesPanel(context, ref, video)
                  : CustomScrollView(
                      key: const PageStorageKey<String>(
                        'video-detail-information',
                      ),
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildVideoInformation(context, video, l10n),
                        ),
                        if (video.seriesId != null &&
                            video.seriesTitle.trim().isNotEmpty)
                          SliverToBoxAdapter(
                            child: _buildSeriesEntry(context, video),
                          ),
                        SliverToBoxAdapter(
                          child: _buildActions(context, ref, video, l10n),
                        ),
                        SliverToBoxAdapter(
                          child: _buildCreator(context, ref, video, l10n),
                        ),
                        SliverToBoxAdapter(
                          child: _buildDescription(context, video, l10n),
                        ),
                        SliverToBoxAdapter(child: _buildTags(context, video)),
                        SliverToBoxAdapter(
                          child: _buildCommentEntry(context, video, l10n),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 70)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  serverpod.SubtitleCueDetail? _findActiveSubtitleForLearning(
    List<serverpod.SubtitleCueDetail> subtitles,
    int milliseconds,
  ) {
    for (final detail in subtitles) {
      if (milliseconds >= detail.cue.startMs &&
          milliseconds < detail.cue.endMs) {
        return detail;
      }
    }

    return null;
  }

  SubtitlePlaybackSelection? _normalizeSubtitleSelection(
    SubtitlePlaybackSelection? selection,
    List<SubtitleTrackAvailability> availability,
  ) {
    if (selection == null) {
      return null;
    }

    SubtitleTrackAvailability? item;

    for (final candidate in availability) {
      if (subtitleSelectionMatchesTrack(selection, candidate.track)) {
        item = candidate;
        break;
      }
    }

    if (item == null || item.scriptCodes.isEmpty) {
      return null;
    }

    if (selection.scriptCode != null &&
        item.scriptCodes.contains(selection.scriptCode)) {
      return selection;
    }

    final defaultScript = item.track.defaultScriptCode?.trim();

    if (defaultScript != null &&
        defaultScript.isNotEmpty &&
        item.scriptCodes.contains(defaultScript)) {
      return subtitleSelectionFromTrack(item.track, scriptCode: defaultScript);
    }

    return subtitleSelectionFromTrack(
      item.track,
      scriptCode: item.scriptCodes.first,
    );
  }

  Widget _buildMiniContent(
    BuildContext context,
    WidgetRef ref,
    VideoDetail video,
    AppLocalizations l10n,
  ) {
    final historyItem = ref.watch(watchHistoryItemProvider(video.id));
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surface,
      child: Row(
        children: [
          SizedBox(
            width: 135,
            height: 76,
            child: Stack(
              fit: StackFit.expand,
              children: [
                IgnorePointer(
                  child: _buildPersistentPlayer(
                    ref,
                    video,
                    const <serverpod.SubtitleCueDetail>[],
                    historyItem?.positionSeconds ?? 0,
                    compact: true,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onExpand,
                  child: const SizedBox.expand(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onExpand,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface.withValues(alpha: 0.55),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onExpand,
            icon: const Icon(Icons.open_in_full_rounded, size: 19),
          ),
          IconButton(
            onPressed: widget.onClose,
            icon: const Icon(Icons.close_rounded, size: 21),
          ),
          const SizedBox(width: 3),
        ],
      ),
    );
  }

  Widget _buildPersistentPlayer(
    WidgetRef ref,
    VideoDetail video,
    List<serverpod.SubtitleCueDetail> subtitles,
    int initialPositionSeconds, {
    List<serverpod.SubtitleCueDetail> secondarySubtitles =
        const <serverpod.SubtitleCueDetail>[],
    String? subtitleLanguageCode,
    String? subtitleScriptCode,
    String? secondarySubtitleLanguageCode,
    String? secondarySubtitleScriptCode,
    bool subtitlesEnabled = true,
    bool hideSubtitleOverlay = false,
    ValueChanged<int>? onSubtitlePositionChanged,
    VoidCallback? onSubtitlesPressed,
    bool compact = false,
  }) {
    return NetworkVideoPlayer(
      key: _persistentPlayerKey,
      videoId: int.tryParse(video.id),
      videoUrl: video.videoUrl,
      coverUrl: video.coverUrl,
      subtitles: hideSubtitleOverlay
          ? const <serverpod.SubtitleCueDetail>[]
          : subtitles,
      secondarySubtitles: hideSubtitleOverlay
          ? const <serverpod.SubtitleCueDetail>[]
          : secondarySubtitles,
      subtitleLanguageCode: subtitleLanguageCode,
      subtitleScriptCode: subtitleScriptCode,
      secondarySubtitleLanguageCode: secondarySubtitleLanguageCode,
      secondarySubtitleScriptCode: secondarySubtitleScriptCode,
      subtitlesEnabled: subtitlesEnabled,
      onSubtitlePositionChanged: onSubtitlePositionChanged,
      onSubtitlesPressed: onSubtitlesPressed,
      initialPositionSeconds: initialPositionSeconds,
      fallbackDurationSeconds: video.durationSeconds,
      compact: compact,
      onProgress: (position, duration) {
        _recordViewIfNeeded(video, position);
        ref
            .read(watchHistoryProvider.notifier)
            .saveProgress(
              videoId: video.id,
              title: video.title,
              coverUrl: video.coverUrl,
              authorName: video.authorName,
              positionSeconds: position.inSeconds,
              durationSeconds: duration.inSeconds > 0
                  ? duration.inSeconds
                  : video.durationSeconds,
            );
      },
    );
  }

  Widget _buildVideoInformation(
    BuildContext context,
    VideoDetail video,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  localizedTopicLabel(l10n, video.category).toUpperCase(),
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _formatDate(context, video.publishedAt),
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            video.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 28,
              height: 1.12,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.45),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_outline_rounded,
                  size: 17,
                  color: scheme.secondary,
                ),
                const SizedBox(width: 6),
                Text(
                  l10n.viewsCount(_formatCount(context, video.viewCount)),
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outline,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.schedule_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(
                  _formatDuration(video.durationSeconds),
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesEntry(BuildContext context, VideoDetail video) {
    final seriesId = video.seriesId;
    final title = video.seriesTitle.trim();

    if (seriesId == null || title.isEmpty) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Material(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _openSeries,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 15, 15, 15),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.video_library_outlined,
                    color: scheme.onSecondary,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '所属系列',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeriesVideoCover(
    WidgetRef ref,
    serverpod.Video video,
    ColorScheme scheme,
  ) {
    final coverKey = video.coverStorageKey?.trim();

    if (coverKey == null || coverKey.isEmpty) {
      return Container(
        color: scheme.surfaceContainerHighest,
        alignment: Alignment.center,
        child: Icon(
          Icons.video_library_outlined,
          color: scheme.onSurfaceVariant,
          size: 28,
        ),
      );
    }

    final client = ref.read(serverpodClientProvider);

    return FutureBuilder<String?>(
      future: client.video.getVideoUrl(path: coverKey),
      builder: (context, snapshot) {
        final coverUrl = snapshot.data?.trim();

        if (coverUrl == null || coverUrl.isEmpty) {
          return Container(
            color: scheme.surfaceContainerHighest,
            alignment: Alignment.center,
            child: snapshot.connectionState == ConnectionState.waiting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    Icons.video_library_outlined,
                    color: scheme.onSurfaceVariant,
                    size: 28,
                  ),
          );
        }

        return Image.network(
          coverUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: scheme.surfaceContainerHighest,
              alignment: Alignment.center,
              child: Icon(
                Icons.broken_image_outlined,
                color: scheme.onSurfaceVariant,
                size: 28,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFullSeriesPanel(
    BuildContext context,
    WidgetRef ref,
    VideoDetail currentVideo,
  ) {
    final seriesId = currentVideo.seriesId;

    if (seriesId == null) {
      return const SizedBox.shrink();
    }

    final videosAsync = ref.watch(seriesVideosProvider(seriesId));

    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 10, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '系列',
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        currentVideo.seriesTitle.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _closeSeries,
                  icon: const Icon(Icons.close_rounded, size: 26),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          Expanded(
            child: videosAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Center(child: Text('系列内容加载失败')),
              data: (videos) {
                if (videos.isEmpty) {
                  return const Center(child: Text('这个系列暂时没有视频'));
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 40),
                  itemCount: videos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = videos[index];

                    final isCurrent = item.id?.toString() == currentVideo.id;

                    return Material(
                      color: isCurrent
                          ? scheme.primaryContainer.withValues(alpha: 0.38)
                          : scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(18),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: item.id == null
                            ? null
                            : () {
                                openGlobalVideo(item.id!.toString());
                              },
                        child: SizedBox(
                          height: 105,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                                height: double.infinity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    _buildSeriesVideoCover(ref, item, scheme),
                                    Positioned(
                                      right: 7,
                                      bottom: 7,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.78,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                        ),
                                        child: Text(
                                          _formatDuration(item.durationSeconds),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (isCurrent)
                                      Positioned(
                                        left: 8,
                                        top: 8,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: scheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            size: 18,
                                            color: scheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    13,
                                    10,
                                    12,
                                    10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: scheme.onSurface,
                                          fontSize: 14,
                                          height: 1.25,
                                          fontWeight: isCurrent
                                              ? FontWeight.w900
                                              : FontWeight.w800,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.play_circle_outline_rounded,
                                            size: 13,
                                            color: Color(0xFF908A81),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              '${_formatCount(context, item.viewCount)} views',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color(0xFF908A81),
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.category,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: scheme.secondary,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          if (isCurrent) ...[
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 7,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: scheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '正在播放',
                                                style: TextStyle(
                                                  color: scheme.onPrimary,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(
    BuildContext context,
    WidgetRef ref,
    VideoDetail video,
    AppLocalizations l10n,
  ) {
    final interactionAsync = ref.watch(videoInteractionProvider(video.id));
    // Same unwrapPrevious() reasoning as the follow button: don't let a
    // stale liked/favorited state survive past a sign-out.
    final interaction = interactionAsync.unwrapPrevious().value;
    final likeCount = interaction?.likeCount ?? video.likeCount;
    final favoriteCount = interaction?.favoriteCount ?? video.favoriteCount;
    final isLiked = interaction?.isLiked ?? false;
    final isFavorited = interaction?.isFavorited ?? false;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: _inkColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            _ActionButton(
              icon: isLiked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              value: _formatCount(context, likeCount),
              label: l10n.like,
              onTap: () async {
                final state = interactionAsync.unwrapPrevious().value;

                if (state?.isChangingLike == true) {
                  return;
                }

                final allowed = await requireLogin(context, ref);

                if (!allowed || !context.mounted) {
                  return;
                }

                await ref
                    .read(videoInteractionProvider(video.id).notifier)
                    .toggleLike();
              },
            ),
            _ActionButton(
              icon: isFavorited
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              value: _formatCount(context, favoriteCount),
              label: l10n.favoriteAction,
              onTap: () async {
                final state = interactionAsync.unwrapPrevious().value;

                if (state?.isChangingFavorite == true) {
                  return;
                }

                final allowed = await requireLogin(context, ref);

                if (!allowed || !context.mounted) {
                  return;
                }

                await ref
                    .read(videoInteractionProvider(video.id).notifier)
                    .toggleFavorite();
              },
            ),
            _ActionButton(
              icon: Icons.mode_comment_outlined,
              value: _formatCount(context, video.commentCount),
              label: l10n.discussion,
              onTap: _openComments,
            ),
            _ActionButton(
              icon: Icons.ios_share_rounded,
              value: '',
              label: l10n.share,
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
    AppLocalizations l10n,
  ) {
    final creatorAsync = ref.watch(creatorProfileProvider(video.authorId));
    // unwrapPrevious() drops the stale value Riverpod carries over from
    // before a sign-out, so a logged-out/errored fetch reads as no data
    // instead of showing the previous user's follow state.
    final creatorRaw = creatorAsync.unwrapPrevious();
    final creatorState = creatorRaw.value;
    final isFollowing = creatorState?.isFollowing ?? false;
    final isChangingFollow =
        creatorState?.isChangingFollow ?? creatorRaw.isLoading;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreatorProfilePage(creatorId: video.authorId);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: scheme.brightness == Brightness.dark
                ? const Color(0xFF191918)
                : Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.brightness == Brightness.dark
                  ? const Color(0xFF4B4945)
                  : const Color(0xFFE3DED5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: scheme.secondary,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Text(
                  video.authorName.isEmpty
                      ? '?'
                      : video.authorName.substring(0, 1),
                  style: TextStyle(
                    color: scheme.onSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.creatorLabel,
                      style: TextStyle(
                        color: scheme.brightness == Brightness.dark
                            ? const Color(0xFFB8B3AA)
                            : const Color(0xFF99938A),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.authorName,
                      style: TextStyle(
                        color: scheme.brightness == Brightness.dark
                            ? const Color(0xFFF4F1EA)
                            : _inkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  if (isChangingFollow) {
                    return;
                  }

                  final allowed = await requireLogin(context, ref);

                  if (!allowed || !context.mounted) {
                    return;
                  }

                  await ref
                      .read(creatorProfileProvider(video.authorId).notifier)
                      .toggleFollow();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isChangingFollow
                        ? l10n.processing
                        : isFollowing
                        ? l10n.followingButton
                        : l10n.follow,
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
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

  Widget _buildDescription(
    BuildContext context,
    VideoDetail video,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aboutThisFrame,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            video.description,
            style: TextStyle(
              color: scheme.brightness == Brightness.dark
                  ? const Color(0xFFE4E0D8)
                  : const Color(0xFF393632),
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context, VideoDetail video) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: video.tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: scheme.outlineVariant),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '# $tag',
              style: TextStyle(
                color: scheme.onSurfaceVariant,
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
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 34, 20, 0),
      child: GestureDetector(
        onTap: _openComments,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: scheme.inverseSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.forum_outlined,
                  color: scheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.enterDiscussion,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.discussionCountHappening(
                        _formatCount(context, video.commentCount),
                      ),
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded, color: scheme.onSurface),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareVideo(VideoDetail video) async {
    await SharePlus.instance.share(
      ShareParams(
        title: video.title,
        subject: video.title,
        text: '${video.title}\n${video.authorName}\n\n${video.videoUrl}',
      ),
    );
  }

  String _formatCount(BuildContext context, int value) {
    final localeName = Localizations.localeOf(context).toString();
    return NumberFormat.compact(locale: localeName).format(value);
  }

  static String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$remainingSeconds';
    }

    return '${duration.inMinutes}:$remainingSeconds';
  }

  String _formatDate(BuildContext context, DateTime date) {
    final localeName = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(localeName).format(date);
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
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 21),
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
