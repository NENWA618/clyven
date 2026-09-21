import 'package:clyven_backend_client/clyven_backend_client.dart';

class SubtitleCueService {
  SubtitleCueService({
    required this.client,
  });

  final Client client;

  Future<SubtitleCue> updateText({
    required int cueId,
    required String text,
  }) {
    return client.subtitle.updateCueText(
      cueId: cueId,
      text: text,
    );
  }

  Future<SubtitleCue> updateTiming({
    required int cueId,
    required int startMs,
    required int endMs,
  }) {
    return client.subtitle.updateCueTiming(
      cueId: cueId,
      startMs: startMs,
      endMs: endMs,
    );
  }

  Future<void> create({
    required int videoId,
    required String languageCode,
    required int startMs,
    required int endMs,
    required String text,
  }) async {
    await client.subtitle.createCue(
      videoId: videoId,
      languageCode: languageCode,
      startMs: startMs,
      endMs: endMs,
      text: text,
    );
  }

  Future<void> delete({
    required int cueId,
  }) async {
    await client.subtitle.deleteCue(
      cueId: cueId,
    );
  }

  Future<List<SubtitleCueDetail>> loadCues({
    required int videoId,
    required String languageCode,
  }) {
    return client.subtitle.getCueDetails(
      videoId: videoId,
      languageCode: languageCode,
    );
  }
}