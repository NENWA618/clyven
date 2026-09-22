import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SubtitleReviewTaskService {
  Future<String?> resolveScriptCodeForTrack(
    Session session,
    SubtitleTrack track,
  ) async {
    final configured = track.defaultScriptCode?.trim();
    if (configured != null && configured.isNotEmpty) {
      return configured;
    }

    if (track.id == null) return null;

    final cue = await SubtitleCue.db.findFirstRow(
      session,
      where: (c) => c.trackId.equals(track.id!),
      orderBy: (c) => c.startMs,
    );

    if (cue?.id == null) return null;

    final primary = await SubtitleCueText.db.findFirstRow(
      session,
      where: (t) => t.cueId.equals(cue!.id!) & t.isPrimary.equals(true),
    );

    if (primary != null) return primary.scriptCode;

    final anyText = await SubtitleCueText.db.findFirstRow(
      session,
      where: (t) => t.cueId.equals(cue!.id!),
    );

    return anyText?.scriptCode;
  }

  Future<SubtitleReviewTask> ensureTaskForTrack(
    Session session, {
    required SubtitleTrack track,
    String? scriptCode,
    bool forceReadyForReview = false,
  }) async {
    if (track.id == null) {
      throw Exception('无法为未保存的字幕轨创建审核任务');
    }

    final resolvedScriptCode =
        scriptCode ?? await resolveScriptCodeForTrack(session, track);

    final existing = await SubtitleReviewTask.db.find(
      session,
      where: (task) => task.trackId.equals(track.id!),
      orderBy: (task) => task.createdAt,
    );

    for (final task in existing) {
      if ((task.scriptCode ?? '') == (resolvedScriptCode ?? '')) {
        return task;
      }
    }

    final publishState = await SubtitlePublishState.db.findFirstRow(
      session,
      where: (state) => state.trackId.equals(track.id!),
    );

    final payload = publishState?.publishedPayload;
    final alreadyPublished = payload != null && payload.trim().isNotEmpty;
    final now = DateTime.now();

    return SubtitleReviewTask.db.insertRow(
      session,
      SubtitleReviewTask(
        videoId: track.videoId,
        trackId: track.id!,
        languageCode: track.languageCode,
        scriptCode: resolvedScriptCode,
        status: forceReadyForReview
            ? SubtitleReviewTaskStatus.readyForReview
            : alreadyPublished
            ? SubtitleReviewTaskStatus.published
            : SubtitleReviewTaskStatus.readyForReview,
        publishedAt: !forceReadyForReview && alreadyPublished
            ? publishState?.publishedAt
            : null,
        completedAt: !forceReadyForReview && alreadyPublished
            ? publishState?.publishedAt ?? now
            : null,
        updatedAt: now,
      ),
    );
  }

  /// One-time compatibility bridge for subtitle tracks that existed before the
  /// review-task system. It is only called while the task table is empty.
  Future<void> initialBackfillIfNeeded(Session session) async {
    final count = await SubtitleReviewTask.db.count(session);
    if (count != 0) return;

    final tracks = await SubtitleTrack.db.find(
      session,
      orderBy: (track) => track.createdAt,
    );

    for (final track in tracks) {
      await ensureTaskForTrack(session, track: track);
    }
  }
}
