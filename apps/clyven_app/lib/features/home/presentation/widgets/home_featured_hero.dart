import 'package:clyven_app/features/home/data/models/home_video.dart';
import 'package:flutter/material.dart';

import 'home_design_tokens.dart';
import 'home_media.dart';

class HomeFeaturedHero extends StatelessWidget {
  final HomeVideo video;
  final String category;
  final String eyebrow;
  final VoidCallback onTap;

  const HomeFeaturedHero({
    super.key,
    required this.video,
    required this.category,
    required this.eyebrow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Semantics(
        button: true,
        label: video.title,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: HomeDesignTokens.cardShadow(context),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(
                  aspectRatio: 1.62,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      HomeMedia(path: video.coverUrl),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x10000000),
                              Color(0x22000000),
                              Color(0xE6000712),
                            ],
                            stops: [0, .42, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 18,
                        child: _HeroLabel(text: category),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 18,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eyebrow.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFFE7BB94),
                                      fontSize: 10,
                                      letterSpacing: 1.7,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    video.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      height: 1.12,
                                      letterSpacing: -.55,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      CreatorAvatar(name: video.authorName),
                                      const SizedBox(width: 9),
                                      Expanded(
                                        child: Text(
                                          '${video.authorName}  ·  ${video.viewText}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFFDDD6CC),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 54,
                              height: 54,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 20,
                                    offset: Offset(0, 7),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xFF171714),
                                size: 33,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 18,
                        right: 18,
                        child: VideoDurationBadge(duration: video.duration),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroLabel extends StatelessWidget {
  final String text;

  const _HeroLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF171714),
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
