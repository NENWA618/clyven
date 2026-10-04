import 'package:clyven_app/core/localization/app_locale_provider.dart';
import 'package:clyven_app/core/media/playback_data_saver_provider.dart';
import 'package:clyven_app/core/theme/app_theme.dart';
import 'package:clyven_app/core/theme/app_theme_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/utils/require_login.dart';
import '../../../notifications/presentation/pages/notification_settings_page.dart';
import '../providers/my_profile_provider.dart';
import 'about_page.dart';
import 'edit_profile_page.dart';
import 'privacy_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedLocale = ref.watch(appLocaleProvider);
    final themeSettings = ref.watch(appThemeProvider);
    final dataSaverEnabled = ref.watch(playbackDataSaverProvider);
    final authAsync = ref.watch(authProvider);
    final isAuthenticated = authAsync.value != null;
    final colors = Theme.of(context).colorScheme;
    final isNight = themeSettings.displayMode == ClyvenDisplayMode.night;
    final isZh = Localizations.localeOf(context).languageCode == 'zh';

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, l10n, colors),
            Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.12)),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                children: [
                  _buildSectionTitle(
                    l10n.accountSectionEyebrow,
                    l10n.accountSectionTitle,
                    colors,
                  ),
                  const SizedBox(height: 12),
                  if (isAuthenticated) ...[
                    _SettingsItem(
                      icon: Icons.person_outline_rounded,
                      title: l10n.accountAndProfile,
                      subtitle: l10n.accountAndProfileSubtitle,
                      onTap: () async {
                        final profile = ref.read(myProfileProvider).value;
                        if (profile == null) {
                          ref.invalidate(myProfileProvider);
                          return;
                        }

                        final changed = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfilePage(profile: profile),
                          ),
                        );
                        if (changed == true) {
                          ref.invalidate(myProfileProvider);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _SettingsItem(
                      icon: Icons.lock_outline_rounded,
                      title: l10n.privacy,
                      subtitle: l10n.privacySubtitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPage(),
                          ),
                        );
                      },
                    ),
                  ] else
                    _SettingsItem(
                      icon: Icons.login_rounded,
                      title: isZh
                          ? '\u767b\u5f55 / \u6ce8\u518c'
                          : 'Sign in / Register',
                      subtitle: isZh
                          ? '\u767b\u5f55\u540e\u7ba1\u7406\u8d26\u53f7\u4e0e\u4e2a\u4eba\u8d44\u6599'
                          : 'Sign in to manage your account and profile',
                      onTap: () async {
                        await requireLogin(context, ref);
                      },
                    ),
                  const SizedBox(height: 30),
                  _buildSectionTitle(
                    l10n.appSectionEyebrow,
                    l10n.appSectionTitle,
                    colors,
                  ),
                  const SizedBox(height: 12),
                  _SettingsItem(
                    icon: Icons.language_rounded,
                    title: l10n.language,
                    subtitle: _languageLabel(selectedLocale, l10n),
                    onTap: () {
                      _showLanguageSheet(context, ref, l10n, selectedLocale);
                    },
                  ),
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: isNight
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: isZh ? '\u6df1\u591c\u6a21\u5f0f' : 'Night mode',
                    subtitle: isNight
                        ? (isZh
                              ? '\u5df2\u5f00\u542f \u00b7 \u4f7f\u7528 Clyven \u6df1\u8272\u80cc\u666f'
                              : 'On - Clyven dark background')
                        : (isZh
                              ? '\u767d\u5929\u6a21\u5f0f \u00b7 \u4fdd\u6301 F4F1EA \u80cc\u666f'
                              : 'Day mode - Keep the F4F1EA background'),
                    onTap: () {
                      ref
                          .read(appThemeProvider.notifier)
                          .setDisplayMode(
                            isNight
                                ? ClyvenDisplayMode.day
                                : ClyvenDisplayMode.night,
                          );
                    },
                    trailing: Switch(
                      value: isNight,
                      onChanged: (enabled) {
                        ref
                            .read(appThemeProvider.notifier)
                            .setDisplayMode(
                              enabled
                                  ? ClyvenDisplayMode.night
                                  : ClyvenDisplayMode.day,
                            );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: Icons.data_saver_on_rounded,
                    title: isZh
                        ? '\u7701\u6d41\u91cf\u6a21\u5f0f'
                        : 'Data Saver',
                    subtitle: dataSaverEnabled
                        ? (isZh
                              ? '\u5df2\u5f00\u542f \u00b7 \u65b0\u89c6\u9891\u4f18\u5148\u4f7f\u7528 360p'
                              : 'On - New playback prefers 360p')
                        : (isZh
                              ? '\u5df2\u5173\u95ed \u00b7 \u4f7f\u7528\u81ea\u52a8\u753b\u8d28'
                              : 'Off - Adaptive quality'),
                    onTap: () {
                      ref
                          .read(playbackDataSaverProvider.notifier)
                          .setEnabled(!dataSaverEnabled);
                    },
                    trailing: Switch(
                      value: dataSaverEnabled,
                      onChanged: (enabled) {
                        ref
                            .read(playbackDataSaverProvider.notifier)
                            .setEnabled(enabled);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isAuthenticated) ...[
                    _SettingsItem(
                      icon: Icons.notifications_none_rounded,
                      title: l10n.notifications,
                      subtitle: l10n.notificationsSettingsSubtitle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationSettingsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: Icons.info_outline_rounded,
                    title: l10n.about,
                    subtitle: l10n.aboutSubtitle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutPage()),
                      );
                    },
                  ),
                  if (isAuthenticated) ...[
                    const SizedBox(height: 36),
                    _buildSectionTitle(
                      l10n.identitySectionEyebrow,
                      l10n.currentIdentity,
                      colors,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () async {
                          await ref.read(authProvider.notifier).logout();

                          if (!context.mounted) {
                            return;
                          }

                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.onSurface,
                          side: const BorderSide(color: Color(0xFFCAC5BB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout_rounded, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              l10n.logoutCurrentIdentity,
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      l10n.appName.toUpperCase(),
                      style: TextStyle(
                        color: Color(0xFFAAA49B),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _languageLabel(Locale? locale, AppLocalizations l10n) {
    if (locale == null) {
      return l10n.languageSystem;
    }

    return switch (locale.languageCode) {
      'en' => l10n.languageEnglish,
      'zh' => l10n.languageChinese,
      _ => l10n.languageSettingsSubtitle,
    };
  }

  Future<void> _showLanguageSheet(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Locale? selectedLocale,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        final colors = Theme.of(sheetContext).colorScheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    l10n.language,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _LanguageOption(
                  label: l10n.languageSystem,
                  selected: selectedLocale == null,
                  onTap: () {
                    ref.read(appLocaleProvider.notifier).useSystem();
                    Navigator.pop(sheetContext);
                  },
                ),
                _LanguageOption(
                  label: l10n.languageEnglish,
                  selected: selectedLocale?.languageCode == 'en',
                  onTap: () {
                    ref.read(appLocaleProvider.notifier).useEnglish();
                    Navigator.pop(sheetContext);
                  },
                ),
                _LanguageOption(
                  label: l10n.languageChinese,
                  selected: selectedLocale?.languageCode == 'zh',
                  onTap: () {
                    ref.read(appLocaleProvider.notifier).useSimplifiedChinese();
                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colors,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 20, 12),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.brightness == Brightness.dark
                    ? Theme.of(context).cardColor
                    : Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.brightness == Brightness.dark
                      ? const Color(0xFF383838)
                      : const Color(0xFFE3DED5),
                ),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: colors.onSurface,
                size: 21,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsEyebrow,
                  style: TextStyle(
                    color: colors.secondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.settings,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String eyebrow, String title, ColorScheme colors) {
    return Row(
      children: [
        Text(
          eyebrow,
          style: TextStyle(
            color: colors.secondary,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: onTap,
      title: Text(
        label,
        style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.w700),
      ),
      trailing: selected
          ? Icon(Icons.check_circle_rounded, color: colors.secondary)
          : null,
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: colors.brightness == Brightness.dark
              ? Theme.of(context).cardColor
              : Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.brightness == Brightness.dark
                ? const Color(0xFF383838)
                : const Color(0xFFE3DED5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.secondary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: colors.secondary, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Color(0xFF99938A), fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF99938A),
                  size: 21,
                ),
          ],
        ),
      ),
    );
  }
}
