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

// Shared Clyven browser auth boundary.
//
// Studio uses persistent browser storage instead of page-local memory auth.
// Future Clyven Web should reuse the same Serverpod auth session. If Web and
// Studio are hosted on the same origin (for example / and /studio), entering
// Studio can restore the existing session without another login.
// Future Clyven Web SSO hook: keep auth storage behind this shared client.
final studioClient =
    Client(
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
        connectionTimeout: const Duration(minutes: 2),
      )
      ..authSessionManager = ClientAuthSessionManager(
        storage: KeyValueClientAuthSuccessStorage(
          keyValueStorage: BrowserKeyValueStorage(),
        ),
      );
