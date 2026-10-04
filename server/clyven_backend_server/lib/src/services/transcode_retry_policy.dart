class ParsedTranscodeJob {
  const ParsedTranscodeJob({
    required this.attempt,
    required this.rawJobName,
  });

  final int attempt;
  final String rawJobName;
}

class TranscodeRetryPolicy {
  const TranscodeRetryPolicy._();

  static const int maxRetryAttempts = 3;

  /// Initial media version for newly transcoded videos.
  ///
  /// Existing videos are not rewritten. Their already persisted
  /// hlsManifestStorageKey continues to point at the old path.
  ///
  /// New video transcodes use:
  ///   transcoded/{videoId}/v1/manifest.m3u8
  ///
  /// Retry attempts stay inside the same media version:
  ///   transcoded/{videoId}/v1/retry-1/manifest.m3u8
  static const int initialMediaVersion = 1;

  static String _versionPrefix(int videoId) {
    return 'transcoded/$videoId/v$initialMediaVersion/';
  }

  static String manifestKey(int videoId, int attempt) {
    final base = _versionPrefix(videoId);

    if (attempt <= 0) {
      return '${base}manifest.m3u8';
    }

    return '${base}retry-$attempt/manifest.m3u8';
  }

  static String outputPrefix(int videoId, int attempt) {
    final base = _versionPrefix(videoId);

    if (attempt <= 0) {
      return base;
    }

    return '${base}retry-$attempt/';
  }

  static String encodeJobName(int attempt, String rawJobName) {
    if (attempt <= 0) {
      return rawJobName;
    }

    return 'retry$attempt|$rawJobName';
  }

  static ParsedTranscodeJob parseJobName(String value) {
    final match = RegExp(r'^retry(\d+)\|(.*)$').firstMatch(value);

    if (match == null) {
      return ParsedTranscodeJob(
        attempt: 0,
        rawJobName: value,
      );
    }

    return ParsedTranscodeJob(
      attempt: int.tryParse(match.group(1) ?? '') ?? 0,
      rawJobName: match.group(2) ?? value,
    );
  }

  static bool canRetry(int attempt) {
    return attempt < maxRetryAttempts;
  }
}
