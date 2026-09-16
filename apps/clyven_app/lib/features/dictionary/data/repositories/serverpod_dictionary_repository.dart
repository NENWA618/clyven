import 'package:clyven_backend_client/clyven_backend_client.dart'
    as serverpod;

import 'dictionary_repository.dart';

class ServerpodDictionaryRepository
    implements DictionaryRepository {
  final serverpod.Client client;

  ServerpodDictionaryRepository({
    required this.client,
  });

  @override
  Future<serverpod.DictionaryEntryDetail?> lookup({
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String explanationLanguageCode,
  }) {
    return client.dictionary.lookup(
      languageCode: languageCode,
      normalizedText: normalizedText,
      entryType: entryType,
      explanationLanguageCode:
          explanationLanguageCode,
    );
  }
}