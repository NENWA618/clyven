import 'dictionary.dart';
import 'models.dart';

class NomConverter {
  NomConverter(this.dictionary);

  final NomDictionary dictionary;

  static final RegExp _latinWord = RegExp(
    r"[A-Za-zÀ-ÖØ-öø-ỹĐđ]+(?:['’-][A-Za-zÀ-ÖØ-öø-ỹĐđ]+)*",
  );
  static final RegExp _onlyWhitespace = RegExp(r'^\s+$');

  NomConversionResult convert(
    String text, {
    required NomConversionDirection direction,
  }) {
    return switch (direction) {
      NomConversionDirection.latinToNom => convertLatinToNom(text),
      NomConversionDirection.nomToLatin => convertNomToLatin(text),
    };
  }

  NomConversionResult convertLatinToNom(String text) {
    if (text.isEmpty) {
      return const NomConversionResult(
        direction: NomConversionDirection.latinToNom,
        sourceText: '',
        convertedText: '',
        segments: <NomConversionSegment>[],
      );
    }

    final tokens = _tokenizeLatin(text);
    final output = StringBuffer();
    final segments = <NomConversionSegment>[];

    var tokenIndex = 0;
    while (tokenIndex < tokens.length) {
      final token = tokens[tokenIndex];

      if (!token.isWord) {
        output.write(token.text);
        tokenIndex++;
        continue;
      }

      final match = _findLatinMatch(tokens, tokenIndex);
      if (match == null) {
        output.write(token.text);
        segments.add(
          NomConversionSegment(
            source: token.text,
            output: token.text,
            start: token.start,
            end: token.end,
            matched: false,
          ),
        );
        tokenIndex++;
        continue;
      }

      final entries = match.entries;
      final chosen = entries.first;
      final source = text.substring(
        tokens[tokenIndex].start,
        tokens[match.endTokenIndex].end,
      );

      output.write(chosen.nom);
      segments.add(
        NomConversionSegment(
          source: source,
          output: chosen.nom,
          start: tokens[tokenIndex].start,
          end: tokens[match.endTokenIndex].end,
          matched: true,
          candidates: entries
              .map(
                (entry) => NomConversionCandidate(
                  output: entry.nom,
                  priority: entry.priority,
                  note: entry.note,
                  metadata: entry.metadata,
                ),
              )
              .toList(growable: false),
        ),
      );

      tokenIndex = match.endTokenIndex + 1;
    }

    return NomConversionResult(
      direction: NomConversionDirection.latinToNom,
      sourceText: text,
      convertedText: output.toString(),
      segments: List<NomConversionSegment>.unmodifiable(segments),
    );
  }

  NomConversionResult convertNomToLatin(String text) {
    if (text.isEmpty) {
      return const NomConversionResult(
        direction: NomConversionDirection.nomToLatin,
        sourceText: '',
        convertedText: '',
        segments: <NomConversionSegment>[],
      );
    }

    final output = StringBuffer();
    final segments = <NomConversionSegment>[];

    var index = 0;
    while (index < text.length) {
      String? matchedKey;
      List<NomDictionaryEntry>? matchedEntries;

      for (final key in dictionary.nomKeysLongestFirst) {
        if (key.isEmpty || index + key.length > text.length) continue;
        if (text.startsWith(key, index)) {
          matchedKey = key;
          matchedEntries = dictionary.lookupNom(key);
          break;
        }
      }

      if (matchedKey == null ||
          matchedEntries == null ||
          matchedEntries.isEmpty) {
        final firstCodeUnit = text.codeUnitAt(index);
        var nextIndex = index + 1;

        if (firstCodeUnit >= 0xD800 &&
            firstCodeUnit <= 0xDBFF &&
            nextIndex < text.length) {
          final secondCodeUnit = text.codeUnitAt(nextIndex);
          if (secondCodeUnit >= 0xDC00 && secondCodeUnit <= 0xDFFF) {
            nextIndex++;
          }
        }

        final source = text.substring(index, nextIndex);
        output.write(source);

        if (source.trim().isNotEmpty) {
          segments.add(
            NomConversionSegment(
              source: source,
              output: source,
              start: index,
              end: nextIndex,
              matched: false,
            ),
          );
        }

        index = nextIndex;
        continue;
      }

      final chosen = matchedEntries.first;
      output.write(chosen.latin);

      segments.add(
        NomConversionSegment(
          source: matchedKey,
          output: chosen.latin,
          start: index,
          end: index + matchedKey.length,
          matched: true,
          candidates: matchedEntries
              .map(
                (entry) => NomConversionCandidate(
                  output: entry.latin,
                  priority: entry.priority,
                  note: entry.note,
                  metadata: entry.metadata,
                ),
              )
              .toList(growable: false),
        ),
      );

      index += matchedKey.length;
    }

    return NomConversionResult(
      direction: NomConversionDirection.nomToLatin,
      sourceText: text,
      convertedText: output.toString(),
      segments: List<NomConversionSegment>.unmodifiable(segments),
    );
  }

  _LatinMatch? _findLatinMatch(List<_LatinToken> tokens, int startTokenIndex) {
    final words = <String>[];
    final wordTokenIndexes = <int>[];

    var tokenIndex = startTokenIndex;

    while (tokenIndex < tokens.length &&
        words.length < dictionary.maxLatinWords) {
      final token = tokens[tokenIndex];

      if (token.isWord) {
        words.add(token.text);
        wordTokenIndexes.add(tokenIndex);
      } else if (!_onlyWhitespace.hasMatch(token.text)) {
        break;
      }

      tokenIndex++;
    }

    for (var count = words.length; count >= 1; count--) {
      final key = words.take(count).join(' ');
      final entries = dictionary.lookupLatin(key);
      if (entries.isEmpty) continue;

      return _LatinMatch(
        endTokenIndex: wordTokenIndexes[count - 1],
        entries: entries,
      );
    }

    return null;
  }

  List<_LatinToken> _tokenizeLatin(String text) {
    final tokens = <_LatinToken>[];
    var cursor = 0;

    for (final match in _latinWord.allMatches(text)) {
      if (match.start > cursor) {
        tokens.add(
          _LatinToken(
            text: text.substring(cursor, match.start),
            start: cursor,
            end: match.start,
            isWord: false,
          ),
        );
      }

      tokens.add(
        _LatinToken(
          text: match.group(0)!,
          start: match.start,
          end: match.end,
          isWord: true,
        ),
      );

      cursor = match.end;
    }

    if (cursor < text.length) {
      tokens.add(
        _LatinToken(
          text: text.substring(cursor),
          start: cursor,
          end: text.length,
          isWord: false,
        ),
      );
    }

    return tokens;
  }
}

class _LatinToken {
  const _LatinToken({
    required this.text,
    required this.start,
    required this.end,
    required this.isWord,
  });

  final String text;
  final int start;
  final int end;
  final bool isWord;
}

class _LatinMatch {
  const _LatinMatch({required this.endTokenIndex, required this.entries});

  final int endTokenIndex;
  final List<NomDictionaryEntry> entries;
}
