import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../word_list/presentation/providers/word_list_provider.dart';
import '../../data/repositories/known_entry_repository.dart';
import '../../data/repositories/serverpod_known_entry_repository.dart';

final knownEntryRepositoryProvider =
    Provider<KnownEntryRepository>((ref) {
  final client = ref.watch(
    serverpodClientProvider,
  );

  return ServerpodKnownEntryRepository(
    client: client,
  );
});

final knownEntriesForListProvider =
    FutureProvider.family<
        Set<int>,
        ({
          int listId,
          String explanationLanguageCode,
        })>((ref, query) async {
  final detail = await ref.watch(
    wordListDetailProvider(
      (
        listId: query.listId,
        explanationLanguageCode:
            query.explanationLanguageCode,
      ),
    ).future,
  );

  if (detail == null) {
    return <int>{};
  }

  final entryIds = detail.items
      .map((item) => item.entry.id)
      .whereType<int>()
      .toList();

  if (entryIds.isEmpty) {
    return <int>{};
  }

  final repository = ref.watch(
    knownEntryRepositoryProvider,
  );

  final knownIds =
      await repository.getKnownEntryIds(
    entryIds: entryIds,
  );

  return knownIds.toSet();
});

final knowledgeStateProvider =
    FutureProvider.family<
        String,
        ({
          String languageCode,
          String normalizedText,
          String entryType,
        })>((ref, query) async {
  final repository = ref.watch(
    knownEntryRepositoryProvider,
  );

  return repository.getKnowledgeState(
    languageCode: query.languageCode,
    normalizedText: query.normalizedText,
    entryType: query.entryType,
  );
});

String knowledgeStateKey({
  required String languageCode,
  required String normalizedText,
  required String entryType,
}) {
  return '$languageCode\u0000'
      '$entryType\u0000'
      '$normalizedText';
}

class KnowledgeBatchRequest {
  final List<KnowledgeStateRequest> queries;

  late final String signature = queries
      .map(
        (query) => knowledgeStateKey(
          languageCode: query.languageCode,
          normalizedText:
              query.normalizedText,
          entryType: query.entryType,
        ),
      )
      .join('\u0001');

  KnowledgeBatchRequest({
    required this.queries,
  });

  @override
  bool operator ==(Object other) {
    return other is KnowledgeBatchRequest &&
        other.signature == signature;
  }

  @override
  int get hashCode => signature.hashCode;
}

final knowledgeStatesProvider =
    FutureProvider.family<
        Map<String, String>,
        KnowledgeBatchRequest>(
  (ref, request) async {
    if (request.queries.isEmpty) {
      return <String, String>{};
    }

    final repository = ref.watch(
      knownEntryRepositoryProvider,
    );

    final results =
        await repository.getKnowledgeStates(
      queries: request.queries,
    );

    return {
      for (final result in results)
        knowledgeStateKey(
          languageCode: result.languageCode,
          normalizedText:
              result.normalizedText,
          entryType: result.entryType,
        ): result.state,
    };
  },
);