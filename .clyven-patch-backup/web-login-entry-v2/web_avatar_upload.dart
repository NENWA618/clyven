import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/web_client.dart';

class WebAvatarUpload extends StatefulComponent {
  const WebAvatarUpload({super.key});

  @override
  State<WebAvatarUpload> createState() => _WebAvatarUploadState();
}

class _WebAvatarUploadState extends State<WebAvatarUpload> {
  bool _loading = true;
  bool _uploading = false;
  bool _signedIn = false;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    unawaited(_loadProfile());
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await webClient.userProfileEdit.get();

      if (!mounted) return;

      setState(() {
        _avatarUrl = profile.imageUrl?.toString();
        _signedIn = true;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _signedIn = false;
        _loading = false;
      });
    }
  }

  Future<Uint8List?> _pickImage() async {
    final input = html.FileUploadInputElement()
      ..accept = 'image/jpeg,image/png,image/webp'
      ..multiple = false;

    input.click();

    await input.onChange.first;

    final files = input.files;

    if (files == null || files.isEmpty) {
      return null;
    }

    final file = files.first;

    if (file.size > 10 * 1024 * 1024) {
      html.window.alert('头像图片不能超过 10 MB');
      return null;
    }

    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoadEnd.first;

    final result = reader.result;

    if (result is ByteBuffer) {
      return Uint8List.view(result);
    }

    if (result is Uint8List) {
      return result;
    }

    throw StateError('无法读取所选图片');
  }

  Future<void> _upload() async {
    if (_loading || _uploading) {
      return;
    }

    if (!_signedIn) {
      html.window.alert('请先登录 Clyven Web，再上传头像');
      return;
    }

    final bytes = await _pickImage();

    if (bytes == null || bytes.isEmpty) {
      return;
    }

    setState(() {
      _uploading = true;
    });

    try {
      final profile = await webClient.userProfileEdit.setUserImage(
        ByteData.sublistView(bytes),
      );

      if (!mounted) return;

      setState(() {
        _avatarUrl = profile.imageUrl?.toString();
        _signedIn = true;
        _uploading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _uploading = false;
        });
      }

      html.window.alert('头像上传失败：$error');
    }
  }

  Component _avatarVisual() {
    final avatarUrl = _avatarUrl?.trim();

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      final safeUrl = avatarUrl.replaceAll("'", '%27');

      return span(
        classes: 'web-avatar-upload-image',
        attributes: {'style': "background-image:url('$safeUrl');"},
        [],
      );
    }

    return span(classes: 'web-avatar-upload-placeholder', [
      .text(_signedIn ? '我' : '人'),
    ]);
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes:
          'web-avatar-upload'
          '${_signedIn ? ' is-signed-in' : ' is-guest'}'
          '${_uploading ? ' is-uploading' : ''}',
      [
        button(
          type: ButtonType.button,
          classes: 'web-avatar-upload-button',
          attributes: {
            'title': _signedIn ? '更换头像' : '登录后可上传头像',
            'aria-label': _signedIn ? '更换头像' : '登录后可上传头像',
          },
          onClick: _upload,
          [
            _avatarVisual(),
            span(classes: 'web-avatar-upload-camera', [
              .text(_uploading ? '…' : '＋'),
            ]),
          ],
        ),
      ],
    );
  }
}
