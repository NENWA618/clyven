// ignore_for_file: avoid_print

import 'package:glyphora_backend_client/backend_client.dart';

Future<void> main() async {
  const apiUrl = String.fromEnvironment(
    'GLYPHORA_API_URL',
    defaultValue:
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final client = Client(apiUrl);

  final result = await client.dictionary.lookup(
    languageCode: 'vi',
    normalizedText: 'học sinh',
    entryType: 'phrase',
    explanationLanguageCode: 'zh',
  );

  if (result == null) {
    print('NOT FOUND');
    return;
  }

  print('Entry: ${result.entry.text}');

  for (final definition in result.definitions) {
    print('Meaning: ${definition.gloss}');
  }

  print('--- Relations ---');

  for (final relationDetail in result.relations) {
    print(
      '${relationDetail.relation.relationType} '
      '${relationDetail.relation.position}: '
      '${relationDetail.targetEntry.text}',
    );

    for (final definition in relationDetail.targetDefinitions) {
      print('  → ${definition.gloss}');
    }
  }
}
