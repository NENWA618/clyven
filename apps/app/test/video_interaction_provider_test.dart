import 'dart:async';

import 'package:glyphora_app/core/errors/app_error.dart';
import 'package:glyphora_app/features/auth/data/models/app_user.dart';
import 'package:glyphora_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:glyphora_app/features/video/data/models/video_detail.dart';
import 'package:glyphora_app/features/video/presentation/providers/video_detail_provider.dart';
import 'package:glyphora_app/features/video_interactions/data/models/video_interaction_state.dart';
import 'package:glyphora_app/features/video_interactions/data/repositories/video_interaction_repository.dart';
import 'package:glyphora_app/features/video_interactions/presentation/providers/video_interaction_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class InteractionAuth extends AuthNotifier {
  @override
  Future<AppUser?> build() async => null;

  void setUser(String? id) => state = AsyncData(
    id == null
        ? null
        : AppUser(id: id, username: id, displayName: id, avatarUrl: ''),
  );
}

class InteractionRepository implements VideoInteractionRepository {
  final loadedUsers = <String>[];
  Completer<VideoInteractionState>? loading;
  Completer<bool>? toggling;
  Object? error;
  int likes = 0;
  int favorites = 0;

  @override
  Future<VideoInteractionState> load({
    required String videoId,
    required String userId,
    required int initialLikeCount,
    required int initialFavoriteCount,
  }) async {
    loadedUsers.add(userId);
    if (error != null) throw error!;
    return loading?.future ??
        VideoInteractionState(
          likeCount: 0,
          favoriteCount: 0,
          isLiked: false,
          isFavorited: false,
        );
  }

  @override
  Future<List<String>> loadFavoriteVideoIds({required String userId}) async => [
    userId,
  ];

  @override
  Future<bool> toggleLike({
    required String videoId,
    required String userId,
    required bool currentlyLiked,
    required String actorName,
  }) async {
    likes++;
    if (error != null) throw error!;
    return toggling?.future ?? true;
  }

  @override
  Future<bool> toggleFavorite({
    required String videoId,
    required String userId,
    required bool currentlyFavorited,
  }) async {
    favorites++;
    if (error != null) throw error!;
    return true;
  }
}

void main() {
  late ProviderContainer container;
  late InteractionAuth auth;
  late InteractionRepository repository;
  final provider = videoInteractionProvider('1');
  setUp(() async {
    auth = InteractionAuth();
    repository = InteractionRepository();
    container = ProviderContainer(
      overrides: [
        authProvider.overrideWith(() => auth),
        videoInteractionRepositoryProvider.overrideWithValue(repository),
        videoDetailProvider('1').overrideWith(
          (ref) async => VideoDetail(
            id: '1',
            title: '',
            description: '',
            authorId: 'creator',
            authorName: '',
            category: '',
            tags: [],
            coverUrl: '',
            videoUrl: '',
            durationSeconds: 60,
            viewCount: 0,
            likeCount: 0,
            favoriteCount: 0,
            commentCount: 0,
            publishedAt: DateTime(2026),
          ),
        ),
      ],
    );
    container.listen(provider, (_, _) {});
    container.listen(favoriteVideoIdsProvider, (_, _) {});
    await expectLater(
      container.read(provider.future),
      throwsA(isA<AppException>()),
    );
  });
  tearDown(() => container.dispose());

  test('guest error reloads after login, account switch and logout', () async {
    expect(await container.read(favoriteVideoIdsProvider.future), isEmpty);
    auth.setUser('a');
    await container.pump();
    await container.read(provider.future);
    expect(repository.loadedUsers.last, 'a');
    expect(await container.read(favoriteVideoIdsProvider.future), ['a']);
    auth.setUser('b');
    await container.pump();
    await container.read(provider.future);
    expect(repository.loadedUsers.last, 'b');
    expect(await container.read(favoriteVideoIdsProvider.future), ['b']);
    auth.setUser(null);
    await container.pump();
    await expectLater(
      container.read(provider.future),
      throwsA(isA<AppException>()),
    );
    expect(await container.read(favoriteVideoIdsProvider.future), isEmpty);
  });

  test(
    'first post-login action waits for load; parallel taps cannot overwrite',
    () async {
      repository.loading = Completer();
      auth.setUser('a');
      await container.pump();
      final notifier = container.read(provider.notifier);
      repository.toggling = Completer();
      final action = notifier.toggleLike();
      repository.loading!.complete(
        VideoInteractionState(
          likeCount: 0,
          favoriteCount: 0,
          isLiked: false,
          isFavorited: false,
        ),
      );
      await container.pump();
      expect(repository.likes, 1);
      await notifier.toggleLike();
      await notifier.toggleFavorite();
      expect(repository.likes, 1);
      expect(repository.favorites, 0);
      repository.toggling!.complete(true);
      await action;
    },
  );

  test('old account response cannot overwrite newly loaded account', () async {
    auth.setUser('a');
    await container.pump();
    await container.read(provider.future);
    repository.toggling = Completer();
    final action = container.read(provider.notifier).toggleLike();
    await container.pump();
    auth.setUser('b');
    await container.pump();
    await container.read(provider.future);
    repository.toggling!.complete(true);
    await action;
    expect(container.read(provider).requireValue.isLiked, isFalse);
  });

  test(
    'load error stays diagnosable; failed mutation restores usable state',
    () async {
      final error = StateError('Method not found in endpoint');
      repository.error = error;
      auth.setUser('a');
      await container.pump();
      await expectLater(container.read(provider.future), throwsA(same(error)));
      expect(container.read(provider).error, same(error));
      repository.error = null;
      container.invalidate(provider);
      await container.read(provider.future);
      repository.error = error;
      await container.read(provider.notifier).toggleLike();
      final state = container.read(provider).requireValue;
      expect(state.isLiked, isFalse);
      expect(state.likeCount, 0);
      expect(state.isChangingLike, isFalse);
    },
  );
}
