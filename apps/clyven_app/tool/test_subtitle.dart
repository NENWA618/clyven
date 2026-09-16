import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main() async {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final details = await client.subtitle.getCueDetails(
    videoId: 10,
    languageCode: 'vi',
  );

  print('数量: ${details.length}');

  for (final detail in details) {
    print('Cue: ${detail.cue.text}');

    print(
      'Tokens: ${detail.tokens.map((e) => e.text).toList()}',
    );

    print(
      'Phrases: ${detail.phrases.map((e) => e.text).toList()}',
    );
  }
}