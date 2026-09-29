import 'dictionary.dart';
import 'models.dart';
import 'profile.dart';

class ScriptConverter {
  ScriptConverter({required this.profile, required this.dictionary});

  final ScriptConversionProfile profile;
  final ScriptDictionary dictionary;

  static final RegExp _onlyWhitespace = RegExp(r'^\s+$');

  ScriptConversionResult convert(
    String text, {
    required ScriptConversionDirection direction,
  }) {
    return switch (direction) {
      ScriptConversionDirection.forward => convertForward(text),
      ScriptConversionDirection.reverse => convertReverse(text),
    };
  }

  ScriptConversionResult convertForward(String text) {
    if (text.isEmpty) {
      return const ScriptConversionResult(
        direction: ScriptConversionDirection.forward,
        sourceText: '',
        convertedText: '',
        segments: <ScriptConversionSegment>[],
      );
    }

    final tokens = _tokenizeSource(text);
    final output = StringBuffer();
    final segments = <ScriptConversionSegment>[];

    var tokenIndex = 0;
    while (tokenIndex < tokens.length) {
      final token = tokens[tokenIndex];

      if (!token.isWord) {
        output.write(token.text);
        tokenIndex++;
        continue;
      }

      final match = _findSourceMatch(tokens, tokenIndex);
      if (match == null) {
        output.write(token.text);
        segments.add(
          ScriptConversionSegment(
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

      final chosen = match.entries.first;
      final source = text.substring(
        tokens[tokenIndex].start,
        tokens[match.endTokenIndex].end,
      );

      output.write(chosen.target);
      segments.add(
        ScriptConversionSegment(
          source: source,
          output: chosen.target,
          start: tokens[tokenIndex].start,
          end: tokens[match.endTokenIndex].end,
          matched: true,
          candidates: match.entries
              .map(
                (entry) => ScriptConversionCandidate(
                  output: entry.target,
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

    return ScriptConversionResult(
      direction: ScriptConversionDirection.forward,
      sourceText: text,
      convertedText: output.toString(),
      segments: List<ScriptConversionSegment>.unmodifiable(segments),
    );
  }

  ScriptConversionResult convertReverse(String text) {
    if (text.isEmpty) {
      return const ScriptConversionResult(
        direction: ScriptConversionDirection.reverse,
        sourceText: '',
        convertedText: '',
        segments: <ScriptConversionSegment>[],
      );
    }

    final output = StringBuffer();
    final segments = <ScriptConversionSegment>[];

    var index = 0;
    while (index < text.length) {
      String? matchedKey;
      List<ScriptDictionaryEntry>? matchedEntries;

      for (final key in dictionary.targetKeysLongestFirst) {
        if (key.isEmpty || index + key.length > text.length) {
          continue;
        }

        if (text.startsWith(key, index)) {
          matchedKey = key;
          matchedEntries = dictionary.lookupTarget(key);
          break;
        }
      }

      if (matchedKey == null ||
          matchedEntries == null ||
          matchedEntries.isEmpty) {
        final nextIndex = _nextScalarBoundary(text, index);
        final source = text.substring(index, nextIndex);
        output.write(source);

        if (source.trim().isNotEmpty) {
          segments.add(
            ScriptConversionSegment(
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
      output.write(chosen.source);

      segments.add(
        ScriptConversionSegment(
          source: matchedKey,
          output: chosen.source,
          start: index,
          end: index + matchedKey.length,
          matched: true,
          candidates: matchedEntries
              .map(
                (entry) => ScriptConversionCandidate(
                  output: entry.source,
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

    return ScriptConversionResult(
      direction: ScriptConversionDirection.reverse,
      sourceText: text,
      convertedText: output.toString(),
      segments: List<ScriptConversionSegment>.unmodifiable(segments),
    );
  }

  _SourceMatch? _findSourceMatch(
    List<_SourceToken> tokens,
    int startTokenIndex,
  ) {
    final words = <String>[];
    final wordTokenIndexes = <int>[];

    var tokenIndex = startTokenIndex;
    while (tokenIndex < tokens.length &&
        words.length < dictionary.maxSourceWords) {
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
      final entries = dictionary.lookupSource(key);
      if (entries.isEmpty) continue;

      return _SourceMatch(
        endTokenIndex: wordTokenIndexes[count - 1],
        entries: entries,
      );
    }

    return null;
  }

  List<_SourceToken> _tokenizeSource(String text) {
    final tokens = <_SourceToken>[];
    var cursor = 0;

    for (final match in profile.sourceWordPattern.allMatches(text)) {
      if (match.start > cursor) {
        tokens.add(
          _SourceToken(
            text: text.substring(cursor, match.start),
            start: cursor,
            end: match.start,
            isWord: false,
          ),
        );
      }

      tokens.add(
        _SourceToken(
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
        _SourceToken(
          text: text.substring(cursor),
          start: cursor,
          end: text.length,
          isWord: false,
        ),
      );
    }

    return tokens;
  }

  static int _nextScalarBoundary(String text, int index) {
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

    return nextIndex;
  }
}

class _SourceToken {
  const _SourceToken({
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

class _SourceMatch {
  const _SourceMatch({required this.endTokenIndex, required this.entries});

  final int endTokenIndex;
  final List<ScriptDictionaryEntry> entries;
}
