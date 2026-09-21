import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class KnownEntryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _userId(Session session) {
    return session.authenticated!.userIdentifier.toString();
  }

  String _queryKey({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) {
    return '$languageCode\u0000$entryType\u0000$normalizedText';
  }

  Future<List<int>> getKnownEntryIds(
    Session session, {
    required List<int> entryIds,
  }) async {
    if (entryIds.isEmpty) {
      return [];
    }

    final userId = _userId(session);

    final rows = await UserKnownEntry.db.find(
      session,
      where: (k) => k.userId.equals(userId) & k.entryId.inSet(entryIds.toSet()),
    );

    return rows.map((row) => row.entryId).toList();
  }

  Future<bool> setKnown(
    Session session, {
    required int entryId,
    required bool known,
  }) async {
    final userId = _userId(session);

    final existing = await UserKnownEntry.db.findFirstRow(
      session,
      where: (k) => k.userId.equals(userId) & k.entryId.equals(entryId),
    );

    if (known) {
      if (existing == null) {
        await UserKnownEntry.db.insertRow(
          session,
          UserKnownEntry(
            userId: userId,
            entryId: entryId,
          ),
        );
      }

      return true;
    }

    if (existing != null) {
      await UserKnownEntry.db.deleteRow(
        session,
        existing,
      );
    }

    return false;
  }

  Future<List<EntryKnowledgeState>> getKnowledgeStatesByEntryIds(
    Session session, {
    required List<int> entryIds,
  }) async {
    if (entryIds.isEmpty) {
      return [];
    }

    final requestedIds = <int>[];

    for (final entryId in entryIds) {
      if (!requestedIds.contains(entryId)) {
        requestedIds.add(entryId);
      }
    }

    final requestedSet = requestedIds.toSet();
    final userId = _userId(session);

    final relations = await DictionaryRelation.db.find(
      session,
      where: (relation) =>
          relation.sourceEntryId.inSet(requestedSet) |
          relation.targetEntryId.inSet(requestedSet),
    );

    final relevantIds = <int>{...requestedSet};

    for (final relation in relations) {
      relevantIds.add(relation.sourceEntryId);
      relevantIds.add(relation.targetEntryId);
    }

    final knownRows = await UserKnownEntry.db.find(
      session,
      where: (known) =>
          known.userId.equals(userId) & known.entryId.inSet(relevantIds),
    );

    final knownIds = knownRows.map((row) => row.entryId).toSet();
    final relatedByEntryId = <int, Set<int>>{};

    for (final relation in relations) {
      relatedByEntryId
          .putIfAbsent(relation.sourceEntryId, () => <int>{})
          .add(relation.targetEntryId);

      relatedByEntryId
          .putIfAbsent(relation.targetEntryId, () => <int>{})
          .add(relation.sourceEntryId);
    }

    return [
      for (final entryId in requestedIds)
        EntryKnowledgeState(
          entryId: entryId,
          state: knownIds.contains(entryId)
              ? 'exactKnown'
              : (relatedByEntryId[entryId]?.any(knownIds.contains) ?? false)
              ? 'relatedKnown'
              : 'unknown',
        ),
    ];
  }

  Future<String> getKnowledgeState(
    Session session, {
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) async {
    final results = await getKnowledgeStates(
      session,
      queries: [
        KnowledgeStateQuery(
          languageCode: languageCode,
          normalizedText: normalizedText,
          entryType: entryType,
        ),
      ],
    );

    if (results.isEmpty) {
      return 'unknown';
    }

    return results.first.state;
  }

  Future<List<KnowledgeStateResult>> getKnowledgeStates(
    Session session, {
    required List<KnowledgeStateQuery> queries,
  }) async {
    if (queries.isEmpty) {
      return [];
    }

    final userId = _userId(session);

    // 1. 一次查出本批次可能需要的词条。
    final languageCodes = queries.map((q) => q.languageCode).toSet();

    final normalizedTexts = queries.map((q) => q.normalizedText).toSet();

    final entryTypes = queries.map((q) => q.entryType).toSet();

    final entries = await DictionaryEntry.db.find(
      session,
      where: (e) =>
          e.languageCode.inSet(languageCodes) &
          e.normalizedText.inSet(
            normalizedTexts,
          ) &
          e.entryType.inSet(entryTypes),
    );

    final entryByKey = <String, DictionaryEntry>{};

    for (final entry in entries) {
      entryByKey[_queryKey(
            languageCode: entry.languageCode,
            normalizedText: entry.normalizedText,
            entryType: entry.entryType,
          )] =
          entry;
    }

    final requestedEntryIds = entries
        .map((entry) => entry.id)
        .whereType<int>()
        .toSet();

    if (requestedEntryIds.isEmpty) {
      return queries
          .map(
            (query) => KnowledgeStateResult(
              languageCode: query.languageCode,
              normalizedText: query.normalizedText,
              entryType: query.entryType,
              state: 'unknown',
            ),
          )
          .toList();
    }

    // 2. 一次查出所有与当前批次有关的关系。
    // 双向都查：
    //
    // học sinh -> học
    //
    // 可以让：
    // học 已会     → học sinh relatedKnown
    // học sinh 已会 → học relatedKnown
    final relations = await DictionaryRelation.db.find(
      session,
      where: (r) =>
          r.sourceEntryId.inSet(
            requestedEntryIds,
          ) |
          r.targetEntryId.inSet(
            requestedEntryIds,
          ),
    );

    // 3. 收集当前词条 + 所有关联词条。
    final allRelevantEntryIds = <int>{...requestedEntryIds};

    for (final relation in relations) {
      allRelevantEntryIds.add(
        relation.sourceEntryId,
      );

      allRelevantEntryIds.add(
        relation.targetEntryId,
      );
    }

    // 4. 一次查出用户真正标记为已会的所有相关词。
    final knownRows = await UserKnownEntry.db.find(
      session,
      where: (k) =>
          k.userId.equals(userId) &
          k.entryId.inSet(
            allRelevantEntryIds,
          ),
    );

    final knownEntryIds = knownRows.map((row) => row.entryId).toSet();

    // 5. 把关系放到内存里，之后不再查数据库。
    final outgoing = <int, Set<int>>{};

    final incoming = <int, Set<int>>{};

    for (final relation in relations) {
      outgoing
          .putIfAbsent(
            relation.sourceEntryId,
            () => <int>{},
          )
          .add(
            relation.targetEntryId,
          );

      incoming
          .putIfAbsent(
            relation.targetEntryId,
            () => <int>{},
          )
          .add(
            relation.sourceEntryId,
          );
    }

    // 6. 在 Dart 内存里计算整批状态。
    final results = <KnowledgeStateResult>[];

    for (final query in queries) {
      final key = _queryKey(
        languageCode: query.languageCode,
        normalizedText: query.normalizedText,
        entryType: query.entryType,
      );

      final entry = entryByKey[key];

      var state = 'unknown';

      final entryId = entry?.id;

      if (entryId != null) {
        if (knownEntryIds.contains(entryId)) {
          state = 'exactKnown';
        } else {
          final relatedIds = <int>{
            ...?outgoing[entryId],
            ...?incoming[entryId],
          };

          final hasKnownRelated = relatedIds.any(
            knownEntryIds.contains,
          );

          if (hasKnownRelated) {
            state = 'relatedKnown';
          }
        }
      }

      results.add(
        KnowledgeStateResult(
          languageCode: query.languageCode,
          normalizedText: query.normalizedText,
          entryType: query.entryType,
          state: state,
        ),
      );
    }

    return results;
  }
}
