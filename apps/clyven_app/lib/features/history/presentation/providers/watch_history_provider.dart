import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/watch_history_item.dart';
import '../../data/repositories/watch_history_repository.dart';

final watchHistoryRepositoryProvider =
    Provider<WatchHistoryRepository>((ref) {
  return MockWatchHistoryRepository();
});

class WatchHistoryNotifier
    extends AsyncNotifier<
        List<WatchHistoryItem>> {
  WatchHistoryRepository get _repository {
    return ref.read(
      watchHistoryRepositoryProvider,
    );
  }

  @override
  Future<List<WatchHistoryItem>>
      build() async {
    final user = await ref.watch(
      authProvider.future,
    );

    if (user == null) {
      return const [];
    }

    return _repository.loadHistory(
      userId: user.id,
    );
  }

  Future<void> saveProgress({
    required String videoId,
    required String title,
    required String coverUrl,
    required String authorName,
    required int positionSeconds,
    required int durationSeconds,
  }) async {
    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    final item = WatchHistoryItem(
      videoId: videoId,
      title: title,
      coverUrl: coverUrl,
      authorName: authorName,
      positionSeconds:
          positionSeconds,
      durationSeconds:
          durationSeconds,
      watchedAt: DateTime.now(),
    );

    final saved =
        await _repository.saveProgress(
      userId: user.id,
      item: item,
    );

    final current =
        state.value ??
        await _repository.loadHistory(
          userId: user.id,
        );

    final updated = [
      saved,
      ...current.where(
        (item) {
          return item.videoId !=
              videoId;
        },
      ),
    ];

    state = AsyncData(
      List.unmodifiable(updated),
    );
  }

  Future<void> remove(
    String videoId,
  ) async {
    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    await _repository.removeHistory(
      userId: user.id,
      videoId: videoId,
    );

    final current =
        state.value ?? const [];

    state = AsyncData(
      List.unmodifiable(
        current.where(
          (item) {
            return item.videoId !=
                videoId;
          },
        ),
      ),
    );
  }

  Future<void> clear() async {
    final user = await ref.read(
      authProvider.future,
    );

    if (user == null) {
      return;
    }

    await _repository.clearHistory(
      userId: user.id,
    );

    state = const AsyncData([]);
  }
}

final watchHistoryProvider =
    AsyncNotifierProvider<
        WatchHistoryNotifier,
        List<WatchHistoryItem>>(
  WatchHistoryNotifier.new,
);

final watchHistoryItemProvider =
    Provider.family<WatchHistoryItem?, String>(
  (ref, videoId) {
    final history =
        ref.watch(watchHistoryProvider).value;

    if (history == null) {
      return null;
    }

    for (final item in history) {
      if (item.videoId == videoId) {
        return item;
      }
    }

    return null;
  },
);