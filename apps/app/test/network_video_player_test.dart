import 'dart:async';

import 'package:glyphora_app/core/serverpod/serverpod_client_provider.dart';
import 'package:glyphora_app/features/video/presentation/widgets/network_video_player.dart';
import 'package:glyphora_backend_client/backend_client.dart' as serverpod;
import 'package:glyphora_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:video_player/video_player.dart';

class TestManifestEndpoint implements serverpod.EndpointVideo {
  @override
  Future<String?> getPlaybackManifestUrl({required int videoId}) async =>
      'https://media.example/manifest.m3u8';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestManifestClient implements serverpod.Client {
  @override
  final video = TestManifestEndpoint();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestVideoPlatform extends VideoPlayerPlatform {
  final events = <int, StreamController<VideoEvent>>{};
  final disposed = <int>[];
  final played = <int>[];
  final paused = <int>[];
  final loopSettings = <bool>[];
  final sources = <String?>[];

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    sources.add(options.dataSource.uri);
    final id = events.length + 1;
    events[id] = StreamController<VideoEvent>();
    return id;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) => events[playerId]!.stream;

  @override
  Future<void> dispose(int playerId) async {
    disposed.add(playerId);
  }

  @override
  Future<void> setLooping(int playerId, bool looping) async {
    loopSettings.add(looping);
  }

  @override
  Future<void> setVolume(int playerId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async {}

  @override
  Future<void> pause(int playerId) async {
    paused.add(playerId);
  }

  @override
  Future<void> play(int playerId) async {
    played.add(playerId);
  }

  @override
  Future<Duration> getPosition(int playerId) async => Duration.zero;

  @override
  Future<void> seekTo(int playerId, Duration position) async {}

  @override
  Widget buildViewWithOptions(VideoViewOptions options) => const SizedBox();

  void ready(int id, {Size size = const Size(640, 360), int rotation = 0}) =>
      events[id]!.add(
        VideoEvent(
          eventType: VideoEventType.initialized,
          duration: const Duration(seconds: 60),
          size: size,
          rotationCorrection: rotation,
        ),
      );
}

Widget player({
  String url = 'https://media.example/video.mp4',
  bool compact = false,
  double? maxHeight,
  serverpod.Client? client,
}) => ProviderScope(
  overrides: [
    if (client != null) serverpodClientProvider.overrideWithValue(client),
  ],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight ?? double.infinity,
            ),
            child: NetworkVideoPlayer(
              compact: compact,
              videoId: client == null ? null : 17,
              videoUrl: url,
              coverUrl: '',
              subtitles: const [],
              initialPositionSeconds: 0,
              fallbackDurationSeconds: 60,
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    ),
  ),
);

void main() {
  late TestVideoPlatform platform;
  late VideoPlayerPlatform original;

  setUp(() {
    original = VideoPlayerPlatform.instance;
    platform = TestVideoPlatform();
    VideoPlayerPlatform.instance = platform;
  });

  tearDown(() async {
    VideoPlayerPlatform.instance = original;
    for (final stream in platform.events.values) {
      await stream.close();
    }
  });

  for (final fallback in [false, true]) {
    testWidgets(
      'portrait uses ${fallback ? 'ORIGINAL fallback' : 'HLS'} display ratio',
      (tester) async {
        await tester.pumpWidget(
          player(client: TestManifestClient(), compact: true),
        );
        await tester.pump();
        expect(platform.sources, ['https://media.example/manifest.m3u8']);
        if (fallback) {
          platform.events[1]!.addError(
            PlatformException(code: 'VideoError', message: 'HLS source failed'),
          );
          await tester.pump();
          await tester.pump();
          expect(platform.sources.last, 'https://media.example/video.mp4');
        }
        platform.ready(fallback ? 2 : 1, size: const Size(1080, 1920));
        await tester.pumpAndSettle();
        expect(
          tester.getSize(find.byType(VideoPlayer)).aspectRatio,
          closeTo(9 / 16, 0.001),
        );
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
        await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      },
    );
  }

  for (final source in [const Size(1080, 1920), const Size(1920, 1080)]) {
    for (final rotation in [0, 90, 180, 270]) {
      testWidgets(
        'Shorts contains native display size $source rotation $rotation',
        (tester) async {
          const viewport = Size(360, 640);
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = viewport;
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
          Widget shorts(bool active) => ProviderScope(
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    NetworkVideoPlayer(
                      videoId: null,
                      videoUrl: 'https://media.example/portrait.mp4',
                      coverUrl: '',
                      subtitles: const [],
                      initialPositionSeconds: 0,
                      fallbackDurationSeconds: 60,
                      compact: true,
                      shortsMode: true,
                      autoplay: true,
                      looping: true,
                      active: active,
                    ),
                  ],
                ),
              ),
            ),
          );
          await tester.pumpWidget(shorts(true));
          await tester.pump();
          platform.ready(1, size: source, rotation: rotation);
          await tester.pumpAndSettle();
          expect(tester.getSize(find.byType(NetworkVideoPlayer)), viewport);
          final video = tester.getSize(find.byType(VideoPlayer));
          expect(video.aspectRatio, closeTo(source.aspectRatio, 0.001));
          expect(video.width, lessThanOrEqualTo(viewport.width));
          expect(video.height, lessThanOrEqualTo(viewport.height));
          expect(find.textContaining('SOURCE='), findsNothing);
          expect(platform.played, [1]);
          expect(platform.loopSettings, contains(true));
          await tester.pumpWidget(shorts(false));
          await tester.pump();
          expect(platform.paused.last, 1);
          await tester.pumpWidget(shorts(true));
          await tester.pump();
          expect(platform.played, [1, 1]);
          expect(platform.events.length, 1);
          expect(tester.takeException(), isNull);
          await tester.pumpWidget(const SizedBox());
          await tester.runAsync(() => Future<void>.delayed(Duration.zero));
        },
      );
    }
  }

  for (final viewport in [
    const Size(360, 640),
    const Size(640, 360),
    const Size(1280, 720),
  ]) {
    for (final source in [const Size(1080, 1920), const Size(1920, 1080)]) {
      testWidgets('fits $source into $viewport with full source ratio', (
        tester,
      ) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = viewport;
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        final availableHeight = viewport.height * 0.6;
        await tester.pumpWidget(player(maxHeight: availableHeight));
        await tester.pump();
        platform.ready(1, size: source);
        await tester.pumpAndSettle();
        final frame = tester.getSize(find.byType(NetworkVideoPlayer));
        final video = tester.getSize(find.byType(VideoPlayer));
        expect(frame.height, lessThanOrEqualTo(availableHeight));
        expect(video.width / video.height, closeTo(source.aspectRatio, 0.001));
        expect(video.width, lessThanOrEqualTo(frame.width));
        expect(video.height, lessThanOrEqualTo(frame.height));
        expect(tester.takeException(), isNull);
        await tester.tap(find.byIcon(Icons.fullscreen_rounded));
        await tester.pumpAndSettle();
        final fullscreen = tester.getSize(find.byType(VideoPlayer).last);
        expect(
          fullscreen.width / fullscreen.height,
          closeTo(source.aspectRatio, 0.001),
        );
        expect(fullscreen.height, lessThanOrEqualTo(viewport.height));
        expect(fullscreen.width, lessThanOrEqualTo(viewport.width));
        await tester.tap(find.byIcon(Icons.fullscreen_exit_rounded));
        await tester.pumpAndSettle();
        expect(find.byType(VideoPlayer), findsOneWidget);
        await tester.pumpWidget(const SizedBox());
        await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      });
    }
  }

  testWidgets('compact keeps its 16:9 frame for portrait content', (
    tester,
  ) async {
    await tester.pumpWidget(player(compact: true));
    await tester.pump();
    platform.ready(1, size: const Size(1080, 1920));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(find.byType(NetworkVideoPlayer)).aspectRatio,
      closeTo(16 / 9, 0.001),
    );
    expect(
      tester.getSize(find.byType(VideoPlayer)).aspectRatio,
      closeTo(9 / 16, 0.001),
    );
    await tester.pumpWidget(player(compact: true, maxHeight: 100));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(find.byType(NetworkVideoPlayer)).aspectRatio,
      closeTo(16 / 9, 0.001),
    );
    expect(tester.getSize(find.byType(NetworkVideoPlayer)).height, 100);
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  });

  testWidgets(
    'stalled initialization times out, disposes and retries a fresh player',
    (tester) async {
      await tester.pumpWidget(player());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(platform.events.keys, [1]);
      await tester.pump(const Duration(seconds: 31));
      await tester.pumpAndSettle();
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.play_disabled_rounded), findsOneWidget);
      expect(platform.disposed, [1]);
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(platform.events.keys, [1, 2]);
      platform.ready(1);
      platform.ready(2);
      await tester.pump();
      await tester.pump();
      expect(find.byIcon(Icons.play_disabled_rounded), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(platform.disposed, [1, 2]);
    },
  );

  testWidgets('native error after initialization displays a retry state', (
    tester,
  ) async {
    await tester.pumpWidget(player());
    await tester.pump();
    platform.ready(1);
    await tester.pump();
    await tester.pump();
    platform.events[1]!.addError(
      PlatformException(code: 'VideoError', message: 'Decoder failed'),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.play_disabled_rounded), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  });

  testWidgets(
    'leaving while loading cancels watchdog and releases native player',
    (tester) async {
      await tester.pumpWidget(player());
      await tester.pump();
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(platform.disposed, [1]);
    },
  );

  testWidgets(
    'switching source releases the old player and ignores late initialization',
    (tester) async {
      await tester.pumpWidget(player());
      await tester.pump();
      await tester.pumpWidget(player(url: 'https://media.example/short.mp4'));
      await tester.pump();
      platform.ready(1);
      platform.ready(2);
      await tester.pump();
      await tester.pump();
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(platform.disposed, [1]);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(platform.disposed, [1, 2]);
    },
  );
}
