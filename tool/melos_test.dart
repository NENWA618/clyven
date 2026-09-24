import 'dart:io';

Future<void> main() async {
  final packageName =
      Platform.environment['MELOS_PACKAGE_NAME'] ??
      Directory.current.path.split(Platform.pathSeparator).last;

  final pubspec = File('pubspec.yaml');
  if (!await pubspec.exists()) {
    stderr.writeln('[$packageName] pubspec.yaml not found.');
    exitCode = 64;
    return;
  }

  final testDir = Directory('test');
  if (!await testDir.exists()) {
    stdout.writeln('[$packageName] no test/ directory; skipped.');
    return;
  }

  final text = await pubspec.readAsString();
  final usesFlutterSdk = RegExp(
    r'(?m)^\s+flutter:\s*\n\s+sdk:\s*flutter\s*$',
  ).hasMatch(text);

  final executable = usesFlutterSdk ? 'flutter' : 'dart';
  final args = usesFlutterSdk ? const ['test'] : const ['test'];

  stdout.writeln(
    '[$packageName] ${usesFlutterSdk ? 'flutter test' : 'dart test'}',
  );

  final process = await Process.start(
    executable,
    args,
    runInShell: Platform.isWindows,
    mode: ProcessStartMode.inheritStdio,
  );

  exitCode = await process.exitCode;
}
