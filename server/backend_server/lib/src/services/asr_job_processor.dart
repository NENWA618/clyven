import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'deepgram_asr_service.dart';

import 'subtitle_review_task_service.dart';

class AsrJobProcessor {
  const AsrJobProcessor();

  Future<void> process(
    Session session,
    int jobId,
  ) async {
    final job = await AsrJob.db.findById(
      session,
      jobId,
    );

    if (job == null) {
      return;
    }

    if (job.status == AsrJobStatus.readyForReview) {
      return;
    }

    job.status = AsrJobStatus.processing;
    job.errorMessage = null;
    job.updatedAt = DateTime.now();

    await AsrJob.db.updateRow(
      session,
      job,
    );

    try {
      final video = await Video.db.findById(
        session,
        job.videoId,
      );

      if (video == null || video.id == null) {
        throw StateError(
          'Video ${job.videoId} no longer exists',
        );
      }

      final videoUri = await session.storage.getPublicUrl(
        storageId: 'public',
        path: video.videoStorageKey,
      );

      if (videoUri == null) {
        throw StateError(
          'Could not create a public URL for ${video.videoStorageKey}',
        );
      }

      final transcript = await const DeepgramAsrService().transcribe(
        videoUrl: videoUri.toString(),
        requestedLanguageCode: job.requestedLanguageCode,
      );

      final resolvedLanguage = transcript.languageCode.trim();

      if (resolvedLanguage.isEmpty) {
        throw StateError(
          'ASR returned an empty language code',
        );
      }

      var track = await SubtitleTrack.db.findFirstRow(
        session,
        where: (table) =>
            table.videoId.equals(video.id!) &
            table.languageCode.equals(resolvedLanguage),
      );

      if (track != null && track.id != null) {
        final existingCues = await SubtitleCue.db.find(
          session,
          where: (table) => table.trackId.equals(track!.id!),
          limit: 1,
        );

        if (existingCues.isNotEmpty) {
          throw StateError(
            'Subtitle track $resolvedLanguage already has content; '
            'ASR will not overwrite it',
          );
        }
      }

      final fullText = transcript.segments
          .map((segment) => segment.text)
          .join('\n');

      final scriptCode = _resolveScriptCode(
        languageCode: resolvedLanguage,
        text: fullText,
      );

      final now = DateTime.now();

      track ??= await SubtitleTrack.db.insertRow(
        session,
        SubtitleTrack(
          videoId: video.id!,
          languageCode: resolvedLanguage,
          variantCode: null,
          label: _languageLabel(resolvedLanguage),
          defaultScriptCode: scriptCode,
          isDefault: true,
          createdAt: now,
          updatedAt: now,
        ),
      );

      final trackId = track.id;

      if (trackId == null) {
        throw StateError(
          'Failed to create subtitle track',
        );
      }

      final publishState = await SubtitlePublishState.db.findFirstRow(
        session,
        where: (table) => table.trackId.equals(trackId),
      );

      if (publishState == null) {
        await SubtitlePublishState.db.insertRow(
          session,
          SubtitlePublishState(
            trackId: trackId,
            publishedPayload: null,
            publishedAt: null,
            draftRevision: 1,
            publishedRevision: 0,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      for (final segment in transcript.segments) {
        final cueText = segment.text.trim();

        if (cueText.isEmpty) {
          continue;
        }

        final cue = await SubtitleCue.db.insertRow(
          session,
          SubtitleCue(
            trackId: trackId,
            startMs: segment.startMs,
            endMs: segment.endMs <= segment.startMs
                ? segment.startMs + 500
                : segment.endMs,
            text: cueText,
            createdAt: now,
            updatedAt: now,
          ),
        );

        final cueId = cue.id;

        if (cueId == null) {
          continue;
        }

        await SubtitleCueText.db.insertRow(
          session,
          SubtitleCueText(
            cueId: cueId,
            scriptCode: scriptCode,
            text: cueText,
            normalizedText: null,
            isPrimary: true,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      video.languageCode = resolvedLanguage;
      video.updatedAt = DateTime.now();

      await Video.db.updateRow(
        session,
        video,
      );

      job.detectedLanguageCode = resolvedLanguage;
      job.trackId = trackId;
      await SubtitleReviewTaskService().ensureTaskForTrack(
        session,
        track: track,
      );

      job.status = AsrJobStatus.readyForReview;
      job.errorMessage = null;
      job.updatedAt = DateTime.now();

      await AsrJob.db.updateRow(
        session,
        job,
      );
    } catch (error, stackTrace) {
      session.log(
        'ASR job $jobId failed: $error',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );

      job.status = AsrJobStatus.failed;
      job.errorMessage = error.toString();
      job.updatedAt = DateTime.now();

      await AsrJob.db.updateRow(
        session,
        job,
      );
    }
  }

  String _languageLabel(String code) {
    final baseCode = _baseLanguageCode(code);
    final language = LanguageConfig.findByCode(baseCode);

    return language?.nameOf('en') ?? code;
  }

  String _resolveScriptCode({
    required String languageCode,
    required String text,
  }) {
    final normalized = languageCode.toLowerCase();

    if (normalized.startsWith('zh')) {
      if (normalized.contains('hant') ||
          normalized.contains('-tw') ||
          normalized.contains('-hk') ||
          normalized.contains('-mo')) {
        return 'Hant';
      }

      return 'Hans';
    }

    final baseCode = _baseLanguageCode(languageCode);
    final language = LanguageConfig.findByCode(baseCode);

    if (language != null && language.scriptCodes.isNotEmpty) {
      return language.scriptCodes.first;
    }

    for (final rune in text.runes) {
      if (rune >= 0x0400 && rune <= 0x052F) {
        return 'Cyrl';
      }
      if (rune >= 0x0600 && rune <= 0x06FF) {
        return 'Arab';
      }
      if (rune >= 0x0590 && rune <= 0x05FF) {
        return 'Hebr';
      }
      if (rune >= 0x0900 && rune <= 0x097F) {
        return 'Deva';
      }
      if (rune >= 0x0E00 && rune <= 0x0E7F) {
        return 'Thai';
      }
      if (rune >= 0x0E80 && rune <= 0x0EFF) {
        return 'Laoo';
      }
      if (rune >= 0x10A0 && rune <= 0x10FF) {
        return 'Geor';
      }
      if (rune >= 0x0530 && rune <= 0x058F) {
        return 'Armn';
      }
      if (rune >= 0xAC00 && rune <= 0xD7AF) {
        return 'Hang';
      }
      if (rune >= 0x3040 && rune <= 0x30FF) {
        return 'Jpan';
      }
      if (rune >= 0x4E00 && rune <= 0x9FFF) {
        return 'Hani';
      }
    }

    return 'Latn';
  }

  String _baseLanguageCode(String code) {
    return code.trim().toLowerCase().split(RegExp(r'[-_]')).first;
  }
}
