import 'dart:io';

import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/video_upload_draft.dart';
import '../providers/video_upload_queue_provider.dart';

class CreateVideoPage extends ConsumerStatefulWidget {
  const CreateVideoPage({
    super.key,
  });

  @override
  ConsumerState<CreateVideoPage> createState() {
    return _CreateVideoPageState();
  }
}

class _CreateVideoPageState extends ConsumerState<CreateVideoPage> {
  static const Color _background = Color(0xFFF4F1EA);
  static const Color _ink = Color(0xFF161616);
  static const Color _purple = Color(0xFF7657FF);
  static const Color _acid = Color(0xFFE5FF58);

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _video;
  String _category = '影像';
  bool _isPublishing = false;

  final List<String> _categories = const [
    '影像',
    '技术',
    '语言',
    '游戏',
    '音乐',
    '城市',
    '纪录',
  ];

  Future<String> _normalizeVideo(String inputPath) async {
    final l10n = AppLocalizations.of(context)!;
    final inputFile = File(inputPath);
    final outputPath =
        '${inputFile.parent.path}/normalized-${DateTime.now().microsecondsSinceEpoch}.mp4';

    final session = await FFmpegKit.executeWithArguments(
      [
        '-y',
        '-fflags',
        '+genpts',
        '-i',
        inputPath,
        '-map',
        '0:v:0',
        '-map',
        '0:a?',
        '-c',
        'copy',
        '-avoid_negative_ts',
        'make_zero',
        '-movflags',
        '+faststart',
        outputPath,
      ],
    );

    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      throw StateError(l10n.videoNormalizeFailed);
    }

    final outputFile = File(outputPath);

    if (!await outputFile.exists()) {
      throw StateError(l10n.normalizedVideoMissing);
    }

    return outputPath;
  }

  Future<String> _createVideoCover(String videoPath) async {
    final l10n = AppLocalizations.of(context)!;
    final videoFile = File(videoPath);
    final outputPath =
        '${videoFile.parent.path}/cover-${DateTime.now().microsecondsSinceEpoch}.jpg';

    final session = await FFmpegKit.executeWithArguments(
      [
        '-y',
        '-ss',
        '1',
        '-i',
        videoPath,
        '-frames:v',
        '1',
        '-q:v',
        '2',
        outputPath,
      ],
    );

    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      throw StateError(l10n.coverGenerationFailed);
    }

    final coverFile = File(outputPath);

    if (!await coverFile.exists()) {
      throw StateError(l10n.generatedCoverMissing);
    }

    final length = await coverFile.length();

    if (length <= 0) {
      throw StateError(l10n.generatedCoverEmpty);
    }

    return outputPath;
  }

  Future<int> _readVideoDuration(String path) async {
    final session = await FFprobeKit.getMediaInformation(path);
    final information = session.getMediaInformation();

    if (information == null) {
      debugPrint('FFprobe could not read video information');
      return 0;
    }

    final rawDuration = information.getDuration();
    debugPrint('FFprobe duration: $rawDuration');

    if (rawDuration == null) {
      return 0;
    }

    final seconds = double.tryParse(rawDuration);

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

    final video = await _picker.pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null || !mounted) {
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

    final l10n = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (_video == null) {
      _showMessage(l10n.chooseVideoRequired);
      return;
    }

    if (title.isEmpty) {
      _showMessage(l10n.titleRequired);
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    try {
      final user = await ref.read(authProvider.future);

      if (user == null) {
        if (!mounted) {
          return;
        }

        setState(() {
          _isPublishing = false;
        });

        _showMessage(l10n.loginRequired);
        return;
      }

      ref.read(videoUploadQueueProvider.notifier).enqueue(
            VideoUploadRequest(
              userId: user.id,
              authorName: user.displayName,
              videoPath: _video!.path,
              title: title,
              description: description,
              category: _category,
            ),
          );

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isPublishing = false;
      });

      _showMessage(
        l10n.enqueueUploadFailed(error.toString()),
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l10n),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
                children: [
                  _buildVideoSelector(l10n),
                  const SizedBox(height: 26),
                  _buildLabel(
                    l10n.titleEyebrow,
                    l10n.titleLabel,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _titleController,
                    hintText: l10n.videoTitleHint,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel(
                    l10n.aboutEyebrow,
                    l10n.descriptionLabel,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _descriptionController,
                    hintText: l10n.videoDescriptionHint,
                    maxLines: 6,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel(
                    l10n.channelEyebrow,
                    l10n.categoryLabel,
                  ),
                  const SizedBox(height: 12),
                  _buildCategories(l10n),
                  const SizedBox(height: 34),
                  _buildPublishButton(l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: _isPublishing
                ? null
                : () {
                    Navigator.pop(context);
                  },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.newFrame,
                  style: const TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.publishVideo,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSelector(AppLocalizations l10n) {
    return GestureDetector(
      onTap: _isPublishing ? null : _pickVideo,
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(28),
        ),
        child: _video == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.video_library_outlined,
                    color: _acid,
                    size: 42,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.selectVideo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.selectVideoFromDevice,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: _acid,
                      size: 42,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.videoSelected,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _video!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.tapToReselect,
                      style: const TextStyle(
                        color: _acid,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLabel(
    String eyebrow,
    String label,
  ) {
    return Row(
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: _purple,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.7,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: _ink,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required int maxLines,
  }) {
    return TextField(
      controller: controller,
      enabled: !_isPublishing,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFAAA49B),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.72),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFFE3DED5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: _purple,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(AppLocalizations l10n) {
    return Wrap(
      spacing: 8,
      runSpacing: 9,
      children: _categories.map(
        (category) {
          final selected = category == _category;

          return GestureDetector(
            onTap: _isPublishing
                ? null
                : () {
                    setState(() {
                      _category = category;
                    });
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? _purple
                    : Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? _purple
                      : const Color(0xFFD9D4CB),
                ),
              ),
              child: Text(
                localizedTopicLabel(l10n, category),
                style: TextStyle(
                  color: selected ? Colors.white : _ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildPublishButton(AppLocalizations l10n) {
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: _isPublishing ? null : _publish,
        style: FilledButton.styleFrom(
          backgroundColor: _acid,
          disabledBackgroundColor: _acid.withValues(alpha: 0.55),
          foregroundColor: _ink,
          disabledForegroundColor: _ink.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: _isPublishing
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _ink,
                ),
              )
            : Text(
                l10n.continuePublish,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    );
  }
}
