import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/creator_profile.dart';
import 'creator_profile_provider.dart';

final followingCreatorsProvider =
    FutureProvider<List<CreatorProfile>>((ref) async {
  final creatorIds = await ref.watch(
    followingCreatorIdsProvider.future,
  );

  if (creatorIds.isEmpty) {
    return const [];
  }

  final repository = ref.read(
    creatorRepositoryProvider,
  );

  final creators = await Future.wait(
    creatorIds.map(
      (creatorId) {
        return repository.loadCreatorProfile(
          creatorId,
        );
      },
    ),
  );

  return List.unmodifiable(creators);
});