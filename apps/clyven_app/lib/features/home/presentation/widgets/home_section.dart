import 'package:clyven_app/features/home/data/models/home_video.dart';
import 'package:flutter/material.dart';

import 'home_design_tokens.dart';
import 'home_video_card.dart';

class HomeSection extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String actionLabel;
  final List<HomeVideo> videos;
  final String Function(String category) categoryLabel;
  final ValueChanged<HomeVideo> onVideoTap;
  final VoidCallback onAction;

  const HomeSection({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.actionLabel,
    required this.videos,
    required this.categoryLabel,
    required this.onVideoTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 34, 20, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow.toUpperCase(),
                    style: TextStyle(
                      color: HomeDesignTokens.brandFor(context),
                      fontSize: 9,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -.5,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: HomeDesignTokens.brandFor(context),
                padding: const EdgeInsets.symmetric(horizontal: 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(actionLabel),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1000
                ? 4
                : (constraints.maxWidth >= 680 ? 3 : 2);
            const spacing = 14.0;
            final cardWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: spacing,
              runSpacing: 18,
              children: [
                for (final video in videos)
                  SizedBox(
                    width: cardWidth,
                    child: HomeVideoCard(
                      video: video,
                      category: categoryLabel(video.category),
                      onTap: () => onVideoTap(video),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}
