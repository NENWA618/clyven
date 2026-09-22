import 'package:clyven_nom_converter/clyven_nom_converter.dart';
import 'package:test/test.dart';

void main() {
  final dictionary = NomDictionary(const <NomDictionaryEntry>[
    NomDictionaryEntry(latin: 'a', nom: '甲', priority: 1),
    NomDictionaryEntry(latin: 'b', nom: '乙', priority: 1),
    NomDictionaryEntry(latin: 'a b', nom: '丙', priority: 10),
    NomDictionaryEntry(latin: 'x', nom: '丁', priority: 1),
    NomDictionaryEntry(latin: 'y', nom: '丁', priority: 2),
  ]);

  final converter = NomConverter(dictionary);

  test('Latin to Nom prefers longest phrase', () {
    final result = converter.convertLatinToNom('a b!');
    expect(result.convertedText, '丙!');
    expect(result.segments.single.source, 'a b');
    expect(result.segments.single.matched, isTrue);
  });

  test('unmatched Latin is preserved', () {
    final result = converter.convertLatinToNom('a unknown');
    expect(result.convertedText, '甲 unknown');
    expect(result.unmatchedSegmentCount, 1);
  });

  test('Nom to Latin returns highest priority candidate', () {
    final result = converter.convertNomToLatin('丁');
    expect(result.convertedText, 'y');
    expect(result.segments.single.candidates.length, 2);
  });
}
