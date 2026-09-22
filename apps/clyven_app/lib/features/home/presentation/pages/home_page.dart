import 'dart:io';

import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import 'video_search_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _lightBackground = Color(0xFFF7F9FC);
  static const _darkBackground = Color(0xFF0D1117);
  static const _lightInk = Color(0xFF111827);
  static const _darkInk = Color(0xFFF2F4F7);
  static const _lightMuted = Color(0xFF667085);
  static const _darkMuted = Color(0xFFAAB4C3);
  static const _lightSoft = Color(0xFFEEF2F7);
  static const _darkSoft = Color(0xFF1B2430);
  static const _brandBlue = Color(0xFF3478F6);

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;
  Color get _pageBackground => _isDark ? _darkBackground : _lightBackground;
  Color get _ink => _isDark ? _darkInk : _lightInk;
  Color get _muted => _isDark ? _darkMuted : _lightMuted;
  Color get _soft => _isDark ? _darkSoft : _lightSoft;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(homeProvider);
    return ColoredBox(
      color: _pageBackground,
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _error(),
        data: _home,
      ),
    );
  }

  Widget _error() {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 42),
            const SizedBox(height: 12),
            Text(l10n.homeLoadFailed),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => ref.invalidate(homeProvider),
              child: Text(l10n.reload),
            ),
          ],
        ),
      ),
    );
  }

  Widget _home(HomeState state) {
    final l10n = AppLocalizations.of(context)!;
    final videos = state.feed.videos;
    final trending = videos.take(2).toList();
    final explore = videos.skip(2).toList();

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () => ref.read(homeProvider.notifier).refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: _header()),
            SliverToBoxAdapter(child: _forYouHeading()),
            SliverToBoxAdapter(child: _hero(state.feed.featuredVideo, l10n)),
            SliverToBoxAdapter(child: _topics(state, l10n)),
            if (trending.isNotEmpty)
              SliverToBoxAdapter(
                child: _section(
                  title: '正在流行',
                  videos: trending,
                  l10n: l10n,
                  compact: false,
                ),
              ),
            if (explore.isNotEmpty)
              SliverToBoxAdapter(
                child: _section(
                  title: '继续探索',
                  videos: explore,
                  l10n: l10n,
                  compact: true,
                ),
              ),
            if (videos.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(48),
                  child: Center(child: Text('暂无推荐视频')),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clyven',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 38,
                    height: .95,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.7,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Learn. Watch. Grow.',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const VideoSearchPage()),
            ),
            icon: const Icon(Icons.search_rounded, size: 30),
          ),
          const SizedBox(width: 5),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _brandBlue.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: _brandBlue,
              size: 23,
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded, size: 28),
              ),
              Positioned(
                right: 7,
                top: 5,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forYouHeading() {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '为你推荐',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 28,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '根据你的兴趣与学习语言推荐',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: _brandBlue),
            onPressed: () => ref.read(homeProvider.notifier).refresh(),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('查看更多'),
                SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero(HomeVideo video, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: InkWell(
        onTap: () => openGlobalVideo(video.id),
        borderRadius: BorderRadius.circular(23),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: AspectRatio(
            aspectRatio: 16 / 8.8,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _cover(video.coverUrl),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x08000000),
                        Color(0x26000000),
                        Color(0xE0000000),
                      ],
                      stops: [0, .48, 1],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: _pill(
                    localizedTopicLabel(l10n, video.category),
                    light: true,
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x30000000),
                            blurRadius: 18,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: _ink,
                        size: 34,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 17,
                  right: 84,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _avatar(video.authorName, 28),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${video.authorName}\n${video.viewText}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                height: 1.25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 10,
                  child: _duration(video.duration),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topics(HomeState state, AppLocalizations l10n) {
    final colors = Theme.of(context).colorScheme;
    final icons = <IconData>[
      Icons.grid_view_rounded,
      Icons.videocam_outlined,
      Icons.settings_outlined,
      Icons.translate_rounded,
      Icons.sports_esports_outlined,
      Icons.music_note_rounded,
      Icons.location_city_outlined,
      Icons.movie_creation_outlined,
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 15),
        scrollDirection: Axis.horizontal,
        itemCount: HomeNotifier.topics.length,
        separatorBuilder: (_, __) => const SizedBox(width: 9),
        itemBuilder: (_, i) {
          final topic = HomeNotifier.topics[i];
          final selected = state.selectedTopic == topic;
          return InkWell(
            onTap: () => ref.read(homeProvider.notifier).selectTopic(topic),
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: selected ? _brandBlue : _soft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    icons[i % icons.length],
                    size: 17,
                    color: selected ? Colors.white : _ink,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    localizedTopicLabel(l10n, topic),
                    style: TextStyle(
                      color: selected ? Colors.white : _ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _section({
    required String title,
    required List<HomeVideo> videos,
    required AppLocalizations l10n,
    required bool compact,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 5, 18, 23),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: _brandBlue),
                onPressed: () => ref.read(homeProvider.notifier).refresh(),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('查看全部'),
                    Icon(Icons.chevron_right_rounded, size: 18),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (_, c) {
              final width = c.maxWidth;
              final columns = width >= 1050
                  ? (compact ? 4 : 3)
                  : width >= 700
                  ? 3
                  : 2;
              const gap = 14.0;
              final itemWidth = (width - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: 22,
                children: [
                  for (final video in videos)
                    SizedBox(
                      width: itemWidth,
                      child: _videoCard(video, l10n, compact: compact),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _videoCard(
    HomeVideo video,
    AppLocalizations l10n, {
    required bool compact,
  }) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => openGlobalVideo(video.id),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _cover(video.coverUrl),
                  Positioned(
                    right: 7,
                    bottom: 7,
                    child: _duration(video.duration),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _ink,
              fontSize: compact ? 12.5 : 13.5,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              _avatar(video.authorName, 25),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  '${video.authorName}\n${video.viewText}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _muted, fontSize: 9.5, height: 1.25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cover(String path) {
    if (path.isEmpty) return _placeholder();
    final network = path.startsWith('http://') || path.startsWith('https://');
    if (network) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7E0D4), Color(0xFFD8CDBD)],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          size: 34,
          color: Color(0xFF9C8D79),
        ),
      ),
    );
  }

  Widget _avatar(String name, double size) {
    final letter = name.trim().isEmpty ? 'C' : name.trim()[0].toUpperCase();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFE6ECF7),
        shape: BoxShape.circle,
      ),
      child: Text(
        letter,
        style: TextStyle(
          color: const Color(0xFF48678F),
          fontSize: size * .4,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _duration(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xD6111827),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _pill(String text, {required bool light}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: light ? Colors.white.withValues(alpha: .88) : _ink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _ink,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
