import 'package:clyven_app/core/localization/app_locale_provider.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../video/data/models/video_detail.dart';
import '../../../video/presentation/providers/video_detail_provider.dart';
import '../../data/models/home_feed.dart';
import '../../data/models/home_video.dart';
import '../../data/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return const MockHomeRepository();
});

class HomeState {
  final String selectedTopic;
  final HomeFeed feed;

  const HomeState({required this.selectedTopic, required this.feed});

  HomeState copyWith({String? selectedTopic, HomeFeed? feed}) {
    return HomeState(
      selectedTopic: selectedTopic ?? this.selectedTopic,
      feed: feed ?? this.feed,
    );
  }
}

class HomeNotifier extends AsyncNotifier<HomeState> {
  int _topicRequestId = 0;

  static const List<String> topics = [
    '全部',
    '影像',
    '技术',
    '语言',
    '游戏',
    '音乐',
    '城市',
    '纪录',
  ];

  HomeRepository get _repository {
    return ref.read(homeRepositoryProvider);
  }

  @override
  Future<HomeState> build() async {
    const selectedTopic = '全部';

    final selectedLocale = ref.watch(appLocaleProvider);

    final locale = _resolveLocale(selectedLocale);

    final publishedVideos = await ref.watch(allPublishedVideosProvider.future);

    final feed = await _loadFeed(
      topic: selectedTopic,
      publishedVideos: publishedVideos,
      locale: locale,
    );

    return HomeState(selectedTopic: selectedTopic, feed: feed);
  }

  Future<void> selectTopic(String topic) async {
    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (currentState.selectedTopic == topic) {
      return;
    }

    final requestId = ++_topicRequestId;

    // Keep the current feed mounted while the next topic is loading. This
    // preserves the scroll position and avoids flashing the full-page loader.
    state = AsyncData(currentState.copyWith(selectedTopic: topic));

    try {
      final publishedVideos = await ref.read(allPublishedVideosProvider.future);

      final locale = _resolveLocale(ref.read(appLocaleProvider));

      final feed = await _loadFeed(
        topic: topic,
        publishedVideos: publishedVideos,
        locale: locale,
      );

      // A newer topic selection wins when requests finish out of order.
      if (requestId != _topicRequestId) {
        return;
      }

      state = AsyncData(HomeState(selectedTopic: topic, feed: feed));
    } catch (_) {
      if (requestId == _topicRequestId) {
        state = AsyncData(currentState);
      }
    }
  }

  Future<void> refresh() async {
    final currentState = state.value;

    final topic = currentState?.selectedTopic ?? '全部';

    state = await AsyncValue.guard(() async {
      ref.invalidate(allPublishedVideosProvider);

      final publishedVideos = await ref.read(allPublishedVideosProvider.future);

      final locale = _resolveLocale(ref.read(appLocaleProvider));

      final feed = await _loadFeed(
        topic: topic,
        publishedVideos: publishedVideos,
        locale: locale,
      );

      return HomeState(selectedTopic: topic, feed: feed);
    });
  }

  Future<HomeFeed> _loadFeed({
    required String topic,
    required List<VideoDetail> publishedVideos,
    required Locale locale,
  }) async {
    final originalFeed = await _repository.loadHomeFeed(topic: topic);

    final l10n = await AppLocalizations.delegate.load(locale);

    final uploadedVideos = publishedVideos
        .where((video) {
          if (topic == '全部') {
            return true;
          }

          return video.category == topic;
        })
        .map((video) => _toHomeVideo(video, l10n, locale))
        .toList(growable: false);

    final localizedOriginalVideos = originalFeed.videos
        .map((video) => _localizeMockVideo(video, l10n, locale))
        .toList(growable: false);

    return HomeFeed(
      featuredVideo: _localizeMockVideo(
        originalFeed.featuredVideo,
        l10n,
        locale,
      ),
      videos: List.unmodifiable([
        ...uploadedVideos,
        ...localizedOriginalVideos,
      ]),
    );
  }

  HomeVideo _toHomeVideo(
    VideoDetail video,
    AppLocalizations l10n,
    Locale locale,
  ) {
    return HomeVideo(
      id: video.id,
      title: video.title,
      description: video.description,
      authorName: video.authorName,
      category: video.category,
      topic: video.category,
      duration: _formatDuration(video.durationSeconds),
      viewText: _formatViewText(video.viewCount, l10n, locale),
      coverUrl: video.coverUrl,
      videoUrl: video.videoUrl,
    );
  }

  HomeVideo _localizeMockVideo(
    HomeVideo video,
    AppLocalizations l10n,
    Locale locale,
  ) {
    final viewCount = int.tryParse(video.viewText);

    if (viewCount == null) {
      return video;
    }

    return HomeVideo(
      id: video.id,
      title: video.title,
      description: video.description,
      authorName: video.authorName,
      category: video.category,
      topic: video.topic,
      duration: video.duration,
      viewText: _formatViewText(viewCount, l10n, locale),
      coverUrl: video.coverUrl,
      videoUrl: video.videoUrl,
    );
  }

  String _formatViewText(int value, AppLocalizations l10n, Locale locale) {
    final compact = NumberFormat.compact(
      locale: locale.toString(),
    ).format(value);

    return l10n.viewsCount(compact);
  }

  Locale _resolveLocale(Locale? selectedLocale) {
    final candidate =
        selectedLocale ?? WidgetsBinding.instance.platformDispatcher.locale;

    for (final supportedLocale in AppLocalizations.supportedLocales) {
      if (supportedLocale.languageCode == candidate.languageCode) {
        return supportedLocale;
      }
    }

    return const Locale('en');
  }

  String _formatDuration(int seconds) {
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
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
