import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/features/video/data/models/video_detail.dart';
import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/features/video/presentation/providers/video_detail_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/home_provider.dart';
import '../widgets/home_design_tokens.dart';
import '../widgets/home_media.dart';
import '../widgets/home_topic_selector.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  String _selectedTopic = HomeNotifier.topics.first;

  @override
  Widget build(BuildContext context) {
    final shorts = ref.watch(publishedShortsProvider);
    final l10n = AppLocalizations.of(context)!;

    return ColoredBox(
      color: HomeDesignTokens.background(context),
      child: SafeArea(
        bottom: false,
        child: shorts.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => _ErrorState(
            label: l10n.searchLoadFailed,
            actionLabel: l10n.reload,
            onRetry: () => ref.invalidate(publishedShortsProvider),
          ),
          data: (videos) {
            final visibleVideos = _selectedTopic == HomeNotifier.topics.first
                ? videos
                : videos
                      .where((video) => video.category == _selectedTopic)
                      .toList(growable: false);

            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(publishedShortsProvider),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(child: _Header(l10n: l10n)),
                  SliverToBoxAdapter(
                    child: HomeTopicSelector(
                      topics: HomeNotifier.topics,
                      selectedTopic: _selectedTopic,
                      labelFor: (topic) => localizedTopicLabel(l10n, topic),
                      onSelected: (topic) => setState(() {
                        _selectedTopic = topic;
                      }),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 25)),
                  if (visibleVideos.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(label: l10n.noShortsYet),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList.separated(
                        itemCount: visibleVideos.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 22),
                        itemBuilder: (_, index) {
                          final video = visibleVideos[index];
                          return _ShortsCard(
                            index: index,
                            video: video,
                            category: localizedTopicLabel(l10n, video.category),
                            viewText: l10n.viewsCount(
                              NumberFormat.compact(
                                locale: Localizations.localeOf(
                                  context,
                                ).toString(),
                              ).format(video.viewCount),
                            ),
                          );
                        },
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 34)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AppLocalizations l10n;

  const _Header({required this.l10n});

  @override
  Widget build(BuildContext context) => Padding(
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

class _ShortsCard extends StatelessWidget {
  final int index;
  final VideoDetail video;
  final String category;
  final String viewText;

  const _ShortsCard({
    required this.index,
    required this.video,
    required this.category,
    required this.viewText,
  });

  @override
  Widget build(BuildContext context) => Semantics(
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
                      child: VideoDurationBadge(
                        duration: _formatDuration(video.durationSeconds),
                      ),
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
                    viewText,
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

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$remainingSeconds';
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
          Icon(
            Icons.stay_current_portrait_rounded,
            size: 42,
            color: HomeDesignTokens.brandFor(context),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: HomeDesignTokens.muted(context)),
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
        Text(label),
        const SizedBox(height: 12),
        FilledButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    ),
  );
}
