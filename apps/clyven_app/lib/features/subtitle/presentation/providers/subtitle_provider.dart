import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/repositories/subtitle_repository.dart';
import '../../data/repositories/serverpod_subtitle_repository.dart';

// 字幕 Repository 的“供应插座”。
// 谁需要字幕仓库，就从这里拿。
final subtitleRepositoryProvider = Provider<SubtitleRepository>((ref) {
  final client = ref.watch(serverpodClientProvider);

  return ServerpodSubtitleRepository(client: client);
});

// “字幕数据供应口”。
// 输入视频 + 语言，就供应对应的字幕。
final subtitleProvider =
    FutureProvider.family<
      List<serverpod.SubtitleCueDetail>,
      ({int videoId, String languageCode})
    >((ref, query) {
      final repository = ref.watch(subtitleRepositoryProvider);

      return repository.loadSubtitles(
        videoId: query.videoId,
        languageCode: query.languageCode,
      );
    });

// “字幕轨道供应口”。
// 输入视频 ID，就供应这个视频有哪些字幕可选。
final subtitleTracksProvider =
    FutureProvider.family<List<serverpod.SubtitleTrack>, int>((ref, videoId) {
      final repository = ref.watch(subtitleRepositoryProvider);

      return repository.loadAvailableTracks(videoId: videoId);
    });