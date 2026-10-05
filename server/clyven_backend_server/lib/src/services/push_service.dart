import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// A localized push title/body pair.
class PushMessage {
  final String title;
  final String body;

  const PushMessage(this.title, this.body);
}

/// Sends push messages through Firebase Cloud Messaging (HTTP v1).
///
/// Requires the Serverpod password `fcmServiceAccountJson` (the full service
/// account JSON of the Firebase project). Without it, pushing is a no-op so
/// local development keeps working.
class PushService {
  static const _scope = 'https://www.googleapis.com/auth/firebase.messaging';

  static auth.AutoRefreshingAuthClient? _client;
  static String? _projectId;

  static Future<auth.AutoRefreshingAuthClient?> _ensureClient(
    Session session,
  ) async {
    if (_client != null) return _client;

    final raw = session.passwords['fcmServiceAccountJson'];
    if (raw == null || raw.trim().isEmpty) return null;

    final json = jsonDecode(raw) as Map<String, dynamic>;
    _projectId = json['project_id'] as String?;
    _client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(json),
      [_scope],
    );
    return _client;
  }

  /// Pushes a notification to every device registered for [userId].
  /// Never throws: push failures must not break the action that triggered it.
  static Future<void> sendToUser(
    Session session, {
    required String userId,
    required PushMessage Function(String languageCode) messageFor,
    Map<String, String> data = const {},
  }) async {
    try {
      final client = await _ensureClient(session);
      final projectId = _projectId;
      if (client == null || projectId == null) return;

      final devices = await DeviceToken.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );

      for (final device in devices) {
        final message = messageFor(device.languageCode);
        final response = await client.post(
          Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'message': {
              'token': device.token,
              'notification': {'title': message.title, 'body': message.body},
              'data': data,
              'android': {'priority': 'HIGH'},
              'apns': {
                'payload': {
                  'aps': {'sound': 'default'},
                },
              },
            },
          }),
        );

        if (response.statusCode == 404 ||
            (response.statusCode == 400 &&
                response.body.contains('UNREGISTERED'))) {
          // Token is dead (app uninstalled / token rotated).
          await DeviceToken.db.deleteRow(session, device);
        } else if (response.statusCode >= 300) {
          session.log(
            'FCM send failed status=${response.statusCode} body=${response.body}',
            level: LogLevel.warning,
          );
        }
      }
    } catch (error, stackTrace) {
      session.log(
        'Push delivery failed: $error',
        level: LogLevel.warning,
        stackTrace: stackTrace,
      );
    }
  }
}
