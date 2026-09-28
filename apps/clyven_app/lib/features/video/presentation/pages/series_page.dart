import 'package:clyven_app/core/serverpod/serverpod_client_provider.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/global_video_player_controller.dart';

class SeriesPage extends ConsumerStatefulWidget {
  final int seriesId;

  const SeriesPage({
    super.key,
    required this.seriesId,
  });

  @override
  ConsumerState<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends ConsumerState<SeriesPage> {
  late Future<_SeriesBundle> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_SeriesBundle> _load() async {
    final client = ref.read(serverpodClientProvider);

    final series = await client.video.getSeries(
      seriesId: widget.seriesId,
    );

    if (series == null) {
      throw Exception('系列不存在或不可访问');
    }

    final videos = await client.video.getSeriesVideos(
      seriesId: widget.seriesId,
    );

    final coverUrls = <int, String>{};

    for (final video in videos) {
      final videoId = video.id;
      final key = video.coverStorageKey;

      if (videoId == null ||
          key == null ||
          key.trim().isEmpty) {
        continue;
      }

      try {
        final url = await client.video.getVideoUrl(
          path: key,
        );

        if (url != null && url.isNotEmpty) {
          coverUrls[videoId] = url;
        }
      } catch (_) {
        // 封面失败不影响系列页面。
      }
    }

    return _SeriesBundle(
      series: series,
      videos: videos,
      coverUrls: coverUrls,
    );
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: FutureBuilder<_SeriesBundle>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return _buildError(context);
            }

            return _buildContent(
              context,
              snapshot.data!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(context),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.collections_bookmark_outlined,
                  size: 44,
                ),
                const SizedBox(height: 14),
                const Text(
                  '无法加载系列',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _reload,
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    _SeriesBundle bundle,
  ) {
    final series = bundle.series;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _buildTopBar(context),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  series.title,
                  style: const TextStyle(
                    fontSize: 30,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (series.description.trim().isNotEmpty) ...[
                  const SizedBox(height: 13),
                  Text(
                    series.description,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.65),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (bundle.videos.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('这个系列暂时没有视频'),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              16,
              14,
              16,
              42,
            ),
            sliver: SliverList.separated(
              itemCount: bundle.videos.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final video = bundle.videos[index];

                return _buildVideoCard(
                  context,
                  video,
                  bundle.coverUrls[video.id],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
          const Spacer(),
          const Text(
            '系列',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    serverpod.Video video,
    String? coverUrl,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: video.id == null
          ? null
          : () {
              openGlobalVideo(
                video.id!.toString(),
              );
            },
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest
              .withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(22),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 142,
              height: 94,
              child: coverUrl == null
                  ? Container(
                      color: scheme.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.play_circle_outline_rounded,
                        size: 32,
                      ),
                    )
                  : Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          color: scheme.surfaceContainerHighest,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.play_circle_outline_rounded,
                            size: 32,
                          ),
                        );
                      },
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: scheme.onSurface
                            .withValues(alpha: 0.55),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chevron_right_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeriesBundle {
  final serverpod.VideoSeries series;
  final List<serverpod.Video> videos;
  final Map<int, String> coverUrls;

  const _SeriesBundle({
    required this.series,
    required this.videos,
    required this.coverUrls,
  });
}