import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class PrivacySettingsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  String _userId(Session session) {
    return session.authenticated!.userIdentifier.toString();
  }

  Future<PrivacySettings> get(Session session) async {
    final userId = _userId(session);

    final row = await PrivacySettings.db.findFirstRow(
      session,
      where: (r) => r.userId.equals(userId),
    );

    return row ?? PrivacySettings(userId: userId);
  }

  Future<PrivacySettings> update(
    Session session, {
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
  }) async {
    final userId = _userId(session);

    final current = await PrivacySettings.db.findFirstRow(
      session,
      where: (r) => r.userId.equals(userId),
    );

    final merged = (current ?? PrivacySettings(userId: userId)).copyWith(
      privateAccount: privateAccount,
      allowComments: allowComments,
      showActivityStatus: showActivityStatus,
      updatedAt: DateTime.now(),
    );

    if (current == null) {
      return PrivacySettings.db.insertRow(session, merged);
    }

    return PrivacySettings.db.updateRow(session, merged);
  }
}
