import 'dart:convert';
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

// Review uses the same Glyphora Serverpod auth/session model as the other web apps.
final reviewClient =
    Client(
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
        connectionTimeout: const Duration(minutes: 2),
      )
      ..authSessionManager = ClientAuthSessionManager(
        storage: KeyValueClientAuthSuccessStorage(
          keyValueStorage: BrowserKeyValueStorage(),
        ),
      );

/// Imports a session handed over from Glyphora Web (`#sso=<base64url>`), then
/// strips the fragment. Must run before `reviewClient.auth.initialize()`.
/// An invalid or expired session is simply rejected by initialize/refresh and
/// falls back to the normal login form.
void consumeWebSession() {
  final match = RegExp(r'(?:^#|&)sso=([^&]+)').firstMatch(html.window.location.hash);
  if (match == null) return;

  try {
    final session = utf8.decode(base64Url.decode(match.group(1)!));
    html.window.localStorage['serverpod_auth_success_key'] = session;
  } catch (_) {
    // Malformed payload: ignore and use the regular login.
  }

  html.window.history.replaceState(
    null,
    '',
    html.window.location.pathname! + (html.window.location.search ?? ''),
  );
}

/// Restores the stored session from localStorage and validates it with the
/// server. `auth.initialize()` only waits 2s and throws on timeout, which used
/// to make a slow or cold-starting server look like "signed out". Here a
/// timeout or network error keeps the stored session; only a server-side
/// rejection (expired/revoked) signs the user out.
Future<bool> restoreStoredSession() async {
  await reviewClient.auth.restore();
  if (!reviewClient.auth.isAuthenticated) return false;
  try {
    await reviewClient.auth.validateAuthentication(
      timeout: const Duration(seconds: 30),
    );
  } catch (_) {
    // Offline or slow server: keep the session; the next request refreshes it.
  }
  return reviewClient.auth.isAuthenticated;
}
