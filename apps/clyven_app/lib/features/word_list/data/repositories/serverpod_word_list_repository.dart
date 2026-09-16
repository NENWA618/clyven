import 'package:clyven_backend_client/clyven_backend_client.dart'
    as serverpod;

import 'word_list_repository.dart';

class ServerpodWordListRepository
    implements WordListRepository {
  final serverpod.Client client;

  ServerpodWordListRepository({
    required this.client,
  });

  @override
  Future<List<serverpod.WordList>> getLists() {
    return client.wordList.getLists();
  }

  @override
  Future<serverpod.WordListDetail?> getListDetail({
    required int listId,
    required String explanationLanguageCode,
  }) {
    return client.wordList.getListDetail(
      listId: listId,
      explanationLanguageCode:
          explanationLanguageCode,
    );
  }
}