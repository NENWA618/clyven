import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Privacy settings', (builder, endpoints) {
    final a = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-a', {}),
    );
    final b = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-b', {}),
    );

    test('get returns defaults when no row exists yet', () async {
      final settings = await endpoints.privacySettings.get(a);
      expect(settings.privateAccount, isFalse);
      expect(settings.allowComments, isTrue);
      expect(settings.showActivityStatus, isTrue);
    });

    test('update creates the row and only changes the given fields', () async {
      final first = await endpoints.privacySettings.update(
        a,
        privateAccount: true,
      );
      expect(first.privateAccount, isTrue);
      expect(first.allowComments, isTrue);

      final second = await endpoints.privacySettings.update(
        a,
        allowComments: false,
      );
      expect(second.privateAccount, isTrue);
      expect(second.allowComments, isFalse);
      expect(second.showActivityStatus, isTrue);
    });

    test('settings are scoped per user', () async {
      await endpoints.privacySettings.update(a, privateAccount: true);
      final settingsForB = await endpoints.privacySettings.get(b);
      expect(settingsForB.privateAccount, isFalse);
    });
  });

  withServerpod('Notification settings', (builder, endpoints) {
    final a = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-a', {}),
    );
    final b = builder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo('user-b', {}),
    );

    test('get returns defaults when no row exists yet', () async {
      final settings = await endpoints.notificationSettings.get(a);
      expect(settings.pushEnabled, isTrue);
      expect(settings.likeEnabled, isTrue);
      expect(settings.commentEnabled, isTrue);
      expect(settings.followEnabled, isTrue);
    });

    test('update creates the row and only changes the given fields', () async {
      final first = await endpoints.notificationSettings.update(
        a,
        pushEnabled: false,
      );
      expect(first.pushEnabled, isFalse);
      expect(first.likeEnabled, isTrue);

      final second = await endpoints.notificationSettings.update(
        a,
        followEnabled: false,
      );
      expect(second.pushEnabled, isFalse);
      expect(second.followEnabled, isFalse);
      expect(second.likeEnabled, isTrue);
      expect(second.commentEnabled, isTrue);
    });

    test('settings are scoped per user', () async {
      await endpoints.notificationSettings.update(a, pushEnabled: false);
      final settingsForB = await endpoints.notificationSettings.get(b);
      expect(settingsForB.pushEnabled, isTrue);
    });
  });
}
