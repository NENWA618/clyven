import 'dart:convert';
import 'dart:io';

class DeepgramSegment {
  final int startMs;
  final int endMs;
  final String text;

  const DeepgramSegment({
    required this.startMs,
    required this.endMs,
    required this.text,
  });
}

class DeepgramTranscript {
  final String languageCode;
  final List<DeepgramSegment> segments;

  const DeepgramTranscript({
    required this.languageCode,
    required this.segments,
  });
}

class DeepgramAsrService {
  const DeepgramAsrService();

  Future<DeepgramTranscript> transcribe({
    required String videoUrl,
    required String requestedLanguageCode,
  }) async {
    final apiKey = Platform.environment['DEEPGRAM_API_KEY']?.trim();

    if (apiKey == null || apiKey.isEmpty) {
      throw StateError(
        'DEEPGRAM_API_KEY is not configured',
      );
    }

    final normalizedRequested = requestedLanguageCode.trim();

    final query = <String, String>{
      'model': 'nova-3',
      'smart_format': 'true',
      'punctuate': 'true',
      'utterances': 'true',
    };

    if (normalizedRequested.isEmpty ||
        normalizedRequested.toLowerCase() == 'auto') {
      query['detect_language'] = 'true';
    } else {
      query['language'] = normalizedRequested;
    }

    final uri = Uri.https(
      'api.deepgram.com',
      '/v1/listen',
      query,
    );

    final client = HttpClient();

    try {
      final request = await client.postUrl(uri);

      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Token $apiKey',
      );
      request.headers.contentType = ContentType.json;

      request.write(
        jsonEncode(
          {
            'url': videoUrl,
          },
        ),
      );

      final response = await request.close();

      final body = await utf8.decoder.bind(response).join();

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError(
          'Deepgram request failed '
          '(${response.statusCode}): $body',
        );
      }

      final decoded = jsonDecode(body);

      if (decoded is! Map<String, dynamic>) {
        throw StateError('Deepgram returned an invalid JSON object');
      }

      final results = decoded['results'];

      if (results is! Map<String, dynamic>) {
        throw StateError('Deepgram response has no results');
      }

      final languageCode = _resolveLanguageCode(
        requestedLanguageCode: normalizedRequested,
        results: results,
      );

      final segments = _parseSegments(results);

      if (segments.isEmpty) {
        throw StateError(
          'Deepgram returned no usable utterances',
        );
      }

      return DeepgramTranscript(
        languageCode: languageCode,
        segments: segments,
      );
    } finally {
      client.close(force: true);
    }
  }

  String _resolveLanguageCode({
    required String requestedLanguageCode,
    required Map<String, dynamic> results,
  }) {
    if (requestedLanguageCode.isNotEmpty &&
        requestedLanguageCode.toLowerCase() != 'auto') {
      return requestedLanguageCode;
    }

    final channels = results['channels'];

    if (channels is List && channels.isNotEmpty) {
      final firstChannel = channels.first;

      if (firstChannel is Map) {
        final detected = firstChannel['detected_language'];

        if (detected is String && detected.trim().isNotEmpty) {
          return detected.trim();
        }

        final alternatives = firstChannel['alternatives'];

        if (alternatives is List && alternatives.isNotEmpty) {
          final firstAlternative = alternatives.first;

          if (firstAlternative is Map) {
            final words = firstAlternative['words'];

            if (words is List) {
              for (final word in words) {
                if (word is! Map) {
                  continue;
                }

                final language = word['language'];

                if (language is String && language.trim().isNotEmpty) {
                  return language.trim();
                }
              }
            }
          }
        }
      }
    }

    throw StateError(
      'ASR completed but the spoken language could not be detected',
    );
  }

  List<DeepgramSegment> _parseSegments(
    Map<String, dynamic> results,
  ) {
    final utterances = results['utterances'];

    if (utterances is List && utterances.isNotEmpty) {
      final parsed = <DeepgramSegment>[];

      for (final raw in utterances) {
        if (raw is! Map) {
          continue;
        }

        final start = raw['start'];
        final end = raw['end'];
        final transcript = raw['transcript'];

        if (start is! num || end is! num || transcript is! String) {
          continue;
        }

        final text = transcript.trim();

        if (text.isEmpty) {
          continue;
        }

        parsed.add(
          DeepgramSegment(
            startMs: (start.toDouble() * 1000).round(),
            endMs: (end.toDouble() * 1000).round(),
            text: text,
          ),
        );
      }

      if (parsed.isNotEmpty) {
        return parsed;
      }
    }

    // Fallback:
    // build one cue from the full transcript if utterances are unavailable.
    final channels = results['channels'];

    if (channels is! List || channels.isEmpty) {
      return const [];
    }

    final firstChannel = channels.first;

    if (firstChannel is! Map) {
      return const [];
    }

    final alternatives = firstChannel['alternatives'];

    if (alternatives is! List || alternatives.isEmpty) {
      return const [];
    }

    final firstAlternative = alternatives.first;

    if (firstAlternative is! Map) {
      return const [];
    }

    final transcript = firstAlternative['transcript'];

    if (transcript is! String || transcript.trim().isEmpty) {
      return const [];
    }

    final words = firstAlternative['words'];

    if (words is List && words.isNotEmpty) {
      num? firstStart;
      num? lastEnd;

      for (final word in words) {
        if (word is! Map) {
          continue;
        }

        final start = word['start'];
        final end = word['end'];

        if (start is num) {
          firstStart ??= start;
        }

        if (end is num) {
          lastEnd = end;
        }
      }

      if (firstStart != null && lastEnd != null) {
        return [
          DeepgramSegment(
            startMs: (firstStart.toDouble() * 1000).round(),
            endMs: (lastEnd.toDouble() * 1000).round(),
            text: transcript.trim(),
          ),
        ];
      }
    }

    return [
      DeepgramSegment(
        startMs: 0,
        endMs: 1000,
        text: transcript.trim(),
      ),
    ];
  }
}
