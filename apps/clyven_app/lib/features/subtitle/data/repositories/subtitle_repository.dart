import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

abstract class SubtitleRepository {
  Future<List<serverpod.SubtitleCueDetail>> loadSubtitles({
    required int videoId,
    required String languageCode,
    String? scriptCode,
  });

  Future<List<serverpod.SubtitleTrack>> loadAvailableTracks({
    required int videoId,
  });
}
