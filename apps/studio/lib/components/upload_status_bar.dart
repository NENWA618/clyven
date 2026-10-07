import 'package:glyphora_web_l10n/web_l10n.dart';
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
        statusText = context.tr('Uploading · $percent%', '上传中 · $percent%');
      case StudioUploadStage.verifying:
        statusText = context.tr('Upload complete · Verifying', '上传完成 · 校验中');
      case StudioUploadStage.processing:
        statusText = context.tr('Uploaded · Processing video', '已上传 · 视频处理中');
      case StudioUploadStage.completed:
        statusText = context.tr('Upload complete', '上传完成');
      case StudioUploadStage.failed:
        statusText = context.tr('Upload failed', '上传失败');
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