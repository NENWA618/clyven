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

  /// Media version used for brand-new transcodes.
  ///
  /// v2 introduces content-type-aware segment duration:
  /// - Shorts: 3 seconds
  /// - Normal videos: 6 seconds
  ///
  /// Existing persisted v1 manifests are not migrated.
  static const int currentMediaVersion = 2;

  static int mediaVersionFromManifestKey(String? manifestKey) {
    if (manifestKey == null || manifestKey.trim().isEmpty) {
      return currentMediaVersion;
    }

    final match = RegExp(r'/v(\d+)/').firstMatch(manifestKey);
    return int.tryParse(match?.group(1) ?? '') ?? currentMediaVersion;
  }

  static String _versionPrefix(int videoId, int mediaVersion) {
    return 'transcoded/$videoId/v$mediaVersion/';
  }

  static String manifestKey(
    int videoId,
    int attempt, {
    int mediaVersion = currentMediaVersion,
  }) {
    final base = _versionPrefix(videoId, mediaVersion);

    if (attempt <= 0) {
      return '${base}manifest.m3u8';
    }

    return '${base}retry-$attempt/manifest.m3u8';
  }

  static String outputPrefix(
    int videoId,
    int attempt, {
    int mediaVersion = currentMediaVersion,
  }) {
    final base = _versionPrefix(videoId, mediaVersion);

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
