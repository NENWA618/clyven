import 'package:clyven_nom_converter/clyven_nom_converter.dart';
import 'package:test/test.dart';

void main() {
  group('ScriptConverter', () {
    final profile = ScriptConversionProfile(
      id: 'test-latn-alt',
      languageCode: 'xx',
      sourceScript: 'Latn',
      targetScript: 'Test',
      sourceWordPattern: RegExp(r'[A-Za-z]+'),
      normalizeSource: (input) =>
          input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' '),
    );

    final dictionary = ScriptDictionary(const <ScriptDictionaryEntry>[
      ScriptDictionaryEntry(source: 'new', target: 'N', priority: 1),
      ScriptDictionaryEntry(source: 'new world', target: 'NW', priority: 10),
      ScriptDictionaryEntry(source: 'world', target: 'W', priority: 1),
    ], profile: profile);

    final converter = ScriptConverter(profile: profile, dictionary: dictionary);

    test('uses longest source phrase first', () {
      final result = converter.convertForward('New world!');

      expect(result.convertedText, 'NW!');
      expect(result.matchedSegmentCount, 1);
      expect(result.unmatchedSegmentCount, 0);
    });

    test('supports reverse conversion', () {
      final result = converter.convertReverse('NW!');

      expect(result.convertedText, 'new world!');
      expect(result.matchedSegmentCount, 1);
    });

    test('preserves unmatched text', () {
      final result = converter.convertForward('hello new');

      expect(result.convertedText, 'hello N');
      expect(result.unmatchedSegmentCount, 1);
      expect(result.matchedSegmentCount, 1);
    });
  });

  group('VietnameseNomScriptConverter', () {
    final dictionary = NomDictionary(const <NomDictionaryEntry>[
      NomDictionaryEntry(
        latin: 'Vi\u1EC7t Nam',
        nom: '\u8D8A\u5357',
        priority: 10,
      ),
      NomDictionaryEntry(latin: 'Vi\u1EC7t', nom: '\u8D8A', priority: 1),
      NomDictionaryEntry(latin: 'Nam', nom: '\u5357', priority: 1),
    ]);

    final converter = VietnameseNomScriptConverter(dictionary);

    test('reuses Nom dictionary through the generic converter', () {
      expect(
        converter.convertLatinToNom('Vi\u1EC7t Nam').convertedText,
        '\u8D8A\u5357',
      );
      expect(
        converter.convertNomToLatin('\u8D8A\u5357').convertedText,
        'Vi\u1EC7t Nam',
      );
    });
  });
}
