import '../models/home_feed.dart';
import '../models/home_video.dart';

abstract class HomeRepository {
  Future<HomeFeed> loadHomeFeed({
    required String topic,
  });
}

class MockHomeRepository implements HomeRepository {
  const MockHomeRepository();

  @override
  Future<HomeFeed> loadHomeFeed({
    required String topic,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    const featuredVideo = HomeVideo(
      id: 'featured-001',
      title: '沿着旧铁路，寻找逐渐消失的声音',
      description: '一部关于地方语言、记忆和迁徙的影像记录。',
      authorName: '语言群岛',
      category: '纪录',
      topic: '纪录',
      duration: '38:20',
      viewText: '21.4万次观看',
      coverUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'
          '?auto=format&fit=crop&w=1400&q=85',
      videoUrl: '',
    );

    const allVideos = <HomeVideo>[
      HomeVideo(
        id: 'video-001',
        title: '凌晨四点，城市还没有完全醒来',
        description: '观察城市从安静到苏醒的过程。',
        authorName: '边界记录室',
        category: '城市影像',
        topic: '影像',
        duration: '12:48',
        viewText: '8.6万次观看',
        coverUrl:
            'https://images.unsplash.com/photo-1519501025264-65ba15a82390'
            '?auto=format&fit=crop&w=1200&q=80',
        videoUrl: '',
      ),
      HomeVideo(
        id: 'video-002',
        title: '用一整天，重新理解 Flutter 的状态流动',
        description: '从界面状态一路追踪到数据来源。',
        authorName: '未完成实验室',
        category: '开发手记',
        topic: '技术',
        duration: '28:16',
        viewText: '4.2万次观看',
        coverUrl:
            'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
            '?auto=format&fit=crop&w=1200&q=80',
        videoUrl: '',
      ),
      HomeVideo(
        id: 'video-003',
        title: '一门语言消失之前，我们还能留下什么？',
        description: '记录语言、文字与人的关系。',
        authorName: '语言群岛',
        category: '语言纪录',
        topic: '语言',
        duration: '18:35',
        viewText: '13.7万次观看',
        coverUrl:
            'https://images.unsplash.com/photo-1455390582262-044cdead277a'
            '?auto=format&fit=crop&w=1200&q=80',
        videoUrl: '',
      ),
      HomeVideo(
        id: 'video-004',
        title: '没有游客的海岸线，以及生活在那里的人',
        description: '远离旅游路线之后的真实海岸生活。',
        authorName: '远岸频道',
        category: '人文纪录',
        topic: '纪录',
        duration: '35:20',
        viewText: '6.1万次观看',
        coverUrl:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
            '?auto=format&fit=crop&w=1200&q=80',
        videoUrl: '',
      ),
    ];

    final videos = topic == '全部'
        ? allVideos
        : allVideos
            .where((video) {
              return video.topic == topic;
            })
            .toList(growable: false);

    return HomeFeed(
      featuredVideo: featuredVideo,
      videos: List.unmodifiable(videos),
    );
  }
}