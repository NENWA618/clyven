import 'package:clyven_app/core/localization/localized_error_message.dart';
import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/video_content_type.dart';
import '../providers/video_upload_queue_provider.dart';

class CreateVideoPage extends ConsumerStatefulWidget {
  final VideoContentType contentType;

  const CreateVideoPage({super.key, this.contentType = VideoContentType.video});

  @override
  ConsumerState<CreateVideoPage> createState() {
    return _CreateVideoPageState();
  }
}

class _CreateVideoPageState extends ConsumerState<CreateVideoPage> {
  static const Color _ink = Color(0xFF161616);

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

  Color get _background => Theme.of(context).colorScheme.surface;
  Color get _purple => Theme.of(context).colorScheme.secondary;
  Color get _acid => Theme.of(context).colorScheme.primary;

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

    final video = await _picker.pickVideo(source: ImageSource.gallery);

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

      ref
          .read(videoUploadQueueProvider.notifier)
          .enqueue(
            VideoUploadRequest(
              userId: user.id,
              authorName: user.displayName,
              videoPath: _video!.path,
              title: title,
              description: description,
              category: _category,
              contentType: widget.contentType,
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
        l10n.enqueueUploadFailed(localizedErrorMessage(l10n, error)),
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
                  if (widget.contentType == VideoContentType.short) ...[
                    const SizedBox(height: 12),
                    _buildShortGuidance(l10n),
                  ],
                  const SizedBox(height: 26),
                  _buildLabel(l10n.titleEyebrow, l10n.titleLabel),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _titleController,
                    hintText: l10n.videoTitleHint,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel(l10n.aboutEyebrow, l10n.descriptionLabel),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _descriptionController,
                    hintText: l10n.videoDescriptionHint,
                    maxLines: 6,
                  ),
                  const SizedBox(height: 24),
                  _buildLabel(l10n.channelEyebrow, l10n.categoryLabel),
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
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

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
                color: isDark
                    ? const Color(0xFF222222)
                    : Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.close_rounded),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contentType == VideoContentType.short
                      ? l10n.shortContentType
                      : l10n.newFrame,
                  style: TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.contentType == VideoContentType.short
                      ? l10n.publishShort
                      : l10n.publishVideo,
                  style: TextStyle(
                    color: scheme.onSurface,
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
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _isPublishing ? null : _pickVideo,
      child: Container(
        height: widget.contentType == VideoContentType.short ? 330 : 210,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF222222) : _ink,
          borderRadius: BorderRadius.circular(28),
          border: isDark ? Border.all(color: const Color(0xFF383838)) : null,
        ),
        child: _video == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.contentType == VideoContentType.short
                        ? Icons.stay_current_portrait_rounded
                        : Icons.video_library_outlined,
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
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded, color: _acid, size: 42),
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
                      style: TextStyle(
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

  Widget _buildShortGuidance(AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.primary.withValues(alpha: .24)),
      ),
      child: Row(
        children: [
          Icon(Icons.crop_portrait_rounded, color: scheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.shortPortraitGuidance,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 11,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String eyebrow, String label) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            color: _purple,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.7,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: scheme.onSurface,
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
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      style: TextStyle(color: scheme.onSurface),
      enabled: !_isPublishing,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF8F8A83) : const Color(0xFFAAA49B),
        ),
        filled: true,
        fillColor: isDark
            ? const Color(0xFF222222)
            : Colors.white.withValues(alpha: 0.72),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF383838) : const Color(0xFFE3DED5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _purple, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildCategories(AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 9,
      children: _categories.map((category) {
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
              color: selected
                  ? scheme.secondary
                  : (scheme.brightness == Brightness.dark
                        ? const Color(0xFF222222)
                        : Colors.white.withValues(alpha: 0.72)),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected
                    ? scheme.secondary
                    : (scheme.brightness == Brightness.dark
                          ? const Color(0xFF383838)
                          : const Color(0xFFD9D4CB)),
              ),
            ),
            child: Text(
              localizedTopicLabel(l10n, category),
              style: TextStyle(
                color: selected ? scheme.onSecondary : scheme.onSurface,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPublishButton(AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: _isPublishing ? null : _publish,
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.55),
          foregroundColor: scheme.onPrimary,
          disabledForegroundColor: scheme.onPrimary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: _isPublishing
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.onPrimary,
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
