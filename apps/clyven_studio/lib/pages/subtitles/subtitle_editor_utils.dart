import 'package:clyven_backend_client/clyven_backend_client.dart';

String formatSubtitleTime(int milliseconds) {
  final totalSeconds = milliseconds ~/ 1000;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  final millis = milliseconds % 1000;

  return '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}.'
      '${millis.toString().padLeft(3, '0')}';
}

int? parseSubtitleTime(String value) {
  final text = value.trim();
  final parts = text.split(':');

  if (parts.length != 2) {
    return null;
  }

  final minutes = int.tryParse(parts[0]);

  if (minutes == null || minutes < 0) {
    return null;
  }

  final secondParts = parts[1].split('.');

  final seconds = int.tryParse(secondParts[0]);

  if (seconds == null || seconds < 0 || seconds >= 60) {
    return null;
  }

  var milliseconds = 0;

  if (secondParts.length == 2) {
    final msText = secondParts[1].padRight(3, '0');

    if (msText.length > 3) {
      return null;
    }

    milliseconds = int.tryParse(msText) ?? -1;

    if (milliseconds < 0) {
      return null;
    }
  } else if (secondParts.length > 2) {
    return null;
  }

  return minutes * 60000 + seconds * 1000 + milliseconds;
}

SubtitleCueDetail? findOverlappingCue({
  required List<SubtitleCueDetail> cues,
  required int startMs,
  required int endMs,
  int? excludeCueId,
}) {
  for (final detail in cues) {
    final cue = detail.cue;

    if (cue.id == excludeCueId) {
      continue;
    }

    final overlaps =
        startMs < cue.endMs &&
        endMs > cue.startMs;

    if (overlaps) {
      return detail;
    }
  }

  return null;
}