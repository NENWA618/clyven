import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../data/models/home_feed.dart';
import '../../data/models/home_video.dart';
import '../../data/repositories/home_repository.dart';

final homeRepositoryProvider =
    Provider<HomeRepository>(
  (ref) {
    return const MockHomeRepository();
  },
);

class HomeState {
  final String selectedTopic;
  final HomeFeed feed;

  const HomeState({
    required this.selectedTopic,
    required this.feed,
  });

  HomeState copyWith({
    String? selectedTopic,
    HomeFeed? feed,
  }) {
    return HomeState(
      selectedTopic:
          selectedTopic ??
              this.selectedTopic,
      feed:
          feed ?? this.feed,
    );
  }
}

class HomeNotifier
    extends AsyncNotifier<HomeState> {
  static const List<String>
      topics = [
    '全部',
    '影像',
    '技术',
    '语言',
    '游戏',
    '音乐',
    '城市',
    '纪录',
  ];

  HomeRepository get _repository {
    return ref.read(
      homeRepositoryProvider,
    );
  }

  // ============================================================
  // 首次加载
  // ============================================================

  @override
  Future<HomeState> build() async {
    const selectedTopic =
        '全部';

    // 这里改成：
    // 获取所有用户发布的视频。
    final publishedVideos =
        await ref.watch(
      allPublishedVideosProvider
          .future,
    );

    final feed =
        await _loadFeed(
      topic: selectedTopic,
      publishedVideos:
          publishedVideos,
    );

    return HomeState(
      selectedTopic:
          selectedTopic,
      feed: feed,
    );
  }

  // ============================================================
  // 切换分类
  // ============================================================

  Future<void> selectTopic(
    String topic,
  ) async {
    final currentState =
        state.value;

    if (currentState == null) {
      return;
    }

    if (currentState
            .selectedTopic ==
        topic) {
      return;
    }

    state =
        const AsyncLoading();

    state =
        await AsyncValue.guard(
      () async {
        // 所有用户的视频。
        final publishedVideos =
            await ref.read(
          allPublishedVideosProvider
              .future,
        );

        final feed =
            await _loadFeed(
          topic: topic,
          publishedVideos:
              publishedVideos,
        );

        return HomeState(
          selectedTopic:
              topic,
          feed: feed,
        );
      },
    );
  }

  // ============================================================
  // 下拉刷新
  // ============================================================

  Future<void> refresh() async {
    final currentState =
        state.value;

    final topic =
        currentState
                ?.selectedTopic ??
            '全部';

    state =
        await AsyncValue.guard(
      () async {
        // 强制重新从 Serverpod
        // 查询所有用户的视频。
        ref.invalidate(
          allPublishedVideosProvider,
        );

        final publishedVideos =
            await ref.read(
          allPublishedVideosProvider
              .future,
        );

        final feed =
            await _loadFeed(
          topic: topic,
          publishedVideos:
              publishedVideos,
        );

        return HomeState(
          selectedTopic:
              topic,
          feed: feed,
        );
      },
    );
  }

  // ============================================================
  // 组合首页数据
  // ============================================================

  Future<HomeFeed> _loadFeed({
    required String topic,
    required List<VideoDetail>
        publishedVideos,
  }) async {
    final originalFeed =
        await _repository
            .loadHomeFeed(
      topic: topic,
    );

    final uploadedVideos =
        publishedVideos
            .where(
              (video) {
                if (topic ==
                    '全部') {
                  return true;
                }

                return video
                        .category ==
                    topic;
              },
            )
            .map(
              _toHomeVideo,
            )
            .toList(
              growable: false,
            );

    return HomeFeed(
      // 今日主片暂时继续用原来的 Mock。
      featuredVideo:
          originalFeed
              .featuredVideo,

      // 所有用户真实投稿放前面。
      videos:
          List.unmodifiable([
        ...uploadedVideos,

        // 原来的演示视频继续保留。
        ...originalFeed.videos,
      ]),
    );
  }

  // ============================================================
  // VideoDetail -> HomeVideo
  // ============================================================

  HomeVideo _toHomeVideo(
    VideoDetail video,
  ) {
    return HomeVideo(
      id: video.id,
      title: video.title,
      description:
          video.description,
      authorName:
          video.authorName,
      category:
          video.category,
      topic:
          video.category,
      duration:
          _formatDuration(
        video.durationSeconds,
      ),
      viewText:
          '${_formatCount(video.viewCount)}次观看',
      coverUrl:
          video.coverUrl,
      videoUrl:
          video.videoUrl,
    );
  }

  String _formatDuration(
    int seconds,
  ) {
    final duration =
        Duration(
      seconds: seconds,
    );

    final hours =
        duration.inHours;

    final minutes =
        duration.inMinutes
            .remainder(60)
            .toString()
            .padLeft(
              2,
              '0',
            );

    final remainingSeconds =
        duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(
              2,
              '0',
            );

    if (hours > 0) {
      return '$hours:$minutes:$remainingSeconds';
    }

    return '${duration.inMinutes}:$remainingSeconds';
  }

  String _formatCount(
    int value,
  ) {
    if (value >= 10000) {
      final result =
          value / 10000;

      if (result >= 10) {
        return '${result.toStringAsFixed(0)}万';
      }

      return '${result.toStringAsFixed(1)}万';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }

    return value.toString();
  }
}

final homeProvider =
    AsyncNotifierProvider<
        HomeNotifier,
        HomeState>(
  HomeNotifier.new,
);