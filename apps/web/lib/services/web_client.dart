import 'dart:html' as html;

import 'package:glyphora_backend_client/backend_client.dart';

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

final webClient =
    Client(
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
        connectionTimeout: const Duration(minutes: 2),
      )
      ..authSessionManager = ClientAuthSessionManager(
        storage: KeyValueClientAuthSuccessStorage(
          keyValueStorage: BrowserKeyValueStorage(),
        ),
      );

/// Restores the stored session from localStorage and validates it with the
/// server. `auth.initialize()` only waits 2s and throws on timeout, which used
/// to make a slow or cold-starting server look like "signed out". Here a
/// timeout or network error keeps the stored session; only a server-side
/// rejection (expired/revoked) signs the user out.
Future<bool> restoreStoredSession() async {
  await webClient.auth.restore();
  if (!webClient.auth.isAuthenticated) return false;
  try {
    await webClient.auth.validateAuthentication(
      timeout: const Duration(seconds: 30),
    );
  } catch (_) {
    // Offline or slow server: keep the session; the next request refreshes it.
  }
  return webClient.auth.isAuthenticated;
}
