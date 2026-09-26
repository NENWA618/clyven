# 跨用户视频可见性排查（2026-09-26）

## 最终沟通修正

用户随后确认：所看到的转圈是视频本身的内容，并非播放器加载动画。因此该现象不能作为跨账号播放失败的证据，前面的播放器卡住判断已撤回。以下保留排查过程及验证范围；缓存、错误处理和播放器超时修改属于健壮性改进，不应标记为已经证实并修复了真实跨账号播放根因。最终 Flutter analyze 无问题，Flutter 测试 9 个通过；未完成新版 APK 在用户手机上的验证。

## 结论与验证边界

用户补充：除了《帅哥》，新视频在模拟器可见，在自己打包安装的 APK 不可见。

**尚未复现该 APK 的精确失败点，不能宣称真实手机问题已彻底修复。** 初次排查没有连接的 Android 设备，也没有出问题的 APK。用户随后提供了 APK，静态检查见文末补充；手机运行时筛选状态和实际响应仍未取得。

已证实：

- 同一个线上公共 API 能匿名返回《帅哥》(9)、《ai 代码教学》(17)、《Self Introduction》(15)，包括不同作者。
- 9 和 17 是同一作者，都是 `status=published`、`isPublic=true`。三条视频及其封面，六个资源 HEAD 请求全部 HTTP 200。
- 当前部署与仓库协议不一致：线上返回 `isPublic`，没有 `contentType`；本地 Video schema 有 `contentType`，没有 `isPublic`。线上传 video/short 均返回相同 14 个 ID。
- 本地公共 Feed 没有 authorId/currentUserId 条件。不存在已证实的“后台只查作者自己”的根因。
- 本地有可复现的缓存与错误处理缺陷，已修复并加测试，但不能据此推断它们就是该 APK 的唯一根因。

## 真实记录对照

完整字段及资源状态保存在 `build/public-feed-audit.json`。这是部署中 API 返回的持久化模型记录，**不是直接连接生产数据库取得的 SQL dump**。

| 字段 | 正常示例 | 用户所述新视频示例 | 另一作者的新视频 |
|---|---|---|---|
| id | 9 | 17 | 15 |
| title | 帅哥 | ai 代码教学 | Self Introduction |
| authorId | 019fde7d-f98c-7c6b-92fc-8fefaa5a1f64 | 同左 | 01a0dd66-1c1b-7087-b187-1873040b5c95 |
| authorName | testing1 | testing1 | 時紡識 |
| description | 哈哈 | hai | Self Introduction |
| category | 城市 | 技术 | 语言 |
| languageCode | 响应未提供 | auto | ja |
| status | published | published | published |
| isPublic（线上响应） | true | true | true |
| createdAt/publishedAt（UTC） | 2026-08-14 06:44:16.741688 | 2026-09-26 14:39:17.658103 | 2026-09-26 13:31:28.168024 |
| 公共 API 返回 | 是 | 是 | 是 |
| 视频/封面 HEAD | 200/200 | 200/200 | 200/200 |

URL 并非 Video 表字段，实际存储 `videoStorageKey`、`coverStorageKey`，由 `getVideoUrl` 解析。完整 key 和去掉签名查询参数的 URL 见 JSON。

本地 schema 的完整业务字段：id、authorId、authorName、title、description、category、contentType、languageCode、tags、videoStorageKey、coverStorageKey、durationSeconds、viewCount、likeCount、favoriteCount、commentCount、status、publishedAt、createdAt、updatedAt。

本地不存在 ownerId/userId/type/visibility/isPublic/published/moderationStatus/processingStatus/deleted/isDeleted/videoUrl/thumbnailUrl 字段。线上 API 未提供这些额外字段中的任何一个，**除了 isPublic**；不能从 API 缺字段推断线上数据库一定没有该列。

## 数据保存和发布生命周期

元数据：Serverpod 的 PostgreSQL `video` 表。视频和封面：注册为 `public` 的 Google Cloud Storage bucket `glyphora-video-storage-11129163384`。此视频调用链不使用 Firebase/Firestore。

`CreateVideoPage` → `VideoUploadQueueNotifier` → FFmpeg 整理视频/封面 → `ServerpodVideoRepository.createVideo` → 申请上传描述 → 上传至 GCS → verifyUpload → `client.video.create` → `VideoEndpoint.create` → `Video.db.insertRow`。

后端使用认证 session 的 userIdentifier 作为 authorId，忽略客户端传来的 authorId。创建时直接设置 `published`、publishedAt/createdAt。之后创建 ASR job 并处理字幕。ASR 的 processing/readyForReview/failed 是另一张表的状态，不是 Video.status，不构成公共 Feed 的处理门槛。应用仅在 create 和 URL 转换返回后显示上传成功。

本次对照的 9/17/15 已发布，不存在缺 publishedAt 或滞留 pending 的证据。没有修改上传机制或强行改变这几条线上记录。

## 三条查询链

| 入口 | 调用链 | 原过滤条件 | 排序/其他行为 |
|---|---|---|---|
| 我的投稿 | MySubmissionsPage → myPublishedVideosProvider → loadUserVideos → client.video.getVideos() → VideoEndpoint.getVideos → Video.db.find | API 原本无过滤；Flutter 按 authorId == 登录用户 id 过滤 | createdAt 降序；逐条解析 URL |
| 首页/推荐 | HomePage → homeProvider → allPublishedVideosProvider → loadPublishedVideos(video) → client.video.getVideos(video) → VideoEndpoint.getVideos → Video.db.find | contentType == video；HomeNotifier 再按所选 category 过滤 | createdAt 降序；真实视频排在 mock 卡片前，featured 仍是 mock |
| Short | DiscoverPage → publishedShortsProvider → loadPublishedVideos(short) → client.video.getVideos(short) → VideoEndpoint.getVideos → Video.db.find | contentType == short；页面再按 category 过滤 | createdAt 降序；逐条解析 URL |

`getMyVideos` 是后端已有的认证作者查询，但目前 Flutter 的 loadUserVideos 同时服务作者主页和 profile，不能直接整体替换成 getMyVideos，否则其他作者主页会错误显示当前用户投稿。因此保持其调用语义。

修复后本地 getVideos 额外要求 `status == published`，不按查看者过滤；getVideo 的非 published 内容仅作者能看。getMyVideos 仍允许作者查询自己的处理中/失败内容。未新增无需过滤的全表公共 API，也未更改认证规则。

**部署限制：线上已有 isPublic 语义，本地没有。应取得线上对应源码/迁移并对齐后再发布后端，不能把本地 status 过滤当作完整私人内容保护。** 本次未部署后端、未修改线上权限，也未声称已经测试不存在于本地 schema 的 private/draft 状态。现有 GCS 是 public 存储，非公开媒体本身的私有存储设计不在本次修改中。

## 缓存、分页和错误处理

- 无磁盘 Feed 缓存、无分页 cursor/offset/limit，也没有仅请求一页造成漏新视频的代码。线上结果 ID 17 排第一，时间顺序正常。
- 公共 FutureProvider 原先只依赖长期不变的 repository/client；账号切换不使它失效。
- MainPage 使用 IndexedStack，首页和 Short 会预先构建、保持挂载。B 停留在应用中时，A 发布不会通知 B 的 provider。
- 发布成功只 invalidate 发布者设备上的 providers，因此作者更容易及时看到自己的新投稿。
- 原来逐条 URL 解析的 `catch (_)` 会吞掉所有异常，封面解析失败也会让整条视频消失。这能造成“有些卡片可见”，却没有错误提示或排除原因。
- 首页仍有演示数据，但 `_loadFeed` 实际会合并公共视频，不能仅看到 MockHomeRepository 就断言首页完全没接后端。本次未进行无关 UI 重构。

修改：公共 Feed 和详情依赖当前账号 id；账号改变后重新请求，仍允许匿名公共读取。切回首页/Short 时重新请求。Short 下拉刷新等待请求完成。封面失败保留可播放的视频；明确缺失的旧视频 URL 可排除并记录原因；视频 URL 的网络/API 异常向上传递为错误，不再伪装为空列表。

## 日志与复查

后端：POST_CREATED（id、owner、contentType、status、storage key、时间）；FEED_REQUEST（viewer、真实过滤、排序、返回数）。本地 schema 没有 visibility，因此不伪造 visibility=public；记录 storage key 而非可能带凭证的签名 URL。

Flutter：FEED_CLIENT（API 地址、编译 revision）；FEED_REQUEST；FEED_RESPONSE（计数、ID）；FEED_EXCLUDED（id、明确缺 URL）；FEED_FAILED（id、异常类型）；THUMBNAIL_UNAVAILABLE。

不记录 token、密码、原始异常正文或签名 URL。Debug 默认启用；release 需显式开启：

```powershell
cd apps/clyven_app
flutter build apk --release --dart-define=CLYVEN_FEED_DIAGNOSTICS=true --dart-define=CLYVEN_BUILD_REVISION=3d38e08-visibility-diagnostic
adb logcat -v time | Select-String 'FEED_|THUMBNAIL_UNAVAILABLE'
```

只读线上对照（从仓库根运行，不传登录凭证）：

```powershell
./tool/audit_public_feed.ps1
```

如果手机的 FEED_RESPONSE 不含 17，检查它实际连接地址、请求失败/旧缓存和部署版本；如果含 17 但 FEED_EXCLUDED/FEED_FAILED 出现，按相应 URL 解析原因定位；如果记录成功映射但未显示，再检查当前类别和页面状态；若能显示但不能播放，再检查设备网络和播放器错误。这样能把记录查询与媒体播放分开。

## 验证结果

- dart format：本次 Dart 文件已格式化。
- flutter analyze --no-pub（apps/clyven_app）：No issues found。
- flutter test --no-pub（apps/clyven_app）：6 个通过。
- dart analyze（backend）：0 error、0 warning；52 个既有 info，来自字典脚本、server.dart、subtitle_endpoint.dart，本次修改文件没有诊断。
- dart test（backend）：4 个通过（现有 greeting + 3 个可见性集成测试）。
- 数据库测试使用本机隔离 PostgreSQL、真实 Serverpod endpoint 和真实 DB 查询；A/B 是 Serverpod 测试认证 session。测试覆盖 A→B Video、A→B Short、B→A Video/Short、作者隔离、非 published 状态过滤和详情权限。每个测试事务自动回滚。
- 集成测试不包含真实手机登录、MP4 上传、GCS 或 ASR；使用缺失媒体 fixture 避免外部 ASR 调用。不能将这些测试称为线上双手机端到端测试。
- Flutter 新增测试验证账号切换后的两类 Feed、封面 503 保留记录、视频 URL 503 暴露错误、缺失 URL 排除；HTTP 测试通过真实生成的 Serverpod client 调用本地测试 HTTP 服务。
- 线上媒体验证为匿名 HEAD 200，不是使用真实 B 登录态播放 MP4；说明被测资源无需 A 凭证即可读取，不保证手机所在网络可达或解码成功。
- release APK 构建失败：Gradle/JDK `java.io.IOException: Unable to establish loopback connection`，底层 `UnixDomainSockets.connect0 / Invalid argument: connect`。改用较短 JVM 临时目录重试仍失败；未生成新 APK。

## 修改文件

- apps/clyven_app/lib/core/serverpod/feed_diagnostics.dart
- apps/clyven_app/lib/core/serverpod/serverpod_client_provider.dart
- apps/clyven_app/lib/features/video/data/repositories/serverpod_video_repository.dart
- apps/clyven_app/lib/features/video/presentation/providers/video_detail_provider.dart
- apps/clyven_app/lib/features/home/presentation/pages/main_page.dart
- apps/clyven_app/lib/features/home/presentation/pages/discover_page.dart
- server/clyven_backend_server/lib/src/endpoints/video_endpoint.dart
- apps/clyven_app/test/feed_account_switch_test.dart
- apps/clyven_app/test/serverpod_feed_repository_test.dart
- server/clyven_backend_server/test/integration/video_visibility_test.dart
- tool/audit_public_feed.ps1
- docs/video-visibility-investigation.md

尚需：运行故障 APK/连接手机采集日志以确定 APK 故障根因；对齐线上后端协议及 isPublic 权限实现；完成真实 A/B 手机复验。现有修复适用于本地 Video 和 Short 数据链，但不能解决仍在运行的旧线上后端不支持 contentType 的问题。

## 用户提供 APK 后的检查

- 文件：`C:/Users/Chai Zhen Hong/Downloads/app-release.apk`，140179895 字节。
- SHA256：`0D5587C0E1C5775410FBF87CCBBF9C3D95A1AD8797C29948C9BA1853FB31A8D1`。
- 包名：`com.example.clyven`；versionName `1.0.0`，versionCode `1`；minSdk 24、targetSdk 36。
- Manifest 包含 INTERNET、ACCESS_NETWORK_STATE 权限；未发现自定义 networkSecurityConfig；允许 cleartext。没有发现缺少 release 联网权限的证据。
- 包含 arm64-v8a、armeabi-v7a、x86_64 原生库。ARM64 与 x86_64 的 `libapp.so` 都包含相同线上地址 `https://glyphora-server-11129163384.asia-southeast1.run.app/`，与本次公共 API 核验目标一致。编译常量只能证明地址在包内，不能代替运行时请求抓取。
- 包内有 ServerpodVideoRepository、loadPublishedVideos、getVideos、getVideoUrl 等相关字符串。Flutter release 是 AOT 编译文件，不能仅凭字符串重建具体过滤条件。
- 未找到 FEED_CLIENT/FEED_REQUEST 等本次诊断字符串。不能单凭这一点断定是旧源码：release 未启用诊断开关时也会被编译器移除。
- APK 的 `META-INF/version-control-info.textproto` 为 `generate_error_reason: NO_SUPPORTED_VCS_FOUND`，没有可核验源码 commit。ZIP 内时间统一为 1981 年规范化时间；下载文件修改时间不是可靠编译时间。
- `isPublic` 字符串存在于 AOT 库，但无法仅由此确定它归属 Video 模型，因此不把这个字符串当作 APK schema 差异的证明。

本次 APK 检查没有改动用户提供的安装包，也没有发现足以确认手机漏新视频根因的静态证据。

尝试使用 `Small_Phone` AVD 的临时只读、无快照、无窗口实例（emulator-5580）运行该 APK。Android SDK 37 镜像启动期间安装服务尚不可用，随后日志出现 `com.android.systemui ... failed to complete startup` / ANR。因此没有完成 APK 安装和应用启动，此失败属于模拟器系统环境，不能归因于 Clyven。临时实例已关闭，未覆盖原 AVD 的应用或用户数据。

## 用户进一步确认：点进视频后画面一直转圈

用户明确表示：视频可以点进去，播放画面一直转圈；不同手机都如此，除了作者本人。**当前症状定位到播放初始化，不能再把它描述成已证实的 Feed 记录不可见。** 作者与查看者的实际运行时差异仍未取得。

追加只读验证：

- 线上 `getVideo(9/15/17)` 返回的 videoStorageKey/coverStorageKey 与 Feed 中一致，匿名可取得详情。
- 对三个 MP4 各读取最多 1 MiB，均返回 HTTP 206，支持 Range；均为 `ftyp → moov → free → mdat`，不是播放索引在文件尾部。
- 9：H.264 Main（profile 77、level 30），360×640；15：H.264 High（100/30），640×360；17：H.264 High（100/30），474×850。三者均有 mp4a 音轨。
- 三者 Content-Type 都为 application/octet-stream，包括已知可播放的 9；不能仅凭这个共同字段解释新旧差异。
- 编码头部差异不证明手机解码失败，更不能证明用户权限差异。未据此更改上传编码、转码或覆盖线上媒体。
- 详情页面对字幕请求使用可用值/空列表，未等待字幕完成再创建播放器。作者投稿列表与首页点击后都进入同一个 VideoDetailPage/NetworkVideoPlayer。当前源码的 networkUrl 不传作者专属认证头。

发现并修复的播放器生命周期缺陷：

- 原 `_initializePlayer()` 无限等待 initialize/setLooping/seekTo，FutureBuilder 在未完成时始终转圈。
- 增加覆盖整个初始化流程的 30 秒等待上限，超时进入已有播放失败提示并提供重新加载。
- 重试使用新 controller；旧 controller 释放一次，旧请求/事件不会恢复或污染新实例；退出时取消计时器。
- 播放器初始化之后收到 native error 也显示失败状态，原先没有处理该状态。
- 增加 PLAYBACK_INITIALIZING、PLAYBACK_READY、PLAYBACK_INIT_FAILED、PLAYBACK_NATIVE_ERROR 日志。日志包含 postId、network/file、host、阶段和允许的错误类别，不记录原始异常正文或签名 URL。
- release 开启日志仍需 `--dart-define=CLYVEN_FEED_DIAGNOSTICS=true`。抓取命令应额外匹配 `PLAYBACK_`。

新增/修改：`network_video_player.dart`、`video_detail_page.dart`、`test/network_video_player_test.dart`、`apps/clyven_app/pubspec.yaml`（显式引用测试用的已有 video_player_platform_interface 6.9.0，未升级运行时播放器）、`tool/audit_media_headers.py`。媒体头部证据保存为 `build/media-header-audit.json`。

追加验证：Flutter 全套 9 个测试通过，包括初始化不返回、超时释放、重试成功、迟到事件、初始化后的原生错误及加载中退出。**这些测试证明不再无限等待，不证明真实其他账号已能播放。** 仍需要非作者手机的播放日志，或同手机浏览器直接读取该新视频的结果，继续区分 App 播放与设备网络/资源读取问题。
