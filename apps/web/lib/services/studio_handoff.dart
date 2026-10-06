import 'dart:convert';
import 'dart:html' as html;

/// Storage key used by `KeyValueClientAuthSuccessStorage` (serverpod default).
const _authStorageKey = 'serverpod_auth_success_key';

/// Web and Studio live on different origins, so they cannot share
/// localStorage. When the user is signed in on Web, hand the current auth
/// session to Studio through the URL fragment (never sent to a server and
/// stripped by Studio right after it is read) so no second login is needed.
String studioUrlWithSession(String studioUrl) {
  final session = html.window.localStorage[_authStorageKey];
  if (session == null || session.isEmpty) return studioUrl;

  final uri = Uri.parse(studioUrl);
  final payload = base64Url.encode(utf8.encode(session));
  return uri.replace(fragment: 'sso=$payload').toString();
}
