import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/creator_profile.dart';
import '../providers/following_creators_provider.dart';
import 'creator_profile_page.dart';

class FollowingCreatorsPage
    extends ConsumerWidget {
  const FollowingCreatorsPage({
    super.key,
  });

  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final creatorsAsync =
        ref.watch(followingCreatorsProvider);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),

            Expanded(
              child: creatorsAsync.when(
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
                          followingCreatorsProvider,
                        );
                      },
                      child: const Text(
                        '重新加载',
                      ),
                    ),
                  );
                },
                data: (creators) {
                  if (creators.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Icon(
                            Icons
                                .people_outline_rounded,
                            size: 48,
                            color: Color(
                              0xFFAAA49B,
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            '还没有关注创作者',
                            style: TextStyle(
                              color: Color(
                                0xFF77736C,
                              ),
                              fontWeight:
                                  FontWeight
                                      .w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(
                        followingCreatorsProvider,
                      );

                      await ref.read(
                        followingCreatorsProvider
                            .future,
                      );
                    },
                    child: ListView.separated(
                      physics:
                          const AlwaysScrollableScrollPhysics(
                        parent:
                            BouncingScrollPhysics(),
                      ),
                      padding:
                          const EdgeInsets.fromLTRB(
                        18,
                        8,
                        18,
                        40,
                      ),
                      itemCount:
                          creators.length,
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
                        return _buildCreatorCard(
                          context,
                          creators[index],
                        );
                      },
                    ),
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
                  'ORBIT',
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
                  '我的关注',
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
        ],
      ),
    );
  }

  Widget _buildCreatorCard(
    BuildContext context,
    CreatorProfile creator,
  ) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CreatorProfilePage(
                creatorId: creator.id,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
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
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _purple,
                borderRadius:
                    BorderRadius.circular(
                  19,
                ),
              ),
              child: creator.avatarUrl.isEmpty
                  ? Text(
                      creator.name.isEmpty
                          ? '?'
                          : creator.name
                              .substring(
                                0,
                                1,
                              ),
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight
                                .w900,
                      ),
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                        19,
                      ),
                      child: Image.network(
                        creator.avatarUrl,
                        width: 58,
                        height: 58,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    creator.name,
                    style:
                        const TextStyle(
                      color: _ink,
                      fontSize: 16,
                      fontWeight:
                          FontWeight
                              .w900,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    creator.bio,
                    maxLines: 2,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF77736C),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '${_count(creator.followerCount)} 关注者 · '
                    '${creator.videoCount} 个视频',
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF99938A),
                      fontSize: 9,
                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            const Icon(
              Icons.arrow_forward_rounded,
              color: _ink,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  static String _count(
    int value,
  ) {
    if (value >= 10000) {
      final result = value / 10000;

      return '${result.toStringAsFixed(
        result >= 10 ? 0 : 1,
      )}万';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }

    return value.toString();
  }
}