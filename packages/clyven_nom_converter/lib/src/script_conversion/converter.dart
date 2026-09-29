import 'dictionary.dart';
import 'models.dart';
import 'profile.dart';
import 'rules.dart';

class ScriptConverter {
  ScriptConverter({
    required this.profile,
    required this.dictionary,
    this.exceptionDictionary,
    ScriptRuleSet? rules,
  }) : rules = rules ?? ScriptRuleSet(const <ScriptRuleEntry>[]);

  final ScriptConversionProfile profile;
  final ScriptDictionary dictionary;
  final ScriptDictionary? exceptionDictionary;
  final ScriptRuleSet rules;

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

      // Exceptions always win over normal dictionary entries and rules.
      final exceptionMatch = exceptionDictionary == null
          ? null
          : _findSourceMatch(tokens, tokenIndex, exceptionDictionary!);
      final dictionaryMatch =
          exceptionMatch ?? _findSourceMatch(tokens, tokenIndex, dictionary);

      if (dictionaryMatch != null) {
        final chosen = dictionaryMatch.entries.first;
        final source = text.substring(
          tokens[tokenIndex].start,
          tokens[dictionaryMatch.endTokenIndex].end,
        );

        output.write(chosen.target);
        segments.add(
          ScriptConversionSegment(
            source: source,
            output: chosen.target,
            start: tokens[tokenIndex].start,
            end: tokens[dictionaryMatch.endTokenIndex].end,
            matched: true,
            candidates: dictionaryMatch.entries
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

        tokenIndex = dictionaryMatch.endTokenIndex + 1;
        continue;
      }

      final ruleResult = _convertByRules(
        token.text,
        direction: ScriptConversionDirection.forward,
      );

      output.write(ruleResult.output);
      segments.add(
        ScriptConversionSegment(
          source: token.text,
          output: ruleResult.output,
          start: token.start,
          end: token.end,
          matched: ruleResult.matched,
          candidates: ruleResult.candidates,
        ),
      );
      tokenIndex++;
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
      final exception = exceptionDictionary == null
          ? null
          : _findReverseDictionaryMatch(text, index, exceptionDictionary!);
      final dictionaryMatch =
          exception ?? _findReverseDictionaryMatch(text, index, dictionary);

      if (dictionaryMatch != null) {
        final chosen = dictionaryMatch.entries.first;
        output.write(chosen.source);
        segments.add(
          ScriptConversionSegment(
            source: dictionaryMatch.key,
            output: chosen.source,
            start: index,
            end: index + dictionaryMatch.key.length,
            matched: true,
            candidates: dictionaryMatch.entries
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
        index += dictionaryMatch.key.length;
        continue;
      }

      final ruleMatch = _findRuleAt(
        text,
        index,
        direction: ScriptConversionDirection.reverse,
      );
      if (ruleMatch != null) {
        output.write(ruleMatch.output);
        segments.add(
          ScriptConversionSegment(
            source: ruleMatch.key,
            output: ruleMatch.output,
            start: index,
            end: index + ruleMatch.key.length,
            matched: true,
            candidates: ruleMatch.candidates,
          ),
        );
        index += ruleMatch.key.length;
        continue;
      }

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
    }

    return ScriptConversionResult(
      direction: ScriptConversionDirection.reverse,
      sourceText: text,
      convertedText: output.toString(),
      segments: List<ScriptConversionSegment>.unmodifiable(segments),
    );
  }

  _RuleConversion _convertByRules(
    String text, {
    required ScriptConversionDirection direction,
  }) {
    if (rules.isEmpty || text.isEmpty) {
      return _RuleConversion(
        output: text,
        matched: false,
        candidates: const <ScriptConversionCandidate>[],
      );
    }

    final output = StringBuffer();
    var matched = false;
    var index = 0;

    while (index < text.length) {
      final match = _findRuleAt(text, index, direction: direction);
      if (match == null) {
        final nextIndex = _nextScalarBoundary(text, index);
        output.write(text.substring(index, nextIndex));
        index = nextIndex;
        continue;
      }

      output.write(match.output);
      matched = true;
      index += match.key.length;
    }

    final converted = output.toString();
    return _RuleConversion(
      output: converted,
      matched: matched,
      candidates: matched
          ? <ScriptConversionCandidate>[
              ScriptConversionCandidate(
                output: converted,
                priority: 0,
                metadata: const <String, Object?>{'entryType': 'rules'},
              ),
            ]
          : const <ScriptConversionCandidate>[],
    );
  }

  _RuleMatch? _findRuleAt(
    String text,
    int index, {
    required ScriptConversionDirection direction,
  }) {
    final keys = direction == ScriptConversionDirection.forward
        ? rules.sourceKeysLongestFirst
        : rules.targetKeysLongestFirst;

    for (final key in keys) {
      if (key.isEmpty || index + key.length > text.length) continue;
      if (!text.startsWith(key, index)) continue;

      final entries = direction == ScriptConversionDirection.forward
          ? rules.lookupSource(key)
          : rules.lookupTarget(key);
      if (entries.isEmpty) continue;

      final chosen = entries.first;
      final output = direction == ScriptConversionDirection.forward
          ? chosen.target
          : chosen.source;

      return _RuleMatch(
        key: key,
        output: output,
        candidates: entries
            .map(
              (rule) => ruleCandidate(
                rule,
                output: direction == ScriptConversionDirection.forward
                    ? rule.target
                    : rule.source,
              ),
            )
            .toList(growable: false),
      );
    }

    return null;
  }

  _SourceMatch? _findSourceMatch(
    List<_SourceToken> tokens,
    int startTokenIndex,
    ScriptDictionary sourceDictionary,
  ) {
    final words = <String>[];
    final wordTokenIndexes = <int>[];

    var tokenIndex = startTokenIndex;
    while (tokenIndex < tokens.length &&
        words.length < sourceDictionary.maxSourceWords) {
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
      final entries = sourceDictionary.lookupSource(key);
      if (entries.isEmpty) continue;

      return _SourceMatch(
        endTokenIndex: wordTokenIndexes[count - 1],
        entries: entries,
      );
    }

    return null;
  }

  _ReverseDictionaryMatch? _findReverseDictionaryMatch(
    String text,
    int index,
    ScriptDictionary sourceDictionary,
  ) {
    for (final key in sourceDictionary.targetKeysLongestFirst) {
      if (key.isEmpty || index + key.length > text.length) continue;
      if (!text.startsWith(key, index)) continue;

      final entries = sourceDictionary.lookupTarget(key);
      if (entries.isEmpty) continue;
      return _ReverseDictionaryMatch(key: key, entries: entries);
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

class _ReverseDictionaryMatch {
  const _ReverseDictionaryMatch({required this.key, required this.entries});

  final String key;
  final List<ScriptDictionaryEntry> entries;
}

class _RuleConversion {
  const _RuleConversion({
    required this.output,
    required this.matched,
    required this.candidates,
  });

  final String output;
  final bool matched;
  final List<ScriptConversionCandidate> candidates;
}

class _RuleMatch {
  const _RuleMatch({
    required this.key,
    required this.output,
    required this.candidates,
  });

  final String key;
  final String output;
  final List<ScriptConversionCandidate> candidates;
}
