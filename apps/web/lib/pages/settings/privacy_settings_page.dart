import 'dart:async';

import 'package:glyphora_backend_client/backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/settings_header.dart';
import '../../l10n/web_l10n.dart';
import '../../services/web_client.dart';

class PrivacySettingsPage extends StatefulComponent {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _loading = true;
  PrivacySettings? _settings;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final settings = await webClient.privacySettings.get();
      if (!mounted) return;
      setState(() {
        _settings = settings;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _update({
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
  }) async {
    final current = _settings;
    if (current != null) {
      setState(() {
        _settings = current.copyWith(
          privateAccount: privateAccount,
          allowComments: allowComments,
          showActivityStatus: showActivityStatus,
        );
      });
    }

    final updated = await webClient.privacySettings.update(
      privateAccount: privateAccount,
      allowComments: allowComments,
      showActivityStatus: showActivityStatus,
    );

    if (!mounted) return;
    setState(() => _settings = updated);
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;
    final settings = _settings;

    return div(classes: 'settings-page', [
      SettingsHeader(eyebrow: l10n.settingsEyebrow, title: l10n.privacy),
      if (_loading)
        div(classes: 'settings-loading', [.text(l10n.loading)])
      else if (settings == null)
        div(classes: 'settings-loading', [.text(l10n.searchLoadFailed)])
      else ...[
        _switchItem(
          title: l10n.privateAccount,
          subtitle: l10n.privateAccountSubtitle,
          value: settings.privateAccount,
          onChanged: (value) => unawaited(_update(privateAccount: value)),
        ),
        _switchItem(
          title: l10n.allowComments,
          subtitle: l10n.allowCommentsSubtitle,
          value: settings.allowComments,
          onChanged: (value) => unawaited(_update(allowComments: value)),
        ),
        _switchItem(
          title: l10n.showActivityStatus,
          subtitle: l10n.showActivityStatusSubtitle,
          value: settings.showActivityStatus,
          onChanged: (value) => unawaited(_update(showActivityStatus: value)),
        ),
      ],
    ]);
  }

  Component _switchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return div(classes: 'settings-switch-item', [
      div(classes: 'settings-item-copy', [
        div(classes: 'settings-item-title', [.text(title)]),
        div(classes: 'settings-item-subtitle', [.text(subtitle)]),
      ]),
      label(classes: 'settings-toggle', [
        input<bool>(
          type: InputType.checkbox,
          checked: value,
          onChange: onChanged,
        ),
        span(classes: 'settings-toggle-track', []),
      ]),
    ]);
  }
}
