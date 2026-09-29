import 'dart:async';
import 'dart:io';

Future<void> _killProcessTree(Process process) async {
  if (Platform.isWindows) {
    // Process.kill() only targets one process on Windows. Jaspr is started
    // through a shell and can leave compiler/proxy child processes behind,
    // so terminate the complete tree.
    final result = await Process.run('taskkill', [
      '/PID',
      '${process.pid}',
      '/T',
      '/F',
    ], runInShell: true);

    final stdoutText = '${result.stdout}'.trim();
    final stderrText = '${result.stderr}'.trim();

    if (stdoutText.isNotEmpty) {
      stdout.writeln(stdoutText);
    }

    // taskkill returns an error if the process already exited by itself.
    if (result.exitCode != 0 && stderrText.isNotEmpty) {
      stderr.writeln(stderrText);
    }

    return;
  }

  process.kill(ProcessSignal.sigterm);

  await Future<void>.delayed(const Duration(milliseconds: 500));

  try {
    process.kill(ProcessSignal.sigkill);
  } catch (_) {
    // Process already exited.
  }
}

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

  var stopping = false;

  Future<void> stop() async {
    if (stopping) return;
    stopping = true;

    stdout.writeln('');
    stdout.writeln('[$packageName] stopping Jaspr process tree...');

    await _killProcessTree(process);
  }

  StreamSubscription<ProcessSignal>? sigintSub;
  StreamSubscription<ProcessSignal>? sigtermSub;

  try {
    sigintSub = ProcessSignal.sigint.watch().listen((_) async {
      await stop();
    });

    if (!Platform.isWindows) {
      sigtermSub = ProcessSignal.sigterm.watch().listen((_) async {
        await stop();
      });
    }

    final code = await process.exitCode;

    if (!stopping && code != 0) {
      stderr.writeln('[$packageName] jaspr exited with code $code');
      exitCode = code;
    }
  } finally {
    await sigintSub?.cancel();
    await sigtermSub?.cancel();

    if (!stopping) {
      await stop();
    }
  }
}
