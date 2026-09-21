import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/subtitle_srt_parser.dart';
import '../services/subtitle_srt_exporter.dart';
import '../services/subtitle_analysis_service.dart';

class SubtitleEndpoint extends Endpoint {
  static const _analysisService = SubtitleAnalysisService();

  Future<List<SubtitleCueDetail>> getCueDetails(
    Session session, {
    required int videoId,
    required String languageCode,
    String? scriptCode,
  }) async {
    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) & t.languageCode.equals(languageCode),
    );

    if (track == null) {
      return [];
    }

    final selectedScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: languageCode,
      requestedScriptCode: scriptCode,
      trackDefaultScriptCode: track.defaultScriptCode,
    );

    final cues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.equals(track.id),
      orderBy: (c) => c.startMs,
    );

    if (cues.isEmpty) {
      return [];
    }

    final cueIds = cues.map((cue) => cue.id).whereType<int>().toSet();

    final texts = await SubtitleCueText.db.find(
      session,
      where: (t) => t.cueId.inSet(cueIds),
    );

    final tokens = await SubtitleToken.db.find(
      session,
      where: (t) => t.cueId.inSet(cueIds),
      orderBy: (t) => t.position,
    );

    final phrases = await SubtitlePhrase.db.find(
      session,
      where: (p) => p.cueId.inSet(cueIds),
      orderBy: (p) => p.startPosition,
    );

    final textsByCueId = <int, List<SubtitleCueText>>{};

    for (final text in texts) {
      textsByCueId
          .putIfAbsent(
            text.cueId,
            () => [],
          )
          .add(text);
    }

    final tokensByCueId = <int, List<SubtitleToken>>{};

    for (final token in tokens) {
      if (selectedScriptCode != null &&
          token.scriptCode != null &&
          token.scriptCode != selectedScriptCode) {
        continue;
      }

      tokensByCueId
          .putIfAbsent(
            token.cueId,
            () => [],
          )
          .add(token);
    }

    final phrasesByCueId = <int, List<SubtitlePhrase>>{};

    for (final phrase in phrases) {
      if (selectedScriptCode != null &&
          phrase.scriptCode != null &&
          phrase.scriptCode != selectedScriptCode) {
        continue;
      }

      phrasesByCueId
          .putIfAbsent(
            phrase.cueId,
            () => [],
          )
          .add(phrase);
    }

    return [
      for (final cue in cues)
        SubtitleCueDetail(
          cue: cue,
          texts: cue.id == null ? [] : textsByCueId[cue.id!] ?? [],
          tokens: cue.id == null ? [] : tokensByCueId[cue.id!] ?? [],
          phrases: cue.id == null ? [] : phrasesByCueId[cue.id!] ?? [],
        ),
    ];
  }

  Future<List<SubtitleTrack>> getAvailableTracks(
    Session session, {
    required int videoId,
  }) async {
    final tracks = await SubtitleTrack.db.find(
      session,
      where: (t) => t.videoId.equals(videoId),
    );

    if (tracks.isEmpty) {
      return [];
    }

    final trackIds = tracks.map((track) => track.id).whereType<int>().toSet();

    if (trackIds.isEmpty) {
      return [];
    }

    final cues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.inSet(trackIds),
    );

    if (cues.isEmpty) {
      return [];
    }

    final trackIdsWithCues = cues.map((cue) => cue.trackId).toSet();

    final available = tracks.where((track) {
      final id = track.id;
      return id != null && trackIdsWithCues.contains(id);
    }).toList();

    available.sort((a, b) {
      if (a.isDefault != b.isDefault) {
        return a.isDefault ? -1 : 1;
      }

      return a.languageCode.compareTo(b.languageCode);
    });

    return available;
  }

  Future<SubtitleSrtPreview> previewSrtImport(
    Session session, {
    required int videoId,
    required String languageCode,
    required String content,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能导入字幕',
      );
    }

    final video = await Video.db.findById(
      session,
      videoId,
    );

    if (video == null) {
      throw Exception('找不到视频');
    }

    final parser = SubtitleSrtParser();

    final result = parser.parse(
      content,
    );

    final durationErrors = _validateCueDuration(
      result.cues,
      video.durationSeconds * 1000,
    );

    result.errors.addAll(
      durationErrors,
    );

    return SubtitleSrtPreview(
      cueCount: result.cues.length,
      errorCount: result.errors.length,
      errors: result.errors,
      canImport: result.canImport,
    );
  }

  Future<int> confirmReplaceSrtImport(
    Session session, {
    required int videoId,
    required String languageCode,
    required String content,
    String? scriptCode,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能导入字幕',
      );
    }

    final video = await Video.db.findById(
      session,
      videoId,
    );

    if (video == null) {
      throw Exception('找不到视频');
    }

    final parser = SubtitleSrtParser();

    final result = parser.parse(
      content,
    );

    final durationErrors = _validateCueDuration(
      result.cues,
      video.durationSeconds * 1000,
    );

    result.errors.addAll(
      durationErrors,
    );

    if (!result.canImport) {
      throw Exception(
        'SRT 存在 '
        '${result.errors.length} '
        '个错误，无法导入',
      );
    }

    if (result.cues.isEmpty) {
      throw Exception(
        'SRT 中没有可导入的字幕',
      );
    }

    var track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) &
          t.languageCode.equals(
            languageCode,
          ),
    );

    if (track == null) {
      track = await SubtitleTrack.db.insertRow(
        session,
        SubtitleTrack(
          videoId: videoId,
          languageCode: languageCode,
          label: languageCode.toUpperCase(),
          isDefault: false,
        ),
      );
    }

    final resolvedScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: languageCode,
      requestedScriptCode: scriptCode,
      trackDefaultScriptCode: track.defaultScriptCode,
    );

    final lexicon = resolvedScriptCode == null
        ? null
        : await _analysisService.loadLexicon(
            session,
            languageCode: languageCode,
            scriptCode: resolvedScriptCode,
          );

    final importTrack = track;
    final trackId = importTrack.id!;

    await session.db.transaction(
      (transaction) async {
        if (importTrack.defaultScriptCode == null &&
            resolvedScriptCode != null) {
          importTrack.defaultScriptCode = resolvedScriptCode;
          importTrack.updatedAt = DateTime.now();

          await SubtitleTrack.db.updateRow(
            session,
            importTrack,
            transaction: transaction,
          );
        }

        final existingCues = await SubtitleCue.db.find(
          session,
          where: (c) => c.trackId.equals(trackId),
          transaction: transaction,
        );

        final existingCueIds = existingCues
            .map((cue) => cue.id)
            .whereType<int>()
            .toSet();

        if (existingCueIds.isNotEmpty) {
          final existingTexts = await SubtitleCueText.db.find(
            session,
            where: (text) => text.cueId.inSet(existingCueIds),
            transaction: transaction,
          );

          if (existingTexts.isNotEmpty) {
            if (resolvedScriptCode == null) {
              throw Exception(
                'Cannot replace a multi-script subtitle timeline without a script code.',
              );
            }

            final otherScripts = existingTexts
                .map((text) => text.scriptCode)
                .where((code) => code != resolvedScriptCode)
                .toSet();

            if (otherScripts.isNotEmpty) {
              throw Exception(
                'Legacy SRT replacement is blocked because this track already '
                'contains other script variants.',
              );
            }
          }
        }

        for (final cue in existingCues) {
          final cueId = cue.id;

          if (cueId == null) {
            continue;
          }

          await SubtitleCueText.db.deleteWhere(
            session,
            where: (t) => t.cueId.equals(cueId),
            transaction: transaction,
          );

          await SubtitleToken.db.deleteWhere(
            session,
            where: (t) => t.cueId.equals(cueId),
            transaction: transaction,
          );

          await SubtitlePhrase.db.deleteWhere(
            session,
            where: (p) => p.cueId.equals(cueId),
            transaction: transaction,
          );
        }

        await SubtitleCue.db.deleteWhere(
          session,
          where: (c) => c.trackId.equals(trackId),
          transaction: transaction,
        );

        for (final parsedCue in result.cues) {
          final cue = SubtitleCue(
            trackId: trackId,
            startMs: parsedCue.startMs,
            endMs: parsedCue.endMs,
            text: parsedCue.text,
          );

          final insertedCue = await SubtitleCue.db.insertRow(
            session,
            cue,
            transaction: transaction,
          );

          final cueId = insertedCue.id;

          if (cueId != null && resolvedScriptCode != null) {
            await _analysisService.upsertAndAnalyzeCueText(
              session,
              cueId: cueId,
              languageCode: languageCode,
              scriptCode: resolvedScriptCode,
              text: parsedCue.text,
              isPrimary: true,
              lexicon: lexicon,
              transaction: transaction,
            );
          }
        }
      },
    );

    return result.cues.length;
  }

  Future<String> exportSrt(
    Session session, {
    required int videoId,
    required String languageCode,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能导出字幕',
      );
    }

    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) &
          t.languageCode.equals(
            languageCode,
          ),
    );

    if (track == null || track.id == null) {
      throw Exception('找不到字幕轨');
    }

    final cues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.equals(track.id!),
      orderBy: (c) => c.startMs,
    );

    if (cues.isEmpty) {
      throw Exception(
        '当前字幕轨没有可导出的字幕',
      );
    }

    final exporter = SubtitleSrtExporter();

    return exporter.export(
      cues,
    );
  }

  Future<SubtitleCue> updateCueText(
    Session session, {
    required int cueId,
    required String text,
    String? scriptCode,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能修改字幕',
      );
    }

    final normalizedText = text.trim();

    if (normalizedText.isEmpty) {
      throw Exception(
        '字幕内容不能为空',
      );
    }

    final cue = await SubtitleCue.db.findById(
      session,
      cueId,
    );

    if (cue == null) {
      throw Exception('找不到字幕');
    }

    final track = await SubtitleTrack.db.findById(
      session,
      cue.trackId,
    );

    if (track == null) {
      throw Exception('Subtitle track not found.');
    }

    final resolvedScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: track.languageCode,
      requestedScriptCode: scriptCode,
      trackDefaultScriptCode: track.defaultScriptCode,
    );

    var isPrimary = false;

    if (resolvedScriptCode != null) {
      if (track.defaultScriptCode == null) {
        track.defaultScriptCode = resolvedScriptCode;
        track.updatedAt = DateTime.now();

        await SubtitleTrack.db.updateRow(
          session,
          track,
        );

        isPrimary = true;
      } else {
        isPrimary = track.defaultScriptCode == resolvedScriptCode;
      }
    }

    if (isPrimary || resolvedScriptCode == null) {
      cue.text = normalizedText;
    }

    cue.updatedAt = DateTime.now();

    final updatedCue = await SubtitleCue.db.updateRow(
      session,
      cue,
    );

    if (resolvedScriptCode == null) {
      await SubtitleToken.db.deleteWhere(
        session,
        where: (t) => t.cueId.equals(cueId),
      );

      await SubtitlePhrase.db.deleteWhere(
        session,
        where: (p) => p.cueId.equals(cueId),
      );
    } else {
      await _analysisService.upsertAndAnalyzeCueText(
        session,
        cueId: cueId,
        languageCode: track.languageCode,
        scriptCode: resolvedScriptCode,
        text: normalizedText,
        isPrimary: isPrimary,
      );
    }

    return updatedCue;
  }

  Future<SubtitleCueText> upsertCueScriptText(
    Session session, {
    required int cueId,
    required String scriptCode,
    required String text,
    bool isPrimary = false,
  }) async {
    if (session.authenticated == null) {
      throw Exception('Login required to edit subtitles.');
    }

    final cleanScriptCode = scriptCode.trim();
    final cleanText = text.trim();

    if (cleanScriptCode.isEmpty) {
      throw Exception('scriptCode cannot be empty.');
    }

    if (cleanText.isEmpty) {
      throw Exception('Subtitle text cannot be empty.');
    }

    final cue = await SubtitleCue.db.findById(
      session,
      cueId,
    );

    if (cue == null) {
      throw Exception('Subtitle cue not found.');
    }

    final track = await SubtitleTrack.db.findById(
      session,
      cue.trackId,
    );

    if (track == null) {
      throw Exception('Subtitle track not found.');
    }

    final effectivePrimary = isPrimary || track.defaultScriptCode == null;

    if (effectivePrimary) {
      track.defaultScriptCode = cleanScriptCode;
      track.updatedAt = DateTime.now();

      await SubtitleTrack.db.updateRow(
        session,
        track,
      );

      cue.text = cleanText;
      cue.updatedAt = DateTime.now();

      await SubtitleCue.db.updateRow(
        session,
        cue,
      );
    }

    await _analysisService.upsertAndAnalyzeCueText(
      session,
      cueId: cueId,
      languageCode: track.languageCode,
      scriptCode: cleanScriptCode,
      text: cleanText,
      isPrimary: effectivePrimary,
    );

    final row = await SubtitleCueText.db.findFirstRow(
      session,
      where: (item) =>
          item.cueId.equals(cueId) & item.scriptCode.equals(cleanScriptCode),
    );

    if (row == null) {
      throw Exception('Failed to save subtitle script text.');
    }

    return row;
  }

  Future<SubtitleCue> updateCueTiming(
    Session session, {
    required int cueId,
    required int startMs,
    required int endMs,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能修改字幕时间',
      );
    }

    if (startMs < 0) {
      throw Exception(
        '开始时间不能小于 0',
      );
    }

    if (endMs <= startMs) {
      throw Exception(
        '结束时间必须大于开始时间',
      );
    }

    final cue = await SubtitleCue.db.findById(
      session,
      cueId,
    );

    if (cue == null) {
      throw Exception('找不到字幕');
    }

    await _ensureNoTimingOverlap(
      session,
      trackId: cue.trackId,
      startMs: startMs,
      endMs: endMs,
      excludeCueId: cueId,
    );

    cue.startMs = startMs;
    cue.endMs = endMs;
    cue.updatedAt = DateTime.now();

    return SubtitleCue.db.updateRow(
      session,
      cue,
    );
  }

  Future<void> _ensureNoTimingOverlap(
    Session session, {
    required int trackId,
    required int startMs,
    required int endMs,
    int? excludeCueId,
  }) async {
    final existingCues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.equals(trackId),
    );

    for (final existing in existingCues) {
      if (existing.id == excludeCueId) {
        continue;
      }

      final overlaps = startMs < existing.endMs && endMs > existing.startMs;

      if (overlaps) {
        throw Exception(
          '字幕时间与现有字幕重叠：'
          '${existing.startMs}ms - '
          '${existing.endMs}ms',
        );
      }
    }
  }

  Future<SubtitleCue> createCue(
    Session session, {
    required int videoId,
    required String languageCode,
    required int startMs,
    required int endMs,
    required String text,
    String? scriptCode,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能新增字幕',
      );
    }

    if (text.trim().isEmpty) {
      throw Exception(
        '字幕内容不能为空',
      );
    }

    if (startMs < 0) {
      throw Exception(
        '开始时间不能小于 0',
      );
    }

    if (endMs <= startMs) {
      throw Exception(
        '结束时间必须大于开始时间',
      );
    }

    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) &
          t.languageCode.equals(
            languageCode,
          ),
    );

    if (track == null || track.id == null) {
      throw Exception('找不到字幕轨');
    }

    await _ensureNoTimingOverlap(
      session,
      trackId: track.id!,
      startMs: startMs,
      endMs: endMs,
    );

    final resolvedScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: languageCode,
      requestedScriptCode: scriptCode,
      trackDefaultScriptCode: track.defaultScriptCode,
    );

    if (track.defaultScriptCode == null && resolvedScriptCode != null) {
      track.defaultScriptCode = resolvedScriptCode;
      track.updatedAt = DateTime.now();

      await SubtitleTrack.db.updateRow(
        session,
        track,
      );
    }

    final cue = SubtitleCue(
      trackId: track.id!,
      startMs: startMs,
      endMs: endMs,
      text: text.trim(),
    );

    final insertedCue = await SubtitleCue.db.insertRow(
      session,
      cue,
    );

    if (insertedCue.id != null && resolvedScriptCode != null) {
      await _analysisService.upsertAndAnalyzeCueText(
        session,
        cueId: insertedCue.id!,
        languageCode: languageCode,
        scriptCode: resolvedScriptCode,
        text: text.trim(),
        isPrimary: true,
      );
    }

    return insertedCue;
  }

  Future<void> deleteCue(
    Session session, {
    required int cueId,
  }) async {
    if (session.authenticated == null) {
      throw Exception(
        '需要登录后才能删除字幕',
      );
    }

    final cue = await SubtitleCue.db.findById(
      session,
      cueId,
    );

    if (cue == null) {
      throw Exception('找不到字幕');
    }

    await SubtitleCueText.db.deleteWhere(
      session,
      where: (t) => t.cueId.equals(cueId),
    );

    await SubtitleToken.db.deleteWhere(
      session,
      where: (t) => t.cueId.equals(cueId),
    );

    await SubtitlePhrase.db.deleteWhere(
      session,
      where: (p) => p.cueId.equals(cueId),
    );

    await SubtitleCue.db.deleteWhere(
      session,
      where: (c) => c.id.equals(cueId),
    );
  }

  List<String> _validateCueDuration(
    List<ParsedSubtitleCue> cues,
    int videoDurationMs,
  ) {
    final errors = <String>[];

    for (final cue in cues) {
      if (cue.startMs >= videoDurationMs) {
        errors.add(
          '第 ${cue.sourceNumber} '
          '条字幕开始时间超出视频时长',
        );

        continue;
      }

      if (cue.endMs > videoDurationMs) {
        errors.add(
          '第 ${cue.sourceNumber} '
          '条字幕结束时间超出视频时长',
        );
      }
    }

    return errors;
  }
}
