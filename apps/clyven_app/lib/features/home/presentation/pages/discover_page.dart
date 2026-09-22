import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import '../widgets/home_design_tokens.dart';
import '../widgets/home_media.dart';
import '../widgets/home_topic_selector.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);
    final l10n = AppLocalizations.of(context)!;

    return ColoredBox(
      color: HomeDesignTokens.background(context),
      child: SafeArea(
        bottom: false,
        child: home.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => _ErrorState(
            label: l10n.searchLoadFailed,
            actionLabel: l10n.reload,
            onRetry: () => ref.invalidate(homeProvider),
          ),
          data: (state) => RefreshIndicator(
            onRefresh: () => ref.read(homeProvider.notifier).refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(child: _Header(l10n: l10n)),
                SliverToBoxAdapter(
                  child: HomeTopicSelector(
                    topics: HomeNotifier.topics,
                    selectedTopic: state.selectedTopic,
                    labelFor: (topic) => localizedTopicLabel(l10n, topic),
                    onSelected: (topic) =>
                        ref.read(homeProvider.notifier).selectTopic(topic),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 25)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList.separated(
                    itemCount: state.feed.videos.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 22),
                    itemBuilder: (_, index) => _ShortsCard(
                      index: index,
                      video: state.feed.videos[index],
                      category: localizedTopicLabel(
                        l10n,
                        state.feed.videos[index].category,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 34)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AppLocalizations l10n;

  const _Header({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.discoverEyebrow,
                  style: TextStyle(
                    color: HomeDesignTokens.brandFor(context),
                    fontSize: 10,
                    letterSpacing: 2.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  l10n.discoverTitle,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  l10n.happeningNow,
                  style: TextStyle(
                    color: HomeDesignTokens.muted(context),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortsCard extends StatelessWidget {
  final int index;
  final HomeVideo video;
  final String category;

  const _ShortsCard({
    required this.index,
    required this.video,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: video.title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => openGlobalVideo(video.id),
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      HomeMedia(path: video.coverUrl),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xB8000000)],
                            stops: [.46, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 15,
                        child: Text(
                          '${(index + 1).toString().padLeft(2, '0')} /',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 14,
                        top: 14,
                        child: VideoDurationBadge(duration: video.duration),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFFE5B98F),
                                      fontSize: 9,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    video.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1.17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 43,
                              height: 43,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xFF171714),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 11, 3, 0),
                child: Row(
                  children: [
                    CreatorAvatar(name: video.authorName, size: 28),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        video.authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      video.viewText,
                      style: TextStyle(
                        color: HomeDesignTokens.muted(context),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
        Text(label),
        const SizedBox(height: 12),
        FilledButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    ),
  );
}
