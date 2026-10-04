# 分享站点（Firebase Hosting）

[English](README.md) | **简体中文**

托管分享视频用的 `https://share.glyphora.net/v/<videoId>` 页面，以及让手机在 App 内打开这些链接的域名校验文件。

部署前请先填写：

- `public/.well-known/assetlinks.json`：App 签名证书的 SHA-256 指纹
- `public/.well-known/apple-app-site-association`：Apple Team ID
- `public/v/index.html` 中的应用商店地址（可选，上架之后再填）

部署：在本目录下运行 `firebase deploy --only hosting`。

域名必须与以下三处保持一致：`CLYVEN_SHARE_BASE_URL`（默认 `https://share.glyphora.net`）、`AndroidManifest.xml` 里的 intent filter，以及 `ios/Runner/Runner.entitlements` 里的 `applinks:`。

完整的配置步骤见[待办清单](../../docs/zh-CN/owner-checklist.md)。
