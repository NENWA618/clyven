class KnowledgeStateRequest {
  final String languageCode;
  final String normalizedText;
  final String entryType;

  const KnowledgeStateRequest({
    required this.languageCode,
    required this.normalizedText,
    required this.entryType,
  });
}

class KnowledgeStateValue {
  final String languageCode;
  final String normalizedText;
  final String entryType;
  final String state;

  const KnowledgeStateValue({
    required this.languageCode,
    required this.normalizedText,
    required this.entryType,
    required this.state,
  });
}

abstract class KnownEntryRepository {
  Future<List<int>> getKnownEntryIds({required List<int> entryIds});

  Future<bool> setKnown({required int entryId, required bool known});

  Future<Map<int, String>> getKnowledgeStatesByEntryIds({
    required List<int> entryIds,
  });

  Future<String> getKnowledgeState({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  });

  Future<List<KnowledgeStateValue>> getKnowledgeStates({
    required List<KnowledgeStateRequest> queries,
  });
}
