import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/user_profile.dart';
import '../providers/my_profile_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final UserProfile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late final TextEditingController _username;
  late final TextEditingController _displayName;
  late final TextEditingController _bio;
  Uint8List? _avatarBytes;
  bool _removeAvatar = false;
  bool _saving = false;

  bool get _zh => Localizations.localeOf(context).languageCode == 'zh';

  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: widget.profile.username);
    _displayName = TextEditingController(text: widget.profile.displayName);
    _bio = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    _username.dispose();
    _displayName.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
      maxWidth: 1200,
    );
    if (file == null) {
      return;
    }
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() {
      _avatarBytes = bytes;
      _removeAvatar = false;
    });
  }

  Future<void> _save() async {
    if (_saving ||
        _username.text.trim().isEmpty ||
        _displayName.text.trim().isEmpty) {
      return;
    }
    setState(() => _saving = true);
    final authSaved = await ref
        .read(authProvider.notifier)
        .updateProfile(
          username: _username.text,
          displayName: _displayName.text,
          avatarBytes: _avatarBytes,
          removeAvatar: _removeAvatar,
        );
    if (authSaved) {
      try {
        await ref.read(myProfileProvider.notifier).updateBio(_bio.text);
        if (mounted) Navigator.pop(context, true);
        return;
      } catch (_) {}
    }
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_zh ? '保存失败，请重试' : 'Could not save profile')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    final muted = isDark ? const Color(0xFFA7A29A) : const Color(0xFF77736C);
    final card = isDark ? const Color(0xFF191918) : Colors.white;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context, scheme, isDark),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatarCard(scheme, card, muted),
                    const SizedBox(height: 24),
                    _sectionLabel(
                      _zh ? '公开身份' : 'PUBLIC IDENTITY',
                      scheme.primary,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: _cardDecoration(context, card),
                      child: Column(
                        children: [
                          _profileField(
                            controller: _displayName,
                            label: _zh ? '显示名称' : 'Display name',
                            hint: _zh ? '其他人看到的名称' : 'Name shown to others',
                            icon: Icons.badge_outlined,
                            scheme: scheme,
                            muted: muted,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          _profileField(
                            controller: _username,
                            label: _zh ? '用户名' : 'Username',
                            hint: _zh ? '你的唯一账号名称' : 'Your unique handle',
                            icon: Icons.alternate_email_rounded,
                            scheme: scheme,
                            muted: muted,
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel(_zh ? '关于你' : 'ABOUT YOU', scheme.primary),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: _cardDecoration(context, card),
                      child: _profileField(
                        controller: _bio,
                        label: _zh ? '个人简介' : 'Bio',
                        hint: _zh
                            ? '说说你的创作、兴趣或正在学习的事。'
                            : 'Share what you create, love, or learn.',
                        icon: Icons.notes_rounded,
                        scheme: scheme,
                        muted: muted,
                        minLines: 4,
                        maxLines: 6,
                        maxLength: 300,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 15,
                          color: muted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _zh
                                ? '你的邮箱和登录信息不会显示在公开资料中。'
                                : 'Your email and sign-in details stay private.',
                            style: TextStyle(
                              color: muted,
                              fontSize: 11,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.96),
            border: Border(top: BorderSide(color: scheme.outlineVariant)),
          ),
          child: SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: _saving ? null : _save,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: _saving
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      )
                    : Row(
                        key: const ValueKey('save'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_rounded, size: 20),
                          const SizedBox(width: 9),
                          Text(
                            _zh ? '保存更改' : 'Save changes',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme scheme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      child: Row(
        children: [
          _roundAction(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
            scheme: scheme,
            isDark: isDark,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _zh ? 'PERSONAL PROFILE' : 'PERSONAL PROFILE',
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _zh ? '编辑资料' : 'Edit profile',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 25,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          _roundAction(
            icon: Icons.close_rounded,
            onTap: () => Navigator.pop(context),
            scheme: scheme,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarCard(ColorScheme scheme, Color card, Color muted) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(context, card),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Container(
                  width: 92,
                  height: 92,
                  color: const Color(0xFF171714),
                  child: _avatarBytes != null
                      ? Image.memory(_avatarBytes!, fit: BoxFit.cover)
                      : !_removeAvatar && widget.profile.avatarUrl.isNotEmpty
                      ? Image.network(
                          widget.profile.avatarUrl,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            widget.profile.displayName.isEmpty
                                ? '?'
                                : widget.profile.displayName[0].toUpperCase(),
                            style: TextStyle(
                              color: scheme.primary,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                right: -7,
                bottom: -7,
                child: Material(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    onTap: _pickAvatar,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.photo_camera_outlined,
                        size: 18,
                        color: scheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _zh ? '个人头像' : 'Profile photo',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _zh ? '选择清晰、容易辨认的照片。' : 'Choose a clear, recognizable image.',
                  style: TextStyle(color: muted, fontSize: 11, height: 1.45),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    TextButton(
                      onPressed: _pickAvatar,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 32),
                      ),
                      child: Text(_zh ? '更换照片' : 'Change photo'),
                    ),
                    if (widget.profile.avatarUrl.isNotEmpty ||
                        _avatarBytes != null)
                      TextButton(
                        onPressed: () => setState(() {
                          _avatarBytes = null;
                          _removeAvatar = true;
                        }),
                        style: TextButton.styleFrom(
                          foregroundColor: scheme.error,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 32),
                        ),
                        child: Text(_zh ? '移除' : 'Remove'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required ColorScheme scheme,
    required Color muted,
    TextInputAction? textInputAction,
    int minLines = 1,
    int maxLines = 1,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      style: TextStyle(
        color: scheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: minLines > 1,
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: minLines > 1 ? 66 : 0),
          child: Icon(icon, size: 19, color: scheme.primary),
        ),
        labelStyle: TextStyle(color: muted, fontSize: 12),
        hintStyle: TextStyle(
          color: muted.withValues(alpha: 0.65),
          fontSize: 12,
        ),
        filled: true,
        fillColor: scheme.surface,
        counterStyle: TextStyle(color: muted, fontSize: 10),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 9,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.7,
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context, Color color) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: theme.dividerColor),
      boxShadow: theme.brightness == Brightness.light
          ? const [
              BoxShadow(
                color: Color(0x0A171714),
                blurRadius: 26,
                offset: Offset(0, 10),
              ),
            ]
          : null,
    );
  }

  Widget _roundAction({
    required IconData icon,
    required VoidCallback onTap,
    required ColorScheme scheme,
    required bool isDark,
  }) {
    return Material(
      color: isDark ? const Color(0xFF191918) : Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
