import 'package:clyven_backend_client/clyven_backend_client.dart';

import 'subtitle_cue_service.dart';

class SubtitleWorkspaceData {
  const SubtitleWorkspaceData({
    required this.video,
    required this.videoUrl,
    required this.cues,
  });

  final Video video;
  final String videoUrl;
  final List<SubtitleCueDetail> cues;
}

class SubtitleWorkspaceService {
  SubtitleWorkspaceService({
    required this.client,
    required this.cueService,
  });

  final Client client;
  final SubtitleCueService cueService;

  Future<SubtitleWorkspaceData> load({
    required int videoId,
    required String languageCode,
    String? scriptCode,
  }) async {
    final video = await client.video.getVideo(videoId);
    if (video == null) {
      throw Exception('找不到视频');
    }

    final videoUrl = await client.video.getVideoUrl(
      path: video.videoStorageKey,
    );
    if (videoUrl == null || videoUrl.isEmpty) {
      throw Exception('无法取得视频播放地址');
    }

    final cues = await cueService.loadCues(
      videoId: videoId,
      languageCode: languageCode,
    );

    return SubtitleWorkspaceData(
      video: video,
      videoUrl: videoUrl,
      cues: cues,
    );
  }
}
