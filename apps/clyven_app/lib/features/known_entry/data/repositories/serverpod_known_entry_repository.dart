import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

import 'known_entry_repository.dart';

class ServerpodKnownEntryRepository implements KnownEntryRepository {
  final serverpod.Client client;

  ServerpodKnownEntryRepository({required this.client});

  @override
  Future<List<int>> getKnownEntryIds({required List<int> entryIds}) {
    return client.knownEntry.getKnownEntryIds(entryIds: entryIds);
  }

  @override
  Future<bool> setKnown({required int entryId, required bool known}) {
    return client.knownEntry.setKnown(entryId: entryId, known: known);
  }

  @override
  Future<Map<int, String>> getKnowledgeStatesByEntryIds({
    required List<int> entryIds,
  }) async {
    if (entryIds.isEmpty) {
      return <int, String>{};
    }

    final results = await client.knownEntry.getKnowledgeStatesByEntryIds(
      entryIds: entryIds,
    );

    return {for (final result in results) result.entryId: result.state};
  }

  @override
  Future<String> getKnowledgeState({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) {
    return client.knownEntry.getKnowledgeState(
      languageCode: languageCode,
      normalizedText: normalizedText,
      entryType: entryType,
    );
  }

  @override
  Future<List<KnowledgeStateValue>> getKnowledgeStates({
    required List<KnowledgeStateRequest> queries,
  }) async {
    if (queries.isEmpty) {
      return [];
    }

    final serverpodQueries = queries
        .map(
          (query) => serverpod.KnowledgeStateQuery(
            languageCode: query.languageCode,
            normalizedText: query.normalizedText,
            entryType: query.entryType,
          ),
        )
        .toList();

    final results = await client.knownEntry.getKnowledgeStates(
      queries: serverpodQueries,
    );

    return results
        .map(
          (result) => KnowledgeStateValue(
            languageCode: result.languageCode,
            normalizedText: result.normalizedText,
            entryType: result.entryType,
            state: result.state,
          ),
        )
        .toList();
  }
}
