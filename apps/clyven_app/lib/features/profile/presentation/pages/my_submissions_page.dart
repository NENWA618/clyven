import 'dart:io';

import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../../video/presentation/providers/video_upload_queue_provider.dart';

import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class MySubmissionsPage extends ConsumerWidget {
  const MySubmissionsPage({super.key});

  static const Color _ink = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsync = ref.watch(myPublishedVideosProvider);
    final uploadTasks = ref.watch(videoUploadQueueProvider);
    final l10n = AppLocalizations.of(context)!;

    final activeUploadTasks = uploadTasks
        .where((task) => task.status != VideoUploadStatus.success)
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, l10n),
            Expanded(
              child: videosAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return _buildError(ref, l10n);
                },
                data: (videos) {
                  if (videos.isEmpty && activeUploadTasks.isEmpty) {
                    return _buildEmpty(ref, l10n);
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(myPublishedVideosProvider);
                      await ref.read(myPublishedVideosProvider.future);
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 40),
                      itemCount: activeUploadTasks.length + videos.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 14);
                      },
                      itemBuilder: (context, index) {
                        if (index < activeUploadTasks.length) {
                          return _buildUploadTask(
                            context,
                            activeUploadTasks[index],
                            l10n,
                          );
                        }

                        final videoIndex = index - activeUploadTasks.length;
                        final video = videos[videoIndex];

                        return _buildVideo(context, video, videoIndex, l10n);
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

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
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
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.myFrames,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.mySubmissionsTitle,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(WidgetRef ref, AppLocalizations l10n) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(myPublishedVideosProvider);
        await ref.read(myPublishedVideosProvider.future);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 160),
          const Icon(
            Icons.video_library_outlined,
            size: 48,
            color: Color(0xFFAAA49B),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              l10n.noSubmissions,
              style: const TextStyle(
                color: Color(0xFF77736C),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              l10n.publishFirstVideo,
              style: const TextStyle(color: Color(0xFFAAA49B), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(WidgetRef ref, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 42,
            color: Color(0xFF77736C),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.submissionsLoadFailed,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              ref.invalidate(myPublishedVideosProvider);
            },
            child: Text(l10n.reload),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadTask(
    BuildContext context,
    VideoUploadTask task,
    AppLocalizations l10n,
  ) {
    late final String statusText;
    late final IconData icon;

    switch (task.status) {
      case VideoUploadStatus.waiting:
        statusText = l10n.uploadWaiting;
        icon = Icons.schedule_rounded;
      case VideoUploadStatus.preparing:
        statusText = l10n.uploadPreparing;
        icon = Icons.movie_creation_outlined;
      case VideoUploadStatus.uploading:
        statusText = l10n.uploadUploading;
        icon = Icons.cloud_upload_outlined;
      case VideoUploadStatus.failed:
        statusText = l10n.uploadFailed;
        icon = Icons.error_outline_rounded;
      case VideoUploadStatus.success:
        statusText = l10n.uploadComplete;
        icon = Icons.check_circle_outline_rounded;
    }

    final secondary = Theme.of(context).colorScheme.secondary;

    return Container(
      height: 130,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFFE3DED5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: Center(
              child:
                  task.status == VideoUploadStatus.preparing ||
                      task.status == VideoUploadStatus.uploading
                  ? const CircularProgressIndicator()
                  : Icon(icon, size: 34, color: secondary),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: task.status == VideoUploadStatus.failed
                        ? Colors.red
                        : secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (task.status == VideoUploadStatus.failed &&
                    task.errorMessage != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    task.errorMessage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF908A81),
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
    AppLocalizations l10n,
  ) {
    final number = (index + 1).toString().padLeft(2, '0');
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        openGlobalVideo(video.id);
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: const Color(0xFFE3DED5)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(22),
              ),
              child: SizedBox(
                width: 145,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildCover(context, video),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _ink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _duration(video.durationSeconds),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
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
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.frameNumber(number),
                          style: TextStyle(
                            color: scheme.secondary,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.3,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            localizedTopicLabel(l10n, video.category),
                            style: TextStyle(
                              color: scheme.onPrimary,
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 15,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 12,
                          color: Color(0xFF908A81),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          l10n.viewsCount(_count(context, video.viewCount)),
                          style: const TextStyle(
                            color: Color(0xFF908A81),
                            fontSize: 10,
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

  Widget _buildCover(BuildContext context, VideoDetail video) {
    if (video.coverUrl.isEmpty) {
      return Container(
        color: _ink,
        alignment: Alignment.center,
        child: Icon(
          Icons.play_circle_outline_rounded,
          color: Theme.of(context).colorScheme.primary,
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
        errorBuilder: (context, error, stackTrace) {
          return Container(color: _ink);
        },
      );
    }

    return Image.file(
      File(video.coverUrl),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(color: _ink);
      },
    );
  }

  String _duration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$remainingSeconds';
    }

    return '${duration.inMinutes}:$remainingSeconds';
  }

  String _count(BuildContext context, int value) {
    final localeName = Localizations.localeOf(context).toString();
    return NumberFormat.compact(locale: localeName).format(value);
  }
}
