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
  final Map<int, String?> coverUrls = {};
  SelectedVideoFile? selectedFile;
  bool uploadModalOpen = false;

  int? editingVideoId;
  bool editSaving = false;
  String? editMessage;
  String editTitle = '';
  String editDescription = '';
  String editCategory = 'general';
  String editLanguageCode = 'auto';
  String editTagsText = '';
  bool editPublic = true;

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
      final nextCoverUrls = <int, String?>{};

      for (final video in result) {
        final id = video.id;
        final coverKey = video.coverStorageKey?.trim();

        if (id == null || coverKey == null || coverKey.isEmpty) {
          continue;
        }

        try {
          nextCoverUrls[id] = await client.video.getVideoUrl(path: coverKey);
        } catch (_) {
          nextCoverUrls[id] = null;
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        videos = result;
        coverUrls
          ..clear()
          ..addAll(nextCoverUrls);
        loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  void _openUploadModal() {
    setState(() {
      uploadModalOpen = true;
      uploadMessage = null;
    });
  }

  void _closeUploadModal() {
    if (studioUploadManager.busy) {
      return;
    }

    setState(() {
      uploadModalOpen = false;
      uploadMessage = null;
      fileSelectionError = null;
      selectedFile = null;
    });
  }

  Future<void> _selectFile() async {
    try {
      final file = await readSelectedVideoFile('studio-video-file');
      setState(() {
        selectedFile = file;
        fileSelectionError = null;
        uploadMessage = file == null
            ? null
            : '${file.name} · ${_formatBytes(file.size)} · ${_formatDuration(file.durationSeconds)} · 已生成封面';
      });
    } catch (e) {
      setState(() {
        selectedFile = null;
        fileSelectionError = e.toString();
        uploadMessage = fileSelectionError;
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
      fileSelectionError = null;
      uploadModalOpen = false;
      title = '';
      description = '';
      tagsText = '';
    });
  }

  void _openEditModal(Video video) {
    final id = video.id;
    if (id == null) {
      return;
    }

    setState(() {
      editingVideoId = id;
      editSaving = false;
      editMessage = null;
      editTitle = video.title;
      editDescription = video.description;
      editCategory = video.category;
      editLanguageCode = video.languageCode?.trim().isNotEmpty == true ? video.languageCode!.trim() : 'auto';
      editTagsText = video.tags.join(',');
      editPublic = video.isPublic;
    });
  }

  void _closeEditModal() {
    if (editSaving) {
      return;
    }

    setState(() {
      editingVideoId = null;
      editMessage = null;
    });
  }

  Future<void> _saveEdit() async {
    final id = editingVideoId;
    if (id == null || editSaving) {
      return;
    }

    if (editTitle.trim().isEmpty) {
      setState(() {
        editMessage = '请输入视频标题';
      });
      return;
    }

    final editTags = editTagsText
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);

    setState(() {
      editSaving = true;
      editMessage = null;
      error = null;
    });

    try {
      await client.video.updateMetadata(
        videoId: id,
        title: editTitle.trim(),
        description: editDescription.trim(),
        category: editCategory.trim(),
        languageCode: editLanguageCode.trim(),
        tags: editTags,
        isPublic: editPublic,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        editingVideoId = null;
        editMessage = null;
      });

      await _loadVideos();
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        editMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          editSaving = false;
        });
      }
    }
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
          classes: 'studio-page-heading sv-video-page-heading',
          [
            div([
              h1([.text('Videos')]),
              p([.text('上传视频，并管理公开状态与已有投稿。')]),
            ]),
            div(
              classes: 'sv-page-actions',
              [
                button(
                  classes: 'sv-secondary-button',
                  onClick: loading ? null : _loadVideos,
                  [.text(loading ? 'Loading...' : 'Refresh')],
                ),
                button(
                  classes: 'sv-primary-button sv-upload-open-button',
                  onClick: studioUploadManager.busy ? null : _openUploadModal,
                  [.text('+ Upload video')],
                ),
              ],
            ),
          ],
        ),
        if (error != null) div(classes: 'sv-alert sv-alert-error', [.text(error!)]),
        div(
          classes: 'sv-panel sv-video-library-panel',
          [
            div(
              classes: 'sv-video-library-header',
              [
                div([
                  h2([.text('My videos')]),
                  p([
                    .text(
                      '${videos.length} ${videos.length == 1 ? 'video' : 'videos'}',
                    ),
                  ]),
                ]),
              ],
            ),
            if (loading)
              p(classes: 'sv-video-list-status', [.text('正在读取视频...')])
            else if (videos.isEmpty)
              div(
                classes: 'sv-empty sv-video-empty',
                [
                  h3([.text('还没有视频')]),
                  p([.text('上传第一个视频后，它会显示在这里。')]),
                  button(
                    classes: 'sv-primary-button',
                    onClick: _openUploadModal,
                    [.text('+ Upload video')],
                  ),
                ],
              )
            else
              div(
                classes: 'sv-video-grid',
                [for (final video in videos) _videoCard(video)],
              ),
          ],
        ),
        if (uploadModalOpen) _uploadModal(),
        if (editingVideoId != null) _editModal(),
      ],
    );
  }

  Component _uploadModal() {
    return div(
      classes: 'sv-modal-backdrop',
      [
        div(
          classes: 'sv-modal',
          [
            div(
              classes: 'sv-modal-header',
              [
                div([
                  h2([.text('Upload video')]),
                  p([.text('填写视频资料并选择文件。封面会由浏览器自动生成。')]),
                ]),
                button(
                  classes: 'sv-modal-close',
                  attributes: studioUploadManager.busy ? {'disabled': 'disabled'} : null,
                  onClick: studioUploadManager.busy ? null : _closeUploadModal,
                  [.text('×')],
                ),
              ],
            ),
            div(
              classes: 'sv-modal-body',
              [
                _field(
                  'Title',
                  title,
                  '视频标题',
                  (value) => setState(() => title = value),
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
                  classes: 'sv-upload-box sv-modal-upload-box',
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
                        .text('选择一个视频文件；浏览器会自动验证并抽取封面。'),
                      ]),
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
              classes: 'sv-modal-footer',
              [
                button(
                  classes: 'sv-secondary-button',
                  onClick: studioUploadManager.busy ? null : _closeUploadModal,
                  [.text('Cancel')],
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
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _editModal() {
    return div(
      classes: 'sv-modal-backdrop',
      [
        div(
          classes: 'sv-modal sv-edit-modal',
          [
            div(
              classes: 'sv-modal-header',
              [
                div([
                  h2([.text('Edit video')]),
                  p([.text('修改视频资料、语言标记与公开状态。')]),
                ]),
                button(
                  classes: 'sv-modal-close',
                  attributes: editSaving ? {'disabled': 'disabled'} : null,
                  onClick: editSaving ? null : _closeEditModal,
                  [.text('×')],
                ),
              ],
            ),
            div(
              classes: 'sv-modal-body',
              [
                _field(
                  'Title',
                  editTitle,
                  '视频标题',
                  (value) => setState(() => editTitle = value),
                ),
                _field(
                  'Description',
                  editDescription,
                  '视频简介',
                  (value) => setState(() => editDescription = value),
                ),
                div(
                  classes: 'sv-two-columns',
                  [
                    _field(
                      'Category',
                      editCategory,
                      'general',
                      (value) => setState(() => editCategory = value),
                    ),
                    _field(
                      'Language',
                      editLanguageCode,
                      'vi / ms / en / ru / ...',
                      (value) => setState(() => editLanguageCode = value),
                    ),
                  ],
                ),
                _field(
                  'Tags',
                  editTagsText,
                  'language,vlog,podcast',
                  (value) => setState(() => editTagsText = value),
                ),
                div(
                  classes: 'sv-field',
                  [
                    span(classes: 'sv-label', [.text('Visibility')]),
                    div(
                      classes: 'sv-segmented',
                      [
                        button(
                          classes: 'sv-segment ${editPublic ? 'active' : ''}',
                          onClick: editSaving ? null : () => setState(() => editPublic = true),
                          [.text('Public')],
                        ),
                        button(
                          classes: 'sv-segment ${!editPublic ? 'active' : ''}',
                          onClick: editSaving ? null : () => setState(() => editPublic = false),
                          [.text('Private')],
                        ),
                      ],
                    ),
                  ],
                ),
                if (editMessage != null)
                  div(
                    classes: 'sv-upload-message sv-edit-message',
                    [.text(editMessage!)],
                  ),
              ],
            ),
            div(
              classes: 'sv-modal-footer',
              [
                button(
                  classes: 'sv-secondary-button',
                  onClick: editSaving ? null : _closeEditModal,
                  [.text('Cancel')],
                ),
                button(
                  classes: 'sv-primary-button',
                  attributes: editSaving ? {'disabled': 'disabled'} : null,
                  onClick: editSaving ? null : _saveEdit,
                  [.text(editSaving ? 'Saving...' : 'Save changes')],
                ),
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
    final coverUrl = id == null ? null : coverUrls[id];

    return div(
      classes: 'sv-video-card sv-video-card-rich',
      [
        div(
          classes: 'sv-video-thumbnail${coverUrl == null ? ' no-cover' : ''}',
          attributes: {
            if (coverUrl != null) 'style': "background-image:url('${coverUrl.replaceAll("'", "%27")}');",
          },
          [
            if (coverUrl == null) span(classes: 'sv-video-thumbnail-placeholder', [.text('CLYVEN')]),
            span(
              classes: 'sv-video-duration-badge',
              [.text(_formatDuration(video.durationSeconds))],
            ),
          ],
        ),
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
                '#${video.id ?? '-'} · ${video.languageCode ?? 'unknown'} · ${video.status.name}',
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
              classes: 'sv-secondary-button sv-edit-button',
              onClick: busy ? null : () => _openEditModal(video),
              [.text('Edit')],
            ),
            button(
              classes: 'sv-secondary-button',
              onClick: busy ? null : () => _toggleVisibility(video),
              [.text(video.isPublic ? 'Make private' : 'Make public')],
            ),
            button(
              classes: 'sv-danger-button${confirmDelete ? ' confirm' : ''}',
              onClick: busy ? null : () => _delete(video),
              [.text(confirmDelete ? 'Confirm delete' : 'Delete')],
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
