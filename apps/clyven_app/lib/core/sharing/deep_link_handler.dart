import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

import '../../features/video/presentation/controllers/global_video_player_controller.dart';
import 'share_links.dart';

/// Opens the shared video inside the app when a share link is tapped.
class DeepLinkHandler {
  DeepLinkHandler._();

  static StreamSubscription<Uri>? _subscription;

  static Future<void> init() async {
    if (_subscription != null) return;

    try {
      final links = AppLinks();

      // Link that cold-started the app.
      final initial = await links.getInitialLink();
      if (initial != null) _handle(initial);

      // Links received while the app is already running.
      _subscription = links.uriLinkStream.listen(
        _handle,
        onError: (Object error) => debugPrint('DEEP_LINK_ERROR: $error'),
      );
    } catch (error) {
      debugPrint('DEEP_LINK_INIT_FAILED: $error');
    }
  }

  static void _handle(Uri uri) {
    final videoId = ShareLinks.parseVideoId(uri);
    if (videoId == null) return;
    openGlobalVideo(videoId);
  }
}
