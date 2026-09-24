import 'package:clyven_app/features/video/data/models/video_content_type.dart';
import 'package:clyven_app/features/video/data/models/video_upload_draft.dart';
import 'package:clyven_app/features/video/data/repositories/video_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('published video and short feeds remain separated', () async {
    final repository = MockVideoRepository();

    await repository.createVideo(
      userId: 'creator',
      authorName: 'Creator',
      draft: const VideoUploadDraft(
        videoPath: 'video.mp4',
        title: 'Long form',
        description: 'Long-form video',
        category: '影像',
        durationSeconds: 600,
      ),
    );
    await repository.createVideo(
      userId: 'creator',
      authorName: 'Creator',
      draft: const VideoUploadDraft(
        videoPath: 'short.mp4',
        title: 'Short form',
        description: 'Short-form video',
        category: '语言',
        durationSeconds: 30,
        contentType: VideoContentType.short,
      ),
    );

    final videos = await repository.loadPublishedVideos();
    final shorts = await repository.loadPublishedVideos(
      contentType: VideoContentType.short,
    );

    expect(videos, hasLength(1));
    expect(videos.single.contentType, VideoContentType.video);
    expect(shorts, hasLength(1));
    expect(shorts.single.contentType, VideoContentType.short);
  });
}
