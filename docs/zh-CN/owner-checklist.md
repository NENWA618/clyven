# 待办清单

[English](../en/owner-checklist.md) | **简体中文**

画中画、消息推送和分享链接的代码都已写好。剩下的是只有项目所有者才能完成的配置：账号、密钥、DNS 和真机测试。请按顺序完成，并勾选。

相关文档：[画中画](picture-in-picture.md)、[消息推送](push-notifications.md)、[分享链接](share-links.md)。

**切勿提交到 git**：Firebase 服务账号 JSON、Apple 的 `.p8` 密钥、`config/passwords.yaml`。

## 0. 先做的决定

- [ ] **应用包名 / Bundle ID。** 两个平台目前都还是示例的 `com.example.clyven`。Google Play 不接受以 `com.example` 开头的包名。如果打算上架，现在就改：Android 的 `applicationId` 和 `namespace`、iOS 的 Bundle Identifier、Firebase 里的应用、`google-services.json`、`GoogleService-Info.plist`，以及第 3 节的两个校验文件都依赖它。以后再改就要把这些步骤重做一遍。
- [ ] **分享域名。** 代码里使用 `share.glyphora.net`。可以保留，也可以换成别的子域名，换的话按[分享链接](share-links.md#为什么用独立子域名)里列的三处同步修改。

消息推送和分享链接**不要求**上架 Google Play，侧载安装的包也能用。费用方面：这个规模下 FCM 和 Firebase Hosting 免费；只有 Apple 开发者计划需要付费（约每年 99 美元，iOS 推送必须有），以及只在上架 Android 时才需要的 Google Play 开发者账号（一次性 25 美元）。最新条款请在 Firebase 控制台的“用量和结算”页面确认。

## 1. Firebase 控制台

- [ ] 打开 [Firebase 控制台](https://console.firebase.google.com)，点“添加项目”，选择已有的 Google Cloud 项目 `glyphora-video`。用同一个项目可以让 Firebase 和后端放在一起。
- [ ] 添加 **Android 应用**，包名填第 0 节确定的包名（目前是 `com.example.clyven`）。下载 `google-services.json`，放到 `apps/clyven_app/android/app/google-services.json`。
- [ ] 添加 **iOS 应用**，Bundle ID 相同。下载 `GoogleService-Info.plist`，留到第 2 节使用。
- [ ] 打开“项目设置 → 服务账号 → 生成新的私钥”，下载 JSON。这是服务端发送推送用的密钥，请妥善保管，第 4 节会用到。

## 2. Apple 开发者后台与 Xcode（仅 iOS）

需要付费的 Apple 开发者账号和一台 Mac。

- [ ] 在 Certificates, Identifiers & Profiles → Identifiers 里打开这个 App 的标识符，勾选 **Push Notifications** 和 **Associated Domains**，保存。
- [ ] 在 Keys 里新建一个密钥，勾选 **Apple Push Notifications service (APNs)**，下载 `.p8` 文件。这个文件只能下载一次。记下 Key ID 和 Team ID。
- [ ] 在 Firebase 控制台打开“项目设置 → 云消息传递 → iOS 应用配置”，上传 `.p8`，填入 Key ID 和 Team ID。
- [ ] 用 Xcode 打开 `apps/clyven_app/ios/Runner.xcworkspace`，把 `GoogleService-Info.plist` 拖进 Runner 分组，勾选“Copy items if needed”和 Runner target。
- [ ] 在 Runner → Signing & Capabilities 里确认已有 Push Notifications、Associated Domains 和 Background Modes（Audio 与 Remote notifications），缺哪个补哪个。

## 3. 分享站点与域名

分享落地页和校验文件在 `deploy/share_site` 中，托管在 Firebase Hosting。

- [ ] 在 Firebase 控制台打开 Hosting，点“添加自定义网域”，填入 `share.glyphora.net`。
- [ ] 在 DNS 服务商处添加 Firebase 给出的记录（一条 TXT 验证记录，加一条 A 记录或 CNAME）。这只影响 `share` 子域名，根域名和 `www` 不受影响。
- [ ] 等待 Firebase 签发 HTTPS 证书（几分钟到几小时）。
- [ ] 填写 `deploy/share_site/public/.well-known/assetlinks.json`：把 `REPLACE_WITH_SIGNING_CERT_SHA256` 换成 Android 应用签名证书的 SHA-256 指纹。
  * 调试包：`keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`
  * 由 Google Play 签名的正式包：使用 Play 控制台“应用完整性”里显示的指纹。
- [ ] 填写 `deploy/share_site/public/.well-known/apple-app-site-association`：把 `REPLACE_WITH_TEAM_ID` 换成 Apple Team ID。
- [ ] 部署：在 `deploy/share_site` 目录运行 `firebase deploy --only hosting`。
- [ ] 可选，应用上架之后：把应用商店地址填进 `deploy/share_site/public/v/index.html` 脚本顶部的两个变量，商店按钮才会显示。

## 4. 服务端

- [ ] 把第 1 节下载的服务账号 JSON 配置成 Serverpod 密码 `fcmServiceAccountJson`。
  * 本地开发：写入 `server/clyven_backend_server/config/passwords.yaml` 的 `shared:` 下，用单行 JSON 字符串。
  * Cloud Run：把 JSON 存进 Secret Manager，再以环境变量 `SERVERPOD_PASSWORD_fcmServiceAccountJson` 的形式提供给服务。
- [ ] 给 Cloud Run 的运行服务账号授予这个密钥的 **Secret Manager Secret Accessor** 权限。
- [ ] 部署服务端，启动时带 `--apply-migrations`，让 `device_token` 表及其 `languageCode` 列被创建（共两个迁移）。

## 5. 真机验证

请使用真机。iOS 模拟器既收不到推送，也不能显示画中画。

消息推送：

- [ ] 登录后弹出通知权限请求，点允许。
- [ ] `device_token` 表新增一行，`languageCode` 为 `zh` 或 `en`。
- [ ] 用第二个账号给第一个账号的视频点赞：第一部手机在前台和后台都能收到推送。
- [ ] 点击推送，打开的是正确的视频。
- [ ] 在 App 内切换语言后，下一条推送的语言随之改变。
- [ ] 关闭推送总开关或某一类通知后，对应的推送不再收到。
- [ ] 如果收不到，先看服务端日志里有没有 `FCM send failed` 及其状态码。常见原因：密钥没配或被截断、服务账号属于另一个 Firebase 项目、没上传 APNs 密钥、设备没有 Google 服务。

分享链接：

- [ ] 分享视频后得到 `https://share.glyphora.net/v/<id>` 形式的链接。
- [ ] 在装了 App 的手机上点击链接，会在 App 内打开视频。校验文件没填好时，会先打开落地页，再点“在 Clyven 中打开”启动 App。
- [ ] 在没装 App 的手机上，显示落地页。

画中画：

- [ ] Android 12 及以上：在详情页播放视频，按 Home 键，悬浮小窗继续播放。
- [ ] Android 8 到 11：同上（如果有这样的设备）。
- [ ] iOS：在真机 iPhone 上同上。同时检查迷你播放条过渡和字幕叠层有没有卡顿，因为 iOS 现在通过 platform view 渲染这些视频。
- [ ] 关闭悬浮小窗后，播放会暂停。

## 6. 正式上架前

- [ ] 把 `apps/clyven_app/ios/Runner/Runner.entitlements` 中的 `aps-environment` 从 `development` 改成 `production`。
- [ ] 如果还没改，替换示例包名（见第 0 节）。
- [ ] 把正式签名的指纹填进 `assetlinks.json`，并重新部署分享站点。

## 已知限制

* 没有 Google 服务的 Android 手机（中国大陆常见）用不了 FCM。要覆盖这部分用户，需要厂商通道或聚合推送服务。
* 聊天应用里的分享链接预览是通用的，不是单个视频的预览。
* 推送文案目前只有简体中文和英文，其他语言回退到英文。
