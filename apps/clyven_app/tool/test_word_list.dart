// ignore_for_file: avoid_print

import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main() async {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final lists = await client.wordList.getLists();

  print('Lists: ${lists.length}');

  for (final list in lists) {
    print('List: ${list.id} | ${list.name} | ${list.languageCode}');
  }

  final detail = await client.wordList.getListDetail(
    listId: 1,
    explanationLanguageCode: 'zh',
  );

  if (detail == null) {
    print('LIST NOT FOUND');
    return;
  }

  print('--- ${detail.wordList.name} ---');

  for (final item in detail.items) {
    final meaning = item.definitions.isEmpty
        ? '暂无释义'
        : item.definitions.first.gloss;

    print(
      '${item.item.position}. '
      '${item.entry.text} '
      '(${item.entry.entryType}) '
      '→ $meaning',
    );
  }
}
