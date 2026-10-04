/// Share links for videos.
///
/// A shared link is a normal https page (`<base>/v/<id>`) hosted on Firebase
/// Hosting. Phones with the app open the video directly (Universal Links /
/// App Links); everyone else lands on a page that offers to open or install
/// the app. The custom scheme `clyven://video/<id>` is the fallback used by
/// that page's "Open in Clyven" button.
class ShareLinks {
  ShareLinks._();

  /// Override with `--dart-define=CLYVEN_SHARE_BASE_URL=https://example.com`.
  /// Must match the host declared in AndroidManifest.xml / Runner.entitlements.
  static const String baseUrl = String.fromEnvironment(
    'CLYVEN_SHARE_BASE_URL',
    defaultValue: 'https://share.glyphora.net',
  );

  static const String appScheme = 'clyven';

  static String videoUrl(String videoId) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return '$base/v/${Uri.encodeComponent(videoId)}';
  }

  /// Returns the video id for a share link or app-scheme link, else null.
  static String? parseVideoId(Uri uri) {
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();

    if (uri.scheme == appScheme) {
      // clyven://video/<id>
      if (uri.host == 'video' && segments.isNotEmpty) return segments.first;
      return null;
    }

    final baseHost = Uri.tryParse(baseUrl)?.host;
    if ((uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host == baseHost &&
        segments.length >= 2 &&
        segments.first == 'v') {
      return segments[1];
    }
    return null;
  }
}
