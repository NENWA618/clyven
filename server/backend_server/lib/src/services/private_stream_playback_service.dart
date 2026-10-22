import 'dart:convert';
import 'dart:io';

/// Issues a time-limited HLS URL only for Stream assets already protected
/// by requireSignedURLs. Caller MUST check Glyphora video ownership first.
class PrivateStreamPlaybackService {
  const PrivateStreamPlaybackService();

  Future<String?> signedManifestUrl(String uid) async {
    if (!RegExp(r'^[A-Za-z0-9_-]{10,80}$').hasMatch(uid)) return null;
    final account = Platform.environment['CLOUDFLARE_ACCOUNT_ID']?.trim() ?? '';
    final apiToken =
        Platform.environment['CLOUDFLARE_STREAM_API_TOKEN']?.trim() ?? '';
    if (account.isEmpty || apiToken.isEmpty) return null;
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    try {
      Future<Map<String, dynamic>?> call(String method, String suffix) async {
        final uri = Uri.https(
          'api.cloudflare.com',
          '/client/v4/accounts/$account/stream/$uid$suffix',
        );
        final request = await client
            .openUrl(method, uri)
            .timeout(const Duration(seconds: 20));
        request.headers.set(
          HttpHeaders.authorizationHeader,
          'Bearer $apiToken',
        );
        final response = await request.close().timeout(
          const Duration(seconds: 30),
        );
        final raw = await utf8.decoder
            .bind(response)
            .join()
            .timeout(const Duration(seconds: 30));
        if (response.statusCode < 200 || response.statusCode >= 300)
          return null;
        final payload = jsonDecode(raw);
        if (payload is! Map<String, dynamic> || payload['success'] != true)
          return null;
        final result = payload['result'];
        return result is Map<String, dynamic> ? result : null;
      }

      // Fail closed: never issue tokens for a public Stream asset.
      final asset = await call('GET', '');
      if (asset == null ||
          asset['requireSignedURLs'] != true ||
          asset['readyToStream'] != true)
        return null;
      final manifest = (asset['playback'] is Map)
          ? (asset['playback'] as Map)['hls']?.toString()
          : null;
      final parsed = manifest == null ? null : Uri.tryParse(manifest);
      if (parsed == null ||
          parsed.scheme != 'https' ||
          !(parsed.host.endsWith('.cloudflarestream.com') ||
              parsed.host == 'videodelivery.net'))
        return null;

      // Cloudflare's /token API defaults to one hour, no download permission.
      final tokenResponse = await call('POST', '/token');
      final token = tokenResponse?['token']?.toString();
      if (token == null ||
          !RegExp(
            r'^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$',
          ).hasMatch(token)) {
        return null;
      }
      final segments = parsed.pathSegments;
      if (segments.length < 3 ||
          segments[0] != uid ||
          segments[1] != 'manifest')
        return null;
      return parsed
          .replace(pathSegments: [token, ...segments.skip(1)])
          .toString();
    } catch (_) {
      return null;
    } finally {
      client.close(force: true);
    }
  }
}
