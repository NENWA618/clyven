import 'dart:async';
import 'dart:html' as html;
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'components/subtitle_timeline.dart';
import '../../services/studio_client.dart';
import 'components/subtitle_video_panel.dart';
import 'components/subtitle_create_panel.dart';
import 'subtitle_keyboard_controller.dart';
import 'components/subtitle_login_panel.dart';
import 'components/subtitle_side_panel.dart';
import 'subtitle_video_controller.dart';
import 'subtitle_timeline_controller.dart';
import 'subtitle_cue_drag_controller.dart';
import 'components/subtitle_cue_list.dart';
import 'subtitle_cue_service.dart';
import 'subtitle_cue_controller.dart';
import 'subtitle_auth_controller.dart';
import 'subtitle_workspace_service.dart';
import 'subtitle_workspace_controller.dart';
import 'subtitle_navigation_controller.dart';
import 'subtitle_srt_import_controller.dart';
import 'subtitle_srt_export_controller.dart';
import 'components/subtitle_srt_import_panel.dart';

class SubtitleEditorPage extends StatefulComponent {
  const SubtitleEditorPage({
    required this.videoId,
    required this.languageCode,
    super.key,
  });

  final int videoId;
  final String languageCode;

  @override
  State<SubtitleEditorPage> createState() => _SubtitleEditorPageState();
}

class _SubtitleEditorPageState extends State<SubtitleEditorPage> {
  final client = studioClient;

  Video? get video => _workspaceController.video;

  String? get videoUrl => _workspaceController.videoUrl;

  List<SubtitleCueDetail> get cues => _workspaceController.cues;

  bool get loading => _workspaceController.loading;

  String? get error => _workspaceController.error;

  int currentVideoTimeMs = 0;
  int? selectedCueId;
  int? activeCueId;
  double timelineZoom = 1.0;
  late final SubtitleAuthController _authController;
  late final SubtitleCueService _cueService;
  late final SubtitleWorkspaceService _workspaceService;
  late final SubtitleWorkspaceController _workspaceController;
  late final SubtitleCueController _cueController;
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

    _authController = SubtitleAuthController(
      client: client,
      onChanged: () {
        if (!mounted) {
          return;
        }

        setState(() {});
      },
    );

    _cueService = SubtitleCueService(
      client: client,
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
        );
      },
    );

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
      isLoggedIn: () => _authController.loggedIn,
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
          if (milliseconds >= detail.cue.startMs && milliseconds < detail.cue.endMs) {
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
            .clamp(
              0,
              durationMs,
            )
            .toInt();

        _videoController.seekTo(targetMs);
      },
      onSeekForward: () {
        _videoController.stopReversePlayback();

        final durationMs = (video?.durationSeconds ?? 0) * 1000;

        final targetMs = (currentVideoTimeMs + 1000)
            .clamp(
              0,
              durationMs,
            )
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
        _cueController.useCurrentTimeAsStart(
          currentVideoTimeMs,
        );
      },
      onSetEnd: () {
        _cueController.useCurrentTimeAsEnd(
          currentVideoTimeMs,
        );
      },
    );

    _keyboardController.start();

    _authController.restoreLogin();

    _workspaceController.load(
      videoId: component.videoId,
      languageCode: component.languageCode,
    );
  }

  @override
  void dispose() {
    _keyboardController.dispose();
    _cueDragController.dispose();
    _videoController.dispose();

    super.dispose();
  }

  Future<void> _deleteCue(
    SubtitleCueDetail detail,
  ) async {
    final cueId = detail.cue.id;

    if (cueId == null) {
      return;
    }

    final confirmed = html.window.confirm(
      '确定要删除这条字幕吗？删除后无法恢复。',
    );

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

    _cueController.useCurrentTimeAsStart(
      currentMs,
    );
  }

  void _useCurrentTimeAsEnd() {
    final currentMs = _videoController.currentTimeMs();

    if (currentMs == null) {
      _cueController.createCueError = '无法读取当前视频时间';

      setState(() {});
      return;
    }

    _cueController.useCurrentTimeAsEnd(
      currentMs,
    );
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

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'subtitle-editor-page',
      [
        div(
          classes: 'subtitle-editor-toolbar',
          [
            Link(
              to: '/subtitles',
              child: span(
                classes: 'subtitle-back-link',
                [.text('← Subtitles')],
              ),
            ),
            div(
              classes: 'subtitle-editor-toolbar-actions',
              [
                span(
                  classes: 'subtitle-language-badge',
                  [.text(component.languageCode.toUpperCase())],
                ),
              ],
            ),
          ],
        ),

        SubtitleLoginPanel(
          loggedIn: _authController.loggedIn,
          loading: _authController.loading,
          error: _authController.error,
          onEmailChanged: (value) {
            _authController.loginEmail = value;
          },
          onPasswordChanged: (value) {
            _authController.loginPassword = value;
          },
          onLogin: () {
            _authController.login();
          },
        ),

        if (loading)
          div(
            classes: 'preview-loading',
            [.text('正在载入字幕工作台...')],
          )
        else if (error != null)
          div(
            classes: 'preview-error',
            [.text(error!)],
          )
        else ...[
          div(
            classes: 'subtitle-editor-heading',
            [
              div(
                [
                  h1([
                    .text(video?.title ?? 'Video #${component.videoId}'),
                  ]),
                  p([
                    .text(
                      'Video #${component.videoId} · '
                      '${component.languageCode.toUpperCase()}',
                    ),
                  ]),
                ],
              ),
              div(
                classes: 'subtitle-cue-count',
                [.text('${cues.length} cues')],
              ),
            ],
          ),

          SubtitleSrtImportPanel(
            controller: _srtImportController,
            exportController: _srtExportController,
          ),

          if (videoUrl != null)
            SubtitleVideoPanel(
              videoUrl: videoUrl!,
              captionText: _activeCueText(),
              onTimeUpdate: () {
                final currentMs = _videoController.currentTimeMs();

                if (currentMs == null) {
                  return;
                }

                int? currentCueId;

                for (final detail in cues) {
                  if (currentMs >= detail.cue.startMs && currentMs < detail.cue.endMs) {
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
            onZoomChanged: (value) {
              setState(() {
                timelineZoom = value;
              });
            },
            onTimelineClick: (event) {
              _timelineController.seekFromTimelineClick(event);
            },
            onCueMouseDown: (detail) {
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

              _videoController.seekTo(
                detail.cue.startMs,
              );
            },
            onResizeStart: (detail, resizeStart) {
              _cueDragController.beginResizeCue(
                detail,
                resizeStart: resizeStart,
              );
            },
            onPlayheadMouseDown: (event) {
              _timelineController.beginScrubPlayhead(event);
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

          div(
            classes: 'subtitle-editor-layout',
            [
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

                  _videoController.seekTo(
                    detail.cue.startMs,
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
                cueCount: cues.length,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
