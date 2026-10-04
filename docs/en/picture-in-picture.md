# Picture-in-Picture Playback

**English** | [简体中文](../zh-CN/picture-in-picture.md)

When a user is watching a video in the app and presses the Home button (or uses the Home gesture), the video keeps playing in a small floating window.

Status: implemented for Android and iOS. Neither platform has been verified on a physical device yet; see the [owner checklist](owner-checklist.md#5-verify-on-devices).

## Which players qualify

Picture-in-picture is offered only for the long-form player on the video detail page. The player reports itself as eligible while it is playing, and withdraws eligibility when it pauses, is disposed, or stops being the active player.

Not included:

* Shorts (the vertical feed), because a swipe list does not make sense in a small window.
* The compact player.
* Custom actions in the floating window (play/pause buttons and so on). The system's default controls are used.

## Android

* `AndroidManifest.xml` declares `supportsPictureInPicture` and `resizeableActivity` on `MainActivity`.
* `MainActivity.kt` exposes a `clyven/pip` method channel:
  * Android 12 and later: the activity enters picture-in-picture automatically when the user leaves the app (`setAutoEnterEnabled`).
  * Android 8 to 11: the activity enters picture-in-picture in `onUserLeaveHint`.
  * The window aspect ratio follows the video and is clamped to the range Android accepts (1:2.39 to 2.39:1).
  * Entering and leaving picture-in-picture is reported back to Flutter as `pipChanged`.
* While in picture-in-picture, the Flutter side shows only the video surface (an overlay), not the whole page.
* Android also fires the "inactive / paused" lifecycle states when entering picture-in-picture. The player normally pauses on those states, so when it is eligible it waits 800 ms for the native side to confirm picture-in-picture before pausing.
* If the user dismisses the floating window while the app is in the background, playback pauses.

## iOS

* iOS can only show picture-in-picture for an `AVPlayerLayer`. The `video_player` plugin renders into a texture by default, which has no such layer, so eligible players use `VideoViewType.platformView` on iOS. That mode renders through a native `AVPlayerLayer`.
* `ios/Runner/PipBridge.swift` finds the largest on-screen `AVPlayerLayer` that has a player, binds an `AVPictureInPictureController` to it, and enables `canStartPictureInPictureAutomaticallyFromInline` (iOS 14.2 and later) so the system starts picture-in-picture when the app goes to the background. The plugin does not expose its `AVPlayer`, which is why the layer is located by walking the view tree.
* `Info.plist` enables the `audio` background mode, which picture-in-picture requires. The audio session category is set to playback.
* The same `clyven/pip` channel and `pipChanged` event are used as on Android. On iOS the system draws the floating window from the native layer, so no Flutter overlay is shown.

## Things to watch

* Platform-view rendering on iOS has a cost compared with texture rendering. Check the transition into the mini player and the subtitle overlay on top of the video for stutter or misalignment.
* Locating the player layer depends on how `video_player_avfoundation` builds its views. Re-test after upgrading that plugin.
* Picture-in-picture does not start if the user disabled it in system settings, or if the device does not support it. The app then behaves as before: playback pauses in the background.

## Key files

* `apps/clyven_app/lib/core/media/pip_service.dart`
* `apps/clyven_app/lib/features/video/presentation/widgets/network_video_player.dart`
* `apps/clyven_app/android/app/src/main/kotlin/com/example/clyven/MainActivity.kt`
* `apps/clyven_app/android/app/src/main/AndroidManifest.xml`
* `apps/clyven_app/ios/Runner/PipBridge.swift`
* `apps/clyven_app/ios/Runner/AppDelegate.swift`
* `apps/clyven_app/ios/Runner/Info.plist`
