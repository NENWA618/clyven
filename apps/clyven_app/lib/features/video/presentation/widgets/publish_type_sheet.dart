import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../data/models/video_content_type.dart';

Future<VideoContentType?> showPublishTypeSheet(BuildContext context) {
  return showModalBottomSheet<VideoContentType>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: .58),
    builder: (_) => const _PublishTypeSheet(),
  );
}

class _PublishTypeSheet extends StatelessWidget {
  const _PublishTypeSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final dark = scheme.brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(maxWidth: 620),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF151514) : const Color(0xFFF5F2EC),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(
          color: dark ? const Color(0xFF302E2A) : const Color(0xFFDED9D0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.onSurface.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.publishTypeEyebrow,
              style: TextStyle(
                color: scheme.primary,
                fontSize: 10,
                letterSpacing: 2.1,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              l10n.choosePublishType,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -.5,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              l10n.choosePublishTypeSubtitle,
              style: TextStyle(
                color: scheme.onSurface.withValues(alpha: .58),
                fontSize: 12,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            _TypeOption(
              number: '01',
              icon: Icons.ondemand_video_rounded,
              title: l10n.publishVideo,
              subtitle: l10n.publishVideoDescription,
              onTap: () => Navigator.pop(context, VideoContentType.video),
            ),
            const SizedBox(height: 12),
            _TypeOption(
              number: '02',
              icon: Icons.stay_current_portrait_rounded,
              title: l10n.publishShort,
              subtitle: l10n.publishShortDescription,
              emphasized: true,
              onTap: () => Navigator.pop(context, VideoContentType.short),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool emphasized;
  final VoidCallback onTap;

  const _TypeOption({
    required this.number,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = scheme.brightness == Brightness.dark;
    final foreground = emphasized ? Colors.white : scheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: emphasized
                ? const Color(0xFF1B1B18)
                : (dark ? const Color(0xFF1D1D1B) : const Color(0xFFFBF9F5)),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: emphasized
                  ? const Color(0xFF3B3731)
                  : (dark ? const Color(0xFF302E2A) : const Color(0xFFDED9D0)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: emphasized
                      ? scheme.primary.withValues(alpha: .20)
                      : scheme.primary.withValues(alpha: .11),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: scheme.primary, size: 25),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$number  ·  $title',
                      style: TextStyle(
                        color: foreground,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: foreground.withValues(alpha: .58),
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_rounded,
                color: foreground.withValues(alpha: .72),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
