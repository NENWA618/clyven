import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

import 'subtitle_repository.dart';

class ServerpodSubtitleRepository implements SubtitleRepository {
  final serverpod.Client client;

  ServerpodSubtitleRepository({required this.client});

  @override
  Future<List<serverpod.SubtitleCueDetail>> loadSubtitles({
    required int videoId,
    required String languageCode,
    String? scriptCode,
  }) async {
    return client.subtitle.getCueDetails(
      videoId: videoId,
      languageCode: languageCode,
      scriptCode: scriptCode,
    );
  }

  @override
  Future<List<serverpod.SubtitleTrack>> loadAvailableTracks({
    required int videoId,
  }) async {
    return client.subtitle.getAvailableTracks(videoId: videoId);
  }
}
