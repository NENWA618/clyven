import 'package:clyven_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Cross-user video visibility', (builder, endpoints) {
    final a = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-a', {}),
    );
    final b = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-b', {}),
    );

    Future<Video> publish(TestSessionBuilder owner, VideoContentType type) {
      // This tests publication + database visibility, not file upload or ASR.
      // No external ASR request: the fixture storage key has no uploaded object.
      return endpoints.video.create(
        owner,
        authorId: 'untrusted-client-author',
        authorName: 'Test creator',
        title: 'Visibility fixture',
        description: 'Integration test',
        category: '技术',
        contentType: type,
        languageCode: 'auto',
        tags: [],
        videoStorageKey: 'visibility-fixture-missing.mp4',
        durationSeconds: 12,
      );
    }

    for (final type in VideoContentType.values) {
      test('$type: A publishes, B sees; B publishes, A sees', () async {
        final videoA = await publish(a, type);
        final videoB = await publish(b, type);
        expect(videoA.authorId, 'user-a');
        expect(videoB.authorId, 'user-b');
        expect(videoA.status, VideoStatus.published);
        expect(videoA.publishedAt, isNotNull);
        for (final viewer in [a, b]) {
          final feed = await endpoints.video.getVideos(
            viewer,
            contentType: type,
          );
          expect(
            feed.map((video) => video.id),
            containsAll([videoA.id, videoB.id]),
          );
          expect(feed.every((video) => video.contentType == type), isTrue);
        }
        final mine = await endpoints.video.getMyVideos(a);
        expect(mine.map((video) => video.id), contains(videoA.id));
        expect(mine.map((video) => video.id), isNot(contains(videoB.id)));
        expect((await endpoints.video.getVideo(b, videoA.id!))?.id, videoA.id);

        final otherType = type == VideoContentType.video
            ? VideoContentType.short
            : VideoContentType.video;
        final otherFeed = await endpoints.video.getVideos(
          b,
          contentType: otherType,
        );
        expect(otherFeed.map((video) => video.id), isNot(contains(videoA.id)));
      });
    }

    test(
      'non-published rows stay out of public feed and other-user detail',
      () async {
        final video = await publish(a, VideoContentType.video);
        final session = a.build();
        for (final status in [
          VideoStatus.uploading,
          VideoStatus.processing,
          VideoStatus.failed,
        ]) {
          video.status = status;
          await Video.db.updateRow(session, video);
          final feed = await endpoints.video.getVideos(b);
          expect(feed.map((row) => row.id), isNot(contains(video.id)));
          expect(await endpoints.video.getVideo(b, video.id!), isNull);
          expect(await endpoints.video.getVideo(a, video.id!), isNotNull);
          expect(
            (await endpoints.video.getMyVideos(a)).map((row) => row.id),
            contains(video.id),
          );
        }
      },
    );
  });
}
