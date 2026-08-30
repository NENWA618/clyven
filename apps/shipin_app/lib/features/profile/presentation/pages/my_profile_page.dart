import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../creator/presentation/pages/following_creators_page.dart';
import '../../../history/presentation/pages/watch_history_page.dart';
import '../../../video/presentation/pages/video_detail_page.dart';
import '../../../video_interactions/presentation/pages/favorite_videos_page.dart';
import '../../data/models/user_profile.dart';
import '../providers/my_profile_provider.dart';
import 'my_submissions_page.dart';
import 'settings_page.dart';
import '../../../auth/presentation/utils/require_login.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  static const Color _acid =
      Color(0xFFE5FF58);

  Widget _buildGuestContent(
  BuildContext context,
  WidgetRef ref,
) {
  Future<void> login() async {
    await requireLogin(
      context,
      ref,
    );
  }

  return Scaffold(
    backgroundColor: _background,
    body: SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildTopBar(context),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                24,
                20,
                0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: _purple,
                      borderRadius:
                          BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '游客',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 27,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '登录后查看你的个人资料与内容',
                          style: TextStyle(
                            color: Color(0xFF77736C),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                24,
                20,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _libraryItem(
                      icon: Icons.video_library_outlined,
                      title: '投稿',
                      subtitle: '我的作品',
                      onTap: login,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _libraryItem(
                      icon: Icons.bookmark_border_rounded,
                      title: '收藏',
                      subtitle: '保存内容',
                      onTap: login,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _libraryItem(
                      icon: Icons.history_rounded,
                      title: '历史',
                      subtitle: '观看轨迹',
                      onTap: login,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _libraryItem(
                      icon: Icons.people_outline_rounded,
                      title: '关注',
                      subtitle: '我的频道',
                      onTap: login,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                28,
                20,
                0,
              ),
              child: SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: login,
                  style: FilledButton.styleFrom(
                    backgroundColor: _ink,
                    foregroundColor: _acid,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    '登录 / 注册',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 60),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final authAsync =
        ref.watch(authProvider);

    if (authAsync.isLoading) {
      return const Scaffold(
        backgroundColor: _background,
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    final user = authAsync.value;

    if (user == null) {
      return _buildGuestContent(
        context,
        ref,
      );
    }

    final profileAsync =
        ref.watch(myProfileProvider);

    return Scaffold(
      backgroundColor: _background,
      body: profileAsync.when(
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
          return SafeArea(
            child: Column(
              children: [
                _buildTopBar(
                  context,
                ),

                Expanded(
                  child: Center(
                    child: FilledButton(
                      onPressed: () {
                        ref.invalidate(
                          myProfileProvider,
                        );
                      },
                      child: const Text(
                        '重新加载',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        data: (profile) {
          return _buildContent(
            context,
            ref,
            profile,
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) {
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () {
          return ref
              .read(
                myProfileProvider
                    .notifier,
              )
              .refresh();
        },
        child: CustomScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(
            parent:
                BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child:
                  _buildTopBar(context),
            ),

            SliverToBoxAdapter(
              child:
                  _buildIdentity(profile),
            ),

            SliverToBoxAdapter(
              child:
                  _buildStats(profile),
            ),

            SliverToBoxAdapter(
              child:
                  _buildLibrary(context),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(
                  20,
                  32,
                  20,
                  15,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '我的轨道',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 25,
                          fontWeight:
                              FontWeight
                                  .w900,
                        ),
                      ),
                    ),

                    Text(
                      'MY FRAMES',
                      style: TextStyle(
                        color: Color(
                          0xFF99938A,
                        ),
                        fontSize: 9,
                        fontWeight:
                            FontWeight
                                .w800,
                        letterSpacing:
                            1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 18,
              ),
              sliver: SliverList(
                delegate:
                    SliverChildBuilderDelegate(
                  (
                    context,
                    index,
                  ) {
                    final video =
                        profile
                            .videos[index];

                    return Padding(
                      padding:
                          const EdgeInsets
                              .only(
                        bottom: 14,
                      ),
                      child: _buildVideo(
                        context,
                        video,
                        index,
                      ),
                    );
                  },
                  childCount:
                      profile.videos.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child:
                  SizedBox(height: 50),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        12,
        16,
        10,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  'MY SPACE',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight:
                        FontWeight
                            .w900,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  '我的',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight:
                        FontWeight
                            .w900,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            behavior:
                HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                    context,
                  ) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration:
                  BoxDecoration(
                color: Colors.white
                    .withOpacity(
                  0.72,
                ),
                borderRadius:
                    BorderRadius
                        .circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons
                    .settings_outlined,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentity(
    UserProfile profile,
  ) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        22,
        20,
        0,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              25,
            ),
            child: Container(
              width: 82,
              height: 82,
              color: _purple,
              child:
                  profile.avatarUrl.isEmpty
                      ? Center(
                          child: Text(
                            profile
                                    .displayName
                                    .isEmpty
                                ? '?'
                                : profile
                                    .displayName
                                    .substring(
                                      0,
                                      1,
                                    )
                                    .toUpperCase(),
                            style:
                                const TextStyle(
                              color:
                                  Colors
                                      .white,
                              fontSize:
                                  30,
                              fontWeight:
                                  FontWeight
                                      .w900,
                            ),
                          ),
                        )
                      : Image.network(
                          profile
                              .avatarUrl,
                          fit: BoxFit
                              .cover,
                        ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  profile.displayName,
                  style:
                      const TextStyle(
                    color: _ink,
                    fontSize: 27,
                    fontWeight:
                        FontWeight
                            .w900,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  '@${profile.username}',
                  style:
                      const TextStyle(
                    color: Color(
                      0xFF77736C,
                    ),
                    fontSize: 12,
                    fontWeight:
                        FontWeight
                            .w700,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Text(
                  profile.bio,
                  style:
                      const TextStyle(
                    color: Color(
                      0xFF4F4B45,
                    ),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(
    UserProfile profile,
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
        height: 82,
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
              _count(
                profile.followerCount,
              ),
              '关注者',
            ),

            _line(),

            _stat(
              _count(
                profile.followingCount,
              ),
              '关注',
            ),

            _line(),

            _stat(
              profile.videoCount
                  .toString(),
              '投稿',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrary(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: _libraryItem(
              icon: Icons
                  .video_library_outlined,
              title: '投稿',
              subtitle: '我的作品',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) {
                      return const MySubmissionsPage();
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _libraryItem(
              icon: Icons
                  .bookmark_border_rounded,
              title: '收藏',
              subtitle: '保存内容',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) {
                      return const FavoriteVideosPage();
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _libraryItem(
              icon:
                  Icons.history_rounded,
              title: '历史',
              subtitle: '观看轨迹',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) {
                      return const WatchHistoryPage();
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _libraryItem(
              icon: Icons
                  .people_outline_rounded,
              title: '关注',
              subtitle: '我的频道',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                      context,
                    ) {
                      return const FollowingCreatorsPage();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _libraryItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior:
          HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 105,
        padding:
            const EdgeInsets.all(
          11,
        ),
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: const Color(
              0xFFE3DED5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: _purple,
              size: 21,
            ),

            const Spacer(),

            Text(
              title,
              style:
                  const TextStyle(
                color: _ink,
                fontSize: 13,
                fontWeight:
                    FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 2,
            ),

            Text(
              subtitle,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  const TextStyle(
                color: Color(
                  0xFF99938A,
                ),
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo(
    BuildContext context,
    ProfileVideo video,
    int index,
  ) {
    return GestureDetector(
      behavior:
          HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (
              context,
            ) {
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
          color:
              Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(
            23,
          ),
          border: Border.all(
            color: const Color(
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
                left: Radius.circular(
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
                      '${_count(video.viewCount)} 次观看',
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
            style:
                const TextStyle(
              color: _acid,
              fontSize: 18,
              fontWeight:
                  FontWeight.w900,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            label,
            style:
                const TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white12,
    );
  }

  static String _count(
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
        Duration(
      seconds: seconds,
    );

    final minutes =
        duration.inMinutes;

    final remainingSeconds =
        duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '$minutes:$remainingSeconds';
  }
}