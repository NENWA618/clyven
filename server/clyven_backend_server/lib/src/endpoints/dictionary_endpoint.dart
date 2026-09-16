import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DictionaryEndpoint extends Endpoint {
  Future<DictionaryEntryDetail?> lookup(
    Session session, {
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String explanationLanguageCode,
  }) async {
    final entry = await DictionaryEntry.db.findFirstRow(
      session,
      where: (e) =>
          e.languageCode.equals(languageCode) &
          e.normalizedText.equals(normalizedText) &
          e.entryType.equals(entryType),
    );

    if (entry == null) {
      return null;
    }

    final definitions = await DictionaryDefinition.db.find(
      session,
      where: (d) =>
          d.entryId.equals(entry.id) &
          d.explanationLanguageCode.equals(
            explanationLanguageCode,
          ),
    );

    final relations = await DictionaryRelation.db.find(
      session,
      where: (r) =>
          r.sourceEntryId.equals(entry.id),
      orderBy: (r) => r.position,
    );

    final relationDetails =
        <DictionaryRelationDetail>[];

    for (final relation in relations) {
      final targetEntry =
          await DictionaryEntry.db.findById(
        session,
        relation.targetEntryId,
      );

      if (targetEntry == null) {
        continue;
      }

      final targetDefinitions =
          await DictionaryDefinition.db.find(
        session,
        where: (d) =>
            d.entryId.equals(targetEntry.id) &
            d.explanationLanguageCode.equals(
              explanationLanguageCode,
            ),
      );

      relationDetails.add(
        DictionaryRelationDetail(
          relation: relation,
          targetEntry: targetEntry,
          targetDefinitions: targetDefinitions,
        ),
      );
    }

    return DictionaryEntryDetail(
      entry: entry,
      definitions: definitions,
      relations: relationDetails,
    );
  }
}