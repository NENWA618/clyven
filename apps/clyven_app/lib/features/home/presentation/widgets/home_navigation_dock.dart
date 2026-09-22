import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'home_design_tokens.dart';

class HomeNavigationDock extends StatelessWidget {
  final int selectedIndex;
  final int unreadCount;
  final ValueChanged<int> onSelected;
  final VoidCallback onCreate;

  const HomeNavigationDock({
    super.key,
    required this.selectedIndex,
    required this.unreadCount,
    required this.onSelected,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final brandBlue = HomeDesignTokens.brandFor(context);
    const dockBackground = Color(0xFF171715);
    const dockBorder = Color(0xFF302E2A);

    return SafeArea(
      top: false,
      child: Container(
        height: 76,
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
        decoration: BoxDecoration(
          color: dockBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: dockBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .24),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            _item(
              context,
              icon: Icons.home_rounded,
              outlineIcon: Icons.home_outlined,
              label: l10n.navHome,
              index: 0,
            ),
            _item(
              context,
              icon: Icons.smart_display_rounded,
              outlineIcon: Icons.smart_display_outlined,
              label: l10n.navDiscover,
              index: 1,
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: onCreate,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: brandBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: brandBlue.withValues(alpha: .28),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 31,
                    ),
                  ),
                ),
              ),
            ),
            _item(
              context,
              icon: Icons.notifications_rounded,
              outlineIcon: Icons.notifications_none_rounded,
              label: l10n.navEchoes,
              index: 2,
              badge: unreadCount,
            ),
            _item(
              context,
              icon: Icons.person_rounded,
              outlineIcon: Icons.person_outline_rounded,
              label: l10n.navProfile,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required IconData outlineIcon,
    required String label,
    required int index,
    int badge = 0,
  }) {
    final colors = Theme.of(context).colorScheme;
    final brandBlue = HomeDesignTokens.brandFor(context);
    final selected = selectedIndex == index;
    const inactive = Color(0xFF9C978F);

    return Expanded(
      child: InkWell(
        onTap: () => onSelected(index),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  selected ? icon : outlineIcon,
                  size: 24,
                  color: selected ? brandBlue : inactive,
                ),
                if (badge > 0)
                  Positioned(
                    right: -9,
                    top: -5,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.error,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        badge > 99 ? '99+' : '$badge',
                        style: TextStyle(
                          color: colors.onError,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? brandBlue : inactive,
                fontSize: 10,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
