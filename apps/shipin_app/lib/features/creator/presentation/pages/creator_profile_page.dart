import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/presentation/pages/video_detail_page.dart';
import '../../data/models/creator_profile.dart';
import '../providers/creator_profile_provider.dart';

class CreatorProfilePage
    extends ConsumerWidget {
  final String creatorId;

  const CreatorProfilePage({
    super.key,
    required this.creatorId,
  });

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
    final creatorAsync = ref.watch(
      creatorProfileProvider(creatorId),
    );

    return Scaffold(
      backgroundColor: _background,
      body: creatorAsync.when(
        loading: () {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        },

        error: (error, stackTrace) {
          return SafeArea(
            child: Column(
              children: [
                _buildBackButton(context),
                const Expanded(
                  child: Center(
                    child: Text(
                      '创作者资料加载失败',
                    ),
                  ),
                ),
              ],
            ),
          );
        },

        data: (state) {
          return _buildPage(
            context,
            ref,
            state,
          );
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    WidgetRef ref,
    CreatorProfileState state,
  ) {
    final creator = state.creator;

    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _buildHero(
            context,
            creator,
          ),
        ),

        SliverToBoxAdapter(
          child: _buildIdentity(
            ref,
            state,
          ),
        ),

        SliverToBoxAdapter(
          child: _buildStatistics(
            creator,
          ),
        ),

        SliverToBoxAdapter(
          child: _buildSectionHeader(),
        ),

        SliverPadding(
          padding:
              const EdgeInsets.fromLTRB(
            18,
            0,
            18,
            60,
          ),
          sliver: SliverList(
            delegate:
                SliverChildBuilderDelegate(
              (context, index) {
                final video =
                    creator.videos[index];

                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 14,
                  ),
                  child: _buildVideoCard(
                    context,
                    video,
                    index,
                  ),
                );
              },
              childCount:
                  creator.videos.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHero(
    BuildContext context,
    CreatorProfile creator,
  ) {
    return SizedBox(
      height: 290,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            creator.bannerUrl,
            fit: BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                color: _purple,
              );
            },
          ),

          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:
                    Alignment.topCenter,
                end:
                    Alignment.bottomCenter,
                colors: [
                  Color(0x44000000),
                  Color(0x00000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),

          Positioned(
            top:
                MediaQuery.paddingOf(
                      context,
                    ).top +
                    10,
            left: 16,
            child:
                _buildBackButton(
              context,
            ),
          ),

          Positioned(
            top:
                MediaQuery.paddingOf(
                      context,
                    ).top +
                    10,
            right: 16,
            child: Container(
              width: 42,
              height: 42,
              decoration:
                  BoxDecoration(
                color:
                    Colors.black38,
                borderRadius:
                    BorderRadius
                        .circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons
                    .more_horiz_rounded,
                color: Colors.white,
              ),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 20,
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration:
                      BoxDecoration(
                    color: _acid,
                    borderRadius:
                        BorderRadius
                            .circular(
                      20,
                    ),
                  ),
                  child: const Text(
                    'CREATOR SPACE',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Text(
                  '${creator.videoCount} FRAMES',
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentity(
    WidgetRef ref,
    CreatorProfileState state,
  ) {
    final creator =
        state.creator;

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        22,
        20,
        0,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    creator.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color: _purple,
                        alignment:
                            Alignment.center,
                        child: Text(
                          creator.name
                                  .isEmpty
                              ? '?'
                              : creator.name
                                  .substring(
                                    0,
                                    1,
                                  ),
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 24,
                            fontWeight:
                                FontWeight
                                    .w900,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'VOICE / MAKER',
                      style:
                          TextStyle(
                        color: _purple,
                        fontSize: 9,
                        fontWeight:
                            FontWeight
                                .w900,
                        letterSpacing:
                            1.7,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      creator.name,
                      style:
                          const TextStyle(
                        color: _ink,
                        fontSize: 24,
                        fontWeight:
                            FontWeight
                                .w900,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap:
                    state.isChangingFollow
                        ? null
                        : () {
                            ref
                                .read(
                                  creatorProfileProvider(
                                    creator.id,
                                  ).notifier,
                                )
                                .toggleFollow();
                          },
                child:
                    AnimatedContainer(
                  duration:
                      const Duration(
                    milliseconds: 180,
                  ),
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 19,
                    vertical: 11,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        state.isFollowing
                            ? _ink
                            : _acid,
                    borderRadius:
                        BorderRadius
                            .circular(
                      22,
                    ),
                  ),
                  child: Text(
                    state.isFollowing
                        ? '已关注'
                        : '关注',
                    style:
                        TextStyle(
                      color:
                          state.isFollowing
                              ? Colors.white
                              : _ink,
                      fontSize: 12,
                      fontWeight:
                          FontWeight
                              .w900,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          Text(
            creator.bio,
            style: const TextStyle(
              color:
                  Color(0xFF4F4B45),
              fontSize: 14,
              height: 1.65,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(
    CreatorProfile creator,
  ) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        0,
      ),
      child: Container(
        height: 86,
        decoration: BoxDecoration(
          color: _ink,
          borderRadius:
              BorderRadius.circular(
            25,
          ),
        ),
        child: Row(
          children: [
            _stat(
              _formatCount(
                creator.followerCount,
              ),
              '关注者',
            ),

            _divider(),

            _stat(
              creator.videoCount
                  .toString(),
              '作品',
            ),

            _divider(),

            _stat(
              _formatCount(
                creator.totalViewCount,
              ),
              '总观看',
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: _acid,
              fontSize: 18,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white12,
    );
  }

  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        32,
        20,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '创作者轨道',
              style: TextStyle(
                color: _ink,
                fontSize: 24,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
          ),
          Text(
            'LATEST FRAMES',
            style: TextStyle(
              color:
                  Color(0xFF99938A),
              fontSize: 9,
              fontWeight:
                  FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    CreatorVideoPreview video,
    int index,
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
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white
              .withOpacity(0.72),
          borderRadius:
              BorderRadius.circular(
            23,
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
                    Radius.circular(
                  22,
                ),
              ),
              child: SizedBox(
                width: 145,
                height:
                    double.infinity,
                child: Stack(
                  fit:
                      StackFit.expand,
                  children: [
                    Image.network(
                      video.coverUrl,
                      fit:
                          BoxFit.cover,
                    ),

                    Positioned(
                      left: 9,
                      bottom: 9,
                      child:
                          Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal:
                              8,
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
                            color: Colors
                                .white,
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
                    const EdgeInsets
                        .all(
                  14,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      'FRAME ${(index + 1).toString().padLeft(2, '0')}',
                      style:
                          const TextStyle(
                        color: _purple,
                        fontSize: 8,
                        fontWeight:
                            FontWeight
                                .w900,
                        letterSpacing:
                            1.3,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 3,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            const TextStyle(
                          color: _ink,
                          fontSize: 15,
                          height: 1.25,
                          fontWeight:
                              FontWeight
                                  .w800,
                        ),
                      ),
                    ),

                    Text(
                      '${_formatCount(video.viewCount)} 次观看',
                      style:
                          const TextStyle(
                        color: Color(
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

  Widget _buildBackButton(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  static String _formatCount(
    int value,
  ) {
    if (value >= 10000) {
      final result =
          value / 10000;

      return '${result.toStringAsFixed(result >= 10 ? 0 : 1)}万';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }

    return value.toString();
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