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

  static String manifestKey(int videoId, int attempt) {
    if (attempt <= 0) {
      return 'transcoded/$videoId/manifest.m3u8';
    }

    return 'transcoded/$videoId/retry-$attempt/manifest.m3u8';
  }

  static String outputPrefix(int videoId, int attempt) {
    if (attempt <= 0) {
      return 'transcoded/$videoId/';
    }

    return 'transcoded/$videoId/retry-$attempt/';
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
