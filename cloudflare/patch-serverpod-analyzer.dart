import 'dart:io';

// Container-build-only compatibility patch for serverpod 3.4.11.
// Fail closed if the upstream source layout or dependency version changes.
void main() {
  final cache =
      Platform.environment['PUB_CACHE'] ??
      '${Platform.environment['HOME']}/.pub-cache';
  final file = File(
    '$cache/hosted/pub.dev/serverpod-3.4.11/lib/src/database/adapters/postgres/postgres_analyzer.dart',
  );
  if (!file.existsSync()) {
    stderr.writeln(
      'Expected serverpod 3.4.11 analyzer not found: ${file.path}',
    );
    exit(1);
  }
  final source = file.readAsStringSync();
  const start = '''    return await Future.wait(
      tableSchemas.map((tableSchema) async {''';
  const finish = '''      }),
    );
  }

  @override''';
  if (start.allMatches(source).length != 1 ||
      finish.allMatches(source).length != 1 ||
      !source.contains(
        'class PostgresDatabaseAnalyzer extends DatabaseAnalyzer',
      )) {
    stderr.writeln('Unexpected Serverpod analyzer layout. Refusing to patch.');
    exit(1);
  }
  final patched = source
      .replaceFirst(start, '''    final definitions = <TableDefinition>[];
    for (var offset = 0; offset < tableSchemas.length; offset += 2) {
      definitions.addAll(await Future.wait(
        tableSchemas.skip(offset).take(2).map((tableSchema) async {''')
      .replaceFirst(finish, '''        }),
      ));
    }
    return definitions;
  }

  @override''');
  if (patched == source || !patched.contains('offset += 2')) {
    stderr.writeln('Analyzer patch verification failed.');
    exit(1);
  }
  file.writeAsStringSync(patched);
  stdout.writeln(
    'Patched serverpod 3.4.11 analyzer: at most 2 tables concurrently.',
  );
}
