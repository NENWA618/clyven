import 'package:clyven_studio/services/video_selection_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('selectedVideoMissingMessage', () {
    test('preserves a real selection error', () {
      const error = '无法读取该文件作为视频。文件可能已损坏、格式不受浏览器支持，或只是修改了文件扩展名。';

      expect(selectedVideoMissingMessage(error), error);
    });

    test('falls back when no file was selected', () {
      expect(selectedVideoMissingMessage(null), '请先选择视频文件');
      expect(selectedVideoMissingMessage('   '), '请先选择视频文件');
    });
  });
}
