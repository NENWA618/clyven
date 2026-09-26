import 'dart:async';

import 'package:clyven_app/features/video/presentation/widgets/network_video_player.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

class TestVideoPlatform extends VideoPlayerPlatform {
  final events = <int, StreamController<VideoEvent>>{};
  final disposed = <int>[];

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
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
  Future<void> setLooping(int playerId, bool looping) async {}

  @override
  Future<void> setVolume(int playerId, double volume) async {}

  @override
  Future<void> pause(int playerId) async {}

  @override
  Future<void> seekTo(int playerId, Duration position) async {}

  @override
  Widget buildViewWithOptions(VideoViewOptions options) => const SizedBox();

  void ready(int id) => events[id]!.add(
    VideoEvent(
      eventType: VideoEventType.initialized,
      duration: const Duration(seconds: 60),
      size: const Size(640, 360),
    ),
  );
}

Widget player({String url = 'https://media.example/video.mp4'}) =>
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: NetworkVideoPlayer(
            videoId: null,
            videoUrl: url,
            coverUrl: '',
            subtitles: const [],
            initialPositionSeconds: 0,
            fallbackDurationSeconds: 60,
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
}
