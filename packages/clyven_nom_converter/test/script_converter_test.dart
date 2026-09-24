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
      NomDictionaryEntry(latin: 'Việt Nam', nom: '越南', priority: 10),
      NomDictionaryEntry(latin: 'Việt', nom: '越', priority: 1),
      NomDictionaryEntry(latin: 'Nam', nom: '南', priority: 1),
    ]);

    final converter = VietnameseNomScriptConverter(dictionary);

    test('reuses Nom dictionary through the generic converter', () {
      expect(converter.convertLatinToNom('Việt Nam').convertedText, '越南');
      expect(converter.convertNomToLatin('越南').convertedText, 'Việt Nam');
    });
  });

  group('ScriptRuleSet integration', () {
    final profile = ScriptConversionProfile(
      id: 'uz-cyrl-latn',
      languageCode: 'uz',
      sourceScript: 'Cyrl',
      targetScript: 'Latn',
      sourceWordPattern: RegExp(r'[^\s.,!?;:()]+', unicode: true),
    );

    final emptyDictionary = ScriptDictionary(
      const <ScriptDictionaryEntry>[],
      profile: profile,
    );

    final rules = ScriptRuleSet(const <ScriptRuleEntry>[
      ScriptRuleEntry(source: '\u0441', target: 's'),
      ScriptRuleEntry(source: '\u0430', target: 'a'),
      ScriptRuleEntry(source: '\u043b', target: 'l'),
      ScriptRuleEntry(source: '\u043e', target: 'o'),
      ScriptRuleEntry(source: '\u043c', target: 'm'),
      ScriptRuleEntry(source: '\u0448', target: 'sh', kind: 'character'),
    ]);

    test('converts phonetic scripts with character rules', () {
      final converter = ScriptConverter(
        profile: profile,
        dictionary: emptyDictionary,
        rules: rules,
      );

      expect(
        converter
            .convertForward('\u0441\u0430\u043b\u043e\u043c')
            .convertedText,
        'salom',
      );
    });

    test('reverse conversion prefers longest target rule', () {
      final converter = ScriptConverter(
        profile: profile,
        dictionary: emptyDictionary,
        rules: rules,
      );

      expect(converter.convertReverse('sha').convertedText, '\u0448\u0430');
    });

    test('exception dictionary runs before rules', () {
      final exceptions = ScriptDictionary(const <ScriptDictionaryEntry>[
        ScriptDictionaryEntry(
          source: '\u0441\u0430\u043b\u043e\u043c',
          target: 'HELLO',
          priority: 100,
        ),
      ], profile: profile);

      final converter = ScriptConverter(
        profile: profile,
        dictionary: emptyDictionary,
        exceptionDictionary: exceptions,
        rules: rules,
      );

      expect(
        converter
            .convertForward('\u0441\u0430\u043b\u043e\u043c')
            .convertedText,
        'HELLO',
      );
    });
  });
}
