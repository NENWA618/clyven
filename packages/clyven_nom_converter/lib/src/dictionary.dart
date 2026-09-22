import 'dart:convert';

import 'models.dart';

class NomDictionary {
  NomDictionary(Iterable<NomDictionaryEntry> entries)
    : entries = List<NomDictionaryEntry>.unmodifiable(entries) {
    for (final entry in this.entries) {
      final latin = normalizeLatin(entry.latin);
      if (latin.isNotEmpty && entry.nom.trim().isNotEmpty) {
        (_latinIndex[latin] ??= <NomDictionaryEntry>[]).add(entry);
        (_nomIndex[entry.nom] ??= <NomDictionaryEntry>[]).add(entry);
      }
    }

    for (final bucket in _latinIndex.values) {
      bucket.sort(_compareEntries);
    }
    for (final bucket in _nomIndex.values) {
      bucket.sort(_compareEntries);
    }

    maxLatinWords = _latinIndex.keys.fold<int>(1, (maxValue, key) {
      final words = key.split(' ').where((word) => word.isNotEmpty).length;
      return words > maxValue ? words : maxValue;
    });

    nomKeysLongestFirst = _nomIndex.keys.toList(growable: false)
      ..sort((a, b) {
        final byLength = b.runes.length.compareTo(a.runes.length);
        if (byLength != 0) return byLength;
        return b.length.compareTo(a.length);
      });
  }

  final List<NomDictionaryEntry> entries;
  final Map<String, List<NomDictionaryEntry>> _latinIndex =
      <String, List<NomDictionaryEntry>>{};
  final Map<String, List<NomDictionaryEntry>> _nomIndex =
      <String, List<NomDictionaryEntry>>{};

  late final int maxLatinWords;
  late final List<String> nomKeysLongestFirst;

  factory NomDictionary.fromJsonText(String jsonText) {
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
        'Nom dictionary JSON must be a list or an object containing entries.',
      );
    }

    return NomDictionary(
      rawEntries.map((item) {
        if (item is! Map) {
          throw const FormatException(
            'Each dictionary entry must be an object.',
          );
        }
        return NomDictionaryEntry.fromJson(
          item.map((key, value) => MapEntry(key.toString(), value)),
        );
      }),
    );
  }

  List<NomDictionaryEntry> lookupLatin(String text) {
    return List<NomDictionaryEntry>.unmodifiable(
      _latinIndex[normalizeLatin(text)] ?? const <NomDictionaryEntry>[],
    );
  }

  List<NomDictionaryEntry> lookupNom(String text) {
    return List<NomDictionaryEntry>.unmodifiable(
      _nomIndex[text] ?? const <NomDictionaryEntry>[],
    );
  }

  static String normalizeLatin(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  static int _compareEntries(NomDictionaryEntry a, NomDictionaryEntry b) {
    final byPriority = b.priority.compareTo(a.priority);
    if (byPriority != 0) return byPriority;

    final aSourceOrder = switch (a.metadata['sourceOrder']) {
      int value => value,
      num value => value.toInt(),
      String value => int.tryParse(value) ?? 0x7fffffff,
      _ => 0x7fffffff,
    };
    final bSourceOrder = switch (b.metadata['sourceOrder']) {
      int value => value,
      num value => value.toInt(),
      String value => int.tryParse(value) ?? 0x7fffffff,
      _ => 0x7fffffff,
    };

    final bySourceOrder = aSourceOrder.compareTo(bSourceOrder);
    if (bySourceOrder != 0) return bySourceOrder;

    final byNomLength = b.nom.runes.length.compareTo(a.nom.runes.length);
    if (byNomLength != 0) return byNomLength;

    return a.nom.compareTo(b.nom);
  }
}
