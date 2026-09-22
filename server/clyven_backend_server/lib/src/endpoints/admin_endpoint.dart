import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class AdminEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<bool> ping(Session session) async {
    return true;
  }

  Future<Map<String, String>> getUserEmails(Session session) async {
    const pageSize = 1000;
    var offset = 0;

    final emails = <String, String>{};

    while (true) {
      final profiles = await AuthServices.instance.userProfiles.admin
          .listUserProfiles(
            session,
            limit: pageSize,
            offset: offset,
          );

      for (final profile in profiles) {
        emails[profile.authUserId.toString()] = profile.email ?? '';
      }

      if (profiles.length < pageSize) {
        break;
      }

      offset += profiles.length;
    }

    return emails;
  }

  Future<List<Video>> getAllVideos(Session session) async {
    return Video.db.find(
      session,
      orderBy: (video) => video.createdAt,
      orderDescending: true,
    );
  }

  Future<List<Video>> getVideosWithSubtitles(Session session) async {
    final tracks = await SubtitleTrack.db.find(session);

    if (tracks.isEmpty) {
      return [];
    }

    final videoIds = tracks.map((track) => track.videoId).toSet();

    return Video.db.find(
      session,
      where: (video) => video.id.inSet(videoIds),
      orderBy: (video) => video.createdAt,
      orderDescending: true,
    );
  }

  Future<List<SubtitleTrack>> getSubtitleTracks(
    Session session, {
    required int videoId,
  }) async {
    final tracks = await SubtitleTrack.db.find(
      session,
      where: (track) => track.videoId.equals(videoId),
      orderBy: (track) => track.createdAt,
    );

    tracks.sort((a, b) {
      if (a.isDefault != b.isDefault) {
        return a.isDefault ? -1 : 1;
      }

      return a.languageCode.compareTo(b.languageCode);
    });

    return tracks;
  }
}
