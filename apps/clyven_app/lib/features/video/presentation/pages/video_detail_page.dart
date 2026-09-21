import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
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
import '../../../video_interactions/presentation/providers/video_interaction_provider.dart';
import '../../data/models/video_detail.dart';
import '../providers/video_detail_provider.dart';
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
  static const Color _inkColor = Color(0xFF161616);

  final GlobalKey _persistentPlayerKey = GlobalKey(
    debugLabel: 'clyven-persistent-video-player',
  );

  bool _showComments = false;

  void _openComments() {
    if (_showComments) {
      return;
    }

    setState(() {
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
      resolvePrimarySubtitleSelection(
        subtitleTracks,
        subtitleState,
      ),
      subtitleAvailability,
    );

    final secondarySelection = _normalizeSubtitleSelection(
      resolveSecondarySubtitleSelection(
        subtitleTracks,
        subtitleState,
      ),
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
      child: Column(
        children: [
          GestureDetector(
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
                  secondarySubtitleScriptCode: secondarySelection?.scriptCode,
                  subtitlesEnabled:
                      subtitleState.enabled && primarySelection != null,
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
          Expanded(
            child: _showComments
                ? CommentsPage(
                    key: ValueKey('embedded-comments-${video.id}'),
                    videoId: video.id,
                    embedded: true,
                    onClose: _closeComments,
                  )
                : CustomScrollView(
                    key: const PageStorageKey<String>(
                      'video-detail-information',
                    ),
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildVideoInformation(context, video, l10n),
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
                      SliverToBoxAdapter(child: _buildTags(video)),
                      SliverToBoxAdapter(
                        child: _buildCommentEntry(context, video, l10n),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 70)),
                    ],
                  ),
          ),
        ],
      ),
    );
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
      return subtitleSelectionFromTrack(
        item.track,
        scriptCode: defaultScript,
      );
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
    VoidCallback? onSubtitlesPressed,
    bool compact = false,
  }) {
    return NetworkVideoPlayer(
      key: _persistentPlayerKey,
      videoUrl: video.videoUrl,
      coverUrl: video.coverUrl,
      subtitles: subtitles,
      secondarySubtitles: secondarySubtitles,
      subtitleLanguageCode: subtitleLanguageCode,
      subtitleScriptCode: subtitleScriptCode,
      secondarySubtitleLanguageCode: secondarySubtitleLanguageCode,
      secondarySubtitleScriptCode: secondarySubtitleScriptCode,
      subtitlesEnabled: subtitlesEnabled,
      onSubtitlesPressed: onSubtitlesPressed,
      initialPositionSeconds: initialPositionSeconds,
      fallbackDurationSeconds: video.durationSeconds,
      compact: compact,
      onProgress: (position, duration) {
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

  Widget _buildTopBar(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      child: Row(
        children: [
          _SquareButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.frameEyebrow,
                  style: const TextStyle(
                    color: Color(0xFF77736C),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.watchingNow,
                  style: const TextStyle(
                    color: _inkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          _SquareButton(icon: Icons.more_horiz_rounded, onTap: () {}),
        ],
      ),
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  localizedTopicLabel(l10n, video.category),
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(context, video.publishedAt),
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
                l10n.viewsCount(_formatCount(context, video.viewCount)),
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
    AppLocalizations l10n,
  ) {
    final interactionAsync = ref.watch(videoInteractionProvider(video.id));
    final interaction = interactionAsync.value;
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
                final state = interactionAsync.value;

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
                final state = interactionAsync.value;

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
    final creatorState = creatorAsync.value;
    final isFollowing = creatorState?.isFollowing ?? false;
    final isChangingFollow =
        creatorState?.isChangingFollow ?? creatorAsync.isLoading;
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
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE3DED5)),
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
                      style: const TextStyle(
                        color: Color(0xFF99938A),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.authorName,
                      style: const TextStyle(
                        color: _inkColor,
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
                  if (creatorState == null || isChangingFollow) {
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: video.tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCAC5BB)),
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
                      style: const TextStyle(
                        color: _inkColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.discussionCountHappening(
                        _formatCount(context, video.commentCount),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF77736C),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, color: _inkColor),
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

class _SquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SquareButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0DBD2)),
        ),
        child: Icon(icon, color: const Color(0xFF161616), size: 21),
      ),
    );
  }
}
