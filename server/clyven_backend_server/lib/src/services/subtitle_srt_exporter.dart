import '../generated/protocol.dart';

class SubtitleSrtExporter {
  String export(List<SubtitleCue> cues) {
    final sortedCues = [...cues]
      ..sort(
        (a, b) => a.startMs.compareTo(b.startMs),
      );

    final buffer = StringBuffer();

    for (var index = 0; index < sortedCues.length; index++) {
      final cue = sortedCues[index];

      buffer.writeln(index + 1);
      buffer.writeln(
        '${_formatTimestamp(cue.startMs)} --> ${_formatTimestamp(cue.endMs)}',
      );
      buffer.writeln(cue.text);

      if (index < sortedCues.length - 1) {
        buffer.writeln();
      }
    }

    return buffer.toString();
  }

  String _formatTimestamp(int milliseconds) {
    final hours = milliseconds ~/ 3600000;
    final remainingAfterHours = milliseconds % 3600000;

    final minutes = remainingAfterHours ~/ 60000;
    final remainingAfterMinutes = remainingAfterHours % 60000;

    final seconds = remainingAfterMinutes ~/ 1000;
    final millis = remainingAfterMinutes % 1000;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')},'
        '${millis.toString().padLeft(3, '0')}';
  }
}
