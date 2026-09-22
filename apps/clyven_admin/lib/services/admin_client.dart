import 'dart:html' as html;

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

class BrowserKeyValueStorage implements KeyValueStorage {
  @override
  Future<String?> get(String key) async {
    return html.window.localStorage[key];
  }

  @override
  Future<void> set(String key, String? value) async {
    if (value == null) {
      html.window.localStorage.remove(key);
    } else {
      html.window.localStorage[key] = value;
    }
  }
}

// Same Clyven browser auth boundary as Studio.
// When /studio and /admin are served from the same origin, both can restore the
// same Serverpod browser session without asking the user to log in twice.
final adminClient =
    Client(
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
        connectionTimeout: const Duration(minutes: 2),
      )
      ..authSessionManager = ClientAuthSessionManager(
        storage: KeyValueClientAuthSuccessStorage(
          keyValueStorage: BrowserKeyValueStorage(),
        ),
      );
