import 'package:clyven_backend_client/clyven_backend_client.dart';

import '../../../video/data/repositories/video_repository.dart';
import '../models/watch_history_item.dart';

abstract class WatchHistoryRepository {
  Future<List<WatchHistoryItem>> loadHistory({required String userId});

  Future<WatchHistoryItem> saveProgress({
    required String userId,
    required WatchHistoryItem item,
  });

  Future<void> removeHistory({required String userId, required String videoId});

  Future<void> clearHistory({required String userId});
}

class ServerpodWatchHistoryRepository implements WatchHistoryRepository {
  final Client client;
  final VideoRepository videoRepository;

  const ServerpodWatchHistoryRepository({
    required this.client,
    required this.videoRepository,
  });

  @override
  Future<List<WatchHistoryItem>> loadHistory({required String userId}) async {
    final rows = await client.social.getWatchHistory();
    final result = <WatchHistoryItem>[];
    for (final row in rows) {
      try {
        final video = await videoRepository.loadVideoDetail(
          row.videoId.toString(),
        );
        result.add(
          WatchHistoryItem(
            videoId: video.id,
            title: video.title,
            coverUrl: video.coverUrl,
            authorName: video.authorName,
            positionSeconds: row.positionSeconds,
            durationSeconds: video.durationSeconds,
            watchedAt: row.watchedAt,
          ),
        );
      } catch (_) {
        // A deleted or inaccessible video is omitted from history.
      }
    }
    return List.unmodifiable(result);
  }

  @override
  Future<WatchHistoryItem> saveProgress({
    required String userId,
    required WatchHistoryItem item,
  }) async {
    await client.social.saveWatchProgress(
      int.parse(item.videoId),
      item.positionSeconds,
    );
    return item;
  }

  @override
  Future<void> removeHistory({
    required String userId,
    required String videoId,
  }) async {
    await client.social.removeWatchHistory(int.parse(videoId));
  }

  @override
  Future<void> clearHistory({required String userId}) async {
    await client.social.clearWatchHistory();
  }
}
