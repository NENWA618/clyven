import 'dart:io';

import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/video_upload_draft.dart';
import '../providers/video_detail_provider.dart';
import '../providers/video_upload_queue_provider.dart';

class CreateVideoPage
    extends ConsumerStatefulWidget {
  const CreateVideoPage({
    super.key,
  });

  @override
  ConsumerState<CreateVideoPage>
      createState() {
    return _CreateVideoPageState();
  }
}

class _CreateVideoPageState
    extends ConsumerState<CreateVideoPage> {
  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  static const Color _acid =
      Color(0xFFE5FF58);

  final ImagePicker _picker =
      ImagePicker();

  final TextEditingController
      _titleController =
      TextEditingController();

  final TextEditingController
      _descriptionController =
      TextEditingController();

  XFile? _video;

  String _category = '影像';

  bool _isPublishing = false;

  final List<String> _categories =
      const [
    '影像',
    '技术',
    '语言',
    '游戏',
    '音乐',
    '城市',
    '纪录',
  ];

  Future<String> _normalizeVideo(
    String inputPath,
  ) async {
    final inputFile =
        File(inputPath);

    final outputPath =
        '${inputFile.parent.path}/'
        'normalized-'
        '${DateTime.now().microsecondsSinceEpoch}.mp4';

    final session =
        await FFmpegKit.executeWithArguments(
      [
        '-y',

        // 尝试补齐时间戳。
        '-fflags',
        '+genpts',

        '-i',
        inputPath,

        // 只取主要视频轨。
        '-map',
        '0:v:0',

        // 如果有音频就保留。
        '-map',
        '0:a?',

        // 不重新编码，只重新封装。
        '-c',
        'copy',

        // 整理异常的负时间戳。
        '-avoid_negative_ts',
        'make_zero',

        // 让 MP4 更适合网络播放。
        '-movflags',
        '+faststart',

        outputPath,
      ],
    );

    final returnCode =
        await session.getReturnCode();

    if (!ReturnCode.isSuccess(
      returnCode,
    )) {
      throw StateError(
        '视频整理失败',
      );
    }

    final outputFile =
        File(outputPath);

    if (!await outputFile.exists()) {
      throw StateError(
        '整理后的视频文件不存在',
      );
    }

    return outputPath;
  }

  Future<String> _createVideoCover(
    String videoPath,
  ) async {
    final videoFile =
        File(videoPath);

    final outputPath =
        '${videoFile.parent.path}/'
        'cover-'
        '${DateTime.now().microsecondsSinceEpoch}.jpg';

    final session =
        await FFmpegKit.executeWithArguments(
      [
        '-y',

        // 从第 1 秒取画面。
        '-ss',
        '1',

        '-i',
        videoPath,

        // 只生成一张图。
        '-frames:v',
        '1',

        // JPEG 质量。
        '-q:v',
        '2',

        outputPath,
      ],
    );

    final returnCode =
        await session.getReturnCode();

    if (!ReturnCode.isSuccess(
      returnCode,
    )) {
      throw StateError(
        '生成视频封面失败',
      );
    }

    final coverFile =
        File(outputPath);

    if (!await coverFile.exists()) {
      throw StateError(
        '生成的视频封面不存在',
      );
    }

    final length =
        await coverFile.length();

    if (length <= 0) {
      throw StateError(
        '生成的视频封面为空',
      );
    }

    return outputPath;
  }

  Future<int> _readVideoDuration(
    String path,
  ) async {
    final session =
        await FFprobeKit
            .getMediaInformation(
      path,
    );

    final information =
        session.getMediaInformation();

    if (information == null) {
      debugPrint(
        'FFprobe 无法读取视频信息',
      );

      return 0;
    }

    final rawDuration =
        information.getDuration();

    debugPrint(
      'FFprobe duration: $rawDuration',
    );

    if (rawDuration == null) {
      return 0;
    }

    final seconds =
        double.tryParse(
      rawDuration,
    );

    if (seconds == null) {
      return 0;
    }

    return seconds.round();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  Future<void> _pickVideo() async {
    if (_isPublishing) {
      return;
    }

    final video =
        await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _video = video;
    });
  }

  Future<void> _publish() async {
  if (_isPublishing) {
    return;
  }

  final title =
      _titleController.text.trim();

  final description =
      _descriptionController.text.trim();

  if (_video == null) {
    _showMessage(
      '请选择视频',
    );
    return;
  }

  if (title.isEmpty) {
    _showMessage(
      '请输入标题',
    );
    return;
  }

  setState(() {
    _isPublishing = true;
  });

  try {
    final user =
        await ref.read(
      authProvider.future,
    );

    if (user == null) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isPublishing = false;
      });

      _showMessage(
        '请先登录',
      );

      return;
    }

    // 把上传任务交给全局上传队列。
    ref
        .read(
          videoUploadQueueProvider.notifier,
        )
        .enqueue(
          VideoUploadRequest(
            userId: user.id,
            authorName:
                user.displayName,
            videoPath:
                _video!.path,
            title: title,
            description:
                description,
            category:
                _category,
          ),
        );

    if (!mounted) {
      return;
    }

    // 不等待视频处理和上传。
    // 任务已经由上传队列接管。
    Navigator.pop(
      context,
    );
  } catch (error) {
    if (!mounted) {
      return;
    }

    setState(() {
      _isPublishing = false;
    });

    _showMessage(
      '提交上传任务失败：$error',
    );
  }
}

  void _showMessage(
    String message,
  ) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(message),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: ListView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  40,
                ),
                children: [
                  _buildVideoSelector(),

                  const SizedBox(
                    height: 26,
                  ),

                  _buildLabel(
                    'TITLE',
                    '标题',
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildTextField(
                    controller:
                        _titleController,
                    hintText:
                        '给这个视频一个标题',
                    maxLines: 2,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  _buildLabel(
                    'ABOUT',
                    '简介',
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildTextField(
                    controller:
                        _descriptionController,
                    hintText:
                        '告诉大家这个视频在讲什么',
                    maxLines: 6,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  _buildLabel(
                    'CHANNEL',
                    '分类',
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  _buildCategories(),

                  const SizedBox(
                    height: 34,
                  ),

                  _buildPublishButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap:
                _isPublishing
                    ? null
                    : () {
                        Navigator.pop(
                          context,
                        );
                      },
            child: Container(
              width: 42,
              height: 42,
              decoration:
                  BoxDecoration(
                color:
                    Colors.white
                        .withOpacity(
                  0.72,
                ),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child:
                  const Icon(
                Icons.close_rounded,
              ),
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  'NEW FRAME',
                  style:
                      TextStyle(
                    color:
                        _purple,
                    fontSize: 9,
                    fontWeight:
                        FontWeight
                            .w900,
                    letterSpacing:
                        2,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '发布视频',
                  style:
                      TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight:
                        FontWeight
                            .w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSelector() {
    return GestureDetector(
      onTap: _isPublishing
          ? null
          : _pickVideo,
      child: Container(
        height: 210,
        decoration:
            BoxDecoration(
          color: _ink,
          borderRadius:
              BorderRadius.circular(
            28,
          ),
        ),
        child: _video == null
            ? const Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  Icon(
                    Icons
                        .video_library_outlined,
                    color: _acid,
                    size: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    '选择视频',
                    style:
                        TextStyle(
                      color:
                          Colors.white,
                      fontSize: 16,
                      fontWeight:
                          FontWeight
                              .w800,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '从设备中选择视频文件',
                    style:
                        TextStyle(
                      color:
                          Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              )
            : Padding(
                padding:
                    const EdgeInsets
                        .all(
                  18,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    const Icon(
                      Icons
                          .check_circle_rounded,
                      color: _acid,
                      size: 42,
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    const Text(
                      '视频已选择',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize: 16,
                        fontWeight:
                            FontWeight
                                .w800,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      _video!.name,
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      textAlign:
                          TextAlign
                              .center,
                      style:
                          const TextStyle(
                        color:
                            Colors.white54,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    const Text(
                      '点击重新选择',
                      style:
                          TextStyle(
                        color: _acid,
                        fontSize: 10,
                        fontWeight:
                            FontWeight
                                .w700,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLabel(
    String english,
    String chinese,
  ) {
    return Row(
      children: [
        Text(
          english,
          style:
              const TextStyle(
            color: _purple,
            fontSize: 9,
            fontWeight:
                FontWeight.w900,
            letterSpacing:
                1.7,
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Text(
          chinese,
          style:
              const TextStyle(
            color: _ink,
            fontSize: 15,
            fontWeight:
                FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController
        controller,
    required String hintText,
    required int maxLines,
  }) {
    return TextField(
      controller:
          controller,
      enabled:
          !_isPublishing,
      maxLines:
          maxLines,
      decoration:
          InputDecoration(
        hintText:
            hintText,
        hintStyle:
            const TextStyle(
          color:
              Color(
            0xFFAAA49B,
          ),
        ),
        filled: true,
        fillColor:
            Colors.white
                .withOpacity(
          0.72,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            20,
          ),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            20,
          ),
          borderSide:
              const BorderSide(
            color:
                Color(
              0xFFE3DED5,
            ),
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            20,
          ),
          borderSide:
              const BorderSide(
            color:
                _purple,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Wrap(
      spacing: 8,
      runSpacing: 9,
      children:
          _categories.map(
        (category) {
          final selected =
              category ==
                  _category;

          return GestureDetector(
            onTap:
                _isPublishing
                    ? null
                    : () {
                        setState(
                          () {
                            _category =
                                category;
                          },
                        );
                      },
            child: Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal:
                    15,
                vertical: 9,
              ),
              decoration:
                  BoxDecoration(
                color: selected
                    ? _purple
                    : Colors.white
                        .withOpacity(
                        0.72,
                      ),
                borderRadius:
                    BorderRadius
                        .circular(
                  20,
                ),
                border:
                    Border.all(
                  color: selected
                      ? _purple
                      : const Color(
                          0xFFD9D4CB,
                        ),
                ),
              ),
              child: Text(
                category,
                style:
                    TextStyle(
                  color: selected
                      ? Colors.white
                      : _ink,
                  fontSize: 11,
                  fontWeight:
                      FontWeight
                          .w700,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildPublishButton() {
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed:
            _isPublishing
                ? null
                : _publish,
        style:
            FilledButton
                .styleFrom(
          backgroundColor:
              _acid,
          disabledBackgroundColor:
              _acid.withOpacity(
            0.55,
          ),
          foregroundColor:
              _ink,
          disabledForegroundColor:
              _ink.withOpacity(
            0.5,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),
        ),
        child: _isPublishing
            ? const SizedBox(
                width: 22,
                height: 22,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _ink,
                ),
              )
            : const Text(
                '继续发布',
                style:
                    TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight
                          .w900,
                ),
              ),
      ),
    );
  }
}