import 'package:clyven_backend_client/clyven_backend_client.dart'
    as serverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/repositories/serverpod_word_list_repository.dart';
import '../../data/repositories/word_list_repository.dart';

final wordListRepositoryProvider =
    Provider<WordListRepository>((ref) {
  final client = ref.watch(
    serverpodClientProvider,
  );

  return ServerpodWordListRepository(
    client: client,
  );
});

final wordListsProvider =
    FutureProvider<List<serverpod.WordList>>((ref) {
  final repository = ref.watch(
    wordListRepositoryProvider,
  );

  return repository.getLists();
});

final wordListDetailProvider = FutureProvider.family<
    serverpod.WordListDetail?,
    ({
      int listId,
      String explanationLanguageCode,
    })>((ref, query) {
  final repository = ref.watch(
    wordListRepositoryProvider,
  );

  return repository.getListDetail(
    listId: query.listId,
    explanationLanguageCode:
        query.explanationLanguageCode,
  );
});