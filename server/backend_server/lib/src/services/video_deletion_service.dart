import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'video_deletion_fault_injection.dart';

/// Persistent deletion tombstones stay on Video until external cleanup succeeds.
class VideoDeletionService {
  static const deleting = 'DELETING';
  static bool _sweeping = false;
  static final Set<int> _processing = <int>{};

  static Future<void> cleanup(Session session, Video video) async {
    final videoId = video.id;
    if (videoId == null || _processing.contains(videoId)) return;
    // Atomic database claim: prevents separate Containers from deleting the
    // same video concurrently. A stale claim can be recovered after 30 min.
    final claimed = await session.db.unsafeQuery(
      r"""UPDATE "video"
         SET "transcodeState" = 'DELETING_ACTIVE', "updatedAt" = NOW()
         WHERE "id" = @videoId
           AND ("transcodeState" = 'DELETING'
             OR ("transcodeState" = 'DELETING_ACTIVE'
                 AND "updatedAt" < NOW() - INTERVAL '30 minutes'))
         RETURNING "id" """,
      parameters: QueryParameters.named({'videoId': videoId}),
    );
    if (claimed.isEmpty) return;
    final id = videoId;
    _processing.add(id);
    try {
      VideoDeletionFaultInjection.check(videoId: id, step: 'before_stream');
      final job = video.transcoderJobName?.trim() ?? '';
      if (job.startsWith('cfstream:')) {
        await _deleteStream(job.substring('cfstream:'.length));
      }
      VideoDeletionFaultInjection.check(videoId: id, step: 'after_stream');
      await session.storage.deleteFile(
        storageId: 'public',
        path: video.videoStorageKey,
      );
      final cover = video.coverStorageKey;
      if (cover != null && cover.isNotEmpty) {
        await session.storage.deleteFile(storageId: 'public', path: cover);
      }
      VideoDeletionFaultInjection.check(videoId: id, step: 'after_r2');
      // Delete database references only after remote assets are cleaned.
      final comments = await VideoCommentRow.db.find(
        session,
        where: (row) => row.videoId.equals(videoId),
      );
      final commentIds = comments.map((row) => row.id).whereType<int>().toSet();

      if (commentIds.isNotEmpty) {
        final replies = await CommentReplyRow.db.find(
          session,
          where: (row) => row.commentId.inSet(commentIds),
        );
        final replyIds = replies.map((row) => row.id).whereType<int>().toSet();

        if (replyIds.isNotEmpty) {
          await CommentReplyLike.db.deleteWhere(
            session,
            where: (row) => row.replyId.inSet(replyIds),
          );
        }

        await CommentReplyRow.db.deleteWhere(
          session,
          where: (row) => row.commentId.inSet(commentIds),
        );
        await CommentLike.db.deleteWhere(
          session,
          where: (row) => row.commentId.inSet(commentIds),
        );
      }

      await VideoCommentRow.db.deleteWhere(
        session,
        where: (row) => row.videoId.equals(videoId),
      );

      final reviewTasks = await SubtitleReviewTask.db.find(
        session,
        where: (row) => row.videoId.equals(videoId),
      );
      final taskIds = reviewTasks.map((row) => row.id).whereType<int>().toSet();

      if (taskIds.isNotEmpty) {
        await SubtitleReviewEvent.db.deleteWhere(
          session,
          where: (row) => row.taskId.inSet(taskIds),
        );
      }

      await SubtitleReviewTask.db.deleteWhere(
        session,
        where: (row) => row.videoId.equals(videoId),
      );

      final tracks = await SubtitleTrack.db.find(
        session,
        where: (row) => row.videoId.equals(videoId),
      );
      final trackIds = tracks.map((row) => row.id).whereType<int>().toSet();

      if (trackIds.isNotEmpty) {
        final cues = await SubtitleCue.db.find(
          session,
          where: (row) => row.trackId.inSet(trackIds),
        );
        final cueIds = cues.map((row) => row.id).whereType<int>().toSet();

        if (cueIds.isNotEmpty) {
          await SubtitlePhrase.db.deleteWhere(
            session,
            where: (row) => row.cueId.inSet(cueIds),
          );
          await SubtitleToken.db.deleteWhere(
            session,
            where: (row) => row.cueId.inSet(cueIds),
          );
          await SubtitleCueText.db.deleteWhere(
            session,
            where: (row) => row.cueId.inSet(cueIds),
          );
        }

        await SubtitleCue.db.deleteWhere(
          session,
          where: (row) => row.trackId.inSet(trackIds),
        );
        await SubtitlePublishState.db.deleteWhere(
          session,
          where: (row) => row.trackId.inSet(trackIds),
        );
      }

      await AsrJob.db.deleteWhere(
        session,
        where: (row) => row.videoId.equals(videoId),
      );
      await SubtitleTrack.db.deleteWhere(
        session,
        where: (row) => row.videoId.equals(videoId),
      );
      await Video.db.deleteRow(session, video);
      session.log('VIDEO_DELETE_COMPLETED videoId=$id');
    } catch (error, stackTrace) {
      session.log(
        'VIDEO_DELETE_RETRY videoId=$id error=$error',
        level: LogLevel.warning,
      );
      session.log('$stackTrace', level: LogLevel.warning);
      // If cleanup fails, return the job to the queue. If this write fails,
      // the stale-claim timeout will eventually recover it.
      await session.db.unsafeExecute(
        r"""UPDATE "video"
           SET "transcodeState" = 'DELETING'
           WHERE "id" = @videoId AND "transcodeState" = 'DELETING_ACTIVE' """,
        parameters: QueryParameters.named({'videoId': id}),
      );
      rethrow;
    } finally {
      _processing.remove(id);
    }
  }

  static Future<void> _deleteStream(String uid) async {
    if (uid.isEmpty || !RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(uid)) {
      throw StateError('Invalid Cloudflare Stream UID');
    }
    final account = Platform.environment['CLOUDFLARE_ACCOUNT_ID']?.trim() ?? '';
    final token =
        Platform.environment['CLOUDFLARE_STREAM_API_TOKEN']?.trim() ?? '';
    if (account.isEmpty || token.isEmpty) {
      throw StateError(
        'Cloudflare Stream credentials unavailable for deletion',
      );
    }
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      final uri = Uri.https(
        'api.cloudflare.com',
        '/client/v4/accounts/$account/stream/$uid',
      );
      final request = await client
          .deleteUrl(uri)
          .timeout(const Duration(seconds: 20));
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
      final response = await request.close().timeout(
        const Duration(seconds: 30),
      );
      final body = await utf8.decoder
          .bind(response)
          .join()
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == HttpStatus.notFound) return;
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError(
          'Cloudflare Stream delete failed HTTP ${response.statusCode}: ${body.length > 300 ? body.substring(0, 300) : body}',
        );
      }
    } finally {
      client.close(force: true);
    }
  }

  /// Periodically recover tombstones after process restarts and transient errors.
  static Future<void> sweep() async {
    if (_sweeping) return;
    _sweeping = true;
    Session? session;
    try {
      session = await Serverpod.instance.createSession();
      final pending = await Video.db.find(
        session,
        where: (t) =>
            t.transcodeState.equals(deleting) |
            t.transcodeState.equals('DELETING_ACTIVE'),
        limit: 20,
      );
      for (final video in pending) {
        try {
          await cleanup(session, video);
        } catch (_) {
          // Keep tombstone and retry later.
        }
      }
    } catch (error) {
      print('[Glyphora Video Deletion] Sweep failed: $error');
    } finally {
      await session?.close();
      _sweeping = false;
    }
  }
}
