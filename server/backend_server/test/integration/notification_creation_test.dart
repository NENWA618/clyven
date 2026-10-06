import 'package:glyphora_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Notification creation', (builder, endpoints) {
    final a = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-a', {}),
    );
    final b = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-b', {}),
    );

    Future<Video> publishAsA() {
      return endpoints.video.create(
        a,
        authorId: 'user-a',
        authorName: 'Creator A',
        title: 'Notification fixture',
        description: 'Integration test',
        category: '技术',
        contentType: VideoContentType.video,
        languageCode: 'auto',
        tags: [],
        videoStorageKey: 'notification-fixture-missing.mp4',
        durationSeconds: 12,
        isPublic: true,
      );
    }

    test('liking someone else\'s video notifies the author', () async {
      final video = await publishAsA();

      final liked = await endpoints.social.toggleLike(
        b,
        video.id!,
        actorName: 'Viewer B',
      );
      expect(liked, isTrue);

      final refreshedVideo = await Video.db.findById(a.build(), video.id!);
      expect(refreshedVideo!.likeCount, 1);

      final notifications = await endpoints.notification.list(a);
      expect(notifications, hasLength(1));
      expect(notifications.first.type, NotificationType.like);
      expect(notifications.first.actorId, 'user-b');
      expect(notifications.first.actorName, 'Viewer B');
      expect(notifications.first.videoId, video.id);
      expect(notifications.first.isRead, isFalse);

      // Unliking removes the like but leaves the notification history intact.
      final unliked = await endpoints.social.toggleLike(
        b,
        video.id!,
        actorName: 'Viewer B',
      );
      expect(unliked, isFalse);
      final afterUnlike = await Video.db.findById(a.build(), video.id!);
      expect(afterUnlike!.likeCount, 0);
    });

    test('liking your own video never notifies you', () async {
      final video = await publishAsA();
      await endpoints.social.toggleLike(a, video.id!, actorName: 'Creator A');
      expect(await endpoints.notification.list(a), isEmpty);
    });

    test('commenting on someone else\'s video notifies the author', () async {
      final video = await publishAsA();

      await endpoints.comment.createComment(
        b,
        videoId: video.id!,
        userName: 'Viewer B',
        content: 'Great video!',
      );

      final notifications = await endpoints.notification.list(a);
      expect(notifications, hasLength(1));
      expect(notifications.first.type, NotificationType.comment);
      expect(notifications.first.commentPreview, 'Great video!');
      expect(notifications.first.actorName, 'Viewer B');
    });

    test('following someone notifies them', () async {
      await endpoints.social.toggleFollow(
        b,
        'user-a',
        actorName: 'Viewer B',
      );

      final notifications = await endpoints.notification.list(a);
      expect(notifications, hasLength(1));
      expect(notifications.first.type, NotificationType.follow);
      expect(notifications.first.actorId, 'user-b');
    });

    test(
      'markAsRead and markAllAsRead only affect the recipient\'s own rows',
      () async {
        final video = await publishAsA();
        await endpoints.social.toggleLike(b, video.id!, actorName: 'Viewer B');

        final notifications = await endpoints.notification.list(a);
        final notificationId = notifications.first.id!;

        // A different user can't mark someone else's notification as read.
        await endpoints.notification.markAsRead(b, notificationId);
        expect((await endpoints.notification.list(a)).first.isRead, isFalse);

        await endpoints.notification.markAsRead(a, notificationId);
        expect((await endpoints.notification.list(a)).first.isRead, isTrue);

        await endpoints.social.toggleFollow(b, 'user-a', actorName: 'Viewer B');
        expect(
          (await endpoints.notification.list(a)).where((n) => !n.isRead),
          hasLength(1),
        );

        await endpoints.notification.markAllAsRead(a);
        expect(
          (await endpoints.notification.list(a)).where((n) => !n.isRead),
          isEmpty,
        );
      },
    );
  });
}
