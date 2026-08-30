import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/pages/video_detail_page.dart';
import '../providers/favorite_videos_provider.dart';

class FavoriteVideosPage extends ConsumerWidget {
  const FavoriteVideosPage({super.key});

  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  static const Color _acid =
      Color(0xFFE5FF58);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final favoritesAsync =
        ref.watch(favoriteVideosProvider);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(
              context,
              ref,
            ),

            Expanded(
              child: favoritesAsync.when(
                loading: () {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                },
                error: (
                  error,
                  stackTrace,
                ) {
                  return Center(
                    child: FilledButton(
                      onPressed: () {
                        ref.invalidate(
                          favoriteVideosProvider,
                        );
                      },
                      child: const Text(
                        '重新加载',
                      ),
                    ),
                  );
                },
                data: (videos) {
                  if (videos.isEmpty) {
                    return _buildEmpty();
                  }

                  return ListView.separated(
                    padding:
                        const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      40,
                    ),
                    itemCount:
                        videos.length,
                    separatorBuilder: (
                      context,
                      index,
                    ) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return _buildVideoCard(
                        context,
                        videos[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        18,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(
                  0.72,
                ),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
              ),
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'ARCHIVE',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '我的收藏',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              ref.invalidate(
                favoriteVideosProvider,
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _acid,
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons.refresh_rounded,
                color: _ink,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    VideoDetail video,
  ) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VideoDetailPage(
                videoId: video.id,
              );
            },
          ),
        );
      },
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(24),
          border: Border.all(
            color:
                const Color(0xFFE3DED5),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius
                      .horizontal(
                left:
                    Radius.circular(23),
              ),
              child: SizedBox(
                width: 150,
                height:
                    double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      video.coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          color:
                              const Color(
                            0xFFE3DED5,
                          ),
                          child:
                              const Icon(
                            Icons
                                .image_outlined,
                          ),
                        );
                      },
                    ),

                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration:
                            BoxDecoration(
                          color: _ink,
                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),
                        child: Text(
                          _duration(
                            video
                                .durationSeconds,
                          ),
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 9,
                            fontWeight:
                                FontWeight
                                    .w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  14,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'SAVED FRAME',
                      style: TextStyle(
                        color: _purple,
                        fontSize: 8,
                        fontWeight:
                            FontWeight
                                .w900,
                        letterSpacing:
                            1.4,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      video.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        color: _ink,
                        fontSize: 14,
                        height: 1.3,
                        fontWeight:
                            FontWeight
                                .w800,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      video.authorName,
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        color: Color(
                          0xFF77736C,
                        ),
                        fontSize: 10,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 48,
            color: Color(
              0xFFAAA49B,
            ),
          ),
          SizedBox(height: 14),
          Text(
            '还没有收藏视频',
            style: TextStyle(
              color: Color(
                0xFF77736C,
              ),
              fontSize: 14,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  static String _duration(
    int seconds,
  ) {
    final duration =
        Duration(seconds: seconds);

    final minutes =
        duration.inMinutes;

    final remainingSeconds =
        duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');

    return '$minutes:$remainingSeconds';
  }
}