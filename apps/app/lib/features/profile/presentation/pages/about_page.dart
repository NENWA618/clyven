import 'package:glyphora_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Keep in sync with the `version:` field in pubspec.yaml.
  static const String _version = '1.0.0';
  static const String _buildNumber = '1';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

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
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 30),
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(width: 20, height: 2, color: colors.primary),
                        const SizedBox(height: 9),
                        Text(
                          l10n.appName.toUpperCase(),
                          style: TextStyle(
                            color: colors.onSurface,
                            fontSize: 20,
                            letterSpacing: 3.2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.aboutVersion('$_version ($_buildNumber)'),
                          style: TextStyle(
                            color: colors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(18),
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
                    child: Text(
                      l10n.aboutAppDescription,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      l10n.aboutCopyright,
                      style: const TextStyle(
                        color: Color(0xFFAAA49B),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
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
                  l10n.aboutEyebrow,
                  style: TextStyle(
                    color: colors.secondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.about,
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
