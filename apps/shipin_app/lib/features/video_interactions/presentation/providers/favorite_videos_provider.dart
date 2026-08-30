import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import 'video_interaction_provider.dart';

final favoriteVideosProvider =
    FutureProvider<List<VideoDetail>>((ref) async {
  final videoIds = await ref.watch(
    favoriteVideoIdsProvider.future,
  );

  if (videoIds.isEmpty) {
    return const [];
  }

  final repository = ref.read(
    videoRepositoryProvider,
  );

  final videos = await Future.wait(
    videoIds.map((videoId) {
      return repository.loadVideoDetail(
        videoId,
      );
    }),
  );

  return List.unmodifiable(videos);
});