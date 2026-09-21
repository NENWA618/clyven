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

    return div(
      classes: 'subtitle-srt-import-panel',
      [
        div(
          classes: 'subtitle-srt-panel-top',
          [
            div(
              classes: 'subtitle-srt-panel-info',
              [
                h3([
                  text('Subtitle file'),
                ]),
                p([
                  text('Import or export subtitles in SRT format'),
                ]),
              ],
            ),
            div(
              classes: 'subtitle-srt-import-actions',
              [
                button(
                  classes:
                      'subtitle-srt-button subtitle-srt-import-button',
                  onClick: controller.previewing || controller.importing
                      ? null
                      : () {
                          controller.pickFile();
                        },
                  [
                    text(
                      controller.previewing
                          ? 'Reading...'
                          : '↑ Import SRT',
                    ),
                  ],
                ),
                button(
                  classes:
                      'subtitle-srt-button subtitle-srt-export-button',
                  onClick: exportController.exporting
                      ? null
                      : () {
                          exportController.exportSrt();
                        },
                  [
                    text(
                      exportController.exporting
                          ? 'Exporting...'
                          : '↓ Export SRT',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        div(
          classes: 'subtitle-srt-script-field',
          [
            label([
              text('Script code'),
            ]),
            input(
              attributes: {
                'type': 'text',
                'value': controller.scriptCode,
                'placeholder': 'script code',
                'autocomplete': 'off',
              },
              events: events<String>(
                onInput: (value) {
                  controller.scriptCode = value;
                  controller.onChanged();
                },
              ),
            ),
            span([
              text(
                'Required for SRT import. The value is stored as an opaque script identifier.',
              ),
            ]),
          ],
        ),

        if (controller.fileName != null)
          div(
            classes: 'subtitle-srt-file',
            [
              span(
                classes: 'subtitle-srt-file-badge',
                [
                  text('SRT'),
                ],
              ),
              div([
                strong([
                  text(controller.fileName!),
                ]),
                span([
                  text('Selected subtitle file'),
                ]),
              ]),
            ],
          ),

        if (controller.previewing)
          div(
            classes: 'subtitle-srt-status',
            [
              text('Checking subtitle file...'),
            ],
          ),

        if (preview != null)
          div(
            classes: 'subtitle-srt-preview',
            [
              div(
                classes: 'subtitle-srt-preview-stat',
                [
                  strong([
                    text('${preview.cueCount}'),
                  ]),
                  span([
                    text('Cues'),
                  ]),
                ],
              ),
              div(
                classes: 'subtitle-srt-preview-stat',
                [
                  strong([
                    text('${preview.errorCount}'),
                  ]),
                  span([
                    text('Errors'),
                  ]),
                ],
              ),
              div(
                classes: preview.canImport
                    ? 'subtitle-srt-ready'
                    : 'subtitle-srt-invalid',
                [
                  text(
                    preview.canImport
                        ? '✓ Ready to import'
                        : '✕ Cannot import',
                  ),
                ],
              ),
            ],
          ),

        if (preview != null && preview.errors.isNotEmpty)
          ul(
            classes: 'subtitle-srt-error-list',
            [
              for (final error in preview.errors)
                li([
                  text(error),
                ]),
            ],
          ),

        if (controller.error != null)
          p(
            classes: 'subtitle-srt-error',
            [
              text(controller.error!),
            ],
          ),

        if (exportController.error != null)
          p(
            classes: 'subtitle-srt-error',
            [
              text(exportController.error!),
            ],
          ),

        if (preview != null)
          div(
            classes: 'subtitle-srt-confirm-actions',
            [
              button(
                classes:
                    'subtitle-srt-button subtitle-srt-cancel-button',
                onClick: controller.importing
                    ? null
                    : () {
                        controller.reset();
                      },
                [
                  text('Cancel'),
                ],
              ),
              button(
                classes:
                    'subtitle-srt-button subtitle-srt-confirm-button',
                onClick: controller.canImport
                    ? () {
                        controller.confirmReplace();
                      }
                    : null,
                [
                  text(
                    controller.importing
                        ? 'Importing...'
                        : 'Confirm Replace',
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}