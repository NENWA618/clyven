import 'dart:async';
import 'dart:html' as html;
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'components/subtitle_timeline.dart';
import 'components/subtitle_video_panel.dart';
import 'components/subtitle_create_panel.dart';
import 'subtitle_keyboard_controller.dart';
import 'components/subtitle_side_panel.dart';
import 'subtitle_video_controller.dart';
import 'subtitle_timeline_controller.dart';
import 'subtitle_cue_drag_controller.dart';
import 'components/subtitle_cue_list.dart';
import 'subtitle_cue_service.dart';
import 'subtitle_cue_controller.dart';
import 'subtitle_karaoke_controller.dart';
import 'components/subtitle_karaoke_editor.dart';
import 'subtitle_workspace_service.dart';
import 'subtitle_workspace_controller.dart';
import 'subtitle_navigation_controller.dart';
import 'subtitle_srt_import_controller.dart';
import 'subtitle_srt_export_controller.dart';
import 'components/subtitle_srt_import_panel.dart';

class SubtitleEditorPage extends StatefulComponent {
  const SubtitleEditorPage({
    required this.client,
    required this.videoId,
    required this.languageCode,
    this.scriptCode,
    this.backRoute = '/subtitles',
    this.backLabel = '← Subtitles',
    this.showPublishControls = true,
    super.key,
  });

  final Client client;
  final int videoId;
  final String languageCode;
  final String? scriptCode;
  final String backRoute;
  final String backLabel;
  final bool showPublishControls;

  @override
  State<SubtitleEditorPage> createState() => _SubtitleEditorPageState();
}

class _SubtitleEditorPageState extends State<SubtitleEditorPage> {
  SubtitlePublishStatus? _publishStatus;
  bool _publishStatusRequested = false;
  bool _publishingSubtitle = false;
  String? _publishError;

  Client get client => component.client;

  Video? get video => _workspaceController.video;

  String? get videoUrl => _workspaceController.videoUrl;

  List<SubtitleCueDetail> get cues => _workspaceController.cues;

  bool get loading => _workspaceController.loading;

  String? get error => _workspaceController.error;

  int currentVideoTimeMs = 0;
  int? selectedCueId;
  int? activeCueId;
  double timelineZoom = 0.0;
  bool showCueList = false;
  late final SubtitleCueService _cueService;
  late final SubtitleWorkspaceService _workspaceService;
  late final SubtitleWorkspaceController _workspaceController;
  late final SubtitleCueController _cueController;
  late final SubtitleKaraokeController _karaokeController;
  late final SubtitleVideoController _videoController;
  late final SubtitleTimelineController _timelineController;
  late final SubtitleCueDragController _cueDragController;
  late final SubtitleNavigationController _navigationController;
  late final SubtitleKeyboardController _keyboardController;
  late final SubtitleSrtImportController _srtImportController;
  late final SubtitleSrtExportController _srtExportController;
  @override
  void initState() {
    super.initState();

    _cueService = SubtitleCueService(
      client: client,
      scriptCode: component.scriptCode,

      onDraftChanged: () {
        _refreshPublishStatus();
      },
    );

    _workspaceService = SubtitleWorkspaceService(
      client: client,
      cueService: _cueService,
    );

    _workspaceController = SubtitleWorkspaceController(
      service: _workspaceService,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _srtImportController = SubtitleSrtImportController(
      client: client,
      videoId: component.videoId,
      languageCode: component.languageCode,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
      onImported: () async {
        if (!mounted) {
          return;
        }

        setState(() {
          selectedCueId = null;
          activeCueId = null;
        });

        await _workspaceController.load(
          videoId: component.videoId,
          languageCode: component.languageCode,
          scriptCode: component.scriptCode,
        );
      },
    );
    _srtImportController.scriptCode = component.scriptCode ?? '';

    _srtExportController = SubtitleSrtExportController(
      client: client,
      videoId: component.videoId,
      languageCode: component.languageCode,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _cueController = SubtitleCueController(
      service: _cueService,
      getCues: () => _workspaceController.cues,
      isLoggedIn: () => client.auth.isAuthenticated,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _karaokeController = SubtitleKaraokeController(
      service: _cueService,
      isLoggedIn: () => client.auth.isAuthenticated,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _videoController = SubtitleVideoController(
      onSeek: (milliseconds) {
        int? currentCueId;

        for (final detail in cues) {
          if (milliseconds >= detail.cue.startMs &&
              milliseconds < detail.cue.endMs) {
            currentCueId = detail.cue.id;
            break;
          }
        }

        if (!mounted) {
          return;
        }

        setState(() {
          currentVideoTimeMs = milliseconds;
          activeCueId = currentCueId;
        });
      },
    );

    _timelineController = SubtitleTimelineController(
      getDurationMs: () {
        return (video?.durationSeconds ?? 0) * 1000;
      },
      onSeek: (milliseconds) {
        _videoController.seekTo(milliseconds);
      },
    );

    _cueDragController = SubtitleCueDragController(
      getDurationMs: () {
        return (video?.durationSeconds ?? 0) * 1000;
      },
      onSelectCue: (cueId) {
        setState(() {
          selectedCueId = cueId;
          _cueController.timingErrors.remove(cueId);
        });
      },
      onPreviewChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
      onCommitTiming: _cueController.commitDraggedCueTiming,
    );

    _navigationController = SubtitleNavigationController(
      getCues: () => cues,
      getSelectedCueId: () => selectedCueId,
      getCurrentVideoTimeMs: () => currentVideoTimeMs,
      onSelectCue: (cueId) {
        if (!mounted) {
          return;
        }

        setState(() {
          selectedCueId = cueId;
        });
      },
      onSeek: (milliseconds) {
        _videoController.seekTo(milliseconds);
      },
    );

    _keyboardController = SubtitleKeyboardController(
      onTogglePlayback: () {
        _videoController.togglePlayback();
      },
      onSeekBackward: () {
        _videoController.stopReversePlayback();

        final durationMs = (video?.durationSeconds ?? 0) * 1000;

        final targetMs = (currentVideoTimeMs - 1000)
            .clamp(0, durationMs)
            .toInt();

        _videoController.seekTo(targetMs);
      },
      onSeekForward: () {
        _videoController.stopReversePlayback();

        final durationMs = (video?.durationSeconds ?? 0) * 1000;

        final targetMs = (currentVideoTimeMs + 1000)
            .clamp(0, durationMs)
            .toInt();

        _videoController.seekTo(targetMs);
      },
      onJumpPreviousCue: () {
        _videoController.stopReversePlayback();
        _navigationController.jumpToAdjacentCue(-1);
      },
      onJumpNextCue: () {
        _videoController.stopReversePlayback();
        _navigationController.jumpToAdjacentCue(1);
      },
      onReversePlayback: () {
        _videoController.startReversePlayback();
      },
      onPause: () {
        _videoController.pause();
      },
      onForwardPlayback: () {
        _videoController.playForward();
      },
      onNudgeBackward: () {
        final cueId = selectedCueId;

        if (cueId == null) {
          return;
        }

        _cueController.nudgeCue(
          cueId: cueId,
          deltaMs: -100,
          durationMs: (video?.durationSeconds ?? 0) * 1000,
        );
      },
      onNudgeForward: () {
        final cueId = selectedCueId;

        if (cueId == null) {
          return;
        }

        _cueController.nudgeCue(
          cueId: cueId,
          deltaMs: 100,
          durationMs: (video?.durationSeconds ?? 0) * 1000,
        );
      },
      onSetStart: () {
        _cueController.useCurrentTimeAsStart(currentVideoTimeMs);
      },
      onSetEnd: () {
        _cueController.useCurrentTimeAsEnd(currentVideoTimeMs);
      },
    );

    _keyboardController.start();

    _workspaceController.load(
      videoId: component.videoId,
      languageCode: component.languageCode,
      scriptCode: component.scriptCode,
    );
  }

  @override
  void dispose() {
    _keyboardController.dispose();
    _cueDragController.dispose();
    _videoController.dispose();

    super.dispose();
  }

  Future<void> _deleteCue(SubtitleCueDetail detail) async {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final confirmed = html.window.confirm('确定要删除这条字幕吗？删除后无法恢复。');

    if (!confirmed) {
      return;
    }

    await _cueController.deleteCue(
      detail: detail,
      videoId: component.videoId,
      languageCode: component.languageCode,
    );
  }

  void _useCurrentTimeAsStart() {
    final currentMs = _videoController.currentTimeMs();

    if (currentMs == null) {
      _cueController.createCueError = '无法读取当前视频时间';

      setState(() {});
      return;
    }

    _cueController.useCurrentTimeAsStart(currentMs);
  }

  void _useCurrentTimeAsEnd() {
    final currentMs = _videoController.currentTimeMs();

    if (currentMs == null) {
      _cueController.createCueError = '无法读取当前视频时间';

      setState(() {});
      return;
    }

    _cueController.useCurrentTimeAsEnd(currentMs);
  }

  SubtitleCueDetail? _selectedCueDetail() {
    final cueId = selectedCueId;

    if (cueId == null) {
      return null;
    }

    for (final detail in cues) {
      if (detail.cue.id == cueId) {
        return detail;
      }
    }

    return null;
  }

  String _selectedCueText(SubtitleCueDetail detail) {
    final cueId = detail.cue.id;

    if (cueId != null) {
      final edited = _cueController.editedTexts[cueId];

      if (edited != null && edited.trim().isNotEmpty) {
        return edited;
      }
    }

    return detail.cue.text;
  }

  SubtitleCueDetail? _activeCueDetail() {
    for (final detail in cues) {
      if (detail.cue.id == activeCueId) {
        return detail;
      }
    }

    return null;
  }

  Future<void> _refreshPublishStatus() async {
    try {
      final status = await _cueService.getPublishStatus(
        videoId: component.videoId,
        languageCode: component.languageCode,
      );

      setState(() {
        _publishStatus = status;
        _publishError = null;
      });
    } catch (e) {
      setState(() {
        _publishError = e.toString();
      });
    }
  }

  Future<void> _publishSubtitle() async {
    if (_publishingSubtitle) {
      return;
    }

    setState(() {
      _publishingSubtitle = true;
      _publishError = null;
    });

    try {
      final status = await _cueService.publish(
        videoId: component.videoId,
        languageCode: component.languageCode,
      );

      setState(() {
        _publishStatus = status;
        _publishingSubtitle = false;
      });
    } catch (e) {
      setState(() {
        _publishingSubtitle = false;
        _publishError = e.toString();
      });
    }
  }

  Component _buildPublishControls() {
    final status = _publishStatus;

    final stateText = status == null
        ? '发布状态…'
        : !status.hasPublishedVersion
        ? '未发布'
        : status.hasUnpublishedChanges
        ? '有未发布更改'
        : '已发布';

    final stateClass = status == null
        ? ' is-loading'
        : !status.hasPublishedVersion
        ? ' is-draft'
        : status.hasUnpublishedChanges
        ? ' is-dirty'
        : ' is-published';

    return div(classes: 'subtitle-publish-controls', [
      span(classes: 'subtitle-publish-state$stateClass', [.text(stateText)]),
      button(
        type: ButtonType.button,
        classes: 'subtitle-publish-button',
        attributes: _publishingSubtitle ? {'disabled': 'disabled'} : null,
        onClick: _publishingSubtitle
            ? null
            : () {
                _publishSubtitle();
              },
        [.text(_publishingSubtitle ? '发布中…' : '发布字幕')],
      ),
      if (_publishError != null)
        span(classes: 'subtitle-publish-error', [.text(_publishError!)]),
    ]);
  }

  String? _activeCueText() {
    for (final detail in cues) {
      if (detail.cue.id == activeCueId) {
        final cueId = detail.cue.id;

        if (cueId != null && _cueController.editedTexts.containsKey(cueId)) {
          return _cueController.editedTexts[cueId];
        }

        return detail.cue.text;
      }
    }

    return null;
  }

  SubtitleCueDetail? _selectedCueForQuickEdit() {
    final wantedId = selectedCueId ?? activeCueId;

    if (wantedId == null) {
      return null;
    }

    for (final detail in cues) {
      if (detail.cue.id == wantedId) {
        return detail;
      }
    }

    return null;
  }

  String _editableCueText(SubtitleCueDetail detail) {
    final cueId = detail.cue.id;

    if (cueId != null && _cueController.editedTexts.containsKey(cueId)) {
      return _cueController.editedTexts[cueId] ?? '';
    }

    return detail.cue.text;
  }

  Component _buildQuickSubtitleEditor() {
    final detail = _selectedCueForQuickEdit();

    if (detail == null || detail.cue.id == null) {
      return div(classes: 'subtitle-quick-editor is-empty', [
        div(classes: 'subtitle-quick-editor-title', [.text('字幕快速编辑')]),
        p([
          .text(
            '点击时间轴上的字幕片段后，'
            '可以直接在这里输入字幕。',
          ),
        ]),
      ]);
    }

    final cueId = detail.cue.id!;
    final isSaving = _cueController.savingCueIds.contains(cueId);
    final hasUnsavedChanges = _cueController.editedTexts.containsKey(cueId);
    final text = _editableCueText(detail);

    return div(classes: 'subtitle-quick-editor', [
      div(classes: 'subtitle-quick-editor-header', [
        div([
          div(classes: 'subtitle-quick-editor-title', [.text('字幕快速编辑')]),
          span(classes: 'subtitle-quick-editor-time', [
            .text(
              '${detail.cue.startMs}ms → '
              '${detail.cue.endMs}ms',
            ),
          ]),
        ]),
        span(
          classes:
              'subtitle-save-status'
              '${isSaving
                  ? ' is-saving'
                  : hasUnsavedChanges
                  ? ' is-unsaved'
                  : ' is-saved'}',
          [
            .text(
              isSaving
                  ? '保存中…'
                  : hasUnsavedChanges
                  ? '未保存'
                  : '草稿已保存',
            ),
          ],
        ),
        button(
          type: ButtonType.button,
          classes: 'subtitle-save-button',
          attributes: (isSaving || !hasUnsavedChanges)
              ? {'disabled': 'disabled'}
              : null,
          onClick: isSaving
              ? null
              : () {
                  _cueController.saveCue(detail);
                },
          [.text(isSaving ? '保存中…' : '保存草稿')],
        ),
      ]),
      textarea(
        classes: 'subtitle-quick-editor-textarea',
        key: ValueKey('subtitle-quick-editor-$cueId'),
        [.text(text)],
        onInput: (value) {
          _cueController.editedTexts[cueId] = value;
          setState(() {});
        },
      ),
      if (_cueController.saveErrors[cueId] != null)
        span(classes: 'subtitle-save-error', [
          .text(_cueController.saveErrors[cueId]!),
        ]),
    ]);
  }

  @override
  Component build(BuildContext context) {
    // CLYVEN_INITIAL_PUBLISH_STATUS
    if (!_publishStatusRequested) {
      _publishStatusRequested = true;
      _refreshPublishStatus();
    }

    final selectedKaraokeCue = _selectedCueDetail();

    return div(classes: 'subtitle-editor-page', [
      div(classes: 'subtitle-editor-toolbar', [
        Link(
          to: component.backRoute,
          child: span(classes: 'subtitle-back-link', [
            .text(component.backLabel),
          ]),
        ),
        div(classes: 'subtitle-editor-toolbar-actions', [
          if (component.showPublishControls) _buildPublishControls(),
          span(classes: 'subtitle-language-badge', [
            .text(component.languageCode.toUpperCase()),
          ]),
          if (component.scriptCode != null)
            span(classes: 'subtitle-script-badge', [
              .text(component.scriptCode!),
            ]),
        ]),
      ]),

      if (loading)
        div(classes: 'preview-loading', [.text('正在载入字幕工作台...')])
      else if (error != null)
        div(classes: 'preview-error', [.text(error!)])
      else ...[
        div(classes: 'subtitle-editor-heading', [
          div([
            h1([.text(video?.title ?? 'Video #${component.videoId}')]),
            p([
              .text(
                'Video #${component.videoId} · '
                '${component.languageCode.toUpperCase()}'
                '${component.scriptCode == null ? '' : ' · ${component.scriptCode}'}',
              ),
            ]),
          ]),
          div(classes: 'subtitle-cue-count', [.text('${cues.length} cues')]),
        ]),

        SubtitleSrtImportPanel(
          controller: _srtImportController,
          exportController: _srtExportController,
        ),

        if (videoUrl != null)
          SubtitleVideoPanel(
            videoUrl: videoUrl!,
            captionText: _activeCueText(),
            captionCueStartMs: _activeCueDetail()?.cue.startMs,
            karaokeSegments:
                _activeCueDetail()?.karaokeSegments ??
                const <SubtitleKaraokeSegment>[],
            onTimeUpdate: () {
              final currentMs = _videoController.currentTimeMs();

              if (currentMs == null) {
                return;
              }

              int? currentCueId;

              for (final detail in cues) {
                if (currentMs >= detail.cue.startMs &&
                    currentMs < detail.cue.endMs) {
                  currentCueId = detail.cue.id;
                  break;
                }
              }

              setState(() {
                currentVideoTimeMs = currentMs;
                activeCueId = currentCueId;
              });

              _videoController.keepTimelinePlayheadVisible(
                milliseconds: currentMs,
                durationMs: (video?.durationSeconds ?? 0) * 1000,
              );
            },
          ),

        SubtitleTimeline(
          cues: cues,
          currentVideoTimeMs: currentVideoTimeMs,
          selectedCueId: selectedCueId,
          activeCueId: activeCueId,
          timelineZoom: timelineZoom,
          durationMs: (video?.durationSeconds ?? 0) * 1000,
          getCueText: _editableCueText,
          onCueTextChanged: (detail, value) {
            final cueId = detail.cue.id;

            if (cueId == null) {
              return;
            }

            _cueController.editedTexts[cueId] = value;
            setState(() {});
          },
          onCueTextSave: (detail) {
            _cueController.saveCue(detail);
          },
          onZoomChanged: (value) {
            setState(() {
              timelineZoom = value;
            });
          },
          onTimelineClick: (event) {
            _timelineController.seekFromTimelineClick(event);
          },
          onCueMouseDown: (detail) {
            _videoController.seekTo(detail.cue.startMs);
            _cueDragController.beginMoveCue(detail);
          },
          onCueClick: (detail) {
            final cueId = detail.cue.id;

            if (cueId == null) {
              return;
            }

            setState(() {
              selectedCueId = cueId;
            });

            _videoController.seekTo(detail.cue.startMs);

            _videoController.centerTimelineAt(
              milliseconds: detail.cue.startMs,
              durationMs: (video?.durationSeconds ?? 0) * 1000,
            );
          },
          onResizeStart: (detail, resizeStart) {
            _cueDragController.beginResizeCue(detail, resizeStart: resizeStart);
          },
          onPlayheadMouseDown: (event) {
            _timelineController.beginScrubPlayhead(event);
          },
        ),
        _buildQuickSubtitleEditor(),

        if (selectedKaraokeCue != null)
          SubtitleKaraokeEditor(
            detail: selectedKaraokeCue,
            drafts: _karaokeController.draftsFor(selectedKaraokeCue),
            currentVideoTimeMs: currentVideoTimeMs,
            saving:
                selectedKaraokeCue.cue.id != null &&
                _karaokeController.savingCueIds.contains(
                  selectedKaraokeCue.cue.id,
                ),
            error: selectedKaraokeCue.cue.id == null
                ? null
                : _karaokeController.errors[selectedKaraokeCue.cue.id],
            onGenerateFromSubtitle: () {
              _karaokeController.initializeFromSubtitle(
                selectedKaraokeCue,
                _selectedCueText(selectedKaraokeCue),
              );
            },
            onClear: () {
              _karaokeController.clear(selectedKaraokeCue);
            },
            onAdd: () {
              _karaokeController.addSegment(selectedKaraokeCue);
            },
            onDelete: (index) {
              _karaokeController.removeSegment(selectedKaraokeCue, index);
            },
            onTextChanged: (index, value) {
              _karaokeController.updateText(selectedKaraokeCue, index, value);
            },
            onStartChanged: (index, value) {
              _karaokeController.updateStart(selectedKaraokeCue, index, value);
            },
            onEndChanged: (index, value) {
              _karaokeController.updateEnd(selectedKaraokeCue, index, value);
            },
            onUseCurrentStart: (index) {
              final currentMs =
                  _videoController.currentTimeMs() ?? currentVideoTimeMs;

              _karaokeController.useCurrentTimeAsStart(
                selectedKaraokeCue,
                index,
                currentMs,
              );
            },
            onUseCurrentEnd: (index) {
              final currentMs =
                  _videoController.currentTimeMs() ?? currentVideoTimeMs;

              _karaokeController.useCurrentTimeAsEnd(
                selectedKaraokeCue,
                index,
                currentMs,
              );
            },
            onSeekVideo: (milliseconds) {
              _videoController.seekTo(milliseconds);
            },
            onSave: () {
              _karaokeController.save(selectedKaraokeCue);
            },
          ),

        SubtitleCreatePanel(
          startTime: _cueController.newCueStart,
          endTime: _cueController.newCueEnd,
          subtitleText: _cueController.newCueText,
          creating: _cueController.creatingCue,
          error: _cueController.createCueError,
          onStartChanged: (value) {
            _cueController.newCueStart = value;
          },
          onEndChanged: (value) {
            _cueController.newCueEnd = value;
          },
          onTextChanged: (value) {
            _cueController.newCueText = value;
          },
          onUseCurrentStart: () {
            _useCurrentTimeAsStart();
          },
          onUseCurrentEnd: () {
            _useCurrentTimeAsEnd();
          },
          onCreate: () {
            _cueController.createCue(
              videoId: component.videoId,
              languageCode: component.languageCode,
            );
          },
        ),

        button(
          type: ButtonType.button,
          classes: 'subtitle-cue-list-toggle',
          onClick: () {
            setState(() {
              showCueList = !showCueList;
            });
          },
          [
            .text(
              showCueList
                  ? '▾ 隐藏字幕列表（${cues.length}）'
                  : '▸ 字幕列表（${cues.length}）',
            ),
          ],
        ),

        if (showCueList)
          div(classes: 'subtitle-editor-layout', [
            SubtitleCueList(
              cues: cues,
              selectedCueId: selectedCueId,
              activeCueId: activeCueId,
              editedTexts: _cueController.editedTexts,
              editedStartTimes: _cueController.editedStartTimes,
              editedEndTimes: _cueController.editedEndTimes,
              savingCueIds: _cueController.savingCueIds,
              savingTimingCueIds: _cueController.savingTimingCueIds,
              deletingCueIds: _cueController.deletingCueIds,
              saveErrors: _cueController.saveErrors,
              timingErrors: _cueController.timingErrors,
              deleteErrors: _cueController.deleteErrors,
              onRowClick: (detail) {
                final cueId = detail.cue.id;

                if (cueId == null) {
                  return;
                }

                setState(() {
                  selectedCueId = cueId;
                });

                _videoController.seekTo(detail.cue.startMs);

                _videoController.centerTimelineAt(
                  milliseconds: detail.cue.startMs,
                  durationMs: (video?.durationSeconds ?? 0) * 1000,
                );
              },
              onStartChanged: (cueId, value) {
                _cueController.editedStartTimes[cueId] = value;
              },
              onEndChanged: (cueId, value) {
                _cueController.editedEndTimes[cueId] = value;
              },
              onSaveTiming: (detail) {
                _cueController.saveTiming(detail);
              },
              onTextChanged: (cueId, value) {
                _cueController.editedTexts[cueId] = value;
                setState(() {});
              },
              onSaveText: (detail) {
                _cueController.saveCue(detail);
              },
              onDelete: (detail) {
                _deleteCue(detail);
              },
            ),
            SubtitleSidePanel(
              languageCode: component.languageCode,
              scriptCode: component.scriptCode,
              cueCount: cues.length,
            ),
          ]),
      ],
    ]);
  }
}
