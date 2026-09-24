import 'models.dart';

/// A deterministic script-level rewrite rule.
///
/// [kind] is descriptive metadata used by Admin/data import. Runtime matching
/// always prefers the longest source/target key, then priority.
class ScriptRuleEntry {
  const ScriptRuleEntry({
    required this.source,
    required this.target,
    this.kind = 'character',
    this.priority = 0,
    this.note,
    this.metadata = const <String, Object?>{},
  });

  final String source;
  final String target;
  final String kind;
  final int priority;
  final String? note;
  final Map<String, Object?> metadata;
}

class ScriptRuleSet {
  ScriptRuleSet(Iterable<ScriptRuleEntry> rules)
    : rules = List<ScriptRuleEntry>.unmodifiable(rules) {
    for (final rule in this.rules) {
      if (rule.source.isEmpty || rule.target.isEmpty) continue;
      (_sourceIndex[rule.source] ??= <ScriptRuleEntry>[]).add(rule);
      (_targetIndex[rule.target] ??= <ScriptRuleEntry>[]).add(rule);
    }

    for (final bucket in _sourceIndex.values) {
      bucket.sort(_compareRules);
    }
    for (final bucket in _targetIndex.values) {
      bucket.sort(_compareRules);
    }

    sourceKeysLongestFirst = _sourceIndex.keys.toList(growable: false)
      ..sort(_compareKeys);
    targetKeysLongestFirst = _targetIndex.keys.toList(growable: false)
      ..sort(_compareKeys);
  }

  final List<ScriptRuleEntry> rules;
  final Map<String, List<ScriptRuleEntry>> _sourceIndex =
      <String, List<ScriptRuleEntry>>{};
  final Map<String, List<ScriptRuleEntry>> _targetIndex =
      <String, List<ScriptRuleEntry>>{};

  late final List<String> sourceKeysLongestFirst;
  late final List<String> targetKeysLongestFirst;

  bool get isEmpty => rules.isEmpty;

  List<ScriptRuleEntry> lookupSource(String source) =>
      List<ScriptRuleEntry>.unmodifiable(
        _sourceIndex[source] ?? const <ScriptRuleEntry>[],
      );

  List<ScriptRuleEntry> lookupTarget(String target) =>
      List<ScriptRuleEntry>.unmodifiable(
        _targetIndex[target] ?? const <ScriptRuleEntry>[],
      );

  static int _compareKeys(String a, String b) {
    final byRunes = b.runes.length.compareTo(a.runes.length);
    if (byRunes != 0) return byRunes;
    return b.length.compareTo(a.length);
  }

  static int _compareRules(ScriptRuleEntry a, ScriptRuleEntry b) {
    final byPriority = b.priority.compareTo(a.priority);
    if (byPriority != 0) return byPriority;

    final byTargetLength = b.target.runes.length.compareTo(
      a.target.runes.length,
    );
    if (byTargetLength != 0) return byTargetLength;

    return a.target.compareTo(b.target);
  }
}

ScriptConversionCandidate ruleCandidate(
  ScriptRuleEntry rule, {
  required String output,
}) {
  return ScriptConversionCandidate(
    output: output,
    priority: rule.priority,
    note: rule.note,
    metadata: <String, Object?>{'entryType': rule.kind, ...rule.metadata},
  );
}
