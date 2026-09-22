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

  @override
  void dispose() {
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

                  if (results.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.searchNoResults,
                        style: const TextStyle(color: Color(0xFF908A81)),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 40),
                    itemCount: results.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return _buildResult(results[index], l10n);
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
              },
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _keyword.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            _keyword = '';
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
                    '${video.authorName} · ${localizedTopicLabel(l10n, video.category)}',
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
