import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';

import '../../data/models/video_detail.dart';
import '../../data/repositories/video_repository.dart';
import '../../data/repositories/serverpod_video_repository.dart';

final videoRepositoryProvider =
    Provider<VideoRepository>(
  (ref) {
    final client = ref.watch(
      serverpodClientProvider,
    );

    return ServerpodVideoRepository(
      client: client,
    );
  },
);

// ============================================================
// 单个视频详情
// ============================================================

final videoDetailProvider =
    FutureProvider.family<
        VideoDetail,
        String>(
  (ref, videoId) async {
    final repository =
        ref.watch(
      videoRepositoryProvider,
    );

    return repository
        .loadVideoDetail(
      videoId,
    );
  },
);

// ============================================================
// 所有用户发布的视频
//
// 首页 / 发现使用。
// 不根据当前登录账号过滤。
// ============================================================

final allPublishedVideosProvider =
    FutureProvider<
        List<VideoDetail>>(
  (ref) async {
    final repository =
        ref.watch(
      videoRepositoryProvider,
    );

    return repository
        .loadPublishedVideos();
  },
);

// ============================================================
// 当前用户发布的视频
//
// “我的投稿”使用。
// ============================================================

final myPublishedVideosProvider =
    FutureProvider<
        List<VideoDetail>>(
  (ref) async {
    final user =
        await ref.watch(
      authProvider.future,
    );

    if (user == null) {
      return const [];
    }

    final repository =
        ref.watch(
      videoRepositoryProvider,
    );

    return repository
        .loadUserVideos(
      userId: user.id,
    );
  },
);