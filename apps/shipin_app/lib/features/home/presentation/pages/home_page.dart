import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import '../../../video/presentation/pages/video_detail_page.dart';
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
      path.startsWith('http://') ||
      path.startsWith('https://');

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
                const Text(
                  '主页加载失败',
                  style: TextStyle(
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
                  child: const Text('重新加载'),
                ),
              ],
            ),
          ),
        );
      },
      data: (homeState) {
        return _buildHome(homeState);
      },
    ),
  );
}

  Widget _buildHome(HomeState homeState) {
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
            child: _buildHeader(),
          ),

          SliverToBoxAdapter(
            child: _buildFeaturedVideo(
              feed.featuredVideo,
            ),
          ),

          SliverToBoxAdapter(
            child: _buildTopicOrbit(
              homeState,
            ),
          ),

          SliverToBoxAdapter(
            child: _buildSectionHeader(),
          ),

          if (videos.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 60,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.blur_off_rounded,
                        size: 38,
                        color: Color(0xFF908A81),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '这条轨道暂时还没有内容',
                        style: TextStyle(
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
                      return const SizedBox(
                        height: 18,
                      );
                    }

                    final index = rawIndex ~/ 2;

                    return _buildVideoTrackCard(
                      index,
                      videos[index],
                    );
                  },
                  childCount:
                      videos.length * 2 - 1,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

  Widget _buildHeader() {
    final now = DateTime.now();

    const weekdays = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];

    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    final dateText =
        '${weekdays[now.weekday - 1]} · '
        '${now.day.toString().padLeft(2, '0')} '
        '${months[now.month - 1]}';

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
                const Text(
                  '今天想进入哪个世界？',
                  style: TextStyle(
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
              // TODO: 进入个人主页
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

  Widget _buildFeaturedVideo(HomeVideo video) {
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

                Positioned.fill(
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
                    child: const Text(
                      '今日主片',
                      style: TextStyle(
                        color: _inkColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const Positioned(
                  top: 22,
                  right: 22,
                  child: Text(
                    '01 / FEATURED',
                    style: TextStyle(
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
                        video.category.toUpperCase(),
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
                              // TODO: 直接播放
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                              // TODO: 收藏
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
                              child: const Text(
                                '保存',
                                style: TextStyle(
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

  Widget _buildTopicOrbit(HomeState homeState) {
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

          final selected =
              homeState.selectedTopic == topic;

          return Transform.translate(
            offset: Offset(
              0,
              index.isEven ? 0 : 13,
            ),
            child: GestureDetector(
              onTap: () {
                ref
                    .read(homeProvider.notifier)
                    .selectTopic(topic);
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 220,
                ),
                curve: Curves.easeOut,
                height: 47,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color:
                      selected ? _inkColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected
                        ? _inkColor
                        : const Color(0xFFCAC5BB),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  topic,
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

  Widget _buildSectionHeader() {
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
          const Expanded(
            child: Text(
              '沿着兴趣\n继续前进',
              style: TextStyle(
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
            child: const Row(
              children: [
                Text(
                  '重新编排',
                  style: TextStyle(
                    color: Color(0xFF77736C),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
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
  ) {
    final reverse = index.isOdd;

    final cover = Expanded(
      flex: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildCoverImage(
  video.coverUrl,
),

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
                color: index.isEven
                    ? _acidColor
                    : _purpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                video.category,
                style: TextStyle(
                  color: index.isEven
                      ? _inkColor
                      : Colors.white,
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
      ..color = const Color(0xFFE5FF58)
          .withOpacity(0.85);

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



// import 'package:flutter/material.dart';

// class VideoHomePage extends StatefulWidget {
//   const VideoHomePage({super.key});

//   @override
//   State<VideoHomePage> createState() => _VideoHomePageState();
// }

// class _VideoHomePageState extends State<VideoHomePage> {
//   static const Color _backgroundColor = Color(0xFFF4F1EA);
//   static const Color _inkColor = Color(0xFF161616);
//   static const Color _purpleColor = Color(0xFF7657FF);
//   static const Color _acidColor = Color(0xFFE5FF58);

//   final List<String> _topics = const [
//     '全部',
//     '影像',
//     '技术',
//     '语言',
//     '游戏',
//     '音乐',
//     '城市',
//     '纪录',
//   ];

//   final List<_VideoPreview> _videos = const [
//     _VideoPreview(
//       title: '凌晨四点，城市还没有完全醒来',
//       author: '边界记录室',
//       category: '城市影像',
//       duration: '12:48',
//       views: '8.6万次观看',
//       imageUrl:
//           'https://images.unsplash.com/photo-1519501025264-65ba15a82390'
//           '?auto=format&fit=crop&w=1200&q=80',
//     ),
//     _VideoPreview(
//       title: '用一整天，重新理解 Flutter 的状态流动',
//       author: '未完成实验室',
//       category: '开发手记',
//       duration: '28:16',
//       views: '4.2万次观看',
//       imageUrl:
//           'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
//           '?auto=format&fit=crop&w=1200&q=80',
//     ),
//     _VideoPreview(
//       title: '一门语言消失之前，我们还能留下什么？',
//       author: '语言群岛',
//       category: '语言纪录',
//       duration: '18:35',
//       views: '13.7万次观看',
//       imageUrl:
//           'https://images.unsplash.com/photo-1455390582262-044cdead277a'
//           '?auto=format&fit=crop&w=1200&q=80',
//     ),
//     _VideoPreview(
//       title: '没有游客的海岸线，以及生活在那里的人',
//       author: '远岸频道',
//       category: '人文纪录',
//       duration: '35:20',
//       views: '6.1万次观看',
//       imageUrl:
//           'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
//           '?auto=format&fit=crop&w=1200&q=80',
//     ),
//   ];

//   int _selectedTopicIndex = 0;
//   int _selectedNavigationIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             SliverToBoxAdapter(
//               child: _buildHeader(),
//             ),
//             SliverToBoxAdapter(
//               child: _buildFeaturedVideo(),
//             ),
//             SliverToBoxAdapter(
//               child: _buildTopicOrbit(),
//             ),
//             SliverToBoxAdapter(
//               child: _buildSectionHeader(),
//             ),
//             SliverPadding(
//               padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
//               sliver: SliverList.separated(
//                 itemCount: _videos.length,
//                 separatorBuilder: (_, __) {
//                   return const SizedBox(height: 18);
//                 },
//                 itemBuilder: (context, index) {
//                   return _MagazineVideoCard(
//                     index: index,
//                     video: _videos[index],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildNavigationDock(),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
//       child: Row(
//         children: [
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'FRIDAY · 07 AUG',
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1.8,
//                     color: Color(0xFF77736C),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   '今天想进入哪个世界？',
//                   style: TextStyle(
//                     fontSize: 24,
//                     height: 1.1,
//                     fontWeight: FontWeight.w800,
//                     color: _inkColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _HeaderButton(
//             icon: Icons.search_rounded,
//             onTap: () {},
//           ),
//           const SizedBox(width: 10),
//           GestureDetector(
//             onTap: () {},
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: _purpleColor,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 'C',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeaturedVideo() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(30),
//         child: SizedBox(
//           height: 430,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.network(
//                 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'
//                 '?auto=format&fit=crop&w=1400&q=85',
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) {
//                   return Container(
//                     color: const Color(0xFF373149),
//                   );
//                 },
//               ),
//               const DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0x12000000),
//                       Color(0x44000000),
//                       Color(0xE8000000),
//                     ],
//                     stops: [0, 0.52, 1],
//                   ),
//                 ),
//               ),
//               Positioned.fill(
//                 child: CustomPaint(
//                   painter: _OrbitPainter(),
//                 ),
//               ),
//               Positioned(
//                 top: 22,
//                 left: 22,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 13,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: _acidColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: const Text(
//                     '今日主片',
//                     style: TextStyle(
//                       color: _inkColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//               ),
//               const Positioned(
//                 top: 22,
//                 right: 22,
//                 child: Text(
//                   '01 / FEATURED',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 22,
//                 right: 22,
//                 bottom: 24,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '正在发生的世界',
//                       style: TextStyle(
//                         color: _acidColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       '沿着旧铁路，寻找\n逐渐消失的声音',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 31,
//                         height: 1.08,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       '一部关于地方语言、记忆和迁徙的影像记录。',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                         height: 1.5,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             width: 58,
//                             height: 58,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.play_arrow_rounded,
//                               size: 34,
//                               color: _inkColor,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         const Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '38 分钟',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 '纪录 · 语言 · 人文',
//                                 style: TextStyle(
//                                   color: Colors.white60,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 13,
//                             vertical: 9,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.white30,
//                             ),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Text(
//                             '保存',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopicOrbit() {
//     return SizedBox(
//       height: 108,
//       child: ListView.separated(
//         padding: const EdgeInsets.fromLTRB(18, 24, 18, 16),
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: _topics.length,
//         separatorBuilder: (_, __) {
//           return const SizedBox(width: 9);
//         },
//         itemBuilder: (context, index) {
//           final bool selected = _selectedTopicIndex == index;

//           return Transform.translate(
//             offset: Offset(0, index.isEven ? 0 : 13),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedTopicIndex = index;
//                 });
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 220),
//                 curve: Curves.easeOut,
//                 height: 47,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: selected ? _inkColor : Colors.transparent,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: selected
//                         ? _inkColor
//                         : const Color(0xFFCAC5BB),
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   _topics[index],
//                   style: TextStyle(
//                     color: selected
//                         ? _acidColor
//                         : const Color(0xFF504D48),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSectionHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 15, 20, 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           const Expanded(
//             child: Text(
//               '沿着兴趣\n继续前进',
//               style: TextStyle(
//                 color: _inkColor,
//                 fontSize: 27,
//                 height: 1.05,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: const Row(
//               children: [
//                 Text(
//                   '重新编排',
//                   style: TextStyle(
//                     color: Color(0xFF77736C),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Icon(
//                   Icons.shuffle_rounded,
//                   size: 17,
//                   color: Color(0xFF77736C),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavigationDock() {
//     return SafeArea(
//       minimum: const EdgeInsets.fromLTRB(18, 0, 18, 12),
//       child: Container(
//         height: 68,
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: _inkColor,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x38000000),
//               blurRadius: 24,
//               offset: Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             _DockItem(
//               icon: Icons.blur_on_rounded,
//               label: '星轨',
//               selected: _selectedNavigationIndex == 0,
//               onTap: () => _selectNavigation(0),
//             ),
//             _DockItem(
//               icon: Icons.explore_outlined,
//               label: '发现',
//               selected: _selectedNavigationIndex == 1,
//               onTap: () => _selectNavigation(1),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   height: 48,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: _acidColor,
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: const Icon(
//                     Icons.add_rounded,
//                     color: _inkColor,
//                     size: 30,
//                   ),
//                 ),
//               ),
//             ),
//             _DockItem(
//               icon: Icons.notifications_none_rounded,
//               label: '回响',
//               selected: _selectedNavigationIndex == 2,
//               onTap: () => _selectNavigation(2),
//             ),
//             _DockItem(
//               icon: Icons.person_outline_rounded,
//               label: '我的',
//               selected: _selectedNavigationIndex == 3,
//               onTap: () => _selectNavigation(3),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _selectNavigation(int index) {
//     setState(() {
//       _selectedNavigationIndex = index;
//     });
//   }
// }

// class _MagazineVideoCard extends StatelessWidget {
//   final int index;
//   final _VideoPreview video;

//   const _MagazineVideoCard({
//     required this.index,
//     required this.video,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const Color inkColor = Color(0xFF161616);
//     const Color purpleColor = Color(0xFF7657FF);
//     const Color acidColor = Color(0xFFE5FF58);

//     final bool reverse = index.isOdd;

//     final Widget cover = Expanded(
//       flex: 5,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(22),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               video.imageUrl,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) {
//                 return Container(
//                   color: const Color(0xFFD8D2C8),
//                   child: const Icon(
//                     Icons.image_not_supported_outlined,
//                   ),
//                 );
//               },
//             ),
//             const DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Color(0x7A000000),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 12,
//               bottom: 12,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: inkColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   video.duration,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     final Widget information = Expanded(
//       flex: 6,
//       child: Padding(
//         padding: EdgeInsets.only(
//           left: reverse ? 0 : 16,
//           right: reverse ? 16 : 0,
//           top: 6,
//           bottom: 4,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 9,
//                 vertical: 5,
//               ),
//               decoration: BoxDecoration(
//                 color: index.isEven ? acidColor : purpleColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 video.category,
//                 style: TextStyle(
//                   color: index.isEven ? inkColor : Colors.white,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Text(
//               video.title,
//               maxLines: 4,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: inkColor,
//                 fontSize: 18,
//                 height: 1.2,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//             const Spacer(),
//             Text(
//               video.author,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: Color(0xFF5E5A54),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               video.views,
//               style: const TextStyle(
//                 color: Color(0xFF908A81),
//                 fontSize: 11,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         height: 220,
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.72),
//           borderRadius: BorderRadius.circular(26),
//           border: Border.all(
//             color: const Color(0xFFE3DED5),
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 35,
//               decoration: const BoxDecoration(
//                 color: inkColor,
//                 borderRadius: BorderRadius.horizontal(
//                   left: Radius.circular(25),
//                 ),
//               ),
//               child: RotatedBox(
//                 quarterTurns: 3,
//                 child: Center(
//                   child: Text(
//                     'TRACK ${(index + 1).toString().padLeft(2, '0')}',
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 9,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.4,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: reverse
//                       ? [information, cover]
//                       : [cover, information],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _HeaderButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _HeaderButton({
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 44,
//         height: 44,
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.72),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: const Color(0xFFE0DBD2),
//           ),
//         ),
//         child: Icon(
//           icon,
//           color: const Color(0xFF161616),
//         ),
//       ),
//     );
//   }
// }

// class _DockItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;

//   const _DockItem({
//     required this.icon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const Color acidColor = Color(0xFFE5FF58);

//     return Expanded(
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: onTap,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 22,
//               color: selected ? acidColor : Colors.white54,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: selected ? acidColor : Colors.white54,
//                 fontSize: 9,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _OrbitPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint linePaint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.18)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;

//     final Paint dotPaint = Paint()
//       ..color = const Color(0xFFE5FF58).withValues(alpha: 0.85);

//     canvas.drawCircle(
//       Offset(size.width * 0.83, size.height * 0.25),
//       74,
//       linePaint,
//     );

//     canvas.drawCircle(
//       Offset(size.width * 0.83, size.height * 0.25),
//       115,
//       linePaint,
//     );

//     canvas.drawCircle(
//       Offset(size.width * 0.83, size.height * 0.25),
//       4,
//       dotPaint,
//     );

//     canvas.drawLine(
//       Offset(size.width * 0.1, size.height * 0.48),
//       Offset(size.width * 0.88, size.height * 0.48),
//       linePaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class _VideoPreview {
//   final String title;
//   final String author;
//   final String category;
//   final String duration;
//   final String views;
//   final String imageUrl;

//   const _VideoPreview({
//     required this.title,
//     required this.author,
//     required this.category,
//     required this.duration,
//     required this.views,
//     required this.imageUrl,
//   });
// }