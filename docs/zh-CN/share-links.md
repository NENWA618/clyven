# 分享链接

[English](../en/share-links.md) | **简体中文**

分享视频会生成一个普通的网页链接。装了 App 的手机点击后，会直接在 App 内打开视频。此前 App 分享的是视频文件本身的地址，点开就会下载文件。

状态：已实现。只有部署并校验分享站点之后，链接才能完整跑通，见[待办清单](owner-checklist.md#3-分享站点与域名)。

## 链接格式

```text
https://share.glyphora.net/v/<videoId>      经过校验的网页链接
glyphora://video/<videoId>                     App 自定义协议（备用）
```

分享文本包含视频标题、作者名和链接。

## 工作流程

1. 用户在 App 内点击分享，文本中包含 `https://share.glyphora.net/v/<videoId>`。
2. 接收者点击链接：
   * **已安装 App 且域名已校验**：Android App Links / iOS Universal Links 直接打开 App。`DeepLinkHandler`（`app_links` 包）解析出视频 ID 并调用 `openGlobalVideo`。冷启动和 App 已在运行时都支持。
   * **其他情况**：浏览器显示落地页。手机上落地页会尝试一次 `glyphora://video/<id>`，同时提供“在 Glyphora 中打开”按钮，配置后还会显示应用商店按钮。
3. 视频能不能看，仍由 App 现有的逻辑判断。链接本身不暴露媒体文件地址。

## 为什么用 Firebase Hosting

后端运行在 Cloud Run 上，只对外开放 API 端口，而 API 服务无法托管自定义网页路由。所以落地页和校验文件做成静态文件，放在 Firebase Hosting（`deploy/share_site`）。

## 为什么用独立子域名

Android 和 iOS 获取校验文件（`/.well-known/assetlinks.json` 和 `/.well-known/apple-app-site-association`）时**不会跟随重定向**。根域名会 308 重定向到 `www`，而 `www` 托管着主站，两者都不能用。所以分享站点使用独立的子域名 `share.glyphora.net`。

如果要更换域名，需要同时修改以下三处：

* `apps/app/lib/core/sharing/share_links.dart` 中 `ShareLinks.baseUrl` 的默认值（或者构建时传 `--dart-define=GLYPHORA_SHARE_BASE_URL=...`）
* `AndroidManifest.xml` 中 https 入口的 `android:host`
* `ios/Runner/Runner.entitlements` 中的 `applinks:` 条目

## 限制

* 聊天应用里显示的链接预览是通用的（“Glyphora”），不是具体视频的标题和封面。原因是落地页是静态页面，爬虫不会执行 JavaScript。要做成每个视频单独预览，需要动态页面（比如 Cloud Functions）。
* 校验文件填好之前，链接会先打开落地页，再通过页面按钮启动 App。
* 包名目前还是示例的 `com.example.glyphora`，更换时需要同步更新两个校验文件和 Firebase 中的应用。

## 关键文件

* `apps/app/lib/core/sharing/share_links.dart`（生成与解析链接）
* `apps/app/lib/core/sharing/deep_link_handler.dart`
* `apps/app/android/app/src/main/AndroidManifest.xml`（intent filter）
* `apps/app/ios/Runner/Info.plist`（URL scheme）和 `Runner.entitlements`（关联域名）
* `deploy/share_site/`（Firebase Hosting 站点）
* `apps/app/test/core/share_links_test.dart`
