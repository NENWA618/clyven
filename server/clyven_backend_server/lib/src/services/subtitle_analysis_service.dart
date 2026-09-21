import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SubtitleAnalysisService {
  const SubtitleAnalysisService();

  Future<String?> resolveScriptCode(
    Session session, {
    required String languageCode,
    String? requestedScriptCode,
    String? trackDefaultScriptCode,
    Transaction? transaction,
  }) async {
    final requested = requestedScriptCode?.trim();

    if (requested != null && requested.isNotEmpty) {
      return requested;
    }

    final trackDefault = trackDefaultScriptCode?.trim();

    if (trackDefault != null && trackDefault.isNotEmpty) {
      return trackDefault;
    }

    final entries = await DictionaryEntry.db.find(
      session,
      where: (e) => e.languageCode.equals(languageCode),
      transaction: transaction,
    );

    if (entries.isEmpty) {
      return null;
    }

    final primaryCounts = <String, int>{};

    for (final entry in entries) {
      final scriptCode = entry.primaryScriptCode?.trim();

      if (scriptCode == null || scriptCode.isEmpty) {
        continue;
      }

      primaryCounts[scriptCode] = (primaryCounts[scriptCode] ?? 0) + 1;
    }

    final primary = _mostCommonCode(primaryCounts);

    if (primary != null) {
      return primary;
    }

    final entryIds = entries.map((entry) => entry.id).whereType<int>().toSet();

    if (entryIds.isEmpty) {
      return null;
    }

    final forms = await DictionaryForm.db.find(
      session,
      where: (f) => f.entryId.inSet(entryIds),
      transaction: transaction,
    );

    final formCounts = <String, int>{};

    for (final form in forms) {
      final scriptCode = form.scriptCode.trim();

      if (scriptCode.isEmpty) {
        continue;
      }

      formCounts[scriptCode] = (formCounts[scriptCode] ?? 0) + 1;
    }

    return _mostCommonCode(formCounts);
  }

  Future<SubtitleLexicon> loadLexicon(
    Session session, {
    required String languageCode,
    required String scriptCode,
    Transaction? transaction,
  }) async {
    final entries = await DictionaryEntry.db.find(
      session,
      where: (e) => e.languageCode.equals(languageCode),
      transaction: transaction,
    );

    if (entries.isEmpty) {
      return SubtitleLexicon(
        languageCode: languageCode,
        scriptCode: scriptCode,
        words: const [],
        phrases: const [],
      );
    }

    final entryIds = entries.map((entry) => entry.id).whereType<int>().toSet();

    final forms = entryIds.isEmpty
        ? <DictionaryForm>[]
        : await DictionaryForm.db.find(
            session,
            where: (f) =>
                f.entryId.inSet(entryIds) & f.scriptCode.equals(scriptCode),
            transaction: transaction,
          );

    final formsByEntryId = <int, List<DictionaryForm>>{};

    for (final form in forms) {
      formsByEntryId
          .putIfAbsent(
            form.entryId,
            () => <DictionaryForm>[],
          )
          .add(form);
    }

    final candidates = <String, SubtitleLexiconItem>{};

    void addCandidate({
      required DictionaryEntry entry,
      required String surface,
      required String normalizedSurface,
    }) {
      final entryId = entry.id;

      if (entryId == null) {
        return;
      }

      final cleanSurface = surface.trim();
      final cleanNormalized = _normalize(normalizedSurface);

      if (cleanSurface.isEmpty || cleanNormalized.isEmpty) {
        return;
      }

      final key = '${entry.entryType}\u0000$cleanNormalized';

      candidates.putIfAbsent(
        key,
        () => SubtitleLexiconItem(
          entryId: entryId,
          entryType: entry.entryType,
          surface: cleanSurface,
          normalizedSurface: cleanNormalized,
        ),
      );
    }

    for (final entry in entries) {
      final primaryScriptCode = entry.primaryScriptCode?.trim();

      if (primaryScriptCode == scriptCode || primaryScriptCode == null) {
        addCandidate(
          entry: entry,
          surface: entry.text,
          normalizedSurface: entry.normalizedText,
        );
      }

      final entryId = entry.id;

      if (entryId == null) {
        continue;
      }

      for (final form in formsByEntryId[entryId] ?? const <DictionaryForm>[]) {
        addCandidate(
          entry: entry,
          surface: form.text,
          normalizedSurface: form.normalizedText,
        );
      }
    }

    final words =
        candidates.values
            .where((candidate) => candidate.entryType != 'phrase')
            .toList()
          ..sort(_candidateSort);

    final phrases =
        candidates.values
            .where((candidate) => candidate.entryType == 'phrase')
            .toList()
          ..sort(_candidateSort);

    return SubtitleLexicon(
      languageCode: languageCode,
      scriptCode: scriptCode,
      words: words,
      phrases: phrases,
    );
  }

  Future<SubtitleCueText> upsertCueText(
    Session session, {
    required int cueId,
    required String scriptCode,
    required String text,
    required bool isPrimary,
    Transaction? transaction,
  }) async {
    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      throw ArgumentError.value(text, 'text', 'Subtitle text cannot be empty.');
    }

    final existingTexts = await SubtitleCueText.db.find(
      session,
      where: (row) => row.cueId.equals(cueId),
      transaction: transaction,
    );

    if (isPrimary) {
      for (final existing in existingTexts) {
        if (!existing.isPrimary || existing.scriptCode == scriptCode) {
          continue;
        }

        existing.isPrimary = false;
        existing.updatedAt = DateTime.now();

        await SubtitleCueText.db.updateRow(
          session,
          existing,
          transaction: transaction,
        );
      }
    }

    SubtitleCueText? existing;

    for (final row in existingTexts) {
      if (row.scriptCode == scriptCode) {
        existing = row;
        break;
      }
    }

    if (existing != null) {
      existing.text = cleanText;
      existing.normalizedText = _normalize(cleanText);
      existing.isPrimary = isPrimary;
      existing.updatedAt = DateTime.now();

      return SubtitleCueText.db.updateRow(
        session,
        existing,
        transaction: transaction,
      );
    }

    return SubtitleCueText.db.insertRow(
      session,
      SubtitleCueText(
        cueId: cueId,
        scriptCode: scriptCode,
        text: cleanText,
        normalizedText: _normalize(cleanText),
        isPrimary: isPrimary,
      ),
      transaction: transaction,
    );
  }

  Future<void> analyzeCueText(
    Session session, {
    required int cueId,
    required String languageCode,
    required String scriptCode,
    required String text,
    SubtitleLexicon? lexicon,
    Transaction? transaction,
  }) async {
    final cleanText = text.trim();

    final activeLexicon =
        lexicon ??
        await loadLexicon(
          session,
          languageCode: languageCode,
          scriptCode: scriptCode,
          transaction: transaction,
        );

    await _deleteAnalysisRows(
      session,
      cueId: cueId,
      scriptCode: scriptCode,
      transaction: transaction,
    );

    if (cleanText.isEmpty) {
      return;
    }

    final analyzedTokens = _tokenize(
      cleanText,
      activeLexicon.words,
    );

    if (analyzedTokens.isNotEmpty) {
      await SubtitleToken.db.insert(
        session,
        [
          for (final token in analyzedTokens)
            SubtitleToken(
              cueId: cueId,
              scriptCode: scriptCode,
              text: token.text,
              normalizedText: token.normalizedText,
              entryId: token.entryId,
              position: token.position,
            ),
        ],
        transaction: transaction,
      );
    }

    final analyzedPhrases = _findPhrases(
      cleanText,
      analyzedTokens,
      activeLexicon.phrases,
    );

    if (analyzedPhrases.isNotEmpty) {
      await SubtitlePhrase.db.insert(
        session,
        [
          for (final phrase in analyzedPhrases)
            SubtitlePhrase(
              cueId: cueId,
              scriptCode: scriptCode,
              text: phrase.text,
              normalizedText: phrase.normalizedText,
              entryId: phrase.entryId,
              startPosition: phrase.startPosition,
              endPosition: phrase.endPosition,
            ),
        ],
        transaction: transaction,
      );
    }
  }

  Future<void> upsertAndAnalyzeCueText(
    Session session, {
    required int cueId,
    required String languageCode,
    required String scriptCode,
    required String text,
    required bool isPrimary,
    SubtitleLexicon? lexicon,
    Transaction? transaction,
  }) async {
    await upsertCueText(
      session,
      cueId: cueId,
      scriptCode: scriptCode,
      text: text,
      isPrimary: isPrimary,
      transaction: transaction,
    );

    await analyzeCueText(
      session,
      cueId: cueId,
      languageCode: languageCode,
      scriptCode: scriptCode,
      text: text,
      lexicon: lexicon,
      transaction: transaction,
    );
  }

  Future<void> _deleteAnalysisRows(
    Session session, {
    required int cueId,
    required String scriptCode,
    Transaction? transaction,
  }) async {
    final existingTokens = await SubtitleToken.db.find(
      session,
      where: (token) => token.cueId.equals(cueId),
      transaction: transaction,
    );

    for (final token in existingTokens) {
      if (token.scriptCode != null && token.scriptCode != scriptCode) {
        continue;
      }

      await SubtitleToken.db.deleteRow(
        session,
        token,
        transaction: transaction,
      );
    }

    final existingPhrases = await SubtitlePhrase.db.find(
      session,
      where: (phrase) => phrase.cueId.equals(cueId),
      transaction: transaction,
    );

    for (final phrase in existingPhrases) {
      if (phrase.scriptCode != null && phrase.scriptCode != scriptCode) {
        continue;
      }

      await SubtitlePhrase.db.deleteRow(
        session,
        phrase,
        transaction: transaction,
      );
    }
  }

  List<_AnalyzedToken> _tokenize(
    String text,
    List<SubtitleLexiconItem> candidates,
  ) {
    final normalizedText = _normalize(text);
    final candidatesByFirstUnit = <int, List<SubtitleLexiconItem>>{};

    for (final candidate in candidates) {
      if (candidate.normalizedSurface.isEmpty) {
        continue;
      }

      candidatesByFirstUnit
          .putIfAbsent(
            candidate.normalizedSurface.codeUnitAt(0),
            () => <SubtitleLexiconItem>[],
          )
          .add(candidate);
    }

    final tokens = <_AnalyzedToken>[];
    var offset = 0;
    var position = 0;

    while (offset < text.length) {
      final runeLength = _runeLengthAt(text, offset);
      final current = text.substring(offset, offset + runeLength);

      if (_isWhitespace(current)) {
        offset += runeLength;
        continue;
      }

      SubtitleLexiconItem? match;
      var matchLength = 0;

      if (offset < normalizedText.length) {
        final bucket = candidatesByFirstUnit[normalizedText.codeUnitAt(offset)];

        if (bucket != null) {
          for (final candidate in bucket) {
            final candidateLength = candidate.surface.length;

            if (offset + candidateLength > text.length) {
              continue;
            }

            final slice = text.substring(offset, offset + candidateLength);

            if (_normalize(slice) != candidate.normalizedSurface) {
              continue;
            }

            if (!_hasRequiredBoundaries(
              text,
              start: offset,
              end: offset + candidateLength,
              candidate: candidate.surface,
            )) {
              continue;
            }

            match = candidate;
            matchLength = candidateLength;
            break;
          }
        }
      }

      if (match != null) {
        final tokenText = text.substring(offset, offset + matchLength);

        tokens.add(
          _AnalyzedToken(
            text: tokenText,
            normalizedText: match.normalizedSurface,
            entryId: match.entryId,
            position: position,
            startOffset: offset,
            endOffset: offset + matchLength,
          ),
        );

        position++;
        offset += matchLength;
        continue;
      }

      final unknownEnd = _unknownTokenEnd(
        text,
        offset,
      );

      final tokenText = text.substring(offset, unknownEnd);

      tokens.add(
        _AnalyzedToken(
          text: tokenText,
          normalizedText: _normalize(tokenText),
          entryId: null,
          position: position,
          startOffset: offset,
          endOffset: unknownEnd,
        ),
      );

      position++;
      offset = unknownEnd;
    }

    return tokens;
  }

  List<_AnalyzedPhrase> _findPhrases(
    String text,
    List<_AnalyzedToken> tokens,
    List<SubtitleLexiconItem> candidates,
  ) {
    if (tokens.isEmpty || candidates.isEmpty) {
      return const [];
    }

    final normalizedText = _normalize(text);
    final matches = <_PhraseMatch>[];

    for (final candidate in candidates) {
      var searchOffset = 0;

      while (searchOffset < normalizedText.length) {
        final start = normalizedText.indexOf(
          candidate.normalizedSurface,
          searchOffset,
        );

        if (start < 0) {
          break;
        }

        final end = start + candidate.surface.length;

        if (end <= text.length &&
            _hasRequiredBoundaries(
              text,
              start: start,
              end: end,
              candidate: candidate.surface,
            )) {
          final covered = tokens
              .where(
                (token) => token.endOffset > start && token.startOffset < end,
              )
              .toList();

          if (covered.isNotEmpty) {
            matches.add(
              _PhraseMatch(
                candidate: candidate,
                startOffset: start,
                endOffset: end,
                startPosition: covered.first.position,
                endPosition: covered.last.position,
              ),
            );
          }
        }

        searchOffset = start + 1;
      }
    }

    matches.sort((a, b) {
      final startCompare = a.startOffset.compareTo(b.startOffset);

      if (startCompare != 0) {
        return startCompare;
      }

      final aLength = a.endOffset - a.startOffset;
      final bLength = b.endOffset - b.startOffset;

      return bLength.compareTo(aLength);
    });

    final selected = <_PhraseMatch>[];

    for (final match in matches) {
      final overlaps = selected.any(
        (existing) =>
            match.startOffset < existing.endOffset &&
            match.endOffset > existing.startOffset,
      );

      if (!overlaps) {
        selected.add(match);
      }
    }

    return [
      for (final match in selected)
        _AnalyzedPhrase(
          text: text.substring(match.startOffset, match.endOffset),
          normalizedText: match.candidate.normalizedSurface,
          entryId: match.candidate.entryId,
          startPosition: match.startPosition,
          endPosition: match.endPosition,
        ),
    ];
  }

  int _unknownTokenEnd(
    String text,
    int start,
  ) {
    final firstRuneLength = _runeLengthAt(text, start);
    final first = text.substring(start, start + firstRuneLength);

    if (_isPunctuation(first)) {
      return start + firstRuneLength;
    }

    var offset = start + firstRuneLength;

    while (offset < text.length) {
      final runeLength = _runeLengthAt(text, offset);
      final current = text.substring(offset, offset + runeLength);

      if (_isWhitespace(current) || _isPunctuation(current)) {
        break;
      }

      offset += runeLength;
    }

    return offset;
  }

  bool _hasRequiredBoundaries(
    String text, {
    required int start,
    required int end,
    required String candidate,
  }) {
    if (candidate.isEmpty) {
      return false;
    }

    final candidateRunes = candidate.runes.toList();

    if (candidateRunes.isEmpty) {
      return false;
    }

    final requireStart = _isSpaceSeparatedWordRune(candidateRunes.first);
    final requireEnd = _isSpaceSeparatedWordRune(candidateRunes.last);

    if (requireStart && start > 0) {
      final previousRune = _runeBefore(text, start);

      if (previousRune != null && _isSpaceSeparatedWordRune(previousRune)) {
        return false;
      }
    }

    if (requireEnd && end < text.length) {
      final nextRune = text.substring(end).runes.first;

      if (_isSpaceSeparatedWordRune(nextRune)) {
        return false;
      }
    }

    return true;
  }

  int? _runeBefore(
    String text,
    int offset,
  ) {
    if (offset <= 0) {
      return null;
    }

    var start = offset - 1;
    final unit = text.codeUnitAt(start);

    if (_isLowSurrogate(unit) && start > 0) {
      final previous = text.codeUnitAt(start - 1);

      if (_isHighSurrogate(previous)) {
        start--;
      }
    }

    return text.substring(start, offset).runes.first;
  }

  int _runeLengthAt(
    String text,
    int offset,
  ) {
    final unit = text.codeUnitAt(offset);

    if (_isHighSurrogate(unit) &&
        offset + 1 < text.length &&
        _isLowSurrogate(text.codeUnitAt(offset + 1))) {
      return 2;
    }

    return 1;
  }

  bool _isHighSurrogate(int value) => value >= 0xD800 && value <= 0xDBFF;

  bool _isLowSurrogate(int value) => value >= 0xDC00 && value <= 0xDFFF;

  bool _isWhitespace(String value) => RegExp(r'^\s+$').hasMatch(value);

  bool _isPunctuation(String value) {
    const punctuation =
        '.,!?;:'
        '"'
        "'"
        '()[]{}'
        '<>'
        '/\\|'
        '-'
        '\u2013'
        '\u2014'
        '\u2026'
        '\u00b7'
        '\u3001'
        '\u3002'
        '\uff0c'
        '\uff01'
        '\uff1f'
        '\uff1a'
        '\uff1b'
        '\u201c'
        '\u201d'
        '\u2018'
        '\u2019'
        '\u300a'
        '\u300b'
        '\u3008'
        '\u3009';

    return punctuation.contains(value);
  }

  bool _isSpaceSeparatedWordRune(int rune) {
    return (rune >= 0x0030 && rune <= 0x0039) ||
        (rune >= 0x0041 && rune <= 0x005A) ||
        (rune >= 0x0061 && rune <= 0x007A) ||
        (rune >= 0x00C0 && rune <= 0x024F) ||
        (rune >= 0x0370 && rune <= 0x03FF) ||
        (rune >= 0x0400 && rune <= 0x052F) ||
        (rune >= 0x0530 && rune <= 0x058F) ||
        (rune >= 0x0590 && rune <= 0x05FF) ||
        (rune >= 0x0600 && rune <= 0x06FF) ||
        (rune >= 0x0750 && rune <= 0x077F) ||
        (rune >= 0x08A0 && rune <= 0x08FF) ||
        (rune >= 0x10A0 && rune <= 0x10FF) ||
        (rune >= 0x1800 && rune <= 0x18AF);
  }

  static String _normalize(String value) => value.trim().toLowerCase();

  static int _candidateSort(
    SubtitleLexiconItem a,
    SubtitleLexiconItem b,
  ) {
    final lengthCompare = b.surface.length.compareTo(a.surface.length);

    if (lengthCompare != 0) {
      return lengthCompare;
    }

    return a.normalizedSurface.compareTo(b.normalizedSurface);
  }

  String? _mostCommonCode(Map<String, int> counts) {
    if (counts.isEmpty) {
      return null;
    }

    final entries = counts.entries.toList()
      ..sort((a, b) {
        final countCompare = b.value.compareTo(a.value);

        if (countCompare != 0) {
          return countCompare;
        }

        return a.key.compareTo(b.key);
      });

    return entries.first.key;
  }
}

class SubtitleLexicon {
  final String languageCode;
  final String scriptCode;
  final List<SubtitleLexiconItem> words;
  final List<SubtitleLexiconItem> phrases;

  const SubtitleLexicon({
    required this.languageCode,
    required this.scriptCode,
    required this.words,
    required this.phrases,
  });
}

class SubtitleLexiconItem {
  final int entryId;
  final String entryType;
  final String surface;
  final String normalizedSurface;

  const SubtitleLexiconItem({
    required this.entryId,
    required this.entryType,
    required this.surface,
    required this.normalizedSurface,
  });
}

class _AnalyzedToken {
  final String text;
  final String normalizedText;
  final int? entryId;
  final int position;
  final int startOffset;
  final int endOffset;

  const _AnalyzedToken({
    required this.text,
    required this.normalizedText,
    required this.entryId,
    required this.position,
    required this.startOffset,
    required this.endOffset,
  });
}

class _PhraseMatch {
  final SubtitleLexiconItem candidate;
  final int startOffset;
  final int endOffset;
  final int startPosition;
  final int endPosition;

  const _PhraseMatch({
    required this.candidate,
    required this.startOffset,
    required this.endOffset,
    required this.startPosition,
    required this.endPosition,
  });
}

class _AnalyzedPhrase {
  final String text;
  final String normalizedText;
  final int entryId;
  final int startPosition;
  final int endPosition;

  const _AnalyzedPhrase({
    required this.text,
    required this.normalizedText,
    required this.entryId,
    required this.startPosition,
    required this.endPosition,
  });
}
