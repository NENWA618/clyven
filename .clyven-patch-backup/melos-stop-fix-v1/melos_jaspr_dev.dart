import 'dart:io';

Future<void> main() async {
  final packageName = Platform.environment['MELOS_PACKAGE_NAME'];

  const ports = <String, int>{
    'clyven_web': 8084,
    'clyven_studio': 8083,
    'clyven_admin': 8082,
    'clyven_review': 8081,
  };

  if (packageName == null || !ports.containsKey(packageName)) {
    stderr.writeln('melos_jaspr_dev.dart: unsupported package "$packageName".');
    exitCode = 64;
    return;
  }

  final port = ports[packageName]!;
  stdout.writeln('');
  stdout.writeln('[$packageName] starting Jaspr on http://localhost:$port');

  final process = await Process.start(
    'jaspr',
    ['serve', '--port', '$port'],
    runInShell: Platform.isWindows,
    mode: ProcessStartMode.inheritStdio,
  );

  final code = await process.exitCode;
  if (code != 0) {
    stderr.writeln('[$packageName] jaspr exited with code $code');
  }
  exitCode = code;
}
