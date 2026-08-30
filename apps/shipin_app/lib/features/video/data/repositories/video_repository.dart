import '../models/video_detail.dart';
import '../models/video_upload_draft.dart';

abstract class VideoRepository {
  Future<VideoDetail> loadVideoDetail(
    String videoId,
  );

  Future<VideoDetail> createVideo({
    required String userId,
    required String authorName,
    required VideoUploadDraft draft,
  });

  // 首页 / 发现：
  // 获取所有用户发布的视频。
  Future<List<VideoDetail>> loadPublishedVideos();

  // 我的投稿：
  // 只获取指定用户的视频。
  Future<List<VideoDetail>> loadUserVideos({
    required String userId,
  });
}

class MockVideoRepository
    implements VideoRepository {
  final Map<String, VideoDetail>
      _createdVideos = {};

  final Map<String, String>
      _videoOwners = {};

  // ============================================================
  // 创建视频
  // ============================================================

  @override
  Future<VideoDetail> createVideo({
    required String userId,
    required String authorName,
    required VideoUploadDraft draft,
  }) async {
    await Future<void>.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );

    final id =
        'uploaded-${DateTime.now().microsecondsSinceEpoch}';

    final video = VideoDetail(
      id: id,
      title: draft.title,
      description: draft.description,
      authorId: userId,
      authorName: authorName,
      category: draft.category,
      tags: [
        draft.category,
      ],
      coverUrl:
          draft.coverPath ?? '',
      videoUrl:
          draft.videoPath,
      durationSeconds:
          draft.durationSeconds,
      viewCount: 0,
      likeCount: 0,
      favoriteCount: 0,
      commentCount: 0,
      publishedAt:
          DateTime.now(),
    );

    _createdVideos[id] =
        video;

    _videoOwners[id] =
        userId;

    return video;
  }

  // ============================================================
  // 所有用户发布的视频
  // ============================================================

  @override
  Future<List<VideoDetail>>
      loadPublishedVideos() async {
    await Future<void>.delayed(
      const Duration(
        milliseconds: 200,
      ),
    );

    final videos =
        _createdVideos.values
            .toList();

    videos.sort(
      (a, b) {
        return b.publishedAt
            .compareTo(
          a.publishedAt,
        );
      },
    );

    return List.unmodifiable(
      videos,
    );
  }

  // ============================================================
  // 当前用户的视频
  // ============================================================

  @override
  Future<List<VideoDetail>>
      loadUserVideos({
    required String userId,
  }) async {
    await Future<void>.delayed(
      const Duration(
        milliseconds: 200,
      ),
    );

    final videos =
        _createdVideos.values
            .where(
      (video) {
        return _videoOwners[
                video.id] ==
            userId;
      },
    ).toList();

    videos.sort(
      (a, b) {
        return b.publishedAt
            .compareTo(
          a.publishedAt,
        );
      },
    );

    return List.unmodifiable(
      videos,
    );
  }

  // ============================================================
  // 视频详情
  // ============================================================

  @override
  Future<VideoDetail> loadVideoDetail(
    String videoId,
  ) async {
    // 先检查用户刚刚发布的视频。
    final createdVideo =
        _createdVideos[
      videoId
    ];

    if (createdVideo != null) {
      return createdVideo;
    }

    await Future<void>.delayed(
      const Duration(
        milliseconds: 400,
      ),
    );

    switch (videoId) {
      case 'video-001':
        return VideoDetail(
          id: videoId,
          title:
              '凌晨四点，城市还没有完全醒来',
          description:
              '城市真正醒来之前，会出现一段很短暂的安静时刻。'
              '这次我们沿着仍然亮着灯的街道前进，记录清晨、工作、交通以及人与城市之间的关系。',
          authorId:
              'creator-001',
          authorName:
              '边界记录室',
          category:
              '城市影像',
          tags: const [
            '城市',
            '纪录',
            '影像',
          ],
          coverUrl:
              'https://images.unsplash.com/photo-1519501025264-65ba15a82390'
              '?auto=format&fit=crop&w=1400&q=85',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          durationSeconds:
              768,
          viewCount:
              86000,
          likeCount:
              12600,
          favoriteCount:
              4300,
          commentCount:
              912,
          publishedAt:
              DateTime(
            2026,
            8,
            5,
          ),
        );

      case 'video-002':
        return VideoDetail(
          id: videoId,
          title:
              '用一整天，重新理解 Flutter 的状态流动',
          description:
              '从 Widget 开始，一路追踪状态如何经过 Riverpod、Repository 和数据源，'
              '重新理解大型 Flutter 项目中的数据流动。',
          authorId:
              'creator-002',
          authorName:
              '未完成实验室',
          category:
              '开发手记',
          tags: const [
            'Flutter',
            '编程',
            'Riverpod',
          ],
          coverUrl:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3'
              '?auto=format&fit=crop&w=1400&q=85',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          durationSeconds:
              1696,
          viewCount:
              42000,
          likeCount:
              8300,
          favoriteCount:
              5100,
          commentCount:
              682,
          publishedAt:
              DateTime(
            2026,
            8,
            4,
          ),
        );

      case 'video-003':
        return VideoDetail(
          id: videoId,
          title:
              '一门语言消失之前，我们还能留下什么？',
          description:
              '语言不只是词汇和语法。它保存着人与土地、家庭、历史和记忆之间的连接。'
              '这是一段关于语言记录与保存的影像。',
          authorId:
              'creator-003',
          authorName:
              '语言群岛',
          category:
              '语言纪录',
          tags: const [
            '语言',
            '文化',
            '纪录片',
          ],
          coverUrl:
              'https://images.unsplash.com/photo-1455390582262-044cdead277a'
              '?auto=format&fit=crop&w=1400&q=85',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          durationSeconds:
              1115,
          viewCount:
              137000,
          likeCount:
              28600,
          favoriteCount:
              13200,
          commentCount:
              2410,
          publishedAt:
              DateTime(
            2026,
            8,
            2,
          ),
        );

      case 'video-004':
        return VideoDetail(
          id: videoId,
          title:
              '没有游客的海岸线，以及生活在那里的人',
          description:
              '离开热门旅游路线，我们继续沿海岸向前。'
              '这里没有打卡点，只有每天真实生活在海边的人。',
          authorId:
              'creator-004',
          authorName:
              '远岸频道',
          category:
              '人文纪录',
          tags: const [
            '海岸',
            '人文',
            '旅行',
          ],
          coverUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
              '?auto=format&fit=crop&w=1400&q=85',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          durationSeconds:
              2120,
          viewCount:
              61000,
          likeCount:
              9400,
          favoriteCount:
              3800,
          commentCount:
              743,
          publishedAt:
              DateTime(
            2026,
            8,
            1,
          ),
        );

      default:
        return VideoDetail(
          id: videoId,
          title:
              '沿着旧铁路，寻找逐渐消失的声音',
          description:
              '一部关于地方语言、记忆与迁徙的影像记录。'
              '我们沿着旧铁路前进，寻找那些仍然被人们使用，却越来越少被听见的声音。',
          authorId:
              'creator-003',
          authorName:
              '语言群岛',
          category:
              '纪录',
          tags: const [
            '语言',
            '人文',
            '铁路',
          ],
          coverUrl:
              'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'
              '?auto=format&fit=crop&w=1400&q=85',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          durationSeconds:
              2300,
          viewCount:
              214000,
          likeCount:
              39100,
          favoriteCount:
              18400,
          commentCount:
              3280,
          publishedAt:
              DateTime(
            2026,
            8,
            6,
          ),
        );
    }
  }
}