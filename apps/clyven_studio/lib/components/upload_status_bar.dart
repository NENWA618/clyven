import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/upload_manager.dart';

class UploadStatusBar extends StatefulComponent {
  const UploadStatusBar({super.key});

  @override
  State<UploadStatusBar> createState() => _UploadStatusBarState();
}

class _UploadStatusBarState extends State<UploadStatusBar> {
  @override
  void initState() {
    super.initState();
    studioUploadManager.addListener(_handleUpdate);
  }

  @override
  void dispose() {
    studioUploadManager.removeListener(_handleUpdate);
    super.dispose();
  }

  void _handleUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Component build(BuildContext context) {
    final task = studioUploadManager.task;

    if (task == null) {
      return div(classes: 'studio-upload-global hidden', []);
    }

    final percent = (task.progress * 100).round();

    String statusText;

    switch (task.stage) {
      case StudioUploadStage.uploading:
        statusText = 'Uploading · $percent%';
      case StudioUploadStage.verifying:
        statusText = 'Upload complete · Verifying';
      case StudioUploadStage.processing:
        statusText = 'Uploaded · Processing video';
      case StudioUploadStage.completed:
        statusText = 'Upload complete';
      case StudioUploadStage.failed:
        statusText = 'Upload failed';
    }

    return div(
      classes:
          'studio-upload-global ${task.stage.name}',
      [
        div(classes: 'studio-upload-global-main', [
          div(classes: 'studio-upload-global-title', [
            .text(task.fileName),
          ]),
          div(classes: 'studio-upload-global-status', [
            .text(statusText),
          ]),
          if (task.stage == StudioUploadStage.uploading)
            div(classes: 'studio-upload-global-track', [
              div(
                classes: 'studio-upload-global-progress',
                attributes: {
                  'style': 'width: $percent%;',
                },
                [],
              ),
            ]),
          if (task.error != null)
            div(classes: 'studio-upload-global-error', [
              .text(task.error!),
            ]),
        ]),
        if (!task.isActive)
          button(
            classes: 'studio-upload-global-close',
            onClick: studioUploadManager.clearFinished,
            [.text('×')],
          ),
      ],
    );
  }
}