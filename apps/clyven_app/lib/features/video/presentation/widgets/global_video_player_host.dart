import 'package:flutter/material.dart';

import '../controllers/global_video_player_controller.dart';
import '../pages/video_detail_page.dart';

class GlobalVideoPlayerHost extends StatefulWidget {
  final Widget child;

  const GlobalVideoPlayerHost({super.key, required this.child});

  @override
  State<GlobalVideoPlayerHost> createState() {
    return _GlobalVideoPlayerHostState();
  }
}

class _GlobalVideoPlayerHostState extends State<GlobalVideoPlayerHost>
    with WidgetsBindingObserver {
  final GlobalVideoPlayerController _controller = globalVideoPlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    final playerState = _controller.state;

    if (playerState.hasVideo && playerState.expanded) {
      _controller.minimize();
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (overlayContext) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return _buildLayer(context);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLayer(BuildContext context) {
    final playerState = _controller.state;
    final mediaQuery = MediaQuery.of(context);

    final miniBottom = mediaQuery.padding.bottom + 92.0;

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (playerState.hasVideo)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            left: playerState.expanded ? 0 : 10,
            right: playerState.expanded ? 0 : 10,
            top: playerState.expanded ? 0 : null,
            bottom: playerState.expanded ? 0 : miniBottom,
            height: playerState.expanded ? null : 76,
            child: Material(
              color: Colors.transparent,
              elevation: playerState.expanded ? 0 : 18,
              borderRadius: playerState.expanded
                  ? BorderRadius.zero
                  : BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: VideoDetailPage(
                key: ValueKey('global-video-${playerState.videoId}'),
                videoId: playerState.videoId!,
                hosted: true,
                miniMode: !playerState.expanded,
                onMinimize: _controller.minimize,
                onExpand: _controller.expand,
                onClose: _controller.close,
              ),
            ),
          ),
      ],
    );
  }
}
