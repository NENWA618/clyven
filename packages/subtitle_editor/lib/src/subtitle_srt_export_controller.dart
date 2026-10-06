import 'dart:html' as html;

import 'package:glyphora_backend_client/backend_client.dart';

class SubtitleSrtExportController {
  SubtitleSrtExportController({
    required this.client,
    required this.videoId,
    required this.languageCode,
    required this.onChanged,
  });

  final Client client;
  final int videoId;
  final String languageCode;

  final void Function() onChanged;

  bool exporting = false;
  String? error;

  Future<void> exportSrt() async {
    if (exporting) {
      return;
    }

    exporting = true;
    error = null;
    onChanged();

    try {
      final content = await client.subtitle.exportSrt(
        videoId: videoId,
        languageCode: languageCode,
      );

      final blob = html.Blob([
        '\uFEFF$content',
      ], 'application/x-subrip;charset=utf-8');

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..download = 'glyphora-$videoId-$languageCode.srt'
        ..style.display = 'none';

      html.document.body?.append(anchor);

      anchor.click();
      anchor.remove();

      html.Url.revokeObjectUrl(url);

      exporting = false;
      onChanged();
    } catch (e) {
      exporting = false;
      error = e.toString();
      onChanged();
    }
  }
}
