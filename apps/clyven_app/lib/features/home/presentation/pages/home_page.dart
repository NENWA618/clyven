import 'dart:io';

import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../video/presentation/pages/video_detail_page.dart';
import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import 'video_search_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  static const Color _backgroundColor = Color(0xFFF4F1EA);
  static const Color _inkColor = Color(0xFF161616);
  static const Color _purpleColor = Color(0xFF7657FF);
  static const Color _acidColor = Color(0xFFE5FF58);

  Widget _buildCoverImage(String path) {
    if (path.isEmpty) {
      return Container(
        color: const Color(0xFFD8D2C8),
        child: const Icon(
          Icons.image_not_supported_outlined,
        ),
      );
    }

    final isNetwork =
        path.startsWith('http://') || path.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Container(
            color: const Color(0xFFD8D2C8),
            child: const Icon(
              Icons.image_not_supported_outlined,
            ),
          );
        },
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return Container(
          color: const Color(0xFFD8D2C8),
          child: const Icon(
            Icons.image_not_supported_outlined,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeProvider);
    final l10n = AppLocalizations.of(context)!;

    return ColoredBox(
      color: _backgroundColor,
      child: homeAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 42,
                    color: _inkColor,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.homeLoadFailed,
                    style: const TextStyle(
                      color: _inkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      ref.invalidate(homeProvider);
                    },
                    child: Text(l10n.reload),
                  ),
                ],
              ),
            ),
          );
        },
        data: (homeState) {
          return _buildHome(homeState, l10n);
        },
      ),
    );
  }

  Widget _buildHome(
    HomeState homeState,
    AppLocalizations l10n,
  ) {
    final feed = homeState.feed;
    final videos = feed.videos;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () {
          return ref.read(homeProvider.notifier).refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(l10n),
            ),
            SliverToBoxAdapter(
              child: _buildFeaturedVideo(
                feed.featuredVideo,
                l10n,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildTopicOrbit(
                homeState,
                l10n,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionHeader(l10n),
            ),
            if (videos.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.blur_off_rounded,
                          size: 38,
                          color: Color(0xFF908A81),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.emptyTrack,
                          style: const TextStyle(
                            color: Color(0xFF77736C),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  18,
                  130,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, rawIndex) {
                      if (rawIndex.isOdd) {
                        return const SizedBox(height: 18);
                      }

                      final index = rawIndex ~/ 2;

                      return _buildVideoTrackCard(
                        index,
                        videos[index],
                        l10n,
                      );
                    },
                    childCount: videos.length * 2 - 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    final now = DateTime.now();
    final localeName = Localizations.localeOf(context).toString();
    final dateText = DateFormat(
      'EEEE · dd MMM',
      localeName,
    ).format(now).toUpperCase();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateText,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    color: Color(0xFF77736C),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.homeQuestion,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: _inkColor,
                  ),
                ),
              ],
            ),
          ),
          _buildHeaderButton(
            icon: Icons.search_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const VideoSearchPage();
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // TODO: open profile
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _purpleColor,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: const Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.72),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE0DBD2),
          ),
        ),
        child: Icon(
          icon,
          color: _inkColor,
        ),
      ),
    );
  }

  Widget _buildFeaturedVideo(
    HomeVideo video,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VideoDetailPage(
                  videoId: video.id,
                );
              },
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 430,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  video.coverUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color: const Color(0xFF373149),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x12000000),
                        Color(0x44000000),
                        Color(0xE8000000),
                      ],
                      stops: [
                        0,
                        0.52,
                        1,
                      ],
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: CustomPaint(
                    painter: _OrbitPainter(),
                  ),
                ),
                Positioned(
                  top: 22,
                  left: 22,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _acidColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      l10n.featuredToday,
                      style: const TextStyle(
                        color: _inkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 22,
                  right: 22,
                  child: Text(
                    l10n.featuredIndexLabel,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  right: 22,
                  bottom: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedTopicLabel(
                          l10n,
                          video.category,
                        ).toUpperCase(),
                        style: const TextStyle(
                          color: _acidColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        video.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          height: 1.08,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        video.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // TODO: play directly
                            },
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                size: 34,
                                color: _inkColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video.duration,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${video.authorName} · ${video.viewText}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: save
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white30,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                l10n.save,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopicOrbit(
    HomeState homeState,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          18,
          24,
          18,
          16,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: HomeNotifier.topics.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 9);
        },
        itemBuilder: (context, index) {
          final topic = HomeNotifier.topics[index];
          final selected = homeState.selectedTopic == topic;

          return Transform.translate(
            offset: Offset(
              0,
              index.isEven ? 0 : 13,
            ),
            child: GestureDetector(
              onTap: () {
                ref.read(homeProvider.notifier).selectTopic(topic);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                height: 47,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: selected ? _inkColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected
                        ? _inkColor
                        : const Color(0xFFCAC5BB),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  localizedTopicLabel(l10n, topic),
                  style: TextStyle(
                    color: selected
                        ? _acidColor
                        : const Color(0xFF504D48),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        15,
        20,
        16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              l10n.continueByInterest,
              style: const TextStyle(
                color: _inkColor,
                fontSize: 27,
                height: 1.05,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(homeProvider.notifier).refresh();
            },
            child: Row(
              children: [
                Text(
                  l10n.rearrange,
                  style: const TextStyle(
                    color: Color(0xFF77736C),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.shuffle_rounded,
                  size: 17,
                  color: Color(0xFF77736C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTrackCard(
    int index,
    HomeVideo video,
    AppLocalizations l10n,
  ) {
    final reverse = index.isOdd;

    final cover = Expanded(
      flex: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildCoverImage(video.coverUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0x7A000000),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _inkColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  video.duration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final information = Expanded(
      flex: 6,
      child: Padding(
        padding: EdgeInsets.only(
          left: reverse ? 0 : 16,
          right: reverse ? 16 : 0,
          top: 6,
          bottom: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: index.isEven ? _acidColor : _purpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                localizedTopicLabel(l10n, video.category),
                style: TextStyle(
                  color: index.isEven ? _inkColor : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Spacer(),
            Text(
              video.title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _inkColor,
                fontSize: 18,
                height: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Text(
              video.authorName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF5E5A54),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              video.viewText,
              style: const TextStyle(
                color: Color(0xFF908A81),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VideoDetailPage(
                videoId: video.id,
              );
            },
          ),
        );
      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.72),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: const Color(0xFFE3DED5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              decoration: const BoxDecoration(
                color: _inkColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25),
                ),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    'TRACK ${(index + 1).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: reverse
                      ? [
                          information,
                          cover,
                        ]
                      : [
                          cover,
                          information,
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final dotPaint = Paint()
      ..color = const Color(0xFFE5FF58).withOpacity(0.85);

    final center = Offset(
      size.width * 0.83,
      size.height * 0.25,
    );

    canvas.drawCircle(
      center,
      74,
      linePaint,
    );

    canvas.drawCircle(
      center,
      115,
      linePaint,
    );

    canvas.drawCircle(
      center,
      4,
      dotPaint,
    );

    canvas.drawLine(
      Offset(
        size.width * 0.1,
        size.height * 0.48,
      ),
      Offset(
        size.width * 0.88,
        size.height * 0.48,
      ),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
