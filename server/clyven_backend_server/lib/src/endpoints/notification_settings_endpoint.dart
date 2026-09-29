import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class NotificationSettingsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _userId(Session session) {
    return session.authenticated!.userIdentifier.toString();
  }

  Future<NotificationSettings> get(Session session) async {
    final userId = _userId(session);

    final row = await NotificationSettings.db.findFirstRow(
      session,
      where: (r) => r.userId.equals(userId),
    );

    return row ?? NotificationSettings(userId: userId);
  }

  Future<NotificationSettings> update(
    Session session, {
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
  }) async {
    final userId = _userId(session);

    final current = await NotificationSettings.db.findFirstRow(
      session,
      where: (r) => r.userId.equals(userId),
    );

    final merged = (current ?? NotificationSettings(userId: userId)).copyWith(
      pushEnabled: pushEnabled,
      likeEnabled: likeEnabled,
      commentEnabled: commentEnabled,
      followEnabled: followEnabled,
      updatedAt: DateTime.now(),
    );

    if (current == null) {
      return NotificationSettings.db.insertRow(session, merged);
    }

    return NotificationSettings.db.updateRow(session, merged);
  }
}
