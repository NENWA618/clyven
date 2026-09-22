import 'package:clyven_app/features/home/data/models/home_video.dart';
import 'package:flutter/material.dart';

import 'home_design_tokens.dart';
import 'home_media.dart';

class HomeVideoCard extends StatelessWidget {
  final HomeVideo video;
  final String category;
  final VoidCallback onTap;

  const HomeVideoCard({
    super.key,
    required this.video,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: video.title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: HomeDesignTokens.surface(context),
              borderRadius: BorderRadius.circular(16),
              boxShadow: HomeDesignTokens.cardShadow(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        HomeMedia(path: video.coverUrl),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: VideoDurationBadge(duration: video.duration),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 13, 13, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: HomeDesignTokens.brandFor(context),
                          fontSize: 9,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          height: 1.28,
                          letterSpacing: -.15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 11),
                      Row(
                        children: [
                          CreatorAvatar(name: video.authorName, size: 25),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              '${video.authorName} · ${video.viewText}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: HomeDesignTokens.muted(context),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
