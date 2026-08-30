import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import '../../../video/presentation/pages/video_detail_page.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

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
    final homeAsync =
        ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: homeAsync.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
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
                    homeProvider,
                  );
                },
                child: const Text(
                  '重新加载',
                ),
              ),
            );
          },
          data: (state) {
            return CustomScrollView(
              physics:
                  const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(
                    context,
                  ),
                ),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      12,
                    ),
                    child: Text(
                      '探索轨道',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 28,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: _buildTopics(),
                ),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(
                      20,
                      30,
                      20,
                      14,
                    ),
                    child: Text(
                      '正在发生',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    0,
                    18,
                    40,
                  ),
                  sliver: SliverList.separated(
                    itemCount:
                        state.feed.videos.length,
                    separatorBuilder:
                        (
                      context,
                      index,
                    ) {
                      return const SizedBox(
                        height: 14,
                      );
                    },
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return _buildVideo(
                        context,
                        state.feed.videos[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(
  BuildContext context,
) {
  return const Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      22,
      20,
      8,
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'DISCOVER',
              style: TextStyle(
                color: _purple,
                fontSize: 9,
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 3),
            Text(
              '发现',
              style: TextStyle(
                color: _ink,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildTopics() {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        scrollDirection:
            Axis.horizontal,
        itemCount:
            HomeNotifier.topics.length - 1,
        separatorBuilder:
            (
          context,
          index,
        ) {
          return const SizedBox(
            width: 8,
          );
        },
        itemBuilder: (
          context,
          index,
        ) {
          final topic =
              HomeNotifier.topics[
                  index + 1];

          return Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            alignment:
                Alignment.center,
            decoration: BoxDecoration(
              color: index.isEven
                  ? _acid
                  : _purple,
              borderRadius:
                  BorderRadius.circular(
                22,
              ),
            ),
            child: Text(
              topic,
              style: TextStyle(
                color: index.isEven
                    ? _ink
                    : Colors.white,
                fontSize: 12,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideo(
    BuildContext context,
    HomeVideo video,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
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
        height: 118,
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(
            22,
          ),
          border: Border.all(
            color:
                const Color(
              0xFFE3DED5,
            ),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius
                      .horizontal(
                left:
                    Radius.circular(21),
              ),
              child: SizedBox(
                width: 145,
                height:
                    double.infinity,
                child: _buildCover(
                  video.coverUrl,
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
                    Text(
                      video.category,
                      style:
                          const TextStyle(
                        color: _purple,
                        fontSize: 9,
                        fontWeight:
                            FontWeight
                                .w900,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            const TextStyle(
                          color: _ink,
                          fontSize: 15,
                          fontWeight:
                              FontWeight
                                  .w800,
                        ),
                      ),
                    ),

                    Text(
                      '${video.authorName} · ${video.viewText}',
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF908A81,
                        ),
                        fontSize: 10,
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

  Widget _buildCover(
    String path,
  ) {
    if (path.isEmpty) {
      return Container(
        color:
            const Color(0xFFD8D2C8),
      );
    }

    final isNetwork =
        path.startsWith('http://') ||
        path.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }
}