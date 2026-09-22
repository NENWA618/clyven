import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import '../services/admin_client.dart';

class ReviewPage extends StatefulComponent {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final client = adminClient;

  List<Video> _videos = [];
  List<SubtitleTrack> _tracks = [];
  List<SubtitleCueDetail> _cues = [];

  Video? _video;
  SubtitleTrack? _track;
  SubtitlePublishStatus? _publishStatus;

  String? _videoUrl;
  String _scriptCode = '';

  bool _loadingVideos = true;
  bool _loadingTrack = false;
  bool _publishing = false;

  String? _error;
  String? _publishError;

  final Map<int, String> _textEdits = {};
  final Map<int, String> _startEdits = {};
  final Map<int, String> _endEdits = {};
  final Set<int> _saving = {};
  final Map<int, String> _saveErrors = {};

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      _loadingVideos = true;
      _error = null;
    });

    try {
      final videos = await client.admin.getVideosWithSubtitles();

      if (!mounted) return;

      setState(() {
        _videos = videos;
        _loadingVideos = false;
      });

      if (videos.isNotEmpty) {
        await _selectVideo(videos.first);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingVideos = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _selectVideo(Video video) async {
    setState(() {
      _video = video;
      _track = null;
      _tracks = [];
      _cues = [];
      _videoUrl = null;
      _publishStatus = null;
      _loadingTrack = true;
      _error = null;
      _clearEdits();
    });

    try {
      final tracks = await client.admin.getSubtitleTracks(videoId: video.id!);
      final videoUrl = await client.video.getVideoUrl(
        path: video.videoStorageKey,
      );

      if (!mounted) return;

      setState(() {
        _tracks = tracks;
        _videoUrl = videoUrl;
        _loadingTrack = false;
      });

      if (tracks.isNotEmpty) {
        await _selectTrack(tracks.first);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingTrack = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _selectTrack(SubtitleTrack track) async {
    setState(() {
      _track = track;
      _scriptCode = track.defaultScriptCode ?? '';
      _loadingTrack = true;
      _publishStatus = null;
      _publishError = null;
      _clearEdits();
    });

    await _loadCurrentTrack();
  }

  Future<void> _loadCurrentTrack() async {
    final video = _video;
    final track = _track;

    if (video?.id == null || track == null) {
      return;
    }

    try {
      final script = _scriptCode.trim();

      final cues = await client.subtitle.getCueDetails(
        videoId: video!.id!,
        languageCode: track.languageCode,
        scriptCode: script.isEmpty ? null : script,
      );

      final status = await client.subtitle.getSubtitlePublishStatus(
        videoId: video.id!,
        languageCode: track.languageCode,
      );

      if (!mounted) return;

      setState(() {
        _cues = cues;
        _publishStatus = status;
        _loadingTrack = false;
        _error = null;
        _clearEdits();
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingTrack = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _saveCue(SubtitleCueDetail detail) async {
    final cueId = detail.cue.id;
    if (cueId == null || _saving.contains(cueId)) {
      return;
    }

    final startText = _startEdits[cueId] ?? _formatTime(detail.cue.startMs);
    final endText = _endEdits[cueId] ?? _formatTime(detail.cue.endMs);
    final text = (_textEdits[cueId] ?? _displayText(detail)).trim();

    final startMs = _parseTime(startText);
    final endMs = _parseTime(endText);

    if (startMs == null || endMs == null) {
      setState(() {
        _saveErrors[cueId] = '时间格式必须是 mm:ss.mmm';
      });
      return;
    }

    if (endMs <= startMs) {
      setState(() {
        _saveErrors[cueId] = '结束时间必须大于开始时间';
      });
      return;
    }

    if (text.isEmpty) {
      setState(() {
        _saveErrors[cueId] = '字幕内容不能为空';
      });
      return;
    }

    setState(() {
      _saving.add(cueId);
      _saveErrors.remove(cueId);
    });

    try {
      if (startMs != detail.cue.startMs || endMs != detail.cue.endMs) {
        await client.subtitle.updateCueTiming(
          cueId: cueId,
          startMs: startMs,
          endMs: endMs,
        );
      }

      final script = _scriptCode.trim();

      await client.subtitle.updateCueText(
        cueId: cueId,
        text: text,
        scriptCode: script.isEmpty ? null : script,
      );

      if (!mounted) return;

      await _loadCurrentTrack();

      if (!mounted) return;
      setState(() {
        _saving.remove(cueId);
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _saving.remove(cueId);
        _saveErrors[cueId] = e.toString();
      });
    }
  }

  Future<void> _publish() async {
    final video = _video;
    final track = _track;

    if (video?.id == null || track == null || _publishing) {
      return;
    }

    setState(() {
      _publishing = true;
      _publishError = null;
    });

    try {
      final status = await client.subtitle.publishSubtitleTrack(
        videoId: video!.id!,
        languageCode: track.languageCode,
      );

      if (!mounted) return;

      setState(() {
        _publishStatus = status;
        _publishing = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _publishing = false;
        _publishError = e.toString();
      });
    }
  }

  void _clearEdits() {
    _textEdits.clear();
    _startEdits.clear();
    _endEdits.clear();
    _saving.clear();
    _saveErrors.clear();
  }

  String _displayText(SubtitleCueDetail detail) {
    final script = _scriptCode.trim();

    if (script.isNotEmpty) {
      SubtitleCueText? selected;

      for (final row in detail.texts ?? const <SubtitleCueText>[]) {
        if (row.scriptCode.toLowerCase() == script.toLowerCase()) {
          selected = row;
        }
      }

      if (selected != null) {
        return selected.text;
      }
    }

    return detail.cue.text;
  }

  String _formatTime(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final millis = milliseconds % 1000;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }

  int? _parseTime(String value) {
    final match = RegExp(
      r'^(\d+):([0-5]\d)\.(\d{3})$',
    ).firstMatch(value.trim());

    if (match == null) return null;

    final minutes = int.parse(match.group(1)!);
    final seconds = int.parse(match.group(2)!);
    final milliseconds = int.parse(match.group(3)!);

    return ((minutes * 60) + seconds) * 1000 + milliseconds;
  }

  String _publishLabel() {
    final status = _publishStatus;

    if (status == null) return '读取发布状态…';
    if (!status.hasPublishedVersion) return '未发布';
    if (status.hasUnpublishedChanges) return '有待校对更改';
    return '已发布 / 当前无未发布更改';
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'admin-shell', [
      aside(classes: 'admin-sidebar', [
        div(classes: 'admin-brand', [
          div(classes: 'admin-brand-mark', [.text('C')]),
          div([
            strong([.text('Clyven Admin')]),
            span([.text('Subtitle Review')]),
          ]),
        ]),
        div(classes: 'admin-sidebar-heading', [.text('所有有字幕的视频')]),
        if (_loadingVideos)
          div(classes: 'admin-muted', [.text('正在加载…')])
        else if (_videos.isEmpty)
          div(classes: 'admin-muted', [.text('目前没有字幕视频')])
        else
          div(classes: 'admin-video-list', [
            for (final video in _videos)
              button(
                type: ButtonType.button,
                classes:
                    'admin-video-item${_video?.id == video.id ? ' is-active' : ''}',
                onClick: () => _selectVideo(video),
                [
                  strong([.text(video.title)]),
                  span([.text('${video.authorName} · #${video.id}')]),
                ],
              ),
          ]),
      ]),
      main_(classes: 'admin-main', [
        header(classes: 'admin-topbar', [
          div([
            div(classes: 'admin-kicker', [.text('INTERNAL REVIEW')]),
            h1([.text(_video?.title ?? '字幕人工校对')]),
            if (_video != null)
              p([.text('作者：${_video!.authorName} · Video #${_video!.id}')]),
          ]),
          button(
            type: ButtonType.button,
            classes: 'admin-secondary-button',
            onClick: _loadVideos,
            [.text('刷新队列')],
          ),
        ]),
        if (_error != null)
          div(classes: 'admin-error admin-page-error', [.text(_error!)]),
        if (_video == null && !_loadingVideos)
          div(classes: 'admin-empty', [.text('从左侧选择一个字幕视频。')])
        else if (_video != null) ...[
          section(classes: 'admin-review-card', [
            div(classes: 'admin-player-wrap', [
              if (_videoUrl != null && _videoUrl!.isNotEmpty)
                dom.video(
                  [],
                  classes: 'admin-video-player',
                  src: _videoUrl,
                  controls: true,
                  preload: dom.Preload.metadata,
                )
              else
                div(classes: 'admin-empty', [.text('暂无可播放地址')]),
            ]),
            div(classes: 'admin-track-panel', [
              h2([.text('字幕轨')]),
              if (_loadingTrack)
                div(classes: 'admin-muted', [.text('加载字幕轨…')])
              else if (_tracks.isEmpty)
                div(classes: 'admin-muted', [.text('这个视频没有字幕轨')])
              else
                div(classes: 'admin-track-list', [
                  for (final track in _tracks)
                    button(
                      type: ButtonType.button,
                      classes:
                          'admin-track-chip${_track?.id == track.id ? ' is-active' : ''}',
                      onClick: () => _selectTrack(track),
                      [
                        .text(
                          '${track.languageCode}'
                          '${track.variantCode == null ? '' : ' · ${track.variantCode}'}',
                        ),
                      ],
                    ),
                ]),
              if (_track != null) ...[
                label(classes: 'admin-field', [
                  span([.text('校对文字系统 scriptCode')]),
                  input<String>(
                    type: InputType.text,
                    attributes: {
                      'value': _scriptCode,
                      'placeholder': '留空 = 默认 / legacy',
                    },
                    events: events<String>(
                      onInput: (value) {
                        _scriptCode = value;
                      },
                    ),
                  ),
                ]),
                button(
                  type: ButtonType.button,
                  classes: 'admin-secondary-button',
                  onClick: _loadCurrentTrack,
                  [.text('按这个 script 重新读取')],
                ),
              ],
            ]),
          ]),
          if (_track != null)
            section(classes: 'admin-cues-card', [
              div(classes: 'admin-cues-header', [
                div([
                  h2([.text('${_track!.languageCode} · 人工校对')]),
                  p([.text(_publishLabel())]),
                ]),
                button(
                  type: ButtonType.button,
                  classes: 'admin-publish-button',
                  attributes: _publishing ? {'disabled': 'disabled'} : null,
                  onClick: _publishing ? null : _publish,
                  [.text(_publishing ? '发布中…' : '发布校对结果')],
                ),
              ]),
              if (_publishError != null)
                div(classes: 'admin-error', [.text(_publishError!)]),
              if (_loadingTrack)
                div(classes: 'admin-muted', [.text('正在读取字幕…')])
              else if (_cues.isEmpty)
                div(classes: 'admin-empty', [.text('这条字幕轨没有字幕')])
              else
                div(classes: 'admin-cue-list', [
                  for (var index = 0; index < _cues.length; index++)
                    _cueRow(index, _cues[index]),
                ]),
            ]),
        ],
      ]),
    ]);
  }

  Component _cueRow(int index, SubtitleCueDetail detail) {
    final cueId = detail.cue.id;
    if (cueId == null) {
      return const Component.empty();
    }

    final saving = _saving.contains(cueId);

    return div(classes: 'admin-cue-row', [
      div(classes: 'admin-cue-index', [.text('${index + 1}')]),
      div(classes: 'admin-cue-times', [
        input<String>(
          type: InputType.text,
          attributes: {
            'value': _startEdits[cueId] ?? _formatTime(detail.cue.startMs),
          },
          events: events<String>(
            onInput: (value) {
              _startEdits[cueId] = value;
            },
          ),
        ),
        span([.text('→')]),
        input<String>(
          type: InputType.text,
          attributes: {
            'value': _endEdits[cueId] ?? _formatTime(detail.cue.endMs),
          },
          events: events<String>(
            onInput: (value) {
              _endEdits[cueId] = value;
            },
          ),
        ),
      ]),
      div(classes: 'admin-cue-text', [
        input<String>(
          type: InputType.text,
          attributes: {'value': _textEdits[cueId] ?? _displayText(detail)},
          events: events<String>(
            onInput: (value) {
              _textEdits[cueId] = value;
            },
          ),
        ),
        if (_saveErrors[cueId] != null)
          span(classes: 'admin-cue-error', [.text(_saveErrors[cueId]!)]),
      ]),
      button(
        type: ButtonType.button,
        classes: 'admin-save-button',
        attributes: saving ? {'disabled': 'disabled'} : null,
        onClick: saving ? null : () => _saveCue(detail),
        [.text(saving ? '保存中…' : '保存')],
      ),
    ]);
  }
}
