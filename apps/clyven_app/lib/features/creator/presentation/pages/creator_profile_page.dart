import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models/creator_profile.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/creator_profile_provider.dart';

import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class CreatorProfilePage extends ConsumerWidget {
  final String creatorId;

  const CreatorProfilePage({super.key, required this.creatorId});

  static const Color _ink = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creatorAsync = ref.watch(creatorProfileProvider(creatorId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: creatorAsync.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return SafeArea(
            child: Column(
              children: [
                _buildBackButton(context),
                Expanded(
                  child: Center(child: Text(l10n.creatorProfileLoadFailed)),
                ),
              ],
            ),
          );
        },
        data: (state) {
          return _buildPage(context, ref, state, l10n);
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    WidgetRef ref,
    CreatorProfileState state,
    AppLocalizations l10n,
  ) {
    final creator = state.creator;
    final seriesGroups =
        _groupVideosBySeries(creator.videos, l10n.uncategorizedSeries);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _buildHero(context, creator, l10n)),
        SliverToBoxAdapter(child: _buildIdentity(context, ref, state, l10n)),
        SliverToBoxAdapter(child: _buildStatistics(context, creator, l10n)),
        SliverToBoxAdapter(child: _buildSectionHeader(l10n)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 42),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entry = seriesGroups.entries.elementAt(index);
              return _buildSeriesSection(
                context,
                entry.key,
                entry.value,
                l10n,
              );
            }, childCount: seriesGroups.length),
          ),
        ),
      ],
    );
  }

  Widget _buildHero(
    BuildContext context,
    CreatorProfile creator,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 290,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            creator.bannerUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: scheme.secondary);
            },
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x44000000),
                  Color(0x00000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 16,
            child: _buildBackButton(context),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            right: 16,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.more_horiz_rounded, color: Colors.white),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.creatorSpace,
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.framesCount(creator.videoCount),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentity(
    BuildContext context,
    WidgetRef ref,
    CreatorProfileState state,
    AppLocalizations l10n,
  ) {
    final creator = state.creator;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    creator.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: scheme.secondary,
                        alignment: Alignment.center,
                        child: Text(
                          creator.name.isEmpty
                              ? '?'
                              : creator.name.substring(0, 1),
                          style: TextStyle(
                            color: scheme.onSecondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.voiceMaker,
                      style: TextStyle(
                        color: scheme.secondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.7,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      creator.name,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              if (ref.watch(authProvider).value?.id != creator.id)
                GestureDetector(
                  onTap: state.isChangingFollow
                      ? null
                      : () {
                          ref
                              .read(creatorProfileProvider(creator.id).notifier)
                              .toggleFollow();
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 19,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: state.isFollowing ? _ink : scheme.primary,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      state.isFollowing ? l10n.followingButton : l10n.follow,
                      style: TextStyle(
                        color: state.isFollowing
                            ? Colors.white
                            : scheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            creator.bio,
            style: const TextStyle(
              color: Color(0xFF4F4B45),
              fontSize: 14,
              height: 1.65,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(
    BuildContext context,
    CreatorProfile creator,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        height: 86,
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            _stat(
              context,
              _formatCount(context, creator.followerCount),
              l10n.followers,
            ),
            _divider(),
            _stat(
              context,
              _formatCount(context, creator.videoCount),
              l10n.works,
            ),
            _divider(),
            _stat(
              context,
              _formatCount(context, creator.totalViewCount),
              l10n.totalViews,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 30, color: Colors.white12);
  }

  Widget _buildSectionHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.creatorTrack,
              style: const TextStyle(
                color: _ink,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            l10n.latestFrames,
            style: const TextStyle(
              color: Color(0xFF99938A),
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<CreatorVideoPreview>> _groupVideosBySeries(
    List<CreatorVideoPreview> videos,
    String uncategorizedSeries,
  ) {
    final groups = <String, List<CreatorVideoPreview>>{};

    for (final video in videos) {
      final normalized = video.seriesTitle.trim();
      final title = normalized.isEmpty ? uncategorizedSeries : normalized;
      groups.putIfAbsent(title, () => <CreatorVideoPreview>[]).add(video);
    }

    return groups;
  }

  Widget _buildSeriesSection(
    BuildContext context,
    String seriesTitle,
    List<CreatorVideoPreview> videos,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    seriesTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.seriesVideoCount(videos.length),
                  style: const TextStyle(
                    color: Color(0xFF99938A),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          for (var index = 0; index < videos.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == videos.length - 1 ? 0 : 14,
              ),
              child: _buildVideoCard(context, videos[index], index, l10n),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    CreatorVideoPreview video,
    int index,
    AppLocalizations l10n,
  ) {
    final number = (index + 1).toString().padLeft(2, '0');

    return GestureDetector(
      onTap: () {
        openGlobalVideo(video.id);
      },
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: const Color(0xFFE3DED5)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(22),
              ),
              child: SizedBox(
                width: 145,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(video.coverUrl, fit: BoxFit.cover),
                    Positioned(
                      left: 9,
                      bottom: 9,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _ink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _duration(video.durationSeconds),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.frameNumber(number),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 15,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      l10n.viewsCount(_formatCount(context, video.viewCount)),
                      style: const TextStyle(
                        color: Color(0xFF908A81),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
    );
  }

  String _formatCount(BuildContext context, int value) {
    final localeName = Localizations.localeOf(context).toString();
    return NumberFormat.compact(locale: localeName).format(value);
  }

  static String _duration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$remainingSeconds';
  }
}
