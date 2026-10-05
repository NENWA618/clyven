import 'dart:async';
import 'dart:io';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../features/video/presentation/controllers/global_video_player_controller.dart';

/// System-level push notifications through Firebase Cloud Messaging.
///
/// Push is optional: when the Firebase config files are missing (or the user
/// denies permission) every method here quietly does nothing and the in-app
/// notification feed keeps working.
class PushNotifications {
  PushNotifications._();

  static bool _ready = false;
  static String? _token;
  static Client? _client;
  static String _languageCode = 'en';
  static StreamSubscription<String>? _refreshSub;

  static bool get _supported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static Future<void> init() async {
    if (!_supported || _ready) return;

    try {
      await Firebase.initializeApp();
      final messaging = FirebaseMessaging.instance;

      // Android 13+ and iOS both require a runtime prompt.
      final settings = await messaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        return;
      }

      // Show banners while the app is open on iOS too.
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);
      final initial = await messaging.getInitialMessage();
      if (initial != null) _handleTap(initial);

      _refreshSub = messaging.onTokenRefresh.listen((token) {
        _token = token;
        final client = _client;
        if (client != null) unawaited(_send(client, token));
      });

      _ready = true;
    } catch (error) {
      // Typically: google-services.json / GoogleService-Info.plist missing.
      debugPrint('PUSH_INIT_SKIPPED: $error');
    }
  }

  /// Binds this device to the signed-in user. Call after every login.
  /// [languageCode] is the app's effective UI language; the server uses it
  /// to localize the push text. Call again whenever it changes.
  static Future<void> register(
    Client client, {
    required String languageCode,
  }) async {
    _client = client;
    _languageCode = languageCode;
    if (!_ready) await init();
    if (!_ready) return;

    try {
      if (Platform.isIOS) {
        // The FCM token needs the APNs token first; give it a moment.
        for (var i = 0; i < 10; i++) {
          if (await FirebaseMessaging.instance.getAPNSToken() != null) break;
          await Future<void>.delayed(const Duration(milliseconds: 500));
        }
      }
      final token = _token ?? await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      _token = token;
      await _send(client, token);
    } catch (error) {
      debugPrint('PUSH_REGISTER_FAILED: $error');
    }
  }

  /// Stops pushes for this device. Call before signing out (needs the session).
  static Future<void> unregister(Client client) async {
    final token = _token;
    _client = null;
    if (!_ready || token == null) return;

    try {
      await client.pushDevice.unregister(token: token);
    } catch (error) {
      debugPrint('PUSH_UNREGISTER_FAILED: $error');
    }
  }

  static Future<void> _send(Client client, String token) async {
    try {
      await client.pushDevice.register(
        token: token,
        platform: Platform.isIOS ? 'ios' : 'android',
        languageCode: _languageCode,
      );
    } catch (error) {
      debugPrint('PUSH_REGISTER_FAILED: $error');
    }
  }

  static void _handleTap(RemoteMessage message) {
    final videoId = message.data['videoId'];
    if (videoId is String && videoId.isNotEmpty) {
      openGlobalVideo(videoId);
    }
  }

  @visibleForTesting
  static Future<void> dispose() async {
    await _refreshSub?.cancel();
    _refreshSub = null;
    _ready = false;
  }
}
