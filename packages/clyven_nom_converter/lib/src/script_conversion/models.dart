enum ScriptConversionDirection { forward, reverse }

class ScriptDictionaryEntry {
  const ScriptDictionaryEntry({
    required this.source,
    required this.target,
    this.priority = 0,
    this.note,
    this.metadata = const <String, Object?>{},
  });

  final String source;
  final String target;
  final int priority;
  final String? note;
  final Map<String, Object?> metadata;

  factory ScriptDictionaryEntry.fromJson(Map<String, Object?> json) {
    return ScriptDictionaryEntry(
      source: (json['source'] ?? '').toString(),
      target: (json['target'] ?? '').toString(),
      priority: switch (json['priority']) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      note: json['note']?.toString(),
      metadata: switch (json['metadata']) {
        Map value => value.map((key, value) => MapEntry(key.toString(), value)),
        _ => const <String, Object?>{},
      },
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'source': source,
    'target': target,
    'priority': priority,
    if (note != null) 'note': note,
    if (metadata.isNotEmpty) 'metadata': metadata,
  };
}

class ScriptConversionCandidate {
  const ScriptConversionCandidate({
    required this.output,
    required this.priority,
    this.note,
    this.metadata = const <String, Object?>{},
  });

  final String output;
  final int priority;
  final String? note;
  final Map<String, Object?> metadata;
}

class ScriptConversionSegment {
  const ScriptConversionSegment({
    required this.source,
    required this.output,
    required this.start,
    required this.end,
    required this.matched,
    this.candidates = const <ScriptConversionCandidate>[],
  });

  final String source;
  final String output;
  final int start;
  final int end;
  final bool matched;
  final List<ScriptConversionCandidate> candidates;

  bool get ambiguous => candidates.length > 1;
}

class ScriptConversionResult {
  const ScriptConversionResult({
    required this.direction,
    required this.sourceText,
    required this.convertedText,
    required this.segments,
  });

  final ScriptConversionDirection direction;
  final String sourceText;
  final String convertedText;
  final List<ScriptConversionSegment> segments;

  int get matchedSegmentCount =>
      segments.where((segment) => segment.matched).length;

  int get unmatchedSegmentCount =>
      segments.where((segment) => !segment.matched).length;

  int get ambiguousSegmentCount =>
      segments.where((segment) => segment.ambiguous).length;
}
