import 'dart:async';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/settings_header.dart';
import '../../l10n/web_l10n.dart';
import '../../services/web_client.dart';

class NotificationSettingsPage extends StatefulComponent {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _loading = true;
  NotificationSettings? _settings;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final settings = await webClient.notificationSettings.get();
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
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
  }) async {
    final current = _settings;
    if (current != null) {
      setState(() {
        _settings = current.copyWith(
          pushEnabled: pushEnabled,
          likeEnabled: likeEnabled,
          commentEnabled: commentEnabled,
          followEnabled: followEnabled,
        );
      });
    }

    final updated = await webClient.notificationSettings.update(
      pushEnabled: pushEnabled,
      likeEnabled: likeEnabled,
      commentEnabled: commentEnabled,
      followEnabled: followEnabled,
    );

    if (!mounted) return;
    setState(() => _settings = updated);
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;
    final settings = _settings;

    return div(classes: 'settings-page', [
      SettingsHeader(
        eyebrow: l10n.settingsEyebrow,
        title: l10n.notificationsTitle,
      ),
      if (_loading)
        div(classes: 'settings-loading', [.text(l10n.loading)])
      else if (settings == null)
        div(classes: 'settings-loading', [.text(l10n.searchLoadFailed)])
      else ...[
        _switchItem(
          title: l10n.pushNotifications,
          subtitle: l10n.pushNotificationsSubtitle,
          value: settings.pushEnabled,
          onChanged: (value) => unawaited(_update(pushEnabled: value)),
        ),
        div(classes: 'settings-section-title', [
          .text(l10n.notificationTypesSectionTitle),
        ]),
        div(
          classes: settings.pushEnabled
              ? 'settings-subgroup'
              : 'settings-subgroup is-disabled',
          [
            _switchItem(
              title: l10n.likeNotifications,
              subtitle: l10n.likeNotificationsSubtitle,
              value: settings.likeEnabled,
              onChanged: settings.pushEnabled
                  ? (value) => unawaited(_update(likeEnabled: value))
                  : null,
            ),
            _switchItem(
              title: l10n.commentNotifications,
              subtitle: l10n.commentNotificationsSubtitle,
              value: settings.commentEnabled,
              onChanged: settings.pushEnabled
                  ? (value) => unawaited(_update(commentEnabled: value))
                  : null,
            ),
            _switchItem(
              title: l10n.followNotifications,
              subtitle: l10n.followNotificationsSubtitle,
              value: settings.followEnabled,
              onChanged: settings.pushEnabled
                  ? (value) => unawaited(_update(followEnabled: value))
                  : null,
            ),
          ],
        ),
      ],
    ]);
  }

  Component _switchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
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
          disabled: onChanged == null,
          onChange: onChanged ?? (_) {},
        ),
        span(classes: 'settings-toggle-track', []),
      ]),
    ]);
  }
}
