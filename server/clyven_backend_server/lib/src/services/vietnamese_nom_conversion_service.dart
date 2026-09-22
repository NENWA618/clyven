import 'dart:io';

import 'package:clyven_nom_converter/clyven_nom_converter.dart';
import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'subtitle_review_task_service.dart';

class VietnameseNomConversionService {
  final SubtitleReviewTaskService _taskService = SubtitleReviewTaskService();

  NomDictionary? _dictionary;

  String get latinScriptCode {
    final script = ScriptConfig.findByCode('Latn');
    if (script == null) {
      throw Exception('Language core is missing the Latin script definition.');
    }
    return script.code;
  }

  String get nomScriptCode {
    final script = ScriptConfig.findByCode('chunom');
    if (script == null || !script.languageCodes.contains('vi')) {
      throw Exception(
        'Language core is missing the Vietnamese Chữ Nôm script.',
      );
    }
    return script.code;
  }

  Future<NomDictionary> _loadDictionary() async {
    final cached = _dictionary;
    if (cached != null) return cached;

    final override = Platform.environment['CLYVEN_NOM_DICTIONARY_PATH']?.trim();

    final candidates = <File>[
      if (override != null && override.isNotEmpty) File(override),
      File('../../packages/clyven_nom_converter/data/nom_dictionary.json'),
      File('packages/clyven_nom_converter/data/nom_dictionary.json'),
      File('data/clyven_nom_converter/nom_dictionary.json'),
    ];

    File? selected;
    for (final file in candidates) {
      if (await file.exists()) {
        selected = file;
        break;
      }
    }

    if (selected == null) {
      throw Exception(
        '找不到 Clyven 喃字词库 nom_dictionary.json。'
        '请先从 Excel 重新导入词库。',
      );
    }

    final loaded = NomDictionary.fromJsonText(await selected.readAsString());
    _dictionary = loaded;
    return loaded;
  }

  Future<SubtitleReviewTask> generateLatinToNomDraft(
    Session session, {
    required int trackId,
  }) async {
    final track = await SubtitleTrack.db.findById(session, trackId);

    if (track == null || track.id == null) {
      throw Exception('找不到字幕轨');
    }

    final baseLanguage = track.languageCode
        .trim()
        .toLowerCase()
        .split(RegExp(r'[-_]'))
        .first;

    if (baseLanguage != 'vi') {
      throw Exception('喃字转换目前只用于越南语字幕');
    }

    final sourceScript = latinScriptCode;
    final targetScript = nomScriptCode;

    final cues = await SubtitleCue.db.find(
      session,
      where: (cue) => cue.trackId.equals(trackId),
      orderBy: (cue) => cue.startMs,
    );

    if (cues.isEmpty) {
      throw Exception('这个越南语字幕轨还没有字幕内容');
    }

    final cueIds = cues.map((cue) => cue.id).whereType<int>().toSet();

    final texts = await SubtitleCueText.db.find(
      session,
      where: (text) => text.cueId.inSet(cueIds),
    );

    final sourceByCueId = <int, SubtitleCueText>{};
    final targetByCueId = <int, SubtitleCueText>{};

    for (final text in texts) {
      if (text.scriptCode.toLowerCase() == sourceScript.toLowerCase()) {
        sourceByCueId[text.cueId] = text;
      }

      if (text.scriptCode.toLowerCase() == targetScript.toLowerCase()) {
        targetByCueId[text.cueId] = text;
      }
    }

    final missingSourceCueIds = <int>[];

    for (final cue in cues) {
      final cueId = cue.id;
      if (cueId == null) continue;

      final source = sourceByCueId[cueId]?.text.trim();
      if (source == null || source.isEmpty) {
        missingSourceCueIds.add(cueId);
      }
    }

    if (missingSourceCueIds.isNotEmpty) {
      throw Exception(
        '不能生成喃字：有 ${missingSourceCueIds.length} 条字幕缺少 '
        '$sourceScript 越南国语字文本。',
      );
    }

    final existingTask = await SubtitleReviewTask.db.findFirstRow(
      session,
      where: (task) =>
          task.trackId.equals(trackId) & task.scriptCode.equals(targetScript),
      orderBy: (task) => task.createdAt,
      orderDescending: true,
    );

    final hasExistingNomText = targetByCueId.values.any(
      (text) => text.text.trim().isNotEmpty,
    );

    if (existingTask != null && hasExistingNomText) {
      return existingTask;
    }

    final dictionary = await _loadDictionary();
    final converter = NomConverter(dictionary);
    final now = DateTime.now();

    var ambiguousCount = 0;
    var unmatchedCount = 0;
    var generatedCount = 0;

    await session.db.transaction((transaction) async {
      for (final cue in cues) {
        final cueId = cue.id;
        if (cueId == null) continue;

        final sourceText = sourceByCueId[cueId]!.text.trim();
        final existingTarget = targetByCueId[cueId];

        if (existingTarget != null && existingTarget.text.trim().isNotEmpty) {
          continue;
        }

        final result = converter.convertLatinToNom(sourceText);

        ambiguousCount += result.ambiguousSegmentCount;
        unmatchedCount += result.unmatchedSegmentCount;

        final converted = result.convertedText.trim();
        if (converted.isEmpty) {
          continue;
        }

        if (existingTarget == null) {
          await SubtitleCueText.db.insertRow(
            session,
            SubtitleCueText(
              cueId: cueId,
              scriptCode: targetScript,
              text: converted,
              normalizedText: null,
              isPrimary: false,
              createdAt: now,
              updatedAt: now,
            ),
            transaction: transaction,
          );
        } else {
          existingTarget.text = converted;
          existingTarget.normalizedText = null;
          existingTarget.isPrimary = false;
          existingTarget.updatedAt = now;

          await SubtitleCueText.db.updateRow(
            session,
            existingTarget,
            transaction: transaction,
          );
        }

        generatedCount++;
      }
    });

    if (generatedCount == 0 && !hasExistingNomText) {
      throw Exception('转换器没有生成任何喃字字幕');
    }

    await _markDraftChanged(session, trackId);

    final task = await _taskService.ensureTaskForTrack(
      session,
      track: track,
      scriptCode: targetScript,
      forceReadyForReview: true,
    );

    if (task.id != null) {
      await SubtitleReviewEvent.db.insertRow(
        session,
        SubtitleReviewEvent(
          taskId: task.id!,
          actorUserId: null,
          actorDisplayName: 'Clyven Nôm Converter',
          action: 'nomDraftGenerated',
          note:
              '生成 $generatedCount 条喃字草稿；'
              '歧义片段 $ambiguousCount；'
              '未匹配片段 $unmatchedCount。',
        ),
      );
    }

    return task;
  }

  Future<void> _markDraftChanged(
    Session session,
    int trackId,
  ) async {
    var state = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (item) => item.trackId.equals(trackId),
    );

    final now = DateTime.now();

    if (state == null) {
      state = SubtitlePublishState(
        trackId: trackId,
        publishedPayload: null,
        publishedAt: null,
        draftRevision: 1,
        publishedRevision: 0,
        createdAt: now,
        updatedAt: now,
      );

      await SubtitlePublishState.db.insertRow(session, state);
      return;
    }

    state.draftRevision += 1;
    state.updatedAt = now;
    await SubtitlePublishState.db.updateRow(session, state);
  }
}
