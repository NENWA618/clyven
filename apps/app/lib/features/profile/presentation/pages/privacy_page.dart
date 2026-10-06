import 'package:glyphora_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/privacy_settings_provider.dart';

class PrivacyPage extends ConsumerWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final settingsAsync = ref.watch(privacySettingsProvider);
    final notifier = ref.read(privacySettingsProvider.notifier);

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, l10n, colors),
            Divider(height: 1, color: colors.onSurface.withValues(alpha: 0.12)),
            Expanded(
              child: settingsAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(
                    child: FilledButton(
                      onPressed: () {
                        ref.invalidate(privacySettingsProvider);
                      },
                      child: Text(l10n.reload),
                    ),
                  );
                },
                data: (settings) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                    children: [
                      _PrivacySwitchItem(
                        icon: Icons.lock_outline_rounded,
                        title: l10n.privateAccount,
                        subtitle: l10n.privateAccountSubtitle,
                        value: settings.privateAccount,
                        onChanged: notifier.setPrivateAccount,
                      ),
                      const SizedBox(height: 10),
                      _PrivacySwitchItem(
                        icon: Icons.mode_comment_outlined,
                        title: l10n.allowComments,
                        subtitle: l10n.allowCommentsSubtitle,
                        value: settings.allowComments,
                        onChanged: notifier.setAllowComments,
                      ),
                      const SizedBox(height: 10),
                      _PrivacySwitchItem(
                        icon: Icons.visibility_outlined,
                        title: l10n.showActivityStatus,
                        subtitle: l10n.showActivityStatusSubtitle,
                        value: settings.showActivityStatus,
                        onChanged: notifier.setShowActivityStatus,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
                  l10n.privacy,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 18,
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
}

class _PrivacySwitchItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PrivacySwitchItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
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
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
