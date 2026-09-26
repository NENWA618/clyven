import 'package:clyven_app/features/auth/data/models/app_user.dart';
import 'package:clyven_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:clyven_app/features/video/data/models/video_content_type.dart';
import 'package:clyven_app/features/video/data/models/video_upload_draft.dart';
import 'package:clyven_app/features/video/data/repositories/video_repository.dart';
import 'package:clyven_app/features/video/presentation/providers/video_detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class TestAuth extends AuthNotifier {
  @override
  Future<AppUser?> build() async => user('a');

  void switchTo(String id) => state = AsyncData(user(id));

  static AppUser user(String id) =>
      AppUser(id: id, username: id, displayName: id, avatarUrl: '');
}

void main() {
  test(
    'both feed caches reload on account switch and include other authors',
    () async {
      final repository = MockVideoRepository();
      final auth = TestAuth();
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(() => auth),
          videoRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      container.listen(allPublishedVideosProvider, (_, _) {});
      container.listen(publishedShortsProvider, (_, _) {});
      expect(await container.read(allPublishedVideosProvider.future), isEmpty);
      expect(await container.read(publishedShortsProvider.future), isEmpty);

      for (final type in VideoContentType.values) {
        await repository.createVideo(
          userId: 'a',
          authorName: 'A',
          draft: VideoUploadDraft(
            videoPath: 'fixture.mp4',
            title: 'A',
            description: '',
            category: '技术',
            durationSeconds: 12,
            contentType: type,
          ),
        );
      }
      auth.switchTo('b');
      await container.pump();
      expect(
        (await container.read(
          allPublishedVideosProvider.future,
        )).single.authorId,
        'a',
      );
      expect(
        (await container.read(publishedShortsProvider.future)).single.authorId,
        'a',
      );

      await repository.createVideo(
        userId: 'b',
        authorName: 'B',
        draft: const VideoUploadDraft(
          videoPath: 'fixture.mp4',
          title: 'B',
          description: '',
          category: '技术',
          durationSeconds: 12,
        ),
      );
      auth.switchTo('a');
      await container.pump();
      expect(
        (await container.read(
          allPublishedVideosProvider.future,
        )).map((video) => video.authorId),
        containsAll(['a', 'b']),
      );
    },
  );
}
