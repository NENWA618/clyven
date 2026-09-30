import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/studio_client.dart';
import '../services/upload_manager.dart';
import '../services/video_file_reader.dart';
import '../services/video_selection_error.dart';

class VideoManagementPage extends StatefulComponent {
  const VideoManagementPage({super.key});

  @override
  State<VideoManagementPage> createState() => _VideoManagementPageState();
}

class _VideoManagementPageState extends State<VideoManagementPage> {
  final client = studioClient;

  bool loading = true;
  String? error;
  String? uploadMessage;
  String? fileSelectionError;

  List<Video> videos = [];
  SelectedVideoFile? selectedFile;

  String title = '';
  String description = '';
  String category = 'general';
  String languageCode = 'auto';
  String tagsText = '';
  bool uploadPublic = true;

  int? pendingDeleteId;
  int? busyVideoId;

  @override
  void initState() {
    super.initState();
    studioUploadManager.addListener(_onUploadChanged);
    _loadVideos();
  }

  @override
  void dispose() {
    studioUploadManager.removeListener(_onUploadChanged);
    super.dispose();
  }

  void _onUploadChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadVideos() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await client.video.getMyVideos();
      setState(() {
        videos = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> _selectFile() async {
    try {
      final file = await readSelectedVideoFile('studio-video-file');
      setState(() {
        selectedFile = file;
        uploadMessage = file == null
            ? null
            : '${file.name} · ${_formatBytes(file.size)} · ${_formatDuration(file.durationSeconds)} · 已生成封面';
      });
    } catch (e) {
      setState(() {
        selectedFile = null;
        uploadMessage = e.toString();
      });
    }
  }

  void _upload() {
    final file = selectedFile;

    if (file == null) {
      setState(() {
        uploadMessage = selectedVideoMissingMessage(fileSelectionError);
      });
      return;
    }

    if (title.trim().isEmpty) {
      setState(() {
        uploadMessage = '请输入视频标题';
      });
      return;
    }

    if (studioUploadManager.busy) {
      setState(() {
        uploadMessage = '已有视频正在上传，请等待当前任务完成';
      });
      return;
    }

    final uploadTags = tagsText
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);

    studioUploadManager.startUpload(
      file: file,
      title: title.trim(),
      description: description.trim(),
      category: category.trim(),
      languageCode: languageCode.trim(),
      tags: uploadTags,
      isPublic: uploadPublic,
    );

    setState(() {
      uploadMessage = '已开始上传。Creator 将使用当前登录账号，封面已自动生成。';
      selectedFile = null;
      title = '';
      description = '';
      tagsText = '';
    });
  }

  Future<void> _toggleVisibility(Video video) async {
    final id = video.id;
    if (id == null) {
      return;
    }

    setState(() {
      busyVideoId = id;
      error = null;
    });

    try {
      await client.video.setVisibility(
        videoId: id,
        isPublic: !video.isPublic,
      );
      await _loadVideos();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        busyVideoId = null;
      });
    }
  }

  Future<void> _delete(Video video) async {
    final id = video.id;
    if (id == null) {
      return;
    }

    if (pendingDeleteId != id) {
      setState(() {
        pendingDeleteId = id;
      });
      return;
    }

    setState(() {
      busyVideoId = id;
      error = null;
    });

    try {
      await client.video.deleteVideo(videoId: id);
      setState(() {
        pendingDeleteId = null;
      });
      await _loadVideos();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        busyVideoId = null;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'studio-video-page',
      [
        div(
          classes: 'studio-page-heading',
          [
            div([
              h1([.text('Videos')]),
              p([.text('上传视频，并管理公开状态与已有投稿。')]),
            ]),
            button(
              classes: 'sv-secondary-button',
              onClick: loading ? null : _loadVideos,
              [.text(loading ? 'Loading...' : 'Refresh')],
            ),
          ],
        ),
        if (error != null) div(classes: 'sv-alert sv-alert-error', [.text(error!)]),
        div(
          classes: 'sv-layout',
          [
            div(
              classes: 'sv-panel',
              [
                h2([.text('Upload video')]),
                _field(
                  'Title',
                  title,
                  '视频标题',
                  (value) => setState(() => title = value),
                ),
                div(
                  classes: 'sv-field',
                  [
                    span(classes: 'sv-label', [.text('Creator')]),
                    p(
                      classes: 'sv-file-meta',
                      [.text('使用当前登录 Clyven 账号的显示名称')],
                    ),
                  ],
                ),
                _field(
                  'Description',
                  description,
                  '视频简介',
                  (value) => setState(() => description = value),
                ),
                div(
                  classes: 'sv-two-columns',
                  [
                    _field(
                      'Category',
                      category,
                      'general',
                      (value) => setState(() => category = value),
                    ),
                    _field(
                      'Language',
                      languageCode,
                      'auto / vi / ms / ...',
                      (value) => setState(() => languageCode = value),
                    ),
                  ],
                ),
                _field(
                  'Tags',
                  tagsText,
                  'language,vlog,podcast',
                  (value) => setState(() => tagsText = value),
                ),
                div(
                  classes: 'sv-field',
                  [
                    span(classes: 'sv-label', [.text('Visibility')]),
                    div(
                      classes: 'sv-segmented',
                      [
                        button(
                          classes: 'sv-segment ${uploadPublic ? 'active' : ''}',
                          onClick: studioUploadManager.busy ? null : () => setState(() => uploadPublic = true),
                          [.text('Public')],
                        ),
                        button(
                          classes: 'sv-segment ${!uploadPublic ? 'active' : ''}',
                          onClick: studioUploadManager.busy ? null : () => setState(() => uploadPublic = false),
                          [.text('Private')],
                        ),
                      ],
                    ),
                  ],
                ),
                div(
                  classes: 'sv-upload-box',
                  [
                    input<String>(
                      id: 'studio-video-file',
                      type: InputType.file,
                      attributes: {'accept': 'video/*'},
                      events: {
                        'change': (_) {
                          _selectFile();
                        },
                      },
                    ),
                    if (selectedFile != null)
                      p(classes: 'sv-file-meta', [
                        .text(
                          '${selectedFile!.name} · ${_formatBytes(selectedFile!.size)} · ${_formatDuration(selectedFile!.durationSeconds)} · 自动封面已就绪',
                        ),
                      ])
                    else
                      p(classes: 'sv-file-meta', [
                        .text('选择一个视频文件；浏览器会自动抽取封面。'),
                      ]),
                  ],
                ),
                button(
                  classes: 'sv-primary-button',
                  attributes: studioUploadManager.busy ? {'disabled': 'disabled'} : null,
                  onClick: studioUploadManager.busy ? null : _upload,
                  [
                    .text(
                      studioUploadManager.busy ? 'Upload in progress...' : 'Upload',
                    ),
                  ],
                ),
                if (uploadMessage != null)
                  div(
                    classes: 'sv-upload-message',
                    [.text(uploadMessage!)],
                  ),
              ],
            ),
            div(
              classes: 'sv-panel sv-video-list-panel',
              [
                h2([.text('My videos')]),
                if (loading)
                  p([.text('正在读取视频...')])
                else if (videos.isEmpty)
                  div(
                    classes: 'sv-empty',
                    [.text('还没有视频。')],
                  )
                else
                  for (final video in videos) _videoCard(video),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _field(
    String label,
    String value,
    String placeholder,
    void Function(String value) onChanged,
  ) {
    return div(
      classes: 'sv-field',
      [
        span(classes: 'sv-label', [.text(label)]),
        input<String>(
          type: InputType.text,
          attributes: {
            'value': value,
            'placeholder': placeholder,
          },
          events: events<String>(
            onInput: onChanged,
          ),
        ),
      ],
    );
  }

  Component _videoCard(Video video) {
    final id = video.id;
    final busy = id != null && busyVideoId == id;
    final confirmDelete = id != null && pendingDeleteId == id;

    return div(
      classes: 'sv-video-card',
      [
        div(
          classes: 'sv-video-card-main',
          [
            div(
              classes: 'sv-video-title-row',
              [
                h3([.text(video.title)]),
                span(
                  classes: 'sv-visibility ${video.isPublic ? 'public' : 'private'}',
                  [.text(video.isPublic ? 'Public' : 'Private')],
                ),
              ],
            ),
            p(classes: 'sv-video-meta', [
              .text(
                '#${video.id ?? '-'} · ${video.languageCode ?? 'unknown'} · ${_formatDuration(video.durationSeconds)} · ${video.status.name}',
              ),
            ]),
            if (video.description.isNotEmpty)
              p(
                classes: 'sv-video-description',
                [.text(video.description)],
              ),
          ],
        ),
        div(
          classes: 'sv-video-actions',
          [
            button(
              classes: 'sv-secondary-button',
              onClick: busy ? null : () => _toggleVisibility(video),
              [
                .text(video.isPublic ? 'Make private' : 'Make public'),
              ],
            ),
            button(
              classes: 'sv-danger-button${confirmDelete ? ' confirm' : ''}',
              onClick: busy ? null : () => _delete(video),
              [
                .text(confirmDelete ? 'Confirm delete' : 'Delete'),
              ],
            ),
            if (confirmDelete)
              button(
                classes: 'sv-link-button',
                onClick: busy ? null : () => setState(() => pendingDeleteId = null),
                [.text('Cancel')],
              ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  String _formatBytes(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '$bytes B';
  }
}
