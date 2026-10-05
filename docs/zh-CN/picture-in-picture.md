# 画中画播放

[English](../en/picture-in-picture.md) | **简体中文**

用户在 App 内观看视频时，按下 Home 键（或使用回到桌面手势），视频会缩成悬浮小窗继续播放。

状态：Android 和 iOS 均已实现，但都还没有在真机上验证，见[待办清单](owner-checklist.md#5-真机验证)。

## 哪些播放器支持

只有视频详情页的长视频播放器支持画中画。播放器在播放期间声明自己可进入画中画；暂停、销毁或不再是当前播放器时，会撤销这个声明。

不包含：

* Shorts（竖屏短视频流）：滑动列表放进小窗体验不好。
* compact 紧凑播放器。
* 小窗里的自定义按钮（播放、暂停等），使用系统默认控件。

## Android

* `AndroidManifest.xml` 为 `MainActivity` 声明了 `supportsPictureInPicture` 和 `resizeableActivity`。
* `MainActivity.kt` 提供名为 `clyven/pip` 的 method channel：
  * Android 12 及以上：用户离开 App 时自动进入画中画（`setAutoEnterEnabled`）。
  * Android 8 到 11：在 `onUserLeaveHint` 里手动进入画中画。
  * 小窗宽高比跟随视频，并限制在 Android 允许的范围内（1:2.39 到 2.39:1）。
  * 进入和退出画中画时，通过 `pipChanged` 通知 Flutter。
* 处于画中画时，Flutter 端只显示视频画面（一个覆盖层），不显示整个页面。
* 进入画中画时 Android 也会触发 inactive、paused 等生命周期状态，而播放器平时会在这些状态下暂停。所以在可进入画中画的情况下，播放器会等 800 ms，让原生端确认已进入画中画后才决定是否暂停。
* 用户在 App 处于后台时关闭小窗，播放会暂停。

## iOS

* iOS 只能为 `AVPlayerLayer` 显示画中画。`video_player` 插件默认用纹理渲染，没有这个图层，所以符合条件的播放器在 iOS 上改用 `VideoViewType.platformView`，由原生 `AVPlayerLayer` 渲染。
* `ios/Runner/PipBridge.swift` 会找到屏幕上最大且带有播放器的 `AVPlayerLayer`，把 `AVPictureInPictureController` 绑定上去，并开启 `canStartPictureInPictureAutomaticallyFromInline`（iOS 14.2 及以上），让系统在 App 进入后台时自动启动画中画。插件没有公开它内部的 `AVPlayer`，所以只能通过遍历视图树来定位图层。
* `Info.plist` 开启了 `audio` 后台模式，这是画中画的必要条件，音频会话类别设为 playback。
* 与 Android 共用同一个 `clyven/pip` 通道和 `pipChanged` 事件。iOS 上小窗由系统根据原生图层绘制，因此不显示 Flutter 覆盖层。

## 需要留意

* iOS 的 platform view 渲染比纹理渲染有额外开销。请检查切换到迷你播放条的过渡动画，以及视频上方的字幕叠层是否卡顿或错位。
* 定位播放图层依赖 `video_player_avfoundation` 的视图结构，升级这个插件后需要重新测试。
* 用户在系统设置里关闭了画中画，或设备不支持时，不会进入画中画，此时行为和以前一致：退到后台就暂停。

## 关键文件

* `apps/clyven_app/lib/core/media/pip_service.dart`
* `apps/clyven_app/lib/features/video/presentation/widgets/network_video_player.dart`
* `apps/clyven_app/android/app/src/main/kotlin/com/example/clyven/MainActivity.kt`
* `apps/clyven_app/android/app/src/main/AndroidManifest.xml`
* `apps/clyven_app/ios/Runner/PipBridge.swift`
* `apps/clyven_app/ios/Runner/AppDelegate.swift`
* `apps/clyven_app/ios/Runner/Info.plist`
