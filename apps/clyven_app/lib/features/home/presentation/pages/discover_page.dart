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

class DiscoverPage extends ConsumerStatefulWidget {
  final bool isActive;

  const DiscoverPage({super.key, this.isActive = true});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  final PageController _pageController = PageController();
  int _activeIndex = 0;

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

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const PageScrollPhysics(),
            itemCount: videos.length,
            onPageChanged: (index) {
              setState(() => _activeIndex = index);
            },
            itemBuilder: (context, index) {
              return _ShortPage(
                key: ValueKey('short-${videos[index].id}'),
                video: videos[index],
                active: widget.isActive && index == _activeIndex,
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
  final AppLocalizations l10n;

  const _ShortPage({
    super.key,
    required this.video,
    required this.active,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider).unwrapPrevious().value;
    final interactionAsync = ref.watch(videoInteractionProvider(video.id));
    final interaction = interactionAsync.unwrapPrevious().value;
    final creatorAsync = ref.watch(creatorProfileProvider(video.authorId));
    final creatorState = creatorAsync.unwrapPrevious().value;
    final isOwnVideo = auth?.id == video.authorId;
    final isFollowing = creatorState?.isFollowing ?? false;
    final isChangingFollow =
        creatorState?.isChangingFollow ?? creatorAsync.isLoading;
    final likeCount = interaction?.likeCount ?? video.likeCount;
    final favoriteCount = interaction?.favoriteCount ?? video.favoriteCount;

    return Stack(
      fit: StackFit.expand,
      children: [
        NetworkVideoPlayer(
          videoId: int.tryParse(video.id),
          videoUrl: video.videoUrl,
          coverUrl: video.coverUrl,
          subtitles: const [],
          initialPositionSeconds: 0,
          fallbackDurationSeconds: video.durationSeconds,
          compact: true,
          shortsMode: true,
          autoplay: true,
          looping: true,
          active: active,
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
                  likeCount: likeCount,
                  favoriteCount: favoriteCount,
                  commentCount: video.commentCount,
                  isLiked: interaction?.isLiked ?? false,
                  isFavorited: interaction?.isFavorited ?? false,
                  likeBusy: interaction?.isChangingLike ?? false,
                  favoriteBusy: interaction?.isChangingFavorite ?? false,
                  onLike: () async {
                    if (interaction?.isChangingLike == true) return;
                    final allowed = await requireLogin(context, ref);
                    if (!allowed || !context.mounted) return;
                    await ref
                        .read(videoInteractionProvider(video.id).notifier)
                        .toggleLike();
                  },
                  onFavorite: () async {
                    if (interaction?.isChangingFavorite == true) return;
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
                bottom: 24,
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
        text: '${video.title}\n${video.authorName}\n\n${video.videoUrl}',
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
          '短视频',
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
  final int likeCount;
  final int favoriteCount;
  final int commentCount;
  final bool isLiked;
  final bool isFavorited;
  final bool likeBusy;
  final bool favoriteBusy;
  final VoidCallback onLike;
  final VoidCallback onFavorite;
  final VoidCallback onComments;
  final VoidCallback onShare;

  const _ActionRail({
    required this.likeCount,
    required this.favoriteCount,
    required this.commentCount,
    required this.isLiked,
    required this.isFavorited,
    required this.likeBusy,
    required this.favoriteBusy,
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
        _RailButton(
          icon: isLiked
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          value: _formatCount(context, likeCount),
          onTap: likeBusy ? null : onLike,
        ),
        const SizedBox(height: 17),
        _RailButton(
          icon: Icons.mode_comment_outlined,
          value: _formatCount(context, commentCount),
          onTap: onComments,
        ),
        const SizedBox(height: 17),
        _RailButton(
          icon: isFavorited
              ? Icons.bookmark_rounded
              : Icons.bookmark_border_rounded,
          value: _formatCount(context, favoriteCount),
          onTap: favoriteBusy ? null : onFavorite,
        ),
        const SizedBox(height: 17),
        _RailButton(icon: Icons.ios_share_rounded, value: '', onTap: onShare),
      ],
    );
  }

  String _formatCount(BuildContext context, int value) {
    return NumberFormat.compact(
      locale: Localizations.localeOf(context).toString(),
    ).format(value);
  }
}

class _RailButton extends StatelessWidget {
  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  const _RailButton({required this.icon, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 54,
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .36),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            if (value.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
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
