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

// Shared Glyphora browser auth boundary.
//
// Studio uses persistent browser storage instead of page-local memory auth.
// Future Glyphora Web should reuse the same Serverpod auth session. If Web and
// Studio are hosted on the same origin (for example / and /studio), entering
// Studio can restore the existing session without another login.
// Future Glyphora Web SSO hook: keep auth storage behind this shared client.
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

/// Imports a session handed over from Glyphora Web (`#sso=<base64url>`), then
/// strips the fragment. Must run before `studioClient.auth.initialize()`.
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

