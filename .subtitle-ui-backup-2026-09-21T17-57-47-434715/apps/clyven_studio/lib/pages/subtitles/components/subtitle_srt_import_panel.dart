import 'package:glyphora_language_core/glyphora_language_core.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../subtitle_srt_export_controller.dart';
import '../subtitle_srt_import_controller.dart';

class SubtitleSrtImportPanel extends StatelessComponent {
  const SubtitleSrtImportPanel({
    required this.controller,
    required this.exportController,
    super.key,
  });

  final SubtitleSrtImportController controller;
  final SubtitleSrtExportController exportController;

  @override
  Component build(BuildContext context) {
    final preview = controller.preview;
    final script = controller.scriptCode.trim().isEmpty
        ? null
        : ScriptConfig.findByCode(controller.scriptCode.trim());

    return div(
      classes: 'subtitle-srt-import-panel subtitle-srt-v2',
      [
        div(classes: 'subtitle-srt-panel-top', [
          div(classes: 'subtitle-srt-panel-info', [
            span(classes: 'subtitle-tool-kicker', [.text('FILE TOOLS')]),
            h3([.text('SRT')]),
            p([.text('导入当前文字轨，或导出当前主字幕时间轴。')]),
          ]),
          div(classes: 'subtitle-srt-import-actions', [
            if (script != null)
              span(classes: 'subtitle-srt-script-badge', [
                .text('${script.nameOf('zh')} · ${script.code}'),
              ]),
            button(
              classes: 'subtitle-srt-button subtitle-srt-import-button',
              onClick: controller.previewing || controller.importing
                  ? null
                  : () => controller.pickFile(),
              [.text(controller.previewing ? '读取中…' : '↑ 导入 SRT')],
            ),
            button(
              classes: 'subtitle-srt-button subtitle-srt-export-button',
              onClick: exportController.exporting
                  ? null
                  : () => exportController.exportSrt(),
              [.text(exportController.exporting ? '导出中…' : '↓ 导出 SRT')],
            ),
          ]),
        ]),

        if (script == null)
          div(classes: 'subtitle-srt-script-warning', [
            .text('当前轨道没有选择文字系统，因此不能进行新的 SRT 导入。请从字幕入口重新选择文字。'),
          ]),

        if (controller.fileName != null)
          div(classes: 'subtitle-srt-file', [
            span(classes: 'subtitle-srt-file-badge', [.text('SRT')]),
            div([
              strong([.text(controller.fileName!)]),
              span([.text('已选择字幕文件')]),
            ]),
          ]),

        if (controller.previewing)
          div(classes: 'subtitle-srt-status', [.text('正在检查字幕文件…')]),

        if (preview != null)
          div(classes: 'subtitle-srt-preview', [
            div(classes: 'subtitle-srt-preview-stat', [
              strong([.text('${preview.cueCount}')]),
              span([.text('Cues')]),
            ]),
            div(classes: 'subtitle-srt-preview-stat', [
              strong([.text('${preview.errorCount}')]),
              span([.text('Errors')]),
            ]),
            div(
              classes: preview.canImport
                  ? 'subtitle-srt-ready'
                  : 'subtitle-srt-invalid',
              [
                .text(preview.canImport ? '✓ 可导入' : '✕ 无法导入'),
              ],
            ),
          ]),

        if (preview != null && preview.errors.isNotEmpty)
          ul(classes: 'subtitle-srt-error-list', [
            for (final error in preview.errors) li([.text(error)]),
          ]),

        if (controller.error != null)
          p(classes: 'subtitle-srt-error', [.text(controller.error!)]),
        if (exportController.error != null)
          p(classes: 'subtitle-srt-error', [.text(exportController.error!)]),

        if (preview != null)
          div(classes: 'subtitle-srt-confirm-actions', [
            button(
              classes: 'subtitle-srt-button subtitle-srt-cancel-button',
              onClick: controller.importing ? null : () => controller.reset(),
              [.text('取消')],
            ),
            button(
              classes: 'subtitle-srt-button subtitle-srt-confirm-button',
              onClick: controller.canImport
                  ? () => controller.confirmReplace()
                  : null,
              [.text(controller.importing ? '导入中…' : '确认替换')],
            ),
          ]),
      ],
    );
  }
}
