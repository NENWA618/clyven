import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class WordListEndpoint extends Endpoint {
  Future<List<WordList>> getLists(
    Session session,
  ) async {
    final lists = await WordList.db.find(
      session,
      orderBy: (w) => w.name,
    );

    return lists
        .where(
          (wordList) =>
              !(wordList.name == '\u8d8a\u5357\u8bed\u57fa\u7840\u8bcd\u8868' &&
                  wordList.description ==
                      'Clyven \u8bcd\u8868\u529f\u80fd\u6d4b\u8bd5'),
        )
        .toList();
  }

  Future<WordListDetail?> getListDetail(
    Session session, {
    required int listId,
    required String explanationLanguageCode,
  }) async {
    final wordList = await WordList.db.findById(
      session,
      listId,
    );

    if (wordList == null) {
      return null;
    }

    final items = await WordListItem.db.find(
      session,
      where: (i) => i.listId.equals(listId),
      orderBy: (i) => i.position,
    );

    if (items.isEmpty) {
      return WordListDetail(
        wordList: wordList,
        items: [],
      );
    }

    final entryIds = items.map((item) => item.entryId).toSet();

    final entries = await DictionaryEntry.db.find(
      session,
      where: (entry) => entry.id.inSet(
        entryIds,
      ),
    );

    final entriesById = <int, DictionaryEntry>{};

    for (final entry in entries) {
      final entryId = entry.id;

      if (entryId != null) {
        entriesById[entryId] = entry;
      }
    }

    final definitions = await DictionaryDefinition.db.find(
      session,
      where: (definition) =>
          definition.entryId.inSet(
            entryIds,
          ) &
          definition.explanationLanguageCode.equals(
            explanationLanguageCode,
          ),
    );

    final definitionsByEntryId = <int, List<DictionaryDefinition>>{};

    for (final definition in definitions) {
      (definitionsByEntryId[definition.entryId] ??= <DictionaryDefinition>[])
          .add(definition);
    }

    final itemDetails = <WordListItemDetail>[];

    for (final item in items) {
      final entry = entriesById[item.entryId];

      if (entry == null) {
        continue;
      }

      itemDetails.add(
        WordListItemDetail(
          item: item,
          entry: entry,
          definitions:
              definitionsByEntryId[item.entryId] ?? <DictionaryDefinition>[],
        ),
      );
    }

    return WordListDetail(
      wordList: wordList,
      items: itemDetails,
    );
  }
}
