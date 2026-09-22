import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import '../widgets/home_design_tokens.dart';
import '../widgets/home_featured_hero.dart';
import '../widgets/home_section.dart';
import '../widgets/home_topic_selector.dart';
import 'video_search_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);
    return ColoredBox(
      color: HomeDesignTokens.background(context),
      child: home.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            _HomeError(onRetry: () => ref.invalidate(homeProvider)),
        data: (state) => _HomeContent(
          state: state,
          onRefresh: () => ref.read(homeProvider.notifier).refresh(),
          onTopicSelected: (topic) =>
              ref.read(homeProvider.notifier).selectTopic(topic),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final HomeState state;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onTopicSelected;

  const _HomeContent({
    required this.state,
    required this.onRefresh,
    required this.onTopicSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final videos = state.feed.videos;
    final trending = videos.take(4).toList(growable: false);
    final remaining = videos.skip(4).toList(growable: false);
    final explore = remaining.isEmpty
        ? videos.skip(2).toList(growable: false)
        : remaining;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        edgeOffset: 72,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: _HomeHeader(l10n: l10n)),
            SliverToBoxAdapter(
              child: _Intro(
                title: l10n.homeForYou,
                subtitle: l10n.homeForYouSubtitle,
              ),
            ),
            SliverToBoxAdapter(
              child: HomeFeaturedHero(
                video: state.feed.featuredVideo,
                category: localizedTopicLabel(
                  l10n,
                  state.feed.featuredVideo.category,
                ),
                eyebrow: l10n.homeEditorsPick,
                onTap: () => openGlobalVideo(state.feed.featuredVideo.id),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: HomeTopicSelector(
                topics: HomeNotifier.topics,
                selectedTopic: state.selectedTopic,
                labelFor: (topic) => localizedTopicLabel(l10n, topic),
                onSelected: onTopicSelected,
              ),
            ),
            if (trending.isNotEmpty)
              SliverToBoxAdapter(
                child: HomeSection(
                  eyebrow: l10n.homeTrendingEyebrow,
                  title: l10n.homeTrending,
                  actionLabel: l10n.seeAll,
                  videos: trending,
                  categoryLabel: (category) =>
                      localizedTopicLabel(l10n, category),
                  onVideoTap: _openVideo,
                  onAction: onRefresh,
                ),
              ),
            if (explore.isNotEmpty)
              SliverToBoxAdapter(
                child: HomeSection(
                  eyebrow: l10n.homeExploreEyebrow,
                  title: l10n.homeContinueExploring,
                  actionLabel: l10n.refresh,
                  videos: explore,
                  categoryLabel: (category) =>
                      localizedTopicLabel(l10n, category),
                  onVideoTap: _openVideo,
                  onAction: onRefresh,
                ),
              ),
            if (videos.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    l10n.emptyTrack,
                    style: TextStyle(color: HomeDesignTokens.muted(context)),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 112)),
          ],
        ),
      ),
    );
  }

  void _openVideo(HomeVideo video) => openGlobalVideo(video.id);
}

class _HomeHeader extends StatelessWidget {
  final AppLocalizations l10n;
  const _HomeHeader({required this.l10n});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 12, 24),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 2,
                    color: HomeDesignTokens.brandFor(context),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'CLYVEN',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 11,
                      letterSpacing: 3.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                l10n.homeTagline,
                style: TextStyle(
                  color: HomeDesignTokens.muted(context),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        _HeaderButton(
          tooltip: l10n.searchHint,
          icon: Icons.search_rounded,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const VideoSearchPage()),
          ),
        ),
        const SizedBox(width: 8),
        _HeaderButton(
          tooltip: l10n.notifications,
          icon: Icons.notifications_none_rounded,
          onTap: () {},
          showDot: true,
        ),
      ],
    ),
  );
}

class _HeaderButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;
  final bool showDot;

  const _HeaderButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      IconButton.filledTonal(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, size: 22),
        style: IconButton.styleFrom(
          backgroundColor: HomeDesignTokens.surface(context),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          side: BorderSide(color: HomeDesignTokens.border(context)),
        ),
      ),
      if (showDot)
        Positioned(
          right: 10,
          top: 9,
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: HomeDesignTokens.brandFor(context),
              shape: BoxShape.circle,
              border: Border.all(
                color: HomeDesignTokens.surface(context),
                width: 1.5,
              ),
            ),
          ),
        ),
    ],
  );
}

class _Intro extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Intro({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            color: HomeDesignTokens.muted(context),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

class _HomeError extends StatelessWidget {
  final VoidCallback onRetry;
  const _HomeError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 40,
              color: HomeDesignTokens.muted(context),
            ),
            const SizedBox(height: 12),
            Text(l10n.homeLoadFailed),
            const SizedBox(height: 14),
            FilledButton(onPressed: onRetry, child: Text(l10n.reload)),
          ],
        ),
      ),
    );
  }
}
