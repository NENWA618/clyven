import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../../l10n/web_l10n.dart';
import '../../services/auth_ui_state.dart';
import '../../services/web_client.dart';

class SettingsPage extends StatefulComponent {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _signingOut = false;
  StreamSubscription<AuthUiSnapshot>? _authSub;

  @override
  void initState() {
    super.initState();
    _authSub = AuthUiState.instance.stream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    unawaited(_authSub?.cancel());
    super.dispose();
  }

  Future<void> _signOut() async {
    if (_signingOut) return;

    setState(() => _signingOut = true);

    try {
      await webClient.auth.signOutDevice();
    } catch (_) {
      // Still clear the local UI state below even if the network call fails.
    }

    AuthUiState.instance.signOut();

    if (!mounted) return;

    Router.maybeOf(context)?.push('/');
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;
    final signedIn = AuthUiState.instance.snapshot.signedIn;

    if (!signedIn) {
      return div(classes: 'settings-page', [
        _header(l10n),
        p(classes: 'settings-signed-out', [.text(l10n.settingsSignedOut)]),
      ]);
    }

    return div(classes: 'settings-page', [
      _header(l10n),
      div(classes: 'settings-section-title', [.text(l10n.accountSectionTitle)]),
      _settingsItem(
        title: l10n.accountAndProfile,
        subtitle: l10n.accountAndProfileSubtitle,
        to: '/settings/account',
      ),
      _settingsItem(
        title: l10n.privacy,
        subtitle: l10n.privacySubtitle,
        to: '/settings/privacy',
      ),
      _settingsItem(
        title: l10n.notificationsTitle,
        subtitle: l10n.notificationsSettingsSubtitle,
        to: '/settings/notifications',
      ),
      _settingsItem(
        title: l10n.about,
        subtitle: l10n.aboutSubtitle,
        to: '/settings/about',
      ),
      div(classes: 'settings-section-title', [
        .text(l10n.identitySectionTitle),
      ]),
      button(
        type: ButtonType.button,
        classes: 'settings-signout-button',
        attributes: _signingOut ? {'disabled': 'disabled'} : null,
        onClick: _signingOut ? null : _signOut,
        [.text(l10n.logoutCurrentIdentity)],
      ),
    ]);
  }

  Component _header(WebStrings l10n) {
    return div(classes: 'settings-header', [
      Link(to: '/', classes: 'settings-back-button', child: span([.text('←')])),
      div(classes: 'settings-header-copy', [
        div(classes: 'settings-eyebrow', [.text(l10n.settingsEyebrow)]),
        h1([.text(l10n.settings)]),
      ]),
    ]);
  }

  Component _settingsItem({
    required String title,
    required String subtitle,
    required String to,
  }) {
    return Link(
      to: to,
      classes: 'settings-item',
      child: div(classes: 'settings-item-inner', [
        div(classes: 'settings-item-copy', [
          div(classes: 'settings-item-title', [.text(title)]),
          div(classes: 'settings-item-subtitle', [.text(subtitle)]),
        ]),
        span(classes: 'settings-item-chevron', [.text('›')]),
      ]),
    );
  }
}
