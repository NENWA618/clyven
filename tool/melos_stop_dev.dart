import 'dart:io';

Future<void> main() async {
  const ports = <int>[8081, 8082, 8083, 8084];

  if (!Platform.isWindows) {
    stdout.writeln(
      'dev:stop is currently implemented for Windows only. '
      'Use Ctrl+C on this platform.',
    );
    return;
  }

  final seenPids = <int>{};

  for (final port in ports) {
    final result = await Process.run('powershell', [
      '-NoProfile',
      '-Command',
      'Get-NetTCPConnection -LocalPort $port -State Listen '
          '-ErrorAction SilentlyContinue | '
          'Select-Object -ExpandProperty OwningProcess -Unique',
    ], runInShell: true);

    final output = '${result.stdout}'.trim();

    if (output.isEmpty) {
      stdout.writeln('port $port: free');
      continue;
    }

    for (final line in output.split(RegExp(r'\r?\n'))) {
      final pid = int.tryParse(line.trim());
      if (pid == null || !seenPids.add(pid)) continue;

      stdout.writeln('port $port: stopping PID $pid');

      final kill = await Process.run('taskkill', [
        '/PID',
        '$pid',
        '/T',
        '/F',
      ], runInShell: true);

      final killOut = '${kill.stdout}'.trim();
      final killErr = '${kill.stderr}'.trim();

      if (killOut.isNotEmpty) stdout.writeln(killOut);
      if (kill.exitCode != 0 && killErr.isNotEmpty) {
        stderr.writeln(killErr);
      }
    }
  }
}
