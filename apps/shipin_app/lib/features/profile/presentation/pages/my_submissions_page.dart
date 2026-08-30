import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/pages/video_detail_page.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../../video/presentation/providers/video_upload_queue_provider.dart';
class MySubmissionsPage
    extends ConsumerWidget {
  const MySubmissionsPage({
    super.key,
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
    final videosAsync = ref.watch(
      myPublishedVideosProvider,
    );

    final uploadTasks = ref.watch(
  videoUploadQueueProvider,
);

final activeUploadTasks = uploadTasks
    .where(
      (task) =>
          task.status != VideoUploadStatus.success,
    )
    .toList();

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(
              context,
            ),

            Expanded(
              child: videosAsync.when(
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
                  return _buildError(
                    ref,
                  );
                },

                data: (videos) {
  if (videos.isEmpty &&
      activeUploadTasks.isEmpty) {
    return _buildEmpty(
      ref,
    );
  }

  return RefreshIndicator(
    onRefresh: () async {
      ref.invalidate(
        myPublishedVideosProvider,
      );

      await ref.read(
        myPublishedVideosProvider.future,
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
          activeUploadTasks.length +
          videos.length,
      separatorBuilder: (
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
        if (index <
            activeUploadTasks.length) {
          return _buildUploadTask(
            activeUploadTasks[index],
          );
        }

        final videoIndex =
            index -
            activeUploadTasks.length;

        final video =
            videos[videoIndex];

        return _buildVideo(
          context,
          video,
          videoIndex,
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

  Widget _buildHeader(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        18,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
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
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons
                    .arrow_back_rounded,
              ),
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  'MY FRAMES',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '我的投稿',
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

  Widget _buildEmpty(
    WidgetRef ref,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(
          myPublishedVideosProvider,
        );

        await ref.read(
          myPublishedVideosProvider
              .future,
        );
      },
      child: ListView(
        physics:
            const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(
            height: 160,
          ),

          Icon(
            Icons
                .video_library_outlined,
            size: 48,
            color:
                Color(0xFFAAA49B),
          ),

          SizedBox(
            height: 12,
          ),

          Center(
            child: Text(
              '还没有投稿',
              style: TextStyle(
                color:
                    Color(0xFF77736C),
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),

          SizedBox(
            height: 6,
          ),

          Center(
            child: Text(
              '从主页中间的 + 发布第一个视频',
              style: TextStyle(
                color:
                    Color(0xFFAAA49B),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(
    WidgetRef ref,
  ) {
    return Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 42,
            color:
                Color(0xFF77736C),
          ),

          const SizedBox(
            height: 12,
          ),

          const Text(
            '投稿加载失败',
            style: TextStyle(
              color: _ink,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          FilledButton(
            onPressed: () {
              ref.invalidate(
                myPublishedVideosProvider,
              );
            },
            child: const Text(
              '重新加载',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadTask(
  VideoUploadTask task,
) {
  String statusText;

  IconData icon;

  switch (task.status) {
    case VideoUploadStatus.waiting:
      statusText = '等待上传';
      icon = Icons.schedule_rounded;

    case VideoUploadStatus.preparing:
      statusText = '正在处理视频';
      icon = Icons.movie_creation_outlined;

    case VideoUploadStatus.uploading:
      statusText = '正在上传';
      icon = Icons.cloud_upload_outlined;

    case VideoUploadStatus.failed:
      statusText = '上传失败';
      icon = Icons.error_outline_rounded;

    case VideoUploadStatus.success:
      statusText = '上传完成';
      icon = Icons.check_circle_outline_rounded;
  }

  return Container(
    height: 130,
    padding:
        const EdgeInsets.all(
      18,
    ),
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
        color:
            const Color(
          0xFFE3DED5,
        ),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: Center(
            child:
                task.status ==
                        VideoUploadStatus
                            .preparing ||
                    task.status ==
                        VideoUploadStatus
                            .uploading
                ? const CircularProgressIndicator()
                : Icon(
                    icon,
                    size: 34,
                    color: _purple,
                  ),
          ),
        ),

        const SizedBox(
          width: 18,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                task.title,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    const TextStyle(
                  color: _ink,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                statusText,
                style: TextStyle(
                  color:
                      task.status ==
                              VideoUploadStatus
                                  .failed
                          ? Colors.red
                          : _purple,
                  fontSize: 11,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              if (task.status ==
                      VideoUploadStatus
                          .failed &&
                  task.errorMessage != null) ...[
                const SizedBox(
                  height: 4,
                ),
                Text(
                  task.errorMessage!,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    color:
                        Color(
                      0xFF908A81,
                    ),
                    fontSize: 9,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildVideo(
    BuildContext context,
    VideoDetail video,
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
        height: 130,
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
                    _buildCover(
                      video,
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
                    const EdgeInsets
                        .all(
                  14,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'FRAME ${(index + 1).toString().padLeft(2, '0')}',
                          style:
                              const TextStyle(
                            color:
                                _purple,
                            fontSize: 8,
                            fontWeight:
                                FontWeight
                                    .w900,
                            letterSpacing:
                                1.3,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                _acid,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
                            ),
                          ),
                          child: Text(
                            video.category,
                            style:
                                const TextStyle(
                              color: _ink,
                              fontSize: 8,
                              fontWeight:
                                  FontWeight
                                      .w800,
                            ),
                          ),
                        ),
                      ],
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

                    Row(
                      children: [
                        const Icon(
                          Icons
                              .play_circle_outline_rounded,
                          size: 12,
                          color:
                              Color(
                            0xFF908A81,
                          ),
                        ),

                        const SizedBox(
                          width: 4,
                        ),

                        Text(
                          '${_count(video.viewCount)} 次观看',
                          style:
                              const TextStyle(
                            color:
                                Color(
                              0xFF908A81,
                            ),
                            fontSize:
                                10,
                          ),
                        ),
                      ],
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
  VideoDetail video,
) {
  if (video.coverUrl.isEmpty) {
    return Container(
      color: _ink,
      alignment: Alignment.center,
      child: const Icon(
        Icons.play_circle_outline_rounded,
        color: _acid,
        size: 38,
      ),
    );
  }

  final isNetwork =
      video.coverUrl.startsWith('http://') ||
      video.coverUrl.startsWith('https://');

  if (isNetwork) {
    return Image.network(
      video.coverUrl,
      fit: BoxFit.cover,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return Container(
          color: _ink,
        );
      },
    );
  }

  return Image.file(
    File(video.coverUrl),
    fit: BoxFit.cover,
    errorBuilder: (
      context,
      error,
      stackTrace,
    ) {
      return Container(
        color: _ink,
      );
    },
  );
}

  String _duration(
    int seconds,
  ) {
    final duration =
        Duration(
      seconds: seconds,
    );

    final hours =
        duration.inHours;

    final minutes =
        duration.inMinutes
            .remainder(60)
            .toString()
            .padLeft(
              2,
              '0',
            );

    final remainingSeconds =
        duration.inSeconds
            .remainder(60)
            .toString()
            .padLeft(
              2,
              '0',
            );

    if (hours > 0) {
      return '$hours:$minutes:$remainingSeconds';
    }

    return '${duration.inMinutes}:$remainingSeconds';
  }

  String _count(
    int value,
  ) {
    if (value >= 10000) {
      final number =
          value / 10000;

      return '${number.toStringAsFixed(
        number >= 10
            ? 0
            : 1,
      )}万';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }

    return value.toString();
  }
}