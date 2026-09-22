import 'package:flutter/material.dart';

import 'home_design_tokens.dart';

class HomeTopicSelector extends StatelessWidget {
  final List<String> topics;
  final String selectedTopic;
  final String Function(String topic) labelFor;
  final ValueChanged<String> onSelected;

  const HomeTopicSelector({
    super.key,
    required this.topics,
    required this.selectedTopic,
    required this.labelFor,
    required this.onSelected,
  });

  static const _icons = <IconData>[
    Icons.grid_view_rounded,
    Icons.movie_filter_outlined,
    Icons.memory_rounded,
    Icons.translate_rounded,
    Icons.sports_esports_outlined,
    Icons.headphones_rounded,
    Icons.location_city_rounded,
    Icons.document_scanner_outlined,
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: topics.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (_, index) {
        final topic = topics[index];
        return _TopicChip(
          icon: _icons[index % _icons.length],
          label: labelFor(topic),
          selected: topic == selectedTopic,
          onTap: () => onSelected(topic),
        );
      },
    ),
  );
}

class _TopicChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TopicChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brand = HomeDesignTokens.brandFor(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: selected
                ? (Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFF0EDE7)
                      : const Color(0xFF1B1B18))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: selected
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFF0EDE7)
                        : const Color(0xFF1B1B18))
                  : HomeDesignTokens.border(context),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: selected
                    ? (Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF171714)
                          : Colors.white)
                    : brand,
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? (Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF171714)
                            : Colors.white)
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
