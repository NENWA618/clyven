import 'dart:async';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:clyven_app/core/serverpod/serverpod_client_provider.dart';
import 'package:clyven_app/core/localization/localized_labels.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/home_video.dart';
import '../providers/home_provider.dart';
import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class VideoSearchPage extends ConsumerStatefulWidget {
  const VideoSearchPage({super.key});

  @override
  ConsumerState<VideoSearchPage> createState() {
    return _VideoSearchPageState();
  }
}

class _VideoSearchPageState extends ConsumerState<VideoSearchPage> {
  static const Color _ink = Color(0xFF161616);

  final TextEditingController _searchController = TextEditingController();

  String _keyword = '';
  List<serverpod.SubtitleSearchResult> _subtitleResults =
      <serverpod.SubtitleSearchResult>[];
  bool _subtitleSearchLoading = false;
  int _subtitleSearchGeneration = 0;
  Timer? _subtitleSearchDebounce;

  void _scheduleSubtitleSearch(String keyword) {
    _subtitleSearchDebounce?.cancel();

    final query = keyword.trim();

    if (query.isEmpty) {
      _subtitleSearchGeneration++;

      setState(() {
        _subtitleResults = <serverpod.SubtitleSearchResult>[];
        _subtitleSearchLoading = false;
      });

      return;
    }

    _subtitleSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _searchSubtitleCues(query);
    });
  }

  Future<void> _searchSubtitleCues(String keyword) async {
    final query = keyword.trim();
    final generation = ++_subtitleSearchGeneration;

    if (query.isEmpty) {
      if (!mounted) return;

      setState(() {
        _subtitleResults = <serverpod.SubtitleSearchResult>[];
        _subtitleSearchLoading = false;
      });
      return;
    }

    setState(() {
      _subtitleSearchLoading = true;
    });

    try {
      final client = ref.read(serverpodClientProvider);
      final results = await client.subtitle.searchPublishedCues(
        query: query,
        limit: 30,
      );

      if (!mounted || generation != _subtitleSearchGeneration) {
        return;
      }

      setState(() {
        _subtitleResults = results;
        _subtitleSearchLoading = false;
      });
    } catch (error) {
      if (!mounted || generation != _subtitleSearchGeneration) {
        return;
      }

      debugPrint('[Subtitle Search] failed: $error');

      setState(() {
        _subtitleResults = <serverpod.SubtitleSearchResult>[];
        _subtitleSearchLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _subtitleSearchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeProvider);
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l10n),
            Expanded(
              child: homeAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(child: Text(l10n.searchLoadFailed));
                },
                data: (state) {
                  final videos = state.feed.videos;
                  final results = _filterVideos(videos, l10n);

                  if (_keyword.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.searchPrompt,
                        style: const TextStyle(color: Color(0xFF908A81)),
                      ),
                    );
                  }

                  if (results.isEmpty &&
                      _subtitleResults.isEmpty &&
                      !_subtitleSearchLoading) {
                    return Center(
                      child: Text(
                        l10n.searchNoResults,
                        style: const TextStyle(color: Color(0xFF908A81)),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 40),
                    children: [
                      if (results.isNotEmpty) ...[
                        _buildSectionLabel('Videos'),
                        const SizedBox(height: 10),
                        for (final video in results) ...[
                          _buildResult(video, l10n),
                          const SizedBox(height: 10),
                        ],
                      ],
                      if (_subtitleSearchLoading) ...[
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                      if (_subtitleResults.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        _buildSectionLabel('Subtitle clips'),
                        const SizedBox(height: 10),
                        for (final result in _subtitleResults) ...[
                          _buildSubtitleResult(result),
                          const SizedBox(height: 10),
                        ],
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
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
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  _keyword = value.trim();
                });
                _scheduleSubtitleSearch(value);
              },
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _keyword.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();

                          _subtitleSearchDebounce?.cancel();
                          _subtitleSearchGeneration++;
                          setState(() {
                            _keyword = '';
                            _subtitleResults =
                                <serverpod.SubtitleSearchResult>[];
                            _subtitleSearchLoading = false;
                          });
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.75),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<HomeVideo> _filterVideos(List<HomeVideo> videos, AppLocalizations l10n) {
    if (_keyword.isEmpty) {
      return const [];
    }

    final keyword = _keyword.toLowerCase();

    return videos.where((video) {
      final localizedCategory = localizedTopicLabel(
        l10n,
        video.category,
      ).toLowerCase();

      return video.title.toLowerCase().contains(keyword) ||
          video.authorName.toLowerCase().contains(keyword) ||
          video.category.toLowerCase().contains(keyword) ||
          localizedCategory.contains(keyword) ||
          video.description.toLowerCase().contains(keyword);
    }).toList();
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: _ink,
        fontSize: 13,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildSubtitleResult(serverpod.SubtitleSearchResult result) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        openGlobalVideoClip(
          videoId: result.videoId.toString(),
          startMs: result.startMs,
          endMs: result.endMs,
          loop: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.55),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.subtitles_rounded,
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 14,
                      height: 1.35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${result.videoTitle} Ã‚Â· ${result.authorName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF77736C),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatClipTime(result.startMs)} Ã¢â‚¬â€œ '
                    '${_formatClipTime(result.endMs)} Ã‚Â· '
                    '${result.languageCode}',
                    style: const TextStyle(
                      color: Color(0xFF908A81),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.play_circle_fill_rounded,
              color: colors.primary,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }

  String _formatClipTime(int milliseconds) {
    final totalSeconds = milliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final millis = milliseconds % 1000;

    return '$minutes:${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }

  Widget _buildResult(HomeVideo video, AppLocalizations l10n) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        openGlobalVideo(video.id);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE3DED5)),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.play_arrow_rounded, color: colors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${video.authorName} Ã‚Â· ${localizedTopicLabel(l10n, video.category)}',
                    style: const TextStyle(
                      color: Color(0xFF77736C),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_rounded,
              color: colors.secondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
