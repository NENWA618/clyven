import 'dart:convert';

import 'models.dart';
import 'profile.dart';

class ScriptDictionary {
  ScriptDictionary(
    Iterable<ScriptDictionaryEntry> entries, {
    required ScriptConversionProfile profile,
  }) : entries = List<ScriptDictionaryEntry>.unmodifiable(entries),
       _normalizeSource = profile.normalizeSource {
    for (final entry in this.entries) {
      final source = _normalizeSource(entry.source);
      final target = entry.target.trim();

      if (source.isEmpty || target.isEmpty) {
        continue;
      }

      (_sourceIndex[source] ??= <ScriptDictionaryEntry>[]).add(entry);
      (_targetIndex[target] ??= <ScriptDictionaryEntry>[]).add(entry);
    }

    for (final bucket in _sourceIndex.values) {
      bucket.sort(_compareEntries);
    }
    for (final bucket in _targetIndex.values) {
      bucket.sort(_compareEntries);
    }

    maxSourceWords = _sourceIndex.keys.fold<int>(1, (maxValue, key) {
      final words = key.split(' ').where((word) => word.isNotEmpty).length;
      return words > maxValue ? words : maxValue;
    });

    targetKeysLongestFirst = _targetIndex.keys.toList(growable: false)
      ..sort((a, b) {
        final byRunes = b.runes.length.compareTo(a.runes.length);
        if (byRunes != 0) return byRunes;
        return b.length.compareTo(a.length);
      });
  }

  final List<ScriptDictionaryEntry> entries;
  final ScriptSourceNormalizer _normalizeSource;

  final Map<String, List<ScriptDictionaryEntry>> _sourceIndex =
      <String, List<ScriptDictionaryEntry>>{};
  final Map<String, List<ScriptDictionaryEntry>> _targetIndex =
      <String, List<ScriptDictionaryEntry>>{};

  late final int maxSourceWords;
  late final List<String> targetKeysLongestFirst;

  factory ScriptDictionary.fromJsonText(
    String jsonText, {
    required ScriptConversionProfile profile,
  }) {
    final decoded = jsonDecode(jsonText);

    final Object? rawEntries;
    if (decoded is List) {
      rawEntries = decoded;
    } else if (decoded is Map) {
      rawEntries = decoded['entries'];
    } else {
      rawEntries = null;
    }

    if (rawEntries is! List) {
      throw const FormatException(
        'Script dictionary JSON must be a list or an object containing entries.',
      );
    }

    return ScriptDictionary(
      rawEntries.map((item) {
        if (item is! Map) {
          throw const FormatException(
            'Each script dictionary entry must be an object.',
          );
        }
        return ScriptDictionaryEntry.fromJson(
          item.map((key, value) => MapEntry(key.toString(), value)),
        );
      }),
      profile: profile,
    );
  }

  List<ScriptDictionaryEntry> lookupSource(String text) {
    return List<ScriptDictionaryEntry>.unmodifiable(
      _sourceIndex[_normalizeSource(text)] ?? const <ScriptDictionaryEntry>[],
    );
  }

  List<ScriptDictionaryEntry> lookupTarget(String text) {
    return List<ScriptDictionaryEntry>.unmodifiable(
      _targetIndex[text] ?? const <ScriptDictionaryEntry>[],
    );
  }

  static int _compareEntries(ScriptDictionaryEntry a, ScriptDictionaryEntry b) {
    final byPriority = b.priority.compareTo(a.priority);
    if (byPriority != 0) return byPriority;

    final aSourceOrder = _sourceOrder(a.metadata['sourceOrder']);
    final bSourceOrder = _sourceOrder(b.metadata['sourceOrder']);
    final bySourceOrder = aSourceOrder.compareTo(bSourceOrder);
    if (bySourceOrder != 0) return bySourceOrder;

    final byTargetLength = b.target.runes.length.compareTo(
      a.target.runes.length,
    );
    if (byTargetLength != 0) return byTargetLength;

    return a.target.compareTo(b.target);
  }

  static int _sourceOrder(Object? value) {
    return switch (value) {
      int number => number,
      num number => number.toInt(),
      String text => int.tryParse(text) ?? 0x7fffffff,
      _ => 0x7fffffff,
    };
  }
}
