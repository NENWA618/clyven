import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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

  static const Color _inkColor = Color(0xFF161616);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final accent = colors.primary;
    final onAccent = colors.onPrimary;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(18, 0, 18, 12),
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: _inkColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Color(0x38000000),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildItem(
              icon: Icons.blur_on_rounded,
              label: l10n.navHome,
              index: 0,
              accent: accent,
              onAccent: onAccent,
            ),
            _buildItem(
              icon: Icons.explore_outlined,
              label: l10n.navDiscover,
              index: 1,
              accent: accent,
              onAccent: onAccent,
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCreate,
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(Icons.add_rounded, color: onAccent, size: 30),
                ),
              ),
            ),
            _buildItem(
              icon: Icons.notifications_none_rounded,
              label: l10n.navEchoes,
              index: 2,
              badgeCount: unreadCount,
              accent: accent,
              onAccent: onAccent,
            ),
            _buildItem(
              icon: Icons.person_outline_rounded,
              label: l10n.navProfile,
              index: 3,
              accent: accent,
              onAccent: onAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
    required Color accent,
    required Color onAccent,
    int badgeCount = 0,
  }) {
    final selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onSelected(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 22, color: selected ? accent : Colors.white54),
                if (badgeCount > 0)
                  Positioned(
                    right: -9,
                    top: -7,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badgeCount > 99 ? '99+' : badgeCount.toString(),
                        style: TextStyle(
                          color: onAccent,
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
                color: selected ? accent : Colors.white54,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
