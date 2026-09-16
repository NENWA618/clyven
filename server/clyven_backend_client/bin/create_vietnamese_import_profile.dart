import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main() async {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final detail = await client.dictionaryImport
      .createVietnameseVocabularyProfile();

  print(
    'Profile: ${detail.profile.id} | '
    '${detail.profile.name} | '
    '${detail.profile.languageCode} | '
    '${detail.profile.sheetName}',
  );

  print('Mappings: ${detail.mappings.length}');

  for (final mapping in detail.mappings) {
    print(
      '${mapping.position}. '
      '${mapping.sourceColumn} '
      '→ ${mapping.targetType}.${mapping.targetField ?? ''} '
      '| lang=${mapping.languageCode ?? '-'} '
      '| script=${mapping.scriptCode ?? '-'} '
      '| group=${mapping.groupKey ?? '-'}',
    );
  }
}