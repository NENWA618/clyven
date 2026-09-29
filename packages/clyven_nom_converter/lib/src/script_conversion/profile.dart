typedef ScriptSourceNormalizer = String Function(String input);

String defaultScriptSourceNormalizer(String input) {
  return input.trim().replaceAll(RegExp(r'\s+'), ' ');
}

class ScriptConversionProfile {
  ScriptConversionProfile({
    required this.id,
    required this.languageCode,
    required this.sourceScript,
    required this.targetScript,
    required this.sourceWordPattern,
    ScriptSourceNormalizer? normalizeSource,
  }) : normalizeSource = normalizeSource ?? defaultScriptSourceNormalizer;

  final String id;
  final String languageCode;
  final String sourceScript;
  final String targetScript;
  final RegExp sourceWordPattern;
  final ScriptSourceNormalizer normalizeSource;

  @override
  String toString() => '$languageCode:$sourceScript->$targetScript ($id)';
}
