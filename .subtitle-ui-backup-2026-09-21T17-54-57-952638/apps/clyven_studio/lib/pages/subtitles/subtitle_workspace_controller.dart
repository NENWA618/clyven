import 'package:clyven_backend_client/clyven_backend_client.dart';

import 'subtitle_workspace_service.dart';

class SubtitleWorkspaceController {
  SubtitleWorkspaceController({
    required this.service,
    required this.onChanged,
  });

  final SubtitleWorkspaceService service;
  final void Function() onChanged;

  Video? video;
  String? videoUrl;
  List<SubtitleCueDetail> cues = [];

  bool loading = true;
  String? error;

  Future<void> load({
    required int videoId,
    required String languageCode,
  }) async {
    loading = true;
    error = null;
    onChanged();

    try {
      final workspace = await service.load(
        videoId: videoId,
        languageCode: languageCode,
      );

      video = workspace.video;
      videoUrl = workspace.videoUrl;
      cues = workspace.cues;
      loading = false;

      onChanged();
    } catch (e) {
      error = e.toString();
      loading = false;

      onChanged();
    }
  }
}