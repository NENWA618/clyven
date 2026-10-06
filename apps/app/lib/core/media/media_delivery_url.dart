const String _mediaCdnBase = String.fromEnvironment(
  'GLYPHORA_MEDIA_CDN_BASE',
  defaultValue: '',
);

const String _gcsBucketName = 'glyphora-video-storage-11129163384';

/// Rewrites Glyphora public GCS transcoded media URLs to the configured CDN origin.
///
/// Default behavior is a no-op. Enable at build time with:
/// --dart-define=GLYPHORA_MEDIA_CDN_BASE=https://media.example.com
///
/// Only objects under /transcoded/ are rewritten. Original uploads such as
/// /videos/ continue to use their original GCS URLs.
String resolveMediaDeliveryUrl(String source) {
  final cdnBase = _mediaCdnBase.trim();
  if (cdnBase.isEmpty) return source;

  final sourceUri = Uri.tryParse(source);
  final cdnUri = Uri.tryParse(cdnBase);

  if (sourceUri == null ||
      cdnUri == null ||
      !cdnUri.hasScheme ||
      cdnUri.host.isEmpty) {
    return source;
  }

  final path = _extractBucketObjectPath(sourceUri);
  if (path == null || path.isEmpty) return source;

  if (!path.startsWith('/transcoded/')) {
    return source;
  }

  final cleanBasePath = cdnUri.path.endsWith('/')
      ? cdnUri.path.substring(0, cdnUri.path.length - 1)
      : cdnUri.path;

  final cleanObjectPath = path.startsWith('/') ? path : '/$path';

  return cdnUri
      .replace(
        path: '$cleanBasePath$cleanObjectPath',
        query: sourceUri.query.isEmpty ? null : sourceUri.query,
        fragment: sourceUri.fragment.isEmpty ? null : sourceUri.fragment,
      )
      .toString();
}

String? _extractBucketObjectPath(Uri uri) {
  if (uri.host == 'storage.googleapis.com') {
    if (uri.pathSegments.isEmpty || uri.pathSegments.first != _gcsBucketName) {
      return null;
    }

    if (uri.pathSegments.length == 1) return null;

    return '/${uri.pathSegments.skip(1).join('/')}';
  }

  if (uri.host == '$_gcsBucketName.storage.googleapis.com') {
    if (uri.pathSegments.isEmpty) return null;
    return '/${uri.pathSegments.join('/')}';
  }

  return null;
}
