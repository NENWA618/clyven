import 'package:clyven_app/core/sharing/share_links.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds a share url and parses it back', () {
    final url = ShareLinks.videoUrl('42');
    expect(url, endsWith('/v/42'));
    expect(ShareLinks.parseVideoId(Uri.parse(url)), '42');
  });

  test('parses the app scheme', () {
    expect(ShareLinks.parseVideoId(Uri.parse('clyven://video/7')), '7');
    expect(ShareLinks.parseVideoId(Uri.parse('clyven://other/7')), isNull);
  });

  test('ignores unrelated links', () {
    expect(ShareLinks.parseVideoId(Uri.parse('https://evil.com/v/1')), isNull);
    expect(
      ShareLinks.parseVideoId(Uri.parse('${ShareLinks.baseUrl}/other/1')),
      isNull,
    );
  });
}
