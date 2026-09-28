import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../../components/settings_header.dart';
import '../../l10n/web_l10n.dart';
import '../../services/auth_ui_state.dart';
import '../../services/web_client.dart';

class AccountSettingsPage extends StatefulComponent {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool _loading = true;
  bool _saving = false;
  bool _uploading = false;
  String? _error;

  String _displayName = '';
  String _username = '';
  String _bio = '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final profile = await webClient.userProfileEdit.get();
      final stats = await webClient.social.getMyProfileStats();

      if (!mounted) return;

      setState(() {
        _displayName = profile.fullName ?? '';
        _username = profile.userName ?? '';
        _bio = stats.bio;
        _avatarUrl = profile.imageUrl?.toString();
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    if (_uploading) return;

    final input = html.FileUploadInputElement()
      ..accept = 'image/jpeg,image/png,image/webp'
      ..multiple = false;

    input.click();
    await input.onChange.first;

    final files = input.files;
    if (files == null || files.isEmpty) return;

    final file = files.first;

    if (file.size > 10 * 1024 * 1024) {
      html.window.alert(context.l10n.avatarTooLarge);
      return;
    }

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    final result = reader.result;
    final Uint8List bytes;
    if (result is ByteBuffer) {
      bytes = Uint8List.view(result);
    } else if (result is Uint8List) {
      bytes = result;
    } else {
      html.window.alert(context.l10n.cannotReadImage);
      return;
    }

    setState(() => _uploading = true);

    try {
      final profile = await webClient.userProfileEdit.setUserImage(
        ByteData.sublistView(bytes),
      );

      if (!mounted) return;

      setState(() {
        _avatarUrl = profile.imageUrl?.toString();
        _uploading = false;
      });

      AuthUiState.instance.update(
        AuthUiSnapshot(
          signedIn: true,
          avatarUrl: _avatarUrl,
          displayName: _displayName.isEmpty ? null : _displayName,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      setState(() => _uploading = false);
      html.window.alert(context.l10n.avatarUploadFailed(error));
    }
  }

  Future<void> _save() async {
    if (_saving || _displayName.trim().isEmpty || _username.trim().isEmpty) {
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      await webClient.userProfileEdit.changeFullName(_displayName.trim());
      await webClient.userProfileEdit.changeUserName(_username.trim());
      await webClient.social.updateBio(_bio.trim());

      if (!mounted) return;

      AuthUiState.instance.update(
        AuthUiSnapshot(
          signedIn: true,
          avatarUrl: _avatarUrl,
          displayName: _displayName.trim(),
        ),
      );

      Router.maybeOf(context)?.push('/settings');
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _saving = false;
        _error = context.l10n.saveFailed;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    if (_loading) {
      return div(classes: 'settings-page', [
        SettingsHeader(
          eyebrow: l10n.settingsEyebrow,
          title: l10n.accountAndProfile,
        ),
        div(classes: 'settings-loading', [.text(l10n.loading)]),
      ]);
    }

    return div(classes: 'settings-page', [
      SettingsHeader(
        eyebrow: l10n.settingsEyebrow,
        title: l10n.accountAndProfile,
      ),
      div(classes: 'account-avatar-row', [
        _avatarVisual(),
        div(classes: 'account-avatar-copy', [
          div(classes: 'account-avatar-title', [.text(l10n.account)]),
          p([.text(l10n.changeAvatarHint)]),
          button(
            type: ButtonType.button,
            classes: 'settings-secondary-button',
            attributes: _uploading ? {'disabled': 'disabled'} : null,
            onClick: _uploading ? null : _pickAndUploadAvatar,
            [.text(_uploading ? l10n.uploading : l10n.changeAvatar)],
          ),
        ]),
      ]),
      div(classes: 'settings-field', [
        label([.text(l10n.displayName)]),
        input<String>(
          value: _displayName,
          onInput: (value) => setState(() => _displayName = value),
        ),
      ]),
      div(classes: 'settings-field', [
        label([.text(l10n.username)]),
        input<String>(
          value: _username,
          onInput: (value) => setState(() => _username = value),
        ),
      ]),
      div(classes: 'settings-field', [
        label([.text(l10n.bio)]),
        textarea([
          .text(_bio),
        ], onInput: (value) => setState(() => _bio = value)),
      ]),
      if (_error != null) div(classes: 'web-auth-error', [.text(_error!)]),
      button(
        type: ButtonType.button,
        classes: 'settings-primary-button',
        attributes: _saving ? {'disabled': 'disabled'} : null,
        onClick: _saving ? null : _save,
        [.text(_saving ? l10n.saving : l10n.saveChanges)],
      ),
    ]);
  }

  Component _avatarVisual() {
    final avatarUrl = _avatarUrl?.trim();

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      final safeUrl = avatarUrl.replaceAll("'", '%27');

      return span(
        classes: 'account-avatar-image',
        attributes: {'style': "background-image:url('$safeUrl');"},
        [],
      );
    }

    final initial = _displayName.trim().isNotEmpty
        ? _displayName.trim().substring(0, 1).toUpperCase()
        : 'C';

    return span(classes: 'account-avatar-placeholder', [.text(initial)]);
  }
}
