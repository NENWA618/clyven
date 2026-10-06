# 消息推送

[English](../en/push-notifications.md) | **简体中文**

针对点赞、评论、关注的系统级推送，通过 Firebase Cloud Messaging（FCM）下发。FCM 同时覆盖 Android 和 iOS（iOS 在 FCM 背后走 Apple 的 APNs）。

状态：服务端和 App 均已实现。在配置 Firebase 之前不会真正发出任何推送，见[待办清单](owner-checklist.md#1-firebase-控制台)。

## 工作流程

```text
用户 A 给用户 B 点赞 / 评论 / 关注
        │
        ▼
createNotification()            写入站内通知记录
        │
        ▼
检查 B 的设置                    推送总开关，以及点赞 / 评论 / 关注分项开关
        │
        ▼
PushService                     查询 B 已登记的设备
        │
        ▼
FCM HTTP v1                     每台设备一条消息，使用该设备的语言
        │
        ▼
B 的手机弹出通知，点击后打开对应视频
```

## 服务端

* **数据表 `device_token`**：`userId`、`token`（唯一）、`platform`、`languageCode`（默认 `en`）、`updatedAt`。对应迁移：`add-device-token` 和 `device-token-language`。
* **端点 `pushDevice`**：
  * `register(token, platform, languageCode)` 把令牌绑定到当前登录用户。一个令牌只属于一个用户，同一台设备换人登录时，令牌会转移给新用户。
  * `unregister(token)` 删除令牌。
* **`PushService`**（`lib/src/services/push_service.dart`）使用 Google 服务账号（`googleapis_auth`）认证并调用 FCM HTTP v1 接口。失效令牌（HTTP 404，或 400 且包含 `UNREGISTERED`）会被自动删除。发送失败只记录日志、不抛异常，所以推送出问题不会影响点赞或评论本身。
* **`notification_service.dart`** 在写入通知后触发推送；如果调用发生在数据库事务内（此时记录尚未提交），则跳过推送。
* **多语言**：按设备的 `languageCode` 选文案。目前提供简体中文（`zh`）和英文，文案与 App 内的通知文案一致；其他语言回退到英文。新增语言请修改 `notification_service.dart` 末尾的 `_pushMessage`。
* **密钥**：Serverpod 密码 `fcmServiceAccountJson` 存放完整的服务账号 JSON。没有配置时，推送会静默跳过，本地开发不受影响。

## App 端

* `lib/core/push/push_notifications.dart` 负责初始化 Firebase、申请通知权限、监听令牌刷新，并处理点击（带 `videoId` 的通知会通过 `openGlobalVideo` 打开对应视频）。
* `lib/main.dart` 在登录后登记设备，App 内语言变化时再登记一次，上传当前生效的语言（`zh` 或 `en`，选择“跟随系统”时取系统语言）。
* `AuthNotifier.logout` 在退出登录之前先注销设备，因为这个调用需要有效的登录会话。
* 缺少 Firebase 配置文件时，初始化会静默失败，推送被禁用，站内通知列表照常使用。
* Android：声明了 `POST_NOTIFICATIONS` 权限（Android 13 起必需）；Google Services Gradle 插件仅在存在 `google-services.json` 时才启用，没有 Firebase 配置的构建不受影响。
* iOS：`Runner.entitlements` 中的 `aps-environment`，以及 `remote-notification` 后台模式。

## 限制

* FCM 依赖 Google 服务。没有 Google 服务的 Android 手机（中国大陆常见）收不到推送，覆盖这部分用户需要厂商通道或聚合推送服务。
* 评论推送的正文是评论预览，不会被翻译。
* `aps-environment` 目前是 `development`，上架 App Store 前需要改为 `production`。

## 关键文件

* `server/backend_server/lib/src/models/device_token.spy.yaml`
* `server/backend_server/lib/src/endpoints/push_device_endpoint.dart`
* `server/backend_server/lib/src/services/push_service.dart`
* `server/backend_server/lib/src/services/notification_service.dart`
* `apps/app/lib/core/push/push_notifications.dart`
* `apps/app/lib/main.dart`
