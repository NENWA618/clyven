import 'dart:async';
import 'dart:convert';
import 'dart:io';

class _Service {
  _Service({
    required this.name,
    required this.label,
    required this.directory,
    required this.port,
  });

  final String name;
  final String label;
  final String directory;
  final int port;

  Process? process;
  bool ready = false;
  bool starting = false;
  int restartCount = 0;
  final List<String> recentLines = <String>[];
}

final _services = <_Service>[
  _Service(
    name: 'clyven_web',
    label: 'Web',
    directory: 'apps/clyven_web',
    port: 8084,
  ),
  _Service(
    name: 'clyven_studio',
    label: 'Studio',
    directory: 'apps/clyven_studio',
    port: 8083,
  ),
];

const _spinnerFrames = <String>['|', '/', '-', r'\'];

Timer? _spinner;
var _spinnerIndex = 0;
var _stopping = false;
var _printedReadyBlock = false;

String _stripAnsi(String value) {
  return value.replaceAll(RegExp(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])'), '');
}

bool _isKnownNoise(String line) {
  return line.contains('jaspr.styles option "null" is not supported') ||
      line.contains('These options have been removed and were ignored');
}

bool _looksImportant(String line) {
  if (_isKnownNoise(line)) return false;

  final lower = line.toLowerCase();

  return lower.contains('error:') ||
      lower.contains('exception:') ||
      lower.contains('failed') ||
      lower.contains('could not') ||
      lower.contains('compilation') ||
      lower.contains('socketexception');
}

void _remember(_Service service, String rawLine) {
  final line = _stripAnsi(rawLine).trimRight();

  if (line.isEmpty || _isKnownNoise(line)) return;

  service.recentLines.add(line);

  if (service.recentLines.length > 40) {
    service.recentLines.removeAt(0);
  }
}

void _clearStatusLine() {
  if (!stdout.hasTerminal) return;

  stdout.write('\r${' ' * 100}\r');
}

String _statusText() {
  final ready = _services.where((service) => service.ready).length;

  final restarting = _services
      .where((service) => service.restartCount > 0 && !service.ready)
      .map((service) => service.label)
      .join(', ');

  if (restarting.isNotEmpty) {
    return 'Restarting $restarting... $ready/${_services.length} ready';
  }

  return 'Starting Clyven... $ready/${_services.length} ready';
}

void _ensureSpinner() {
  if (_spinner != null) return;

  if (!stdout.hasTerminal) {
    stdout.writeln(_statusText());
    return;
  }

  _spinner = Timer.periodic(const Duration(milliseconds: 100), (_) {
    final frame = _spinnerFrames[_spinnerIndex % _spinnerFrames.length];
    _spinnerIndex++;

    stdout.write('\r$frame ${_statusText()}');
  });
}

void _stopSpinner() {
  _spinner?.cancel();
  _spinner = null;
  _clearStatusLine();
}

void _printReadyBlock() {
  if (_services.any((service) => !service.ready)) return;

  _stopSpinner();

  if (!_printedReadyBlock) {
    _printedReadyBlock = true;
    stdout.writeln('Clyven Web     http://localhost:8084');
    stdout.writeln('Clyven Studio  http://localhost:8083');
    stdout.writeln('');
    stdout.writeln('Ctrl+C to stop.');
    return;
  }

  stdout.writeln('Ready again.');
}

void _printCompactFailure(_Service service, int code) {
  _stopSpinner();

  stderr.writeln('');
  stderr.writeln(
    '${service.label} stopped unexpectedly (exit code $code). '
    'Restarting automatically...',
  );

  final useful = service.recentLines.where(_looksImportant).toList();
  final lines = useful.length <= 8 ? useful : useful.sublist(useful.length - 8);

  if (lines.isNotEmpty) {
    for (final line in lines) {
      stderr.writeln('  $line');
    }
  }

  _ensureSpinner();
}

Future<void> _killProcessTree(Process process) async {
  if (Platform.isWindows) {
    await Process.run('taskkill', [
      '/PID',
      '${process.pid}',
      '/T',
      '/F',
    ], runInShell: true);
    return;
  }

  process.kill(ProcessSignal.sigterm);
  await Future<void>.delayed(const Duration(milliseconds: 350));

  try {
    process.kill(ProcessSignal.sigkill);
  } catch (_) {
    // Already stopped.
  }
}

Future<void> _stopAll() async {
  if (_stopping) return;

  _stopping = true;
  _stopSpinner();

  final active = _services
      .map((service) => service.process)
      .whereType<Process>()
      .toList();

  await Future.wait(active.map(_killProcessTree));

  stdout.writeln('');
  stdout.writeln('Stopped.');
}

Future<int?> _pidUsingPort(int port) async {
  if (!Platform.isWindows) return null;

  final result = await Process.run('powershell', [
    '-NoProfile',
    '-Command',
    'Get-NetTCPConnection -LocalPort $port -State Listen '
        '-ErrorAction SilentlyContinue | '
        'Select-Object -ExpandProperty OwningProcess -Unique',
  ], runInShell: true);

  final output = '${result.stdout}'.trim();

  if (output.isEmpty) return null;

  for (final line in output.split(RegExp(r'\r?\n'))) {
    final pid = int.tryParse(line.trim());
    if (pid != null) return pid;
  }

  return null;
}

Future<void> _waitForPortToBecomeFree(int port) async {
  const maxAttempts = 20;

  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    if (_stopping) return;

    final pid = await _pidUsingPort(port);

    if (pid == null) return;

    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}

Future<int> _runOneService(_Service service) async {
  await _waitForPortToBecomeFree(service.port);

  if (_stopping) return 0;

  service.starting = true;
  service.ready = false;
  service.recentLines.clear();

  final process = await Process.start(
    'jaspr',
    ['serve', '--port', '${service.port}'],
    workingDirectory: service.directory,
    runInShell: Platform.isWindows,
  );

  service.process = process;

  void handleLine(String line) {
    _remember(service, line);

    if (line.contains('Serving at http://localhost:${service.port}')) {
      service.ready = true;
      service.starting = false;
      _printReadyBlock();
      return;
    }

    if (_printedReadyBlock && _looksImportant(line)) {
      // Do not flood the terminal. Keep it buffered and only show it if the
      // service actually exits.
      return;
    }
  }

  final outDone = process.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach(handleLine);

  final errDone = process.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach(handleLine);

  final code = await process.exitCode;

  await Future.wait(<Future<void>>[outDone, errDone]);

  service.process = null;
  service.ready = false;
  service.starting = false;

  return code;
}

Future<void> _supervise(_Service service) async {
  while (!_stopping) {
    final code = await _runOneService(service);

    if (_stopping) return;

    service.restartCount++;

    _printCompactFailure(service, code);

    // Small backoff prevents a broken source file from creating a tight loop.
    await Future<void>.delayed(const Duration(milliseconds: 900));
  }
}

Future<void> main() async {
  _ensureSpinner();

  StreamSubscription<ProcessSignal>? sigintSubscription;
  StreamSubscription<ProcessSignal>? sigtermSubscription;

  sigintSubscription = ProcessSignal.sigint.watch().listen((_) async {
    await _stopAll();
  });

  if (!Platform.isWindows) {
    sigtermSubscription = ProcessSignal.sigterm.watch().listen((_) async {
      await _stopAll();
    });
  }

  try {
    await Future.wait(_services.map(_supervise));
  } finally {
    await sigintSubscription.cancel();
    await sigtermSubscription?.cancel();

    if (!_stopping) {
      await _stopAll();
    }
  }
}
