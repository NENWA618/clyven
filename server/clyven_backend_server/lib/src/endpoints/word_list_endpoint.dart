import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class WordListEndpoint extends Endpoint {
  Future<List<WordList>> getLists(
    Session session,
  ) async {
    return WordList.db.find(
      session,
      orderBy: (w) => w.name,
    );
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

    final itemDetails = <WordListItemDetail>[];

    for (final item in items) {
      final entry = await DictionaryEntry.db.findById(
        session,
        item.entryId,
      );

      if (entry == null) {
        continue;
      }

      final definitions =
          await DictionaryDefinition.db.find(
        session,
        where: (d) =>
            d.entryId.equals(entry.id) &
            d.explanationLanguageCode.equals(
              explanationLanguageCode,
            ),
      );

      itemDetails.add(
        WordListItemDetail(
          item: item,
          entry: entry,
          definitions: definitions,
        ),
      );
    }

    return WordListDetail(
      wordList: wordList,
      items: itemDetails,
    );
  }
}