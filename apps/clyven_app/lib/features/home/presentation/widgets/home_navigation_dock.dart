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
  static const Color _acidColor = Color(0xFFE5FF58);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(
        18,
        0,
        18,
        12,
      ),
      child: Container(
        height: 68,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
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
              label: '星轨',
              index: 0,
            ),

            _buildItem(
              icon: Icons.explore_outlined,
              label: '发现',
              index: 1,
            ),

            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCreate,
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _acidColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: _inkColor,
                    size: 30,
                  ),
                ),
              ),
            ),

            _buildItem(
              icon: Icons.notifications_none_rounded,
              label: '回响',
              index: 2,
              badgeCount: unreadCount,
            ),

            _buildItem(
              icon: Icons.person_outline_rounded,
              label: '我的',
              index: 3,
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
    int badgeCount = 0,
  }) {
    final selected =
        selectedIndex == index;

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
                Icon(
                  icon,
                  size: 22,
                  color: selected
                      ? _acidColor
                      : Colors.white54,
                ),

                if (badgeCount > 0)
                  Positioned(
                    right: -9,
                    top: -7,
                    child: Container(
                      constraints:
                          const BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      alignment: Alignment.center,
                      decoration:
                          const BoxDecoration(
                        color: _acidColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badgeCount > 99
                            ? '99+'
                            : badgeCount.toString(),
                        style:
                            const TextStyle(
                          color: _inkColor,
                          fontSize: 8,
                          fontWeight:
                              FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                color: selected
                    ? _acidColor
                    : Colors.white54,
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