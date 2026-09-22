import 'dart:io';

import 'package:clyven_nom_converter/clyven_nom_converter.dart';

void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln(
      'Usage:\n'
      '  dart run packages/clyven_nom_converter/bin/nom_convert.dart '
      'latin-to-nom "xin chào"\n'
      '  dart run packages/clyven_nom_converter/bin/nom_convert.dart '
      'nom-to-latin "..."',
    );
    exitCode = 64;
    return;
  }

  final directionArg = args.first.trim().toLowerCase();
  final input = args.skip(1).join(' ');

  final direction = switch (directionArg) {
    'latin-to-nom' ||
    'latn-to-nom' ||
    'latn' => NomConversionDirection.latinToNom,
    'nom-to-latin' ||
    'nom-to-latn' ||
    'nom' => NomConversionDirection.nomToLatin,
    _ => null,
  };

  if (direction == null) {
    stderr.writeln(
      'Unknown direction: ${args.first}\n'
      'Use latin-to-nom or nom-to-latin.',
    );
    exitCode = 64;
    return;
  }

  final dictionaryFile = _findDictionary();
  if (dictionaryFile == null) {
    stderr.writeln(
      'Cannot find nom_dictionary.json.\n'
      'Run the Excel importer first.',
    );
    exitCode = 66;
    return;
  }

  final dictionary = NomDictionary.fromJsonText(
    dictionaryFile.readAsStringSync(),
  );
  final converter = NomConverter(dictionary);

  final result = converter.convert(input, direction: direction);

  stdout.writeln('Dictionary : ${dictionaryFile.path}');
  stdout.writeln('Entries    : ${dictionary.entries.length}');
  stdout.writeln('Direction  : ${direction.name}');
  stdout.writeln('Input      : ${result.sourceText}');
  stdout.writeln('Output     : ${result.convertedText}');
  stdout.writeln();
  stdout.writeln(
    'Matched: ${result.matchedSegmentCount}, '
    'Unmatched: ${result.unmatchedSegmentCount}, '
    'Ambiguous: ${result.ambiguousSegmentCount}',
  );

  if (result.segments.isEmpty) return;

  stdout.writeln();
  stdout.writeln('Segments:');

  for (final segment in result.segments) {
    final state = segment.matched ? 'MATCH' : 'MISS';
    stdout.writeln('  [$state] ${segment.source} -> ${segment.output}');

    if (segment.candidates.length > 1) {
      stdout.writeln('    candidates:');
      for (final candidate in segment.candidates) {
        stdout.writeln(
          '      - ${candidate.output} '
          '(priority=${candidate.priority})',
        );
      }
    }
  }
}

File? _findDictionary() {
  final candidates = <File>[
    File('packages/clyven_nom_converter/data/nom_dictionary.json'),
    File('data/nom_dictionary.json'),
  ];

  for (final candidate in candidates) {
    if (candidate.existsSync()) return candidate;
  }

  return null;
}
