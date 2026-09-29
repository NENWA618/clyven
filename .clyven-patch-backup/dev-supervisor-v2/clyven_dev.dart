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
  bool failed = false;
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

void _remember(_Service service, String rawLine) {
  final line = _stripAnsi(rawLine).trimRight();
  if (line.isEmpty) return;

  service.recentLines.add(line);

  if (service.recentLines.length > 30) {
    service.recentLines.removeAt(0);
  }
}

bool _isKnownNoise(String line) {
  return line.contains('jaspr.styles option "null" is not supported') ||
      line.contains('These options have been removed and were ignored');
}

bool _looksLikeError(String line) {
  if (_isKnownNoise(line)) return false;

  final lower = line.toLowerCase();

  return lower.contains('error:') ||
      lower.contains('exception:') ||
      lower.contains('failed to') ||
      lower.contains('could not') ||
      lower.contains('compilation failed');
}

void _clearStatusLine() {
  if (!stdout.hasTerminal) return;
  stdout.write('\r${' ' * 90}\r');
}

void _startSpinner() {
  if (!stdout.hasTerminal) {
    stdout.writeln('Starting Clyven...');
    return;
  }

  _spinner ??= Timer.periodic(const Duration(milliseconds: 100), (_) {
    final frame = _spinnerFrames[_spinnerIndex % _spinnerFrames.length];
    _spinnerIndex++;

    final ready = _services.where((service) => service.ready).length;

    stdout.write(
      '\r$frame Starting Clyven... $ready/${_services.length} ready',
    );
  });
}

void _stopSpinner() {
  _spinner?.cancel();
  _spinner = null;
  _clearStatusLine();
}

void _printReadyIfComplete() {
  if (_printedReadyBlock) return;
  if (_services.any((service) => !service.ready)) return;

  _printedReadyBlock = true;
  _stopSpinner();

  stdout.writeln('Clyven Web     http://localhost:8084');
  stdout.writeln('Clyven Studio  http://localhost:8083');
  stdout.writeln('');
  stdout.writeln('Ctrl+C to stop.');
}

void _printFailure(_Service service, int exitCode) {
  _stopSpinner();

  stderr.writeln('');
  stderr.writeln('${service.label} failed to start (exit code $exitCode).');

  final useful = service.recentLines
      .where((line) => !_isKnownNoise(line))
      .toList();

  final lines = useful.length <= 12
      ? useful
      : useful.sublist(useful.length - 12);

  if (lines.isNotEmpty) {
    stderr.writeln('');
    for (final line in lines) {
      stderr.writeln('  $line');
    }
  }
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

Future<int> _startService(_Service service) async {
  final process = await Process.start(
    'jaspr',
    ['serve', '--port', '${service.port}'],
    workingDirectory: service.directory,
    runInShell: Platform.isWindows,
  );

  service.process = process;

  void handleLine(String line, {required bool isErrorStream}) {
    _remember(service, line);

    if (line.contains('Serving at http://localhost:${service.port}')) {
      service.ready = true;
      _printReadyIfComplete();
      return;
    }

    if (_printedReadyBlock && _looksLikeError(line)) {
      stderr.writeln('[${service.label}] ${_stripAnsi(line).trim()}');
    }
  }

  final outDone = process.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach((line) => handleLine(line, isErrorStream: false));

  final errDone = process.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach((line) => handleLine(line, isErrorStream: true));

  final code = await process.exitCode;

  await Future.wait(<Future<void>>[outDone, errDone]);

  if (!_stopping && code != 0) {
    service.failed = true;
    _printFailure(service, code);
  }

  return code;
}

Future<void> main() async {
  _startSpinner();

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
    final results = await Future.wait(_services.map(_startService));

    if (!_stopping && results.any((code) => code != 0)) {
      await _stopAll();
      exitCode = 1;
    }
  } finally {
    await sigintSubscription.cancel();
    await sigtermSubscription?.cancel();

    if (!_stopping) {
      await _stopAll();
    }
  }
}
