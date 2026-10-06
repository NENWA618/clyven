import 'package:glyphora_backend_client/backend_client.dart' as serverpod;

abstract class WordListRepository {
  Future<List<serverpod.WordList>> getLists();

  Future<serverpod.WordListDetail?> getListDetail({
    required int listId,
    required String explanationLanguageCode,
  });
}
