import 'package:flutter/foundation.dart';
import 'package:flutter_video_caching/flutter_video_caching.dart';

Future<void> initializeVideoCache() async {
  await VideoProxy.init(
    maxMemoryCacheSize: 64,
    maxStorageCacheSize: 1024,
    maxConcurrentDownloads: 4,
    logPrint:
        kDebugMode || const bool.fromEnvironment('CLYVEN_FEED_DIAGNOSTICS'),
  );
}

Uri resolveCachedVideoUri(String source) {
  return source.toLocalUri();
}

Future<bool> isVideoCached(String source) async {
  try {
    return await VideoCaching.isCached(source);
  } catch (_) {
    return false;
  }
}

Future<int> videoCacheStorageBytes() async {
  try {
    return await LruCacheSingleton().storageSizeInBytes();
  } catch (_) {
    return -1;
  }
}

void attachVideoCacheDiagnostics() {
  const enabled = bool.fromEnvironment('CLYVEN_FEED_DIAGNOSTICS');
  if (!enabled) return;

  VideoProxy.downloadManager.stream.listen((task) {
    debugPrint(
      'VIDEO_CACHE_TASK '
      'type=${task.runtimeType} '
      'task=$task',
    );
  });
}
