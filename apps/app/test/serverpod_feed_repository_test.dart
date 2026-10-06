import 'dart:convert';
import 'dart:io';

import 'package:glyphora_app/features/video/data/repositories/serverpod_video_repository.dart';
import 'package:glyphora_app/features/video/data/models/video_content_type.dart'
    as app;
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HttpServer server;
  late Client client;
  late ServerpodVideoRepository repository;
  var failCover = false;
  var failVideo = false;
  var missingVideo = false;
  Object? requestedContentType;

  setUp(() async {
    failCover = false;
    failVideo = false;
    missingVideo = false;
    requestedContentType = null;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    client = Client('http://127.0.0.1:${server.port}/');
    repository = ServerpodVideoRepository(client: client);
    server.listen((request) async {
      final body = jsonDecode(await utf8.decoder.bind(request).join()) as Map;
      request.response.headers.contentType = ContentType.json;
      if (request.uri.path == '/video' && body['method'] == 'getVideos') {
        requestedContentType = body['contentType'];
        final now = DateTime.utc(2026, 9, 26);
        request.response.write(
          jsonEncode([
            Video(
              id: 17,
              authorId: 'a',
              authorName: 'A',
              title: 'Video A',
              description: '',
              category: '技术',
              contentType:
                  requestedContentType == VideoContentType.short.toJson()
                  ? VideoContentType.short
                  : VideoContentType.video,
              seriesTitle: 'Series A',
              seriesId: 3,
              seriesPosition: 2,
              tags: [],
              videoStorageKey: 'video.mp4',
              coverStorageKey: 'cover.jpg',
              durationSeconds: 10,
              viewCount: 42,
              engagedViewCount: 0,
              status: VideoStatus.published,
              publishedAt: now,
              createdAt: now,
              updatedAt: now,
            ).toJson(),
          ]),
        );
      } else if (request.uri.path == '/video' &&
          body['method'] == 'getVideoUrl') {
        final isCover = body['path'] == 'cover.jpg';
        if ((isCover && failCover) || (!isCover && failVideo)) {
          request.response.statusCode = 503;
          request.response.write('{}');
        } else {
          request.response.write(
            jsonEncode(
              !isCover && missingVideo
                  ? null
                  : 'https://media.example/${body['path']}',
            ),
          );
        }
      } else {
        request.response.statusCode = 404;
      }
      await request.response.close();
    });
  });

  tearDown(() async {
    client.close();
    await server.close(force: true);
  });

  test('another author survives a thumbnail resolution failure', () async {
    failCover = true;
    final feed = await repository.loadPublishedVideos();
    expect(feed.single.id, '17');
    expect(feed.single.authorId, 'a');
    expect(feed.single.videoUrl, 'https://media.example/video.mp4');
    expect(feed.single.coverUrl, isEmpty);
  });

  for (final type in app.VideoContentType.values) {
    test('$type feed retains content type, series and views', () async {
      final feed = await repository.loadPublishedVideos(contentType: type);
      expect(
        requestedContentType,
        type == app.VideoContentType.short
            ? VideoContentType.short.toJson()
            : VideoContentType.video.toJson(),
      );
      expect(feed.single.contentType, type);
      expect(feed.single.seriesId, 3);
      expect(feed.single.seriesTitle, 'Series A');
      expect(feed.single.seriesPosition, 2);
      expect(feed.single.viewCount, 42);
    });
  }

  test(
    'video URL network failure surfaces instead of becoming an empty feed',
    () async {
      failVideo = true;
      await expectLater(repository.loadPublishedVideos(), throwsA(anything));
    },
  );

  test(
    'missing legacy media can be excluded without blocking valid records',
    () async {
      missingVideo = true;
      expect(await repository.loadPublishedVideos(), isEmpty);
    },
  );
}
