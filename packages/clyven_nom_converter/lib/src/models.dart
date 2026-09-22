enum NomConversionDirection { latinToNom, nomToLatin }

class NomDictionaryEntry {
  const NomDictionaryEntry({
    required this.latin,
    required this.nom,
    this.priority = 0,
    this.note,
    this.metadata = const <String, Object?>{},
  });

  final String latin;
  final String nom;
  final int priority;
  final String? note;
  final Map<String, Object?> metadata;

  factory NomDictionaryEntry.fromJson(Map<String, Object?> json) {
    return NomDictionaryEntry(
      latin: (json['latin'] ?? '').toString(),
      nom: (json['nom'] ?? '').toString(),
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
    'latin': latin,
    'nom': nom,
    'priority': priority,
    if (note != null) 'note': note,
    if (metadata.isNotEmpty) 'metadata': metadata,
  };
}

class NomConversionCandidate {
  const NomConversionCandidate({
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

class NomConversionSegment {
  const NomConversionSegment({
    required this.source,
    required this.output,
    required this.start,
    required this.end,
    required this.matched,
    this.candidates = const <NomConversionCandidate>[],
  });

  final String source;
  final String output;
  final int start;
  final int end;
  final bool matched;
  final List<NomConversionCandidate> candidates;

  bool get ambiguous => candidates.length > 1;
}

class NomConversionResult {
  const NomConversionResult({
    required this.direction,
    required this.sourceText,
    required this.convertedText,
    required this.segments,
  });

  final NomConversionDirection direction;
  final String sourceText;
  final String convertedText;
  final List<NomConversionSegment> segments;

  int get matchedSegmentCount =>
      segments.where((segment) => segment.matched).length;

  int get unmatchedSegmentCount =>
      segments.where((segment) => !segment.matched).length;

  int get ambiguousSegmentCount =>
      segments.where((segment) => segment.ambiguous).length;
}
