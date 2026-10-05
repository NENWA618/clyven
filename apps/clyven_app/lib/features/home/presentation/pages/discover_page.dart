import 'package:clyven_app/core/serverpod/serverpod_client_provider.dart';
import 'package:clyven_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:clyven_app/features/auth/presentation/utils/require_login.dart';
import 'package:clyven_app/features/comments/presentation/pages/comments_page.dart';
import 'package:clyven_app/features/creator/presentation/providers/creator_profile_provider.dart';
import 'package:clyven_app/features/video/data/models/video_detail.dart';
import 'package:clyven_app/features/video/presentation/providers/video_detail_provider.dart';
import 'package:clyven_app/features/video/presentation/widgets/network_video_player.dart';
import 'package:clyven_app/features/video_interactions/presentation/providers/video_interaction_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:clyven_app/core/sharing/share_links.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  final bool isActive;

  const DiscoverPage({super.key, this.isActive = true});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  final PageController _pageController = PageController();
  int _activeIndex = 0;
  final Map<String, String> _prewarmedManifestUrls = <String, String>{};
  final Set<String> _prewarmingVideoIds = <String>{};

  Future<void> _prewarmNextManifest(
    List<VideoDetail> videos,
    int currentIndex,
  ) async {
    final nextIndex = currentIndex + 1;

    if (!widget.isActive || nextIndex < 0 || nextIndex >= videos.length) {
      return;
    }

    final nextVideo = videos[nextIndex];
    final videoId = int.tryParse(nextVideo.id);

    if (videoId == null ||
        _prewarmedManifestUrls.containsKey(nextVideo.id) ||
        !_prewarmingVideoIds.add(nextVideo.id)) {
      return;
    }

    try {
      final client = ref.read(serverpodClientProvider);
      final manifestUrl = await client.video.getPlaybackManifestUrl(
        videoId: videoId,
      );
      final normalized = manifestUrl?.trim();

      if (!mounted || normalized == null || normalized.isEmpty) {
        return;
      }

      setState(() {
        _prewarmedManifestUrls[nextVideo.id] = normalized;
      });
    } catch (_) {
      // Prewarming is opportunistic. Normal playback still resolves the
      // manifest itself if this lightweight request fails.
    } finally {
      _prewarmingVideoIds.remove(nextVideo.id);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shorts = ref.watch(publishedShortsProvider);
    final l10n = AppLocalizations.of(context)!;

    return ColoredBox(
      color: Colors.black,
      child: shorts.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (_, _) => _ErrorState(
          label: l10n.searchLoadFailed,
          actionLabel: l10n.reload,
          onRetry: () => ref.invalidate(publishedShortsProvider),
        ),
        data: (videos) {
          if (videos.isEmpty) {
            return _EmptyState(label: l10n.noShortsYet);
          }

          final safeIndex = _activeIndex.clamp(0, videos.length - 1);
          if (safeIndex != _activeIndex) {
            _activeIndex = safeIndex;
          }
          // shorts-initial-prewarm
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _prewarmNextManifest(videos, safeIndex);
            }
          });

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const PageScrollPhysics(),
            itemCount: videos.length,
            onPageChanged: (index) {
              setState(() => _activeIndex = index);
              _prewarmNextManifest(videos, index);
            },
            itemBuilder: (context, index) {
              return _ShortPage(
                key: ValueKey('short-${videos[index].id}'),
                video: videos[index],
                active: widget.isActive && index == _activeIndex,
                preResolvedManifestUrl:
                    _prewarmedManifestUrls[videos[index].id],
                l10n: l10n,
              );
            },
          );
        },
      ),
    );
  }
}

class _ShortPage extends ConsumerWidget {
  final VideoDetail video;
  final bool active;
  final String? preResolvedManifestUrl;
  final AppLocalizations l10n;

  const _ShortPage({
    super.key,
    required this.video,
    required this.active,
    required this.preResolvedManifestUrl,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider).unwrapPrevious().value;
    final creatorAsync = ref.watch(creatorProfileProvider(video.authorId));
    final creatorState = creatorAsync.unwrapPrevious().value;
    final isOwnVideo = auth?.id == video.authorId;
    final isFollowing = creatorState?.isFollowing ?? false;
    final isChangingFollow =
        creatorState?.isChangingFollow ?? creatorAsync.isLoading;

    return Stack(
      fit: StackFit.expand,
      children: [
        NetworkVideoPlayer(
          videoId: int.tryParse(video.id),
          videoUrl: video.videoUrl,
          preResolvedManifestUrl: preResolvedManifestUrl,
          coverUrl: video.coverUrl,
          subtitles: const [],
          initialPositionSeconds: 0,
          fallbackDurationSeconds: video.durationSeconds,
          compact: true,
          shortsMode: true,
          autoplay: true,
          looping: true,
          active: active,
          onDoubleTap: () async {
            final allowed = await requireLogin(context, ref);
            if (!allowed || !context.mounted) return;

            final interaction = ref
                .read(videoInteractionProvider(video.id))
                .unwrapPrevious()
                .value;

            // TikTok-style behavior: double tap likes, but never unlikes.
            if (interaction?.isLiked == true ||
                interaction?.isChangingLike == true) {
              return;
            }

            await ref
                .read(videoInteractionProvider(video.id).notifier)
                .toggleLike();
          },
        ),
        const IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x4D000000),
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xCC000000),
                ],
                stops: [0, .22, .55, 1],
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const Positioned(
                top: 12,
                left: 0,
                right: 0,
                child: IgnorePointer(child: _ShortsHeader()),
              ),
              Positioned(
                right: 12,
                bottom: 92,
                child: _ActionRail(
                  videoId: video.id,
                  initialLikeCount: video.likeCount,
                  initialFavoriteCount: video.favoriteCount,
                  commentCount: video.commentCount,
                  onLike: () async {
                    final allowed = await requireLogin(context, ref);
                    if (!allowed || !context.mounted) return;
                    await ref
                        .read(videoInteractionProvider(video.id).notifier)
                        .toggleLike();
                  },
                  onFavorite: () async {
                    final allowed = await requireLogin(context, ref);
                    if (!allowed || !context.mounted) return;
                    await ref
                        .read(videoInteractionProvider(video.id).notifier)
                        .toggleFavorite();
                  },
                  onComments: () => _openComments(context),
                  onShare: () => _shareVideo(),
                ),
              ),
              Positioned(
                left: 16,
                right: 78,
                bottom: 92,
                child: _ShortMetadata(
                  video: video,
                  isOwnVideo: isOwnVideo,
                  isFollowing: isFollowing,
                  isChangingFollow: isChangingFollow,
                  onFollow: () async {
                    if (isOwnVideo || isChangingFollow) return;
                    final allowed = await requireLogin(context, ref);
                    if (!allowed || !context.mounted) return;
                    await ref
                        .read(creatorProfileProvider(video.authorId).notifier)
                        .toggleFollow();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openComments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => CommentsPage(videoId: video.id)),
    );
  }

  Future<void> _shareVideo() async {
    await SharePlus.instance.share(
      ShareParams(
        title: video.title,
        subject: video.title,
        text:
            '${video.title}\n${video.authorName}\n\n'
            '${ShareLinks.videoUrl(video.id)}',
      ),
    );
  }
}

class _ShortsHeader extends StatelessWidget {
  const _ShortsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'çŸ­è§†é¢‘',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            shadows: const [Shadow(blurRadius: 8, color: Colors.black54)],
          ),
        ),
      ],
    );
  }
}

class _ShortMetadata extends StatelessWidget {
  final VideoDetail video;
  final bool isOwnVideo;
  final bool isFollowing;
  final bool isChangingFollow;
  final VoidCallback onFollow;

  const _ShortMetadata({
    required this.video,
    required this.isOwnVideo,
    required this.isFollowing,
    required this.isChangingFollow,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Avatar(name: video.authorName),
            const SizedBox(width: 9),
            Flexible(
              child: Text(
                '@${video.authorName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (!isOwnVideo) ...[
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: isChangingFollow ? null : onFollow,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white60,
                  side: const BorderSide(color: Colors.white70),
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: Text(isFollowing ? l10n.followingButton : l10n.follow),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Text(
          video.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.25,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (video.description.trim().isNotEmpty) ...[
          const SizedBox(height: 5),
          Text(
            video.description.trim(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
        if (video.tags.isNotEmpty) ...[
          const SizedBox(height: 7),
          Text(
            video.tags.take(4).map((tag) => '#$tag').join('  '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionRail extends StatelessWidget {
  final String videoId;
  final int initialLikeCount;
  final int initialFavoriteCount;
  final int commentCount;
  final VoidCallback onLike;
  final VoidCallback onFavorite;
  final VoidCallback onComments;
  final VoidCallback onShare;

  const _ActionRail({
    required this.videoId,
    required this.initialLikeCount,
    required this.initialFavoriteCount,
    required this.commentCount,
    required this.onLike,
    required this.onFavorite,
    required this.onComments,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LikeAction(
          videoId: videoId,
          fallbackCount: initialLikeCount,
          onTap: onLike,
        ),
        const SizedBox(height: 17),
        _StaticAction(
          icon: Icons.mode_comment_outlined,
          count: commentCount,
          onTap: onComments,
        ),
        const SizedBox(height: 17),
        _FavoriteAction(
          videoId: videoId,
          fallbackCount: initialFavoriteCount,
          onTap: onFavorite,
        ),
        const SizedBox(height: 17),
        _StaticAction(icon: Icons.ios_share_rounded, onTap: onShare),
      ],
    );
  }
}

class _LikeAction extends ConsumerWidget {
  final String videoId;
  final int fallbackCount;
  final VoidCallback onTap;

  const _LikeAction({
    required this.videoId,
    required this.fallbackCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = ref.watch(
      videoInteractionProvider(
        videoId,
      ).select((state) => state.unwrapPrevious().value?.isLiked ?? false),
    );
    final count = ref.watch(
      videoInteractionProvider(videoId).select(
        (state) => state.unwrapPrevious().value?.likeCount ?? fallbackCount,
      ),
    );
    final busy = ref.watch(
      videoInteractionProvider(videoId).select(
        (state) => state.unwrapPrevious().value?.isChangingLike ?? false,
      ),
    );

    return RepaintBoundary(
      child: _ActionButton(
        icon: isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        iconColor: isLiked ? Colors.red : Colors.white,
        countText: _formatActionCount(context, count),
        onTap: busy ? null : onTap,
      ),
    );
  }
}

class _FavoriteAction extends ConsumerWidget {
  final String videoId;
  final int fallbackCount;
  final VoidCallback onTap;

  const _FavoriteAction({
    required this.videoId,
    required this.fallbackCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(
      videoInteractionProvider(
        videoId,
      ).select((state) => state.unwrapPrevious().value?.isFavorited ?? false),
    );
    final count = ref.watch(
      videoInteractionProvider(videoId).select(
        (state) => state.unwrapPrevious().value?.favoriteCount ?? fallbackCount,
      ),
    );
    final busy = ref.watch(
      videoInteractionProvider(videoId).select(
        (state) => state.unwrapPrevious().value?.isChangingFavorite ?? false,
      ),
    );

    return RepaintBoundary(
      child: _ActionButton(
        icon: isFavorited
            ? Icons.bookmark_rounded
            : Icons.bookmark_border_rounded,
        countText: _formatActionCount(context, count),
        onTap: busy ? null : onTap,
      ),
    );
  }
}

class _StaticAction extends StatelessWidget {
  final IconData icon;
  final int? count;
  final VoidCallback onTap;

  const _StaticAction({required this.icon, this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: _ActionButton(
        icon: icon,
        countText: count == null ? null : _formatActionCount(context, count!),
        onTap: onTap,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? countText;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    this.iconColor = Colors.white,
    this.countText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0x5C000000),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            if (countText != null) ...[
              const SizedBox(height: 4),
              RepaintBoundary(
                child: Text(
                  countText!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    shadows: <Shadow>[],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _formatActionCount(BuildContext context, int value) {
  return NumberFormat.compact(
    locale: Localizations.localeOf(context).toString(),
  ).format(value);
}

class _Avatar extends StatelessWidget {
  final String name;

  const _Avatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(
        name.trim().isEmpty ? '?' : name.trim().substring(0, 1).toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String label;

  const _EmptyState({required this.label});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stay_current_portrait_rounded,
            size: 42,
            color: Colors.white,
          ),
          const SizedBox(height: 14),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

class _ErrorState extends StatelessWidget {
  final String label;
  final String actionLabel;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.label,
    required this.actionLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 12),
        FilledButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    ),
  );
}
