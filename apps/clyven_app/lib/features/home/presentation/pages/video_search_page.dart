import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import '../../../video/presentation/pages/video_detail_page.dart';

class VideoSearchPage extends ConsumerStatefulWidget {
  const VideoSearchPage({super.key});

  @override
  ConsumerState<VideoSearchPage> createState() {
    return _VideoSearchPageState();
  }
}

class _VideoSearchPageState
    extends ConsumerState<VideoSearchPage> {
  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  final TextEditingController
      _searchController =
      TextEditingController();

  String _keyword = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync =
        ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: homeAsync.when(
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
                  return const Center(
                    child: Text(
                      '加载失败',
                    ),
                  );
                },
                data: (state) {
                  final videos =
                      state.feed.videos;

                  final results =
                      _filterVideos(
                    videos,
                  );

                  if (_keyword.isEmpty) {
                    return const Center(
                      child: Text(
                        '输入标题、作者或分类',
                        style: TextStyle(
                          color:
                              Color(0xFF908A81),
                        ),
                      ),
                    );
                  }

                  if (results.isEmpty) {
                    return const Center(
                      child: Text(
                        '没有找到相关视频',
                        style: TextStyle(
                          color:
                              Color(0xFF908A81),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding:
                        const EdgeInsets
                            .fromLTRB(
                      18,
                      12,
                      18,
                      40,
                    ),
                    itemCount:
                        results.length,
                    separatorBuilder:
                        (
                      context,
                      index,
                    ) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder:
                        (
                      context,
                      index,
                    ) {
                      return _buildResult(
                        results[index],
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

  Widget _buildHeader() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        14,
        12,
        14,
        12,
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
              decoration:
                  BoxDecoration(
                color: Colors.white
                    .withOpacity(0.72),
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

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: TextField(
              controller:
                  _searchController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  _keyword =
                      value.trim();
                });
              },
              decoration:
                  InputDecoration(
                hintText:
                    '搜索视频、作者、分类',
                prefixIcon:
                    const Icon(
                  Icons.search_rounded,
                ),
                suffixIcon:
                    _keyword.isEmpty
                        ? null
                        : IconButton(
                            onPressed:
                                () {
                              _searchController
                                  .clear();

                              setState(() {
                                _keyword =
                                    '';
                              });
                            },
                            icon:
                                const Icon(
                              Icons
                                  .close_rounded,
                            ),
                          ),
                filled: true,
                fillColor:
                    Colors.white
                        .withOpacity(
                  0.75,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                    18,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<HomeVideo> _filterVideos(
    List<HomeVideo> videos,
  ) {
    if (_keyword.isEmpty) {
      return const [];
    }

    final keyword =
        _keyword.toLowerCase();

    return videos.where(
      (video) {
        return video.title
                .toLowerCase()
                .contains(keyword) ||
            video.authorName
                .toLowerCase()
                .contains(keyword) ||
            video.category
                .toLowerCase()
                .contains(keyword) ||
            video.description
                .toLowerCase()
                .contains(keyword);
      },
    ).toList();
  }

  Widget _buildResult(
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
        padding:
            const EdgeInsets.all(16),
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
            color:
                const Color(
              0xFFE3DED5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration:
                  BoxDecoration(
                color: _ink,
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color:
                    Color(0xFFE5FF58),
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
                      fontWeight:
                          FontWeight
                              .w800,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    '${video.authorName} · ${video.category}',
                    style:
                        const TextStyle(
                      color:
                          Color(
                        0xFF77736C,
                      ),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            const Icon(
              Icons
                  .arrow_forward_rounded,
              color: _purple,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}