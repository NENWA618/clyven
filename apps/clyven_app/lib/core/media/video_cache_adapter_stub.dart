Future<void> initializeVideoCache() async {}

Uri resolveCachedVideoUri(String source) {
  return Uri.parse(source);
}

Future<bool> isVideoCached(String source) async {
  return false;
}

Future<int> videoCacheStorageBytes() async {
  return -1;
}

void cancelVideoCacheTasks(String source) {}

void attachVideoCacheDiagnostics() {}
