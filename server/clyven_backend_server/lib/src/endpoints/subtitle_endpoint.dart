import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class SubtitleEndpoint extends Endpoint {
  Future<List<SubtitleCueDetail>> getCueDetails(
    Session session, {
    required int videoId,
    required String languageCode,
  }) async {
    // 1. 找到这个视频对应语言的字幕轨
    final track = await SubtitleTrack.db.findFirstRow(
      session,
      where: (t) =>
          t.videoId.equals(videoId) &
          t.languageCode.equals(languageCode),
    );

    if (track == null) {
      return [];
    }

    // 2. 找这个字幕轨的所有字幕句
    final cues = await SubtitleCue.db.find(
      session,
      where: (c) => c.trackId.equals(track.id),
      orderBy: (c) => c.startMs,
    );

    final result = <SubtitleCueDetail>[];

    // 3. 每一句分别找 Token 和 Phrase
    for (final cue in cues) {
      final tokens = await SubtitleToken.db.find(
        session,
        where: (t) => t.cueId.equals(cue.id),
        orderBy: (t) => t.position,
      );

      final phrases = await SubtitlePhrase.db.find(
        session,
        where: (p) => p.cueId.equals(cue.id),
        orderBy: (p) => p.startPosition,
      );

      result.add(
        SubtitleCueDetail(
          cue: cue,
          tokens: tokens,
          phrases: phrases,
        ),
      );
    }

    return result;
  }
}