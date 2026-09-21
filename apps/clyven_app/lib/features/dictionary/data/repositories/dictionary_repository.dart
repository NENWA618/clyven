import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

abstract class DictionaryRepository {
  Future<serverpod.DictionaryEntryDetail?> lookup({
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String explanationLanguageCode,
  });
}
