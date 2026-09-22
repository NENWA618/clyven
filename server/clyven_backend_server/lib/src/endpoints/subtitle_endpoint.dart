import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/subtitle_srt_parser.dart';
import '../services/subtitle_srt_exporter.dart';
import '../services/subtitle_analysis_service.dart';

class SubtitleEndpoint extends Endpoint {
  static const _analysisService = SubtitleAnalysisService();

  String _requireAuthenticatedUserId(Session session) {
    final auth = session.authenticated;

    if (auth == null) {
      throw Exception('需要登录 Clyven Studio');
    }

    return auth.userIdentifier.toString();
  }

  Future<Video> _requireOwnedVideo(
    Session session,
    int videoId,
  ) async {
    final userId = _requireAuthenticatedUserId(session);

    final video = await Video.db.findById(
      session,
      videoId,
    );

    if (video == null) {
      throw Exception('找不到视频');
    }

    final auth = session.authenticated!;

    if (auth.scopes.contains(Scope.admin)) {
      return video;
    }

    if (video.authorId != userId) {
      throw Exception('只能编辑自己账号名下的视频');
    }

    return video;
  }

  Future<Video> _requireOwnedCueVideo(
    Session session,
    int cueId,
  ) async {
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
      throw Exception('找不到字幕轨');
    }

    return _requireOwnedVideo(
      session,
      track.videoId,
    );
  }

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

    final karaokeSegments = await SubtitleKaraokeSegment.db.find(
      session,
      where: (segment) => segment.cueId.inSet(cueIds),
      orderBy: (segment) => segment.position,
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

    final karaokeSegmentsByCueId = <int, List<SubtitleKaraokeSegment>>{};

    for (final segment in karaokeSegments) {
      // Karaoke text follows the same strict script selection rule as
      // SubtitleCueText. Never show timings from another script.
      if (segment.scriptCode != selectedScriptCode) {
        continue;
      }

      karaokeSegmentsByCueId
          .putIfAbsent(
            segment.cueId,
            () => [],
          )
          .add(segment);
    }

    return [
      for (final cue in cues)
        SubtitleCueDetail(
          cue: cue,
          texts: cue.id == null ? [] : textsByCueId[cue.id!] ?? [],
          tokens: cue.id == null ? [] : tokensByCueId[cue.id!] ?? [],
          phrases: cue.id == null ? [] : phrasesByCueId[cue.id!] ?? [],
          karaokeSegments: cue.id == null
              ? []
              : karaokeSegmentsByCueId[cue.id!] ?? [],
        ),
    ];
  }

  Future<List<SubtitleCueDetail>> getPublishedCueDetails(
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

    if (track == null || track.id == null) return [];

    final state = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (s) => s.trackId.equals(track.id!),
    );

    if (state == null) {
      return getCueDetails(
        session,
        videoId: videoId,
        languageCode: languageCode,
        scriptCode: scriptCode,
      );
    }

    final payload = state.publishedPayload;
    if (payload == null || payload.trim().isEmpty) return [];

    return _publishedDetailsFromPayload(
      session,
      track: track,
      payload: payload,
      requestedScriptCode: scriptCode,
    );
  }

  Future<List<SubtitleTrack>> getPublishedAvailableTracks(
    Session session, {
    required int videoId,
  }) async {
    final tracks = await SubtitleTrack.db.find(
      session,
      where: (t) => t.videoId.equals(videoId),
    );
    if (tracks.isEmpty) return [];

    final trackIds = tracks.map((e) => e.id).whereType<int>().toSet();
    final states = await SubtitlePublishState.db.find(
      session,
      where: (s) => s.trackId.inSet(trackIds),
    );
    final statesByTrackId = <int, SubtitlePublishState>{
      for (final state in states) state.trackId: state,
    };

    final liveCues = await SubtitleCue.db.find(
      session,
      where: (cue) => cue.trackId.inSet(trackIds),
    );
    final liveTrackIds = liveCues.map((e) => e.trackId).toSet();

    final available = <SubtitleTrack>[];
    for (final track in tracks) {
      final id = track.id;
      if (id == null) continue;
      final state = statesByTrackId[id];
      if (state == null) {
        if (liveTrackIds.contains(id)) available.add(track);
        continue;
      }
      final payload = state.publishedPayload;
      if (payload != null && payload.trim().isNotEmpty) available.add(track);
    }

    available.sort((a, b) {
      if (a.isDefault != b.isDefault) return a.isDefault ? -1 : 1;
      return a.languageCode.compareTo(b.languageCode);
    });
    return available;
  }

  Future<SubtitlePublishStatus> getSubtitlePublishStatus(
    Session session, {
    required int videoId,
    required String languageCode,
  }) async {
    await _requireOwnedVideo(session, videoId);

    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) & t.languageCode.equals(languageCode),
    );
    if (track == null || track.id == null) {
      return SubtitlePublishStatus(
        hasPublishedVersion: false,
        hasUnpublishedChanges: false,
        draftRevision: 0,
        publishedRevision: 0,
      );
    }
    return _publishStatusForTrack(session, track);
  }

  Future<SubtitlePublishStatus> publishSubtitleTrack(
    Session session, {
    required int videoId,
    required String languageCode,
  }) async {
    await _requireOwnedVideo(session, videoId);

    if (session.authenticated == null) {
      throw Exception('需要登录 Studio 后才能发布字幕');
    }

    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) & t.languageCode.equals(languageCode),
    );
    if (track == null || track.id == null) throw Exception('找不到字幕轨');

    final cue = await SubtitleCue.db.findFirstRow(
      session,
      where: (c) => c.trackId.equals(track.id!),
    );
    if (cue == null) throw Exception('当前字幕轨没有可发布的字幕');

    final payload = await _buildPublishedPayload(session, track);
    var state = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (s) => s.trackId.equals(track.id!),
    );
    final now = DateTime.now();

    if (state == null) {
      state = await SubtitlePublishState.db.insertRow(
        session,
        SubtitlePublishState(
          trackId: track.id!,
          publishedPayload: payload,
          publishedAt: now,
          draftRevision: 0,
          publishedRevision: 0,
        ),
      );
    } else {
      state.publishedPayload = payload;
      state.publishedAt = now;
      state.publishedRevision = state.draftRevision;
      state.updatedAt = now;
      state = await SubtitlePublishState.db.updateRow(session, state);
    }

    return SubtitlePublishStatus(
      hasPublishedVersion: true,
      hasUnpublishedChanges: false,
      draftRevision: state.draftRevision,
      publishedRevision: state.publishedRevision,
      publishedAt: state.publishedAt,
    );
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
    await _requireOwnedVideo(session, videoId);

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
    await _requireOwnedVideo(session, videoId);

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

    await _ensurePublishBaseline(session, trackId);

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

          await SubtitleKaraokeSegment.db.deleteWhere(
            session,
            where: (segment) => segment.cueId.equals(cueId),
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

    await _markDraftChanged(session, trackId);

    return result.cues.length;
  }

  Future<String> exportSrt(
    Session session, {
    required int videoId,
    required String languageCode,
  }) async {
    await _requireOwnedVideo(session, videoId);

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
    await _requireOwnedCueVideo(session, cueId);

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

    await _ensurePublishBaseline(session, track.id!);

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
        isPrimary = _sameSubtitleScriptCode(
          track.defaultScriptCode,
          resolvedScriptCode,
        );

        if (isPrimary && track.defaultScriptCode != resolvedScriptCode) {
          track.defaultScriptCode = resolvedScriptCode;
          track.updatedAt = DateTime.now();

          await SubtitleTrack.db.updateRow(
            session,
            track,
          );
        }
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

    await _markDraftChanged(session, cue.trackId);

    return updatedCue;
  }

  Future<SubtitleCueText> upsertCueScriptText(
    Session session, {
    required int cueId,
    required String scriptCode,
    required String text,
    bool isPrimary = false,
  }) async {
    await _requireOwnedCueVideo(session, cueId);

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

    await _ensurePublishBaseline(session, track.id!);

    final effectivePrimary =
        isPrimary ||
        track.defaultScriptCode == null ||
        _sameSubtitleScriptCode(
          track.defaultScriptCode,
          cleanScriptCode,
        );

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

    await _markDraftChanged(session, cue.trackId);

    return row;
  }

  Future<SubtitleCue> updateCueTiming(
    Session session, {
    required int cueId,
    required int startMs,
    required int endMs,
  }) async {
    await _requireOwnedCueVideo(session, cueId);

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

    await _ensurePublishBaseline(session, cue.trackId);

    await _ensureNoTimingOverlap(
      session,
      trackId: cue.trackId,
      startMs: startMs,
      endMs: endMs,
      excludeCueId: cueId,
    );

    final newDurationMs = endMs - startMs;

    final karaokeSegments = await SubtitleKaraokeSegment.db.find(
      session,
      where: (segment) => segment.cueId.equals(cueId),
    );

    for (final segment in karaokeSegments) {
      if (segment.endOffsetMs > newDurationMs) {
        throw Exception(
          'Karaoke 片段超出新的字幕时长，请先调整 Karaoke 时间。',
        );
      }
    }

    cue.startMs = startMs;
    cue.endMs = endMs;
    cue.updatedAt = DateTime.now();

    final updatedCue = await SubtitleCue.db.updateRow(
      session,
      cue,
    );

    await _markDraftChanged(session, cue.trackId);

    return updatedCue;
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
    await _requireOwnedVideo(session, videoId);

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

    await _ensurePublishBaseline(session, track.id!);

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

    await _markDraftChanged(session, track.id!);

    return insertedCue;
  }

  Future<void> deleteCue(
    Session session, {
    required int cueId,
  }) async {
    await _requireOwnedCueVideo(session, cueId);

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

    await _ensurePublishBaseline(session, cue.trackId);

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

    await SubtitleKaraokeSegment.db.deleteWhere(
      session,
      where: (segment) => segment.cueId.equals(cueId),
    );

    await SubtitleCue.db.deleteWhere(
      session,
      where: (c) => c.id.equals(cueId),
    );

    await _markDraftChanged(session, cue.trackId);
  }

  Future<List<SubtitleKaraokeSegment>> replaceKaraokeSegments(
    Session session, {
    required int cueId,
    required List<SubtitleKaraokeSegmentInput> segments,
    String? scriptCode,
  }) async {
    await _requireOwnedCueVideo(session, cueId);

    if (session.authenticated == null) {
      throw Exception('需要登录后才能修改 Karaoke 字幕');
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
      throw Exception('找不到字幕轨');
    }

    await _ensurePublishBaseline(session, track.id!);

    final cueDurationMs = cue.endMs - cue.startMs;

    final effectiveScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: track.languageCode,
      requestedScriptCode: scriptCode,
      trackDefaultScriptCode: track.defaultScriptCode,
    );

    var previousEndMs = 0;

    for (var index = 0; index < segments.length; index++) {
      final segment = segments[index];
      final cleanText = segment.text.trim();

      if (cleanText.isEmpty) {
        throw Exception('第 ${index + 1} 个 Karaoke 片段不能为空');
      }

      if (segment.startOffsetMs < 0) {
        throw Exception('第 ${index + 1} 个 Karaoke 片段开始时间不能小于 0');
      }

      if (segment.endOffsetMs <= segment.startOffsetMs) {
        throw Exception('第 ${index + 1} 个 Karaoke 片段结束时间必须大于开始时间');
      }

      if (segment.endOffsetMs > cueDurationMs) {
        throw Exception('第 ${index + 1} 个 Karaoke 片段超出当前字幕时长');
      }

      if (segment.startOffsetMs < previousEndMs) {
        throw Exception('第 ${index + 1} 个 Karaoke 片段与前一片段重叠');
      }

      previousEndMs = segment.endOffsetMs;
    }

    final saved = <SubtitleKaraokeSegment>[];

    await session.db.transaction(
      (transaction) async {
        final existing = await SubtitleKaraokeSegment.db.find(
          session,
          where: (segment) => segment.cueId.equals(cueId),
          transaction: transaction,
        );

        for (final row in existing) {
          if (row.scriptCode != effectiveScriptCode) {
            continue;
          }

          final rowId = row.id;

          if (rowId == null) {
            continue;
          }

          await SubtitleKaraokeSegment.db.deleteWhere(
            session,
            where: (segment) => segment.id.equals(rowId),
            transaction: transaction,
          );
        }

        for (var index = 0; index < segments.length; index++) {
          final input = segments[index];

          final inserted = await SubtitleKaraokeSegment.db.insertRow(
            session,
            SubtitleKaraokeSegment(
              cueId: cueId,
              scriptCode: effectiveScriptCode,
              position: index,
              startOffsetMs: input.startOffsetMs,
              endOffsetMs: input.endOffsetMs,
              text: input.text,
            ),
            transaction: transaction,
          );

          saved.add(inserted);
        }
      },
    );

    await _markDraftChanged(session, track.id!);

    return saved;
  }

  Future<void> _ensurePublishBaseline(Session session, int trackId) async {
    final existing = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (s) => s.trackId.equals(trackId),
    );
    if (existing != null) return;

    final track = await SubtitleTrack.db.findById(session, trackId);
    if (track == null) throw Exception('Subtitle track not found.');

    final cue = await SubtitleCue.db.findFirstRow(
      session,
      where: (c) => c.trackId.equals(trackId),
    );
    final payload = cue == null
        ? null
        : await _buildPublishedPayload(session, track);
    final now = DateTime.now();

    await SubtitlePublishState.db.insertRow(
      session,
      SubtitlePublishState(
        trackId: trackId,
        publishedPayload: payload,
        publishedAt: payload == null ? null : now,
        draftRevision: 0,
        publishedRevision: 0,
      ),
    );
  }

  Future<void> _markDraftChanged(Session session, int trackId) async {
    await _ensurePublishBaseline(session, trackId);
    final state = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (s) => s.trackId.equals(trackId),
    );
    if (state == null)
      throw Exception('Failed to create subtitle publish state.');
    state.draftRevision += 1;
    state.updatedAt = DateTime.now();
    await SubtitlePublishState.db.updateRow(session, state);
  }

  Future<SubtitlePublishStatus> _publishStatusForTrack(
    Session session,
    SubtitleTrack track,
  ) async {
    final id = track.id;
    if (id == null) {
      return SubtitlePublishStatus(
        hasPublishedVersion: false,
        hasUnpublishedChanges: false,
        draftRevision: 0,
        publishedRevision: 0,
      );
    }

    final state = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (s) => s.trackId.equals(id),
    );
    if (state == null) {
      final cue = await SubtitleCue.db.findFirstRow(
        session,
        where: (c) => c.trackId.equals(id),
      );
      return SubtitlePublishStatus(
        hasPublishedVersion: cue != null,
        hasUnpublishedChanges: false,
        draftRevision: 0,
        publishedRevision: 0,
      );
    }

    final payload = state.publishedPayload;
    return SubtitlePublishStatus(
      hasPublishedVersion: payload != null && payload.trim().isNotEmpty,
      hasUnpublishedChanges: state.draftRevision != state.publishedRevision,
      draftRevision: state.draftRevision,
      publishedRevision: state.publishedRevision,
      publishedAt: state.publishedAt,
    );
  }

  Future<String> _buildPublishedPayload(
    Session session,
    SubtitleTrack track,
  ) async {
    final trackId = track.id;
    if (trackId == null) throw Exception('Subtitle track has no id.');

    final cues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.equals(trackId),
      orderBy: (c) => c.startMs,
    );
    final cueIds = cues.map((e) => e.id).whereType<int>().toSet();

    final texts = cueIds.isEmpty
        ? <SubtitleCueText>[]
        : await SubtitleCueText.db.find(
            session,
            where: (r) => r.cueId.inSet(cueIds),
          );
    final tokens = cueIds.isEmpty
        ? <SubtitleToken>[]
        : await SubtitleToken.db.find(
            session,
            where: (r) => r.cueId.inSet(cueIds),
            orderBy: (r) => r.position,
          );
    final phrases = cueIds.isEmpty
        ? <SubtitlePhrase>[]
        : await SubtitlePhrase.db.find(
            session,
            where: (r) => r.cueId.inSet(cueIds),
            orderBy: (r) => r.startPosition,
          );
    final karaoke = cueIds.isEmpty
        ? <SubtitleKaraokeSegment>[]
        : await SubtitleKaraokeSegment.db.find(
            session,
            where: (r) => r.cueId.inSet(cueIds),
            orderBy: (r) => r.position,
          );

    return jsonEncode({
      'version': 1,
      'defaultScriptCode': track.defaultScriptCode,
      'cues': [
        for (final r in cues)
          {
            'id': r.id,
            'trackId': r.trackId,
            'startMs': r.startMs,
            'endMs': r.endMs,
            'text': r.text,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          },
      ],
      'texts': [
        for (final r in texts)
          {
            'id': r.id,
            'cueId': r.cueId,
            'scriptCode': r.scriptCode,
            'text': r.text,
            'normalizedText': r.normalizedText,
            'isPrimary': r.isPrimary,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          },
      ],
      'tokens': [
        for (final r in tokens)
          {
            'id': r.id,
            'cueId': r.cueId,
            'scriptCode': r.scriptCode,
            'text': r.text,
            'normalizedText': r.normalizedText,
            'entryId': r.entryId,
            'startMs': r.startMs,
            'endMs': r.endMs,
            'position': r.position,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          },
      ],
      'phrases': [
        for (final r in phrases)
          {
            'id': r.id,
            'cueId': r.cueId,
            'scriptCode': r.scriptCode,
            'text': r.text,
            'normalizedText': r.normalizedText,
            'entryId': r.entryId,
            'startPosition': r.startPosition,
            'endPosition': r.endPosition,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          },
      ],
      'karaoke': [
        for (final r in karaoke)
          {
            'id': r.id,
            'cueId': r.cueId,
            'scriptCode': r.scriptCode,
            'position': r.position,
            'startOffsetMs': r.startOffsetMs,
            'endOffsetMs': r.endOffsetMs,
            'text': r.text,
            'createdAt': r.createdAt.toIso8601String(),
            'updatedAt': r.updatedAt.toIso8601String(),
          },
      ],
    });
  }

  Future<List<SubtitleCueDetail>> _publishedDetailsFromPayload(
    Session session, {
    required SubtitleTrack track,
    required String payload,
    String? requestedScriptCode,
  }) async {
    final root = Map<String, dynamic>.from(jsonDecode(payload) as Map);
    final snapshotDefault = root['defaultScriptCode'] as String?;
    final selectedScriptCode = await _analysisService.resolveScriptCode(
      session,
      languageCode: track.languageCode,
      requestedScriptCode: requestedScriptCode,
      trackDefaultScriptCode: snapshotDefault,
    );

    final cues = [
      for (final m in _snapshotMaps(root['cues']))
        SubtitleCue(
          id: _snapshotInt(m['id']),
          trackId: _snapshotInt(m['trackId'])!,
          startMs: _snapshotInt(m['startMs'])!,
          endMs: _snapshotInt(m['endMs'])!,
          text: m['text'] as String,
          createdAt: _snapshotDate(m['createdAt']),
          updatedAt: _snapshotDate(m['updatedAt']),
        ),
    ];
    final texts = [
      for (final m in _snapshotMaps(root['texts']))
        SubtitleCueText(
          id: _snapshotInt(m['id']),
          cueId: _snapshotInt(m['cueId'])!,
          scriptCode: m['scriptCode'] as String,
          text: m['text'] as String,
          normalizedText: m['normalizedText'] as String?,
          isPrimary: m['isPrimary'] as bool,
          createdAt: _snapshotDate(m['createdAt']),
          updatedAt: _snapshotDate(m['updatedAt']),
        ),
    ];
    final tokens = [
      for (final m in _snapshotMaps(root['tokens']))
        SubtitleToken(
          id: _snapshotInt(m['id']),
          cueId: _snapshotInt(m['cueId'])!,
          scriptCode: m['scriptCode'] as String?,
          text: m['text'] as String,
          normalizedText: m['normalizedText'] as String?,
          entryId: _snapshotInt(m['entryId']),
          startMs: _snapshotInt(m['startMs']),
          endMs: _snapshotInt(m['endMs']),
          position: _snapshotInt(m['position'])!,
          createdAt: _snapshotDate(m['createdAt']),
          updatedAt: _snapshotDate(m['updatedAt']),
        ),
    ];
    final phrases = [
      for (final m in _snapshotMaps(root['phrases']))
        SubtitlePhrase(
          id: _snapshotInt(m['id']),
          cueId: _snapshotInt(m['cueId'])!,
          scriptCode: m['scriptCode'] as String?,
          text: m['text'] as String,
          normalizedText: m['normalizedText'] as String?,
          entryId: _snapshotInt(m['entryId']),
          startPosition: _snapshotInt(m['startPosition'])!,
          endPosition: _snapshotInt(m['endPosition'])!,
          createdAt: _snapshotDate(m['createdAt']),
          updatedAt: _snapshotDate(m['updatedAt']),
        ),
    ];
    final karaoke = [
      for (final m in _snapshotMaps(root['karaoke']))
        SubtitleKaraokeSegment(
          id: _snapshotInt(m['id']),
          cueId: _snapshotInt(m['cueId'])!,
          scriptCode: m['scriptCode'] as String?,
          position: _snapshotInt(m['position'])!,
          startOffsetMs: _snapshotInt(m['startOffsetMs'])!,
          endOffsetMs: _snapshotInt(m['endOffsetMs'])!,
          text: m['text'] as String,
          createdAt: _snapshotDate(m['createdAt']),
          updatedAt: _snapshotDate(m['updatedAt']),
        ),
    ];

    final textsByCue = <int, List<SubtitleCueText>>{};
    for (final row in texts) {
      textsByCue.putIfAbsent(row.cueId, () => []).add(row);
    }
    final tokensByCue = <int, List<SubtitleToken>>{};
    for (final row in tokens) {
      if (selectedScriptCode != null &&
          row.scriptCode != null &&
          !_sameSubtitleScriptCode(row.scriptCode, selectedScriptCode))
        continue;
      tokensByCue.putIfAbsent(row.cueId, () => []).add(row);
    }
    final phrasesByCue = <int, List<SubtitlePhrase>>{};
    for (final row in phrases) {
      if (selectedScriptCode != null &&
          row.scriptCode != null &&
          !_sameSubtitleScriptCode(row.scriptCode, selectedScriptCode))
        continue;
      phrasesByCue.putIfAbsent(row.cueId, () => []).add(row);
    }
    final karaokeByCue = <int, List<SubtitleKaraokeSegment>>{};
    for (final row in karaoke) {
      if (!_sameSubtitleScriptCode(row.scriptCode, selectedScriptCode))
        continue;
      karaokeByCue.putIfAbsent(row.cueId, () => []).add(row);
    }

    final details = <SubtitleCueDetail>[];

    for (final cue in cues) {
      final cueId = cue.id;
      final cueTexts = cueId == null
          ? <SubtitleCueText>[]
          : textsByCue[cueId] ?? [];

      var displayCue = cue;

      if (selectedScriptCode != null) {
        SubtitleCueText? selectedText;

        for (final row in cueTexts) {
          if (!_sameSubtitleScriptCode(
            row.scriptCode,
            selectedScriptCode,
          )) {
            continue;
          }

          if (selectedText == null ||
              row.updatedAt.isAfter(selectedText.updatedAt)) {
            selectedText = row;
          }
        }

        if (selectedText != null) {
          displayCue = SubtitleCue(
            id: cue.id,
            trackId: cue.trackId,
            startMs: cue.startMs,
            endMs: cue.endMs,
            text: selectedText.text,
            createdAt: cue.createdAt,
            updatedAt: cue.updatedAt,
          );
        }
      }

      details.add(
        SubtitleCueDetail(
          cue: displayCue,
          texts: cueTexts,
          tokens: cueId == null ? [] : tokensByCue[cueId] ?? [],
          phrases: cueId == null ? [] : phrasesByCue[cueId] ?? [],
          karaokeSegments: cueId == null ? [] : karaokeByCue[cueId] ?? [],
        ),
      );
    }

    return details;
  }

  bool _sameSubtitleScriptCode(String? a, String? b) {
    final left = a?.trim();
    final right = b?.trim();

    if (left == null || right == null) {
      return left == right;
    }

    return left.toLowerCase() == right.toLowerCase();
  }

  List<Map<String, dynamic>> _snapshotMaps(dynamic value) {
    final rows = value as List? ?? const [];
    return [for (final row in rows) Map<String, dynamic>.from(row as Map)];
  }

  int? _snapshotInt(dynamic value) =>
      value == null ? null : (value as num).toInt();
  DateTime _snapshotDate(dynamic value) => DateTime.parse(value as String);

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
