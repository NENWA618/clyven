import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Registers the caller's FCM device token so the server can push to it.
class PushDeviceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _userId(Session session) {
    return session.authenticated!.userIdentifier.toString();
  }

  /// Binds [token] to the current user. A token belongs to exactly one user,
  /// so it is re-assigned when someone else signs in on the same device.
  Future<void> register(
    Session session, {
    required String token,
    required String platform,
    String languageCode = 'en',
  }) async {
    final trimmed = token.trim();
    if (trimmed.isEmpty) return;

    final userId = _userId(session);
    final existing = await DeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(trimmed),
    );

    if (existing == null) {
      await DeviceToken.db.insertRow(
        session,
        DeviceToken(
          userId: userId,
          token: trimmed,
          platform: platform,
          languageCode: languageCode,
          updatedAt: DateTime.now(),
        ),
      );
      return;
    }

    await DeviceToken.db.updateRow(
      session,
      existing.copyWith(
        userId: userId,
        platform: platform,
        languageCode: languageCode,
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// Removes [token], e.g. on sign-out, so the device stops receiving pushes.
  Future<void> unregister(Session session, {required String token}) async {
    final userId = _userId(session);
    await DeviceToken.db.deleteWhere(
      session,
      where: (t) => t.token.equals(token.trim()) & t.userId.equals(userId),
    );
  }
}
