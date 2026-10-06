import 'package:flutter/material.dart';

import 'home_design_tokens.dart';

class HomeTopicSelector extends StatefulWidget {
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

  @override
  State<HomeTopicSelector> createState() => _HomeTopicSelectorState();
}

class _HomeTopicSelectorState extends State<HomeTopicSelector> {
  final ScrollController _controller = ScrollController();
  bool _canScrollBack = false;
  bool _canScrollForward = false;

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
  void initState() {
    super.initState();
    _controller.addListener(_updateScrollActions);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollActions());
  }

  @override
  void didUpdateWidget(covariant HomeTopicSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollActions());
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_updateScrollActions)
      ..dispose();
    super.dispose();
  }

  void _updateScrollActions() {
    if (!mounted || !_controller.hasClients) return;
    final position = _controller.position;
    final canBack = position.pixels > position.minScrollExtent + 1;
    final canForward = position.pixels < position.maxScrollExtent - 1;
    if (canBack == _canScrollBack && canForward == _canScrollForward) return;
    setState(() {
      _canScrollBack = canBack;
      _canScrollForward = canForward;
    });
  }

  void _scrollBy(double delta) {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    final target = (position.pixels + delta).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: Stack(
      children: [
        ListView.separated(
          controller: _controller,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.topics.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            final topic = widget.topics[index];
            return _TopicChip(
              icon: _icons[index % _icons.length],
              label: widget.labelFor(topic),
              selected: topic == widget.selectedTopic,
              onTap: () => widget.onSelected(topic),
            );
          },
        ),
        _ScrollAction(
          alignment: Alignment.centerLeft,
          icon: Icons.chevron_left_rounded,
          visible: _canScrollBack,
          onTap: () => _scrollBy(-220),
        ),
        _ScrollAction(
          alignment: Alignment.centerRight,
          icon: Icons.chevron_right_rounded,
          visible: _canScrollForward,
          onTap: () => _scrollBy(220),
        ),
      ],
    ),
  );
}

class _ScrollAction extends StatelessWidget {
  final Alignment alignment;
  final IconData icon;
  final bool visible;
  final VoidCallback onTap;

  const _ScrollAction({
    required this.alignment,
    required this.icon,
    required this.visible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Align(
    alignment: alignment,
    child: IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 160),
        child: Container(
          width: 42,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: alignment == Alignment.centerLeft
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              end: alignment == Alignment.centerLeft
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              colors: [
                HomeDesignTokens.background(context),
                HomeDesignTokens.background(context).withValues(alpha: 0),
              ],
            ),
          ),
          child: Material(
            color: HomeDesignTokens.surface(context),
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 32,
                height: 32,
                child: Icon(icon, size: 20),
              ),
            ),
          ),
        ),
      ),
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
