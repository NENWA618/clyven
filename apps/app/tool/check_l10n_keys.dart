import 'dart:convert';
import 'dart:io';

Set<String> _messageKeys(Map<String, dynamic> arb) {
  return arb.keys.where((key) => !key.startsWith('@')).toSet();
}

Map<String, dynamic> _readArb(File file) {
  final decoded = jsonDecode(file.readAsStringSync());

  if (decoded is! Map<String, dynamic>) {
    throw FormatException('ARB root must be a JSON object: ${file.path}');
  }

  return decoded;
}

void main() {
  final l10nDirectory = Directory('lib/l10n');
  final templateFile = File('${l10nDirectory.path}/app_en.arb');

  if (!templateFile.existsSync()) {
    stderr.writeln('Missing localization template: ${templateFile.path}');
    exitCode = 1;
    return;
  }

  final templateKeys = _messageKeys(_readArb(templateFile));

  final translationFiles =
      l10nDirectory
          .listSync()
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('.arb') && file.path != templateFile.path,
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  if (translationFiles.isEmpty) {
    stderr.writeln(
      'No translated ARB files were found in ${l10nDirectory.path}.',
    );
    exitCode = 1;
    return;
  }

  var hasError = false;

  for (final file in translationFiles) {
    final translationKeys = _messageKeys(_readArb(file));

    final missing = templateKeys.difference(translationKeys).toList()..sort();

    final extra = translationKeys.difference(templateKeys).toList()..sort();

    if (missing.isEmpty && extra.isEmpty) {
      stdout.writeln('[OK] ${file.path}: ${templateKeys.length} messages');
      continue;
    }

    hasError = true;
    stderr.writeln('[FAIL] ${file.path}');

    if (missing.isNotEmpty) {
      stderr.writeln('  Missing: ${missing.join(', ')}');
    }

    if (extra.isNotEmpty) {
      stderr.writeln('  Extra: ${extra.join(', ')}');
    }
  }

  if (hasError) {
    exitCode = 1;
    return;
  }

  stdout.writeln('All localization files match the English template.');
}
