class ParsedSubtitleCue {
  const ParsedSubtitleCue({
    required this.sourceNumber,
    required this.startMs,
    required this.endMs,
    required this.text,
  });

  final int sourceNumber;
  final int startMs;
  final int endMs;
  final String text;
}

class SubtitleSrtParseResult {
  const SubtitleSrtParseResult({
    required this.cues,
    required this.errors,
  });

  final List<ParsedSubtitleCue> cues;
  final List<String> errors;

  bool get canImport => errors.isEmpty;
}

class SubtitleSrtParser {
  SubtitleSrtParseResult parse(String content) {
    final normalized = content
        .replaceFirst('\uFEFF', '')
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .trim();

    if (normalized.isEmpty) {
      return const SubtitleSrtParseResult(
        cues: [],
        errors: ['SRT 文件为空'],
      );
    }

    final blocks = normalized.split(
      RegExp(r'\n\s*\n'),
    );

    final cues = <ParsedSubtitleCue>[];
    final errors = <String>[];

    for (var blockIndex = 0; blockIndex < blocks.length; blockIndex++) {
      final block = blocks[blockIndex].trim();

      if (block.isEmpty) {
        continue;
      }

      final lines = block.split('\n');

      var lineIndex = 0;
      var sourceNumber = blockIndex + 1;

      final firstLine = lines.first.trim();

      final parsedNumber = int.tryParse(firstLine);

      if (parsedNumber != null) {
        sourceNumber = parsedNumber;
        lineIndex = 1;
      }

      if (lineIndex >= lines.length) {
        errors.add(
          '第 $sourceNumber 条字幕缺少时间轴',
        );
        continue;
      }

      final timingLine = lines[lineIndex].trim();

      final timingMatch = RegExp(
        r'^(\d+:\d{2}:\d{2}[,.]\d{3})\s*-->\s*(\d+:\d{2}:\d{2}[,.]\d{3})$',
      ).firstMatch(timingLine);

      if (timingMatch == null) {
        errors.add(
          '第 $sourceNumber 条字幕时间格式错误：$timingLine',
        );
        continue;
      }

      final startMs = _parseTimestamp(
        timingMatch.group(1)!,
      );

      final endMs = _parseTimestamp(
        timingMatch.group(2)!,
      );

      if (startMs == null || endMs == null) {
        errors.add(
          '第 $sourceNumber 条字幕时间格式错误',
        );
        continue;
      }

      if (endMs <= startMs) {
        errors.add(
          '第 $sourceNumber 条字幕结束时间必须大于开始时间',
        );
        continue;
      }

      final textStartIndex = lineIndex + 1;

      if (textStartIndex >= lines.length) {
        errors.add(
          '第 $sourceNumber 条字幕内容为空',
        );
        continue;
      }

      final text = lines.sublist(textStartIndex).join('\n').trim();

      if (text.isEmpty) {
        errors.add(
          '第 $sourceNumber 条字幕内容为空',
        );
        continue;
      }

      cues.add(
        ParsedSubtitleCue(
          sourceNumber: sourceNumber,
          startMs: startMs,
          endMs: endMs,
          text: text,
        ),
      );
    }

    final sortedCues = [...cues]
      ..sort(
        (a, b) => a.startMs.compareTo(b.startMs),
      );

    for (var index = 1; index < sortedCues.length; index++) {
      final previous = sortedCues[index - 1];
      final current = sortedCues[index];

      if (current.startMs < previous.endMs) {
        errors.add(
          '第 ${current.sourceNumber} 条字幕'
          '与第 ${previous.sourceNumber} 条字幕时间重叠',
        );
      }
    }

    return SubtitleSrtParseResult(
      cues: sortedCues,
      errors: errors,
    );
  }

  int? _parseTimestamp(String value) {
    final match = RegExp(
      r'^(\d+):([0-5]\d):([0-5]\d)[,.](\d{3})$',
    ).firstMatch(value.trim());

    if (match == null) {
      return null;
    }

    final hours = int.parse(match.group(1)!);
    final minutes = int.parse(match.group(2)!);
    final seconds = int.parse(match.group(3)!);
    final milliseconds = int.parse(match.group(4)!);

    return hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;
  }
}
