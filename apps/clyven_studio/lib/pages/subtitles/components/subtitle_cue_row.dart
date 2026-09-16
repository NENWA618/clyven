import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleCueRow extends StatelessComponent {
  const SubtitleCueRow({
    required this.number,
    required this.detail,
    required this.selected,
    required this.active,
    required this.startText,
    required this.endText,
    required this.text,
    required this.savingTiming,
    required this.savingText,
    required this.deleting,
    required this.timingError,
    required this.saveError,
    required this.deleteError,
    required this.onRowClick,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onSaveTiming,
    required this.onTextChanged,
    required this.onSaveText,
    required this.onDelete,
    super.key,
  });

  final int number;
  final SubtitleCueDetail detail;

  final bool selected;
  final bool active;

  final String startText;
  final String endText;
  final String text;

  final bool savingTiming;
  final bool savingText;
  final bool deleting;

  final String? timingError;
  final String? saveError;
  final String? deleteError;

  final void Function() onRowClick;

  final void Function(String value) onStartChanged;
  final void Function(String value) onEndChanged;
  final void Function() onSaveTiming;

  final void Function(String value) onTextChanged;
  final void Function() onSaveText;
  final void Function() onDelete;

  String _formatTime(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final millis = milliseconds % 1000;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }

  @override
  Component build(BuildContext context) {
    final cueId = detail.cue.id;

    return div(
      id: cueId == null ? null : 'subtitle-row-$cueId',
      classes:
          'subtitle-editor-row'
          '${selected ? ' is-selected' : ''}'
          '${active ? ' is-active' : ''}',
      events: {
        'click': (event) {
          final target = event.target;

          if (target is html.InputElement ||
              target is html.TextAreaElement ||
              target is html.ButtonElement) {
            return;
          }

          onRowClick();
        },
      },
      [
        div(
          classes: 'subtitle-editor-time',
          [
            span(
              classes: 'subtitle-row-number',
              [
                .text('$number'),
              ],
            ),
            if (cueId != null)
              div(
                classes: 'subtitle-timing-editor',
                [
                  label(
                    [
                      span([
                        .text('Start'),
                      ]),
                      input<String>(
                        attributes: {
                          'value': startText,
                          'placeholder': '00:00.000',
                        },
                        events: events<String>(
                          onInput: onStartChanged,
                        ),
                      ),
                    ],
                  ),
                  span(
                    classes: 'subtitle-time-arrow',
                    [
                      .text('→'),
                    ],
                  ),
                  label(
                    [
                      span([
                        .text('End'),
                      ]),
                      input<String>(
                        attributes: {
                          'value': endText,
                          'placeholder': '00:00.000',
                        },
                        events: events<String>(
                          onInput: onEndChanged,
                        ),
                      ),
                    ],
                  ),
                  button(
                    classes: 'subtitle-timing-save-button',
                    attributes: savingTiming
                        ? {
                            'disabled': 'disabled',
                          }
                        : null,
                    onClick: savingTiming
                        ? null
                        : () {
                            onSaveTiming();
                          },
                    [
                      .text(
                        savingTiming ? 'Saving...' : 'Save time',
                      ),
                    ],
                  ),
                  if (timingError != null)
                    span(
                      classes: 'subtitle-save-error',
                      [
                        .text(timingError!),
                      ],
                    ),
                ],
              )
            else
              span(
                [
                  .text(
                    '${_formatTime(detail.cue.startMs)} → '
                    '${_formatTime(detail.cue.endMs)}',
                  ),
                ],
              ),
          ],
        ),
        div(
          classes: 'subtitle-editor-text',
          [
            textarea(
              [
                .text(text),
              ],
              onInput: onTextChanged,
            ),
            if (cueId != null)
              div(
                classes: 'subtitle-editor-actions',
                [
                  button(
                    classes: 'subtitle-save-button',
                    attributes: savingText
                        ? {
                            'disabled': 'disabled',
                          }
                        : null,
                    onClick: savingText
                        ? null
                        : () {
                            onSaveText();
                          },
                    [
                      .text(
                        savingText ? 'Saving...' : 'Save',
                      ),
                    ],
                  ),
                  button(
                    classes: 'subtitle-delete-button',
                    attributes: deleting
                        ? {
                            'disabled': 'disabled',
                          }
                        : null,
                    onClick: deleting
                        ? null
                        : () {
                            onDelete();
                          },
                    [
                      .text(
                        deleting ? 'Deleting...' : 'Delete',
                      ),
                    ],
                  ),
                  if (saveError != null)
                    span(
                      classes: 'subtitle-save-error',
                      [
                        .text(saveError!),
                      ],
                    ),
                  if (deleteError != null)
                    span(
                      classes: 'subtitle-save-error',
                      [
                        .text(deleteError!),
                      ],
                    ),
                ],
              ),
          ],
        ),
        div(
          classes: 'subtitle-editor-meta',
          [
            span([
              .text('${detail.tokens.length} tokens'),
            ]),
            span([
              .text('${detail.phrases.length} phrases'),
            ]),
          ],
        ),
      ],
    );
  }
}