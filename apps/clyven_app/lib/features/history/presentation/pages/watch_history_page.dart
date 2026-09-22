import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/watch_history_item.dart';
import '../providers/watch_history_provider.dart';

import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class WatchHistoryPage extends ConsumerWidget {
  const WatchHistoryPage({super.key});

  static const Color _ink = Color(0xFF161616);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(watchHistoryProvider);
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref, historyAsync.value ?? const [], l10n),
            Expanded(
              child: historyAsync.when(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(
                    child: FilledButton(
                      onPressed: () {
                        ref.invalidate(watchHistoryProvider);
                      },
                      child: Text(l10n.reload),
                    ),
                  );
                },
                data: (history) {
                  if (history.isEmpty) {
                    return _buildEmpty(l10n);
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
                    itemCount: history.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      return _buildHistoryCard(context, ref, history[index]);
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

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    List<WatchHistoryItem> history,
    AppLocalizations l10n,
  ) {
    final secondary = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
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
                  l10n.tracesEyebrow,
                  style: TextStyle(
                    color: secondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.watchHistory,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          if (history.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(watchHistoryProvider.notifier).clear();
              },
              child: Text(
                l10n.clear,
                style: TextStyle(color: secondary, fontWeight: FontWeight.w800),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context,
    WidgetRef ref,
    WatchHistoryItem item,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(item.videoId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(watchHistoryProvider.notifier).remove(item.videoId);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFDF5A5A),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          openGlobalVideo(item.videoId);
        },
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE3DED5)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(23),
                ),
                child: SizedBox(
                  width: 150,
                  height: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(item.coverUrl, fit: BoxFit.cover),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: LinearProgressIndicator(
                          minHeight: 5,
                          value: item.progress,
                          backgroundColor: Colors.black26,
                          color: colors.primary,
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
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF77736C),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${_duration(item.positionSeconds)} / '
                        '${_duration(item.durationSeconds)}',
                        style: TextStyle(
                          color: colors.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.history_rounded, size: 45, color: Color(0xFFAAA49B)),
          const SizedBox(height: 13),
          Text(
            l10n.noWatchHistory,
            style: const TextStyle(
              color: Color(0xFF77736C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  static String _duration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$remainingSeconds';
  }
}
