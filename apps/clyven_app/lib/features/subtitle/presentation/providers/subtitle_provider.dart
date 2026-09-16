import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart'
    as serverpod;

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/repositories/subtitle_repository.dart';
import '../../data/repositories/serverpod_subtitle_repository.dart';

final subtitleRepositoryProvider =
    Provider<SubtitleRepository>((ref) {
  final client = ref.watch(
    serverpodClientProvider,
  );

  return ServerpodSubtitleRepository(
    client: client,
  );
});

final subtitleProvider = FutureProvider.family<
    List<serverpod.SubtitleCueDetail>,
    ({
      int videoId,
      String languageCode,
    })>((ref, query) {
  final repository = ref.watch(
    subtitleRepositoryProvider,
  );

  return repository.loadSubtitles(
    videoId: query.videoId,
    languageCode: query.languageCode,
  );
});