import 'package:glyphora_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Video interactions', (builder, endpoints) {
    final a = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'interaction-a',
        {},
      ),
    );
    final b = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'interaction-b',
        {},
      ),
    );

    Future<Video> fixture() => Video.db.insertRow(
      a.build(),
      Video(
        authorId: 'interaction-a',
        authorName: 'A',
        title: 'Interactions',
        description: '',
        category: '',
        tags: [],
        videoStorageKey: 'fixture.mp4',
        durationSeconds: 60,
        viewCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: VideoStatus.published,
        // Simulate historical counters that did not match the interaction rows.
        favoriteCount: 19,
        likeCount: 12,
      ),
    );

    test(
      'favorite membership and count persist across users and removals',
      () async {
        final video = await fixture();
        expect(await endpoints.social.toggleFavorite(a, video.id!), isTrue);
        expect(
          await endpoints.social.getFavoriteVideoIds(a),
          contains(video.id),
        );
        expect(
          await endpoints.social.getFavoriteVideoIds(b),
          isNot(contains(video.id)),
        );
        expect(
          (await Video.db.findById(a.build(), video.id!))!.favoriteCount,
          1,
        );
        expect(await endpoints.social.toggleFavorite(b, video.id!), isTrue);
        expect(
          (await Video.db.findById(a.build(), video.id!))!.favoriteCount,
          2,
        );
        expect(await endpoints.social.toggleFavorite(a, video.id!), isFalse);
        expect(
          await endpoints.social.getFavoriteVideoIds(a),
          isNot(contains(video.id)),
        );
        expect(
          (await Video.db.findById(a.build(), video.id!))!.favoriteCount,
          1,
        );
        expect(await endpoints.social.toggleFavorite(b, video.id!), isFalse);
        expect(
          (await Video.db.findById(a.build(), video.id!))!.favoriteCount,
          0,
        );
      },
    );

    test('likes persist with counts and notify only on addition', () async {
      final video = await fixture();
      expect(
        await endpoints.social.toggleLike(b, video.id!, actorName: 'B'),
        isTrue,
      );
      expect(await endpoints.social.getLikedVideoIds(b), contains(video.id));
      expect(
        await endpoints.social.getLikedVideoIds(a),
        isNot(contains(video.id)),
      );
      expect((await Video.db.findById(a.build(), video.id!))!.likeCount, 1);
      expect(await endpoints.notification.list(a), hasLength(1));
      expect(
        await endpoints.social.toggleLike(b, video.id!, actorName: 'B'),
        isFalse,
      );
      expect(
        await endpoints.social.getLikedVideoIds(b),
        isNot(contains(video.id)),
      );
      expect((await Video.db.findById(a.build(), video.id!))!.likeCount, 0);
      expect(await endpoints.notification.list(a), hasLength(1));
    });

    test(
      'missing videos and anonymous calls cannot create interactions',
      () async {
        await expectLater(
          endpoints.social.toggleFavorite(a, -1),
          throwsA(anything),
        );
        await expectLater(
          endpoints.social.toggleLike(a, -1, actorName: 'A'),
          throwsA(anything),
        );
        final video = await fixture();
        await expectLater(
          endpoints.social.toggleFavorite(builder, video.id!),
          throwsA(anything),
        );
        await expectLater(
          endpoints.social.toggleLike(builder, video.id!, actorName: 'Guest'),
          throwsA(anything),
        );
        expect(await endpoints.social.getLikedVideoIds(a), isEmpty);
        expect(await endpoints.social.getFavoriteVideoIds(a), isEmpty);
      },
    );
  });
}
