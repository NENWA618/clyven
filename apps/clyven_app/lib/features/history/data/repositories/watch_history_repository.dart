import '../models/watch_history_item.dart';

abstract class WatchHistoryRepository {
  Future<List<WatchHistoryItem>> loadHistory({
    required String userId,
  });

  Future<WatchHistoryItem> saveProgress({
    required String userId,
    required WatchHistoryItem item,
  });

  Future<void> removeHistory({
    required String userId,
    required String videoId,
  });

  Future<void> clearHistory({
    required String userId,
  });
}

class MockWatchHistoryRepository
    implements WatchHistoryRepository {
  final Map<String, List<WatchHistoryItem>>
      _store = {};

  List<WatchHistoryItem> _historyFor(
    String userId,
  ) {
    return _store.putIfAbsent(
      userId,
      () => [],
    );
  }

  @override
  Future<List<WatchHistoryItem>>
      loadHistory({
    required String userId,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final history = [
      ..._historyFor(userId),
    ];

    history.sort(
      (a, b) {
        return b.watchedAt.compareTo(
          a.watchedAt,
        );
      },
    );

    return List.unmodifiable(history);
  }

  @override
  Future<WatchHistoryItem> saveProgress({
    required String userId,
    required WatchHistoryItem item,
  }) async {
    final history =
        _historyFor(userId);

    final index = history.indexWhere(
      (historyItem) {
        return historyItem.videoId ==
            item.videoId;
      },
    );

    if (index == -1) {
      history.insert(
        0,
        item,
      );
    } else {
      history[index] = item;
    }

    return item;
  }

  @override
  Future<void> removeHistory({
    required String userId,
    required String videoId,
  }) async {
    _historyFor(userId).removeWhere(
      (item) {
        return item.videoId == videoId;
      },
    );
  }

  @override
  Future<void> clearHistory({
    required String userId,
  }) async {
    _historyFor(userId).clear();
  }
}