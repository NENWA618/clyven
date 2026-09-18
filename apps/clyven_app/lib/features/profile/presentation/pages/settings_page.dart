import 'package:clyven_app/core/localization/app_locale_provider.dart';
import 'package:clyven_app/core/theme/app_theme.dart';
import 'package:clyven_app/core/theme/app_theme_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedLocale = ref.watch(appLocaleProvider);
    final themeSettings = ref.watch(appThemeProvider);
    final colors = Theme.of(context).colorScheme;
    final isNight = themeSettings.displayMode == ClyvenDisplayMode.night;
    final isZh = Localizations.localeOf(context).languageCode == 'zh';

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, l10n, colors),
            Divider(height: 1, color: colors.onSurface.withOpacity(0.12)),
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
                  _SettingsItem(
                    icon: Icons.person_outline_rounded,
                    title: l10n.accountAndProfile,
                    subtitle: l10n.accountAndProfileSubtitle,
                    onTap: () {
                      // TODO: open account and profile settings
                    },
                  ),
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: Icons.lock_outline_rounded,
                    title: l10n.privacy,
                    subtitle: l10n.privacySubtitle,
                    onTap: () {
                      // TODO: open privacy settings
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
                    icon: Icons.palette_outlined,
                    title: isZh ? '主题颜色' : 'Theme color',
                    subtitle: _themeSummary(themeSettings, isZh),
                    onTap: () {
                      _showThemeSheet(context, isZh);
                    },
                  ),
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: isNight
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: isZh ? '深夜模式' : 'Night mode',
                    subtitle: isNight
                        ? (isZh
                              ? '已开启 · 使用 Clyven 深色背景'
                              : 'On · Clyven dark background')
                        : (isZh
                              ? '白天模式 · 保持 F4F1EA 背景'
                              : 'Day mode · Keep the F4F1EA background'),
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
                    icon: Icons.notifications_none_rounded,
                    title: l10n.notifications,
                    subtitle: l10n.notificationsSettingsSubtitle,
                    onTap: () {
                      // TODO: open notification settings
                    },
                  ),
                  const SizedBox(height: 10),
                  _SettingsItem(
                    icon: Icons.info_outline_rounded,
                    title: l10n.about,
                    subtitle: l10n.aboutSubtitle,
                    onTap: () {
                      // TODO: open about page
                    },
                  ),
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

  String _themeSummary(ClyvenThemeSettings settings, bool isZh) {
    final mode = switch (settings.mode) {
      ClyvenThemeMode.accentOnly => isZh ? '只换强调色' : 'Accent only',
      ClyvenThemeMode.full => isZh ? '完整主题' : 'Full theme',
    };

    final primary = _themeColorLabel(settings.color, isZh);

    if (settings.mode == ClyvenThemeMode.full &&
        settings.color != ClyvenThemeColor.acid) {
      final companion = _themeColorLabel(settings.companionColor, isZh);
      return '$mode · $primary + $companion';
    }

    return '$mode · $primary';
  }

  String _themeColorLabel(ClyvenThemeColor color, bool isZh) {
    return switch (color) {
      ClyvenThemeColor.acid =>
        isZh
            ? 'Clyven 默认 · E5FF58 + 7657FF'
            : 'Clyven Default · E5FF58 + 7657FF',
      ClyvenThemeColor.yellow => isZh ? '黄色' : 'Yellow',
      ClyvenThemeColor.purple => isZh ? '紫色' : 'Purple',
      ClyvenThemeColor.blue => isZh ? '蓝色' : 'Blue',
      ClyvenThemeColor.green => isZh ? '绿色' : 'Green',
      ClyvenThemeColor.orange => isZh ? '橙色' : 'Orange',
      ClyvenThemeColor.pink => isZh ? '粉色' : 'Pink',
      ClyvenThemeColor.cyan => isZh ? '青色' : 'Cyan',
      ClyvenThemeColor.red => isZh ? '红色' : 'Red',
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

  Future<void> _showThemeSheet(BuildContext context, bool isZh) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, child) {
            final settings = ref.watch(appThemeProvider);
            final colors = Theme.of(context).colorScheme;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        isZh ? '主题颜色' : 'Theme color',
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        isZh
                            ? 'E5FF58 永远保留为 Clyven 默认品牌色。'
                            : 'E5FF58 always remains the default Clyven brand color.',
                        style: TextStyle(
                          color: Color(0xFF777168),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        isZh ? '主题模式' : 'Theme mode',
                        style: TextStyle(
                          color: colors.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _ThemeModeCard(
                            icon: Icons.format_color_fill_rounded,
                            title: isZh ? '只换强调色' : 'Accent only',
                            subtitle: isZh
                                ? '只替换原来的黄色部分'
                                : 'Change the yellow accents only',
                            selected:
                                settings.mode == ClyvenThemeMode.accentOnly,
                            onTap: () {
                              ref
                                  .read(appThemeProvider.notifier)
                                  .setMode(ClyvenThemeMode.accentOnly);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _ThemeModeCard(
                            icon: Icons.auto_awesome_rounded,
                            title: isZh ? '完整主题' : 'Full theme',
                            subtitle: isZh
                                ? '强调色、搭配色和背景一起变化'
                                : 'Accent, companion and background change together',
                            selected: settings.mode == ClyvenThemeMode.full,
                            onTap: () {
                              ref
                                  .read(appThemeProvider.notifier)
                                  .setMode(ClyvenThemeMode.full);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        isZh ? '颜色' : 'Color',
                        style: TextStyle(
                          color: colors.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ClyvenThemeColor.values.map((color) {
                        final value = ClyvenTheme.accentFor(color);
                        final selected = settings.color == color;
                        return Tooltip(
                          message: _themeColorLabel(color, isZh),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(appThemeProvider.notifier)
                                  .setColor(color);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: value,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? colors.onSurface
                                      : Colors.white.withOpacity(0.9),
                                  width: selected ? 3 : 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x18000000),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: selected
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: value.computeLuminance() > 0.55
                                          ? colors.onSurface
                                          : Colors.white,
                                      size: 23,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (settings.mode == ClyvenThemeMode.full &&
                        settings.color != ClyvenThemeColor.acid) ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          isZh ? '搭配色' : 'Companion color',
                          style: TextStyle(
                            color: colors.secondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          isZh
                              ? '这里只显示 Clyven 允许的搭配，避免出现不协调的组合。'
                              : 'Only Clyven-approved pairings are shown.',
                          style: TextStyle(
                            color: colors.onSurface.withOpacity(0.60),
                            fontSize: 10,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children:
                            ClyvenTheme.allowedCompanionsFor(
                              settings.color,
                            ).map((companion) {
                              final value = ClyvenTheme.secondaryForPair(
                                settings.color,
                                companion,
                              );
                              final selected =
                                  settings.companionColor == companion;

                              return Tooltip(
                                message: _themeColorLabel(companion, isZh),
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(appThemeProvider.notifier)
                                        .setCompanionColor(companion);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: value,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: selected
                                            ? colors.onSurface
                                            : colors.onSurface.withOpacity(
                                                0.18,
                                              ),
                                        width: selected ? 3 : 1.5,
                                      ),
                                    ),
                                    child: selected
                                        ? Icon(
                                            Icons.check_rounded,
                                            color:
                                                value.computeLuminance() > 0.55
                                                ? colors.onSurface
                                                : Colors.white,
                                            size: 21,
                                          )
                                        : null,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colors.brightness == Brightness.dark
                            ? Theme.of(context).cardColor
                            : Colors.white.withOpacity(0.62),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colors.brightness == Brightness.dark
                              ? const Color(0xFF383838)
                              : const Color(0xFFE3DED5),
                        ),
                      ),
                      child: Text(
                        _themeSummary(settings, isZh),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
                    : Colors.white.withOpacity(0.72),
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

class _ThemeModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          // Unselected mode cards stay transparent.
          color: selected
              ? colors.primary.withOpacity(0.20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.onSurface.withOpacity(0.24),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: selected
                  ? colors.secondary
                  : colors.secondary.withOpacity(0.78),
              size: 22,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: colors.onSurface.withOpacity(0.62),
                fontSize: 9,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
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
              : Colors.white.withOpacity(0.72),
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
                color: colors.secondary.withOpacity(0.08),
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
