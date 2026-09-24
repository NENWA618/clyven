import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/studio_client.dart';
import '../services/video_file_reader.dart';

class VideoManagementPage extends StatefulComponent {
  const VideoManagementPage({super.key});

  @override
  State<VideoManagementPage> createState() => _VideoManagementPageState();
}

class _VideoManagementPageState extends State<VideoManagementPage> {
  final client = studioClient;

  bool loading = true;
  bool uploading = false;
  String? error;
  String? uploadMessage;

  List<Video> videos = [];
  SelectedVideoFile? selectedFile;

  String title = '';
  String description = '';
  String category = 'general';
  String languageCode = 'auto';
  String tagsText = '';
  String authorName = '';
  bool uploadPublic = true;

  int? pendingDeleteId;
  int? busyVideoId;

  @override
  void initState() {
    super.initState();
    _loadVideos();
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
            : '${file.name} · ${_formatBytes(file.size)} · ${_formatDuration(file.durationSeconds)}';
      });
    } catch (e) {
      setState(() {
        selectedFile = null;
        uploadMessage = e.toString();
      });
    }
  }

  String _extensionFor(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot < 0 || dot == fileName.length - 1) {
      return 'mp4';
    }

    final raw = fileName.substring(dot + 1).toLowerCase();
    final safe = raw.replaceAll(RegExp(r'[^a-z0-9]'), '');
    return safe.isEmpty ? 'mp4' : safe;
  }

  Future<void> _upload() async {
    final file = selectedFile;
    if (file == null) {
      setState(() {
        uploadMessage = '请先选择视频文件';
      });
      return;
    }

    if (title.trim().isEmpty) {
      setState(() {
        uploadMessage = '请输入视频标题';
      });
      return;
    }

    setState(() {
      uploading = true;
      uploadMessage = '正在上传视频...';
    });

    try {
      final userId = await client.video.getCurrentUserId();
      final safeUserId = userId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final extension = _extensionFor(file.name);
      final storageKey = 'videos/$safeUserId/$timestamp.$extension';

      final uploadDescription = await client.video.createUploadDescription(
        path: storageKey,
        fileSize: file.size,
      );

      if (uploadDescription == null) {
        throw Exception('无法创建上传任务');
      }

      final uploader = FileUploader(uploadDescription);
      final uploaded = await uploader.upload(file.openRead(), file.size);

      if (!uploaded) {
        throw Exception('视频上传失败');
      }

      final verified = await client.video.verifyUpload(path: storageKey);
      if (!verified) {
        throw Exception('视频上传完成，但服务器校验失败');
      }

      setState(() {
        uploadMessage = '文件已上传，正在创建视频并处理字幕任务...';
      });

      await client.video.create(
        authorId: userId,
        authorName: authorName.trim().isEmpty ? userId : authorName.trim(),
        title: title.trim(),
        description: descriptionText,
        category: category.trim().isEmpty ? 'general' : category.trim(),
        languageCode: languageCode.trim().isEmpty ? 'auto' : languageCode.trim(),
        tags: tagsText
            .split(',')
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(growable: false),
        videoStorageKey: storageKey,
        coverStorageKey: null,
        durationSeconds: file.durationSeconds,
        isPublic: uploadPublic,
      );

      setState(() {
        uploading = false;
        uploadMessage = '上传完成';
        selectedFile = null;
        title = '';
        description = '';
        tagsText = '';
      });

      await _loadVideos();
    } catch (e) {
      setState(() {
        uploading = false;
        uploadMessage = e.toString();
      });
    }
  }

  String get descriptionText => description.trim();

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
                _field(
                  'Creator name',
                  authorName,
                  '留空时使用账号 ID',
                  (value) => setState(() => authorName = value),
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
                          onClick: uploading ? null : () => setState(() => uploadPublic = true),
                          [.text('Public')],
                        ),
                        button(
                          classes: 'sv-segment ${!uploadPublic ? 'active' : ''}',
                          onClick: uploading ? null : () => setState(() => uploadPublic = false),
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
                          '${selectedFile!.name} · ${_formatBytes(selectedFile!.size)} · ${_formatDuration(selectedFile!.durationSeconds)}',
                        ),
                      ])
                    else
                      p(classes: 'sv-file-meta', [
                        .text('选择一个视频文件。'),
                      ]),
                  ],
                ),
                button(
                  classes: 'sv-primary-button',
                  attributes: uploading ? {'disabled': 'disabled'} : null,
                  onClick: uploading ? null : _upload,
                  [.text(uploading ? 'Uploading / processing...' : 'Upload')],
                ),
                if (uploadMessage != null) div(classes: 'sv-upload-message', [.text(uploadMessage!)]),
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
            if (video.description.isNotEmpty) p(classes: 'sv-video-description', [.text(video.description)]),
          ],
        ),
        div(
          classes: 'sv-video-actions',
          [
            button(
              classes: 'sv-secondary-button',
              onClick: busy ? null : () => _toggleVisibility(video),
              [
                .text(
                  video.isPublic ? 'Make private' : 'Make public',
                ),
              ],
            ),
            button(
              classes: 'sv-danger-button${confirmDelete ? ' confirm' : ''}',
              onClick: busy ? null : () => _delete(video),
              [
                .text(
                  confirmDelete ? 'Confirm delete' : 'Delete',
                ),
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
