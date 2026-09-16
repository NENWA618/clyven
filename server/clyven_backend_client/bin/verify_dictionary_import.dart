import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main() async {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
    connectionTimeout: const Duration(
      minutes: 2,
    ),
  );

  const words = [
    'tôi',
    'bạn',
    'anh ấy',
  ];

  for (final word in words) {
    print('');
    print('==============================');
    print('查询: $word');

    final detail = await client.dictionary.lookup(
      languageCode: 'vi',
      normalizedText: word.toLowerCase(),
      entryType: 'word',
      explanationLanguageCode: 'zh',
    );

    if (detail == null) {
      print('未找到');
      continue;
    }

    final entry = detail.entry;

    print('Entry ID: ${entry.id}');
    print('国语字: ${entry.text}');
    print('Normalized: ${entry.normalizedText}');
    print('类型: ${entry.entryType}');
    print(
      '主文字系统: ${entry.primaryScriptCode}',
    );
    print(
      '词性: ${entry.partOfSpeech}',
    );

    if (detail.definitions.isEmpty) {
      print('中文释义: 无');
    } else {
      for (final definition
          in detail.definitions) {
        print(
          '释义语言: '
          '${definition.explanationLanguageCode}',
        );
        print(
          '中文释义: ${definition.gloss}',
        );

        if (definition.definition != null) {
          print(
            '详细定义: '
            '${definition.definition}',
          );
        }
      }
    }
  }
}