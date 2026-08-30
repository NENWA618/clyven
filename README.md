# Shipin

> A Flutter video platform client built with Riverpod and Serverpod.

**Shipin** 是一个使用 Flutter 开发的视频平台项目。

项目正在实现从用户认证、视频浏览、搜索、播放、投稿，到点赞、评论、关注、观看历史、通知和个人主页等完整的视频平台功能。

客户端使用 **Riverpod** 管理状态，并通过 **Serverpod** 与后端服务通信。

---

## Features

### Video

* 视频首页
* 视频列表
* 视频详情
* 视频播放
* 视频搜索
* 视频投稿
* 本地视频选择
* 视频时长读取
* 视频处理
* 视频分享

### Creator

* 创作者主页
* 关注创作者
* 已关注创作者列表

### Interaction

* 点赞
* 评论
* 视频互动状态
* 分享

### User

* 用户认证
* Auth Gate
* 个人主页
* 观看历史
* 通知

### Discovery

* 首页推荐
* 发现页面
* 视频搜索

---

# Tech Stack

## Client

* Flutter
* Dart
* Material UI

## State Management

* Riverpod

## Backend Communication

* Serverpod
* Serverpod Client
* Serverpod Flutter
* Serverpod Auth

## Video

* `video_player`
* `video_duration_native`
* FFmpeg

## Media

* `image_picker`

## Sharing

* `share_plus`

---

# Architecture

客户端采用以 Feature 为单位的模块化结构。

```text
lib/
│
├── core/
│   └── serverpod/
│
├── features/
│   ├── auth/
│   ├── comments/
│   ├── creator/
│   ├── history/
│   ├── home/
│   ├── notifications/
│   ├── profile/
│   ├── video/
│   └── video_interactions/
│
└── main.dart
```

每个 Feature 根据需要继续拆分：

```text
feature/
├── data/
│   ├── models/
│   └── repositories/
│
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

整体数据流可以理解为：

```text
UI
 │
 ▼
Riverpod Provider
 │
 ▼
Repository
 │
 ▼
Serverpod Client
 │
 ▼
Backend
 │
 ▼
Database / Video Storage
```

---

# Main Modules

## Authentication

```text
features/auth/
```

负责用户登录状态以及应用入口认证流程。

应用启动后由：

```text
AuthGate
```

决定用户应该进入认证流程还是主应用。

---

## Home

```text
features/home/
```

首页模块包含：

```text
home_page.dart
discover_page.dart
main_page.dart
video_search_page.dart
```

负责：

* 主导航
* 首页视频内容
* 发现内容
* 视频搜索

---

## Video

```text
features/video/
```

视频模块负责平台的核心视频功能。

主要页面：

```text
create_video_page.dart
video_detail_page.dart
```

包括：

```text
视频选择
   ↓
视频处理
   ↓
投稿
   ↓
上传
   ↓
后端创建视频记录
   ↓
首页 / 搜索
   ↓
视频详情
   ↓
视频播放
```

---

# Video Upload Flow

投稿不只是简单上传一个文件。

当前客户端已经引入：

* `image_picker`
* `video_duration_native`
* FFmpeg

用于媒体选择与视频处理。

整体流程设计为：

```text
选择视频
   │
   ▼
读取视频信息
   │
   ▼
准备投稿资料
   │
   ▼
视频处理
   │
   ▼
上传
   │
   ▼
Serverpod Backend
   │
   ▼
保存视频数据
   │
   ▼
视频发布
```

对于较大的视频文件，上传属于独立的任务流程，而不是要求用户一直停留在投稿页面。

---

# Video Playback

项目使用：

```text
video_player
```

处理客户端视频播放。

视频详情页负责整合：

```text
视频播放
+
视频信息
+
作者信息
+
互动状态
+
评论
```

形成完整的视频观看页面。

---

# Comments

```text
features/comments/
```

评论作为独立 Feature 管理。

结构包含：

```text
data/
presentation/
```

使评论的数据请求、状态和界面与视频主体模块保持解耦。

---

# Video Interactions

```text
features/video_interactions/
```

互动逻辑与视频内容本身分离。

该模块用于管理视频相关用户行为，例如：

```text
Like
Follow
Interaction State
```

这种拆分可以避免把所有逻辑集中在 `video_detail_page.dart` 中。

---

# Creator

```text
features/creator/
```

创作者模块包含：

```text
creator_profile_page.dart
following_creators_page.dart
```

用于展示创作者资料以及用户已经关注的创作者。

---

# History

```text
features/history/
```

负责保存和展示用户的视频观看历史。

---

# Notifications

```text
features/notifications/
```

用于集中处理平台通知相关功能。

未来可以继续扩展：

```text
Like Notification
Comment Notification
Follow Notification
Creator Notification
System Notification
```

---

# Profile

```text
features/profile/
```

负责用户自己的资料及相关个人功能。

---

# Serverpod

客户端通过：

```text
serverpod_client
serverpod_flutter
serverpod_auth_idp_flutter
```

连接后端。

Serverpod Client Provider 位于：

```text
lib/core/serverpod/serverpod_client_provider.dart
```

因此业务模块不需要自行创建后端 Client，而是通过统一 Provider 获取连接。

---

# Backend Dependency

当前仓库主要包含 **Flutter 客户端**。

`pubspec.yaml` 中使用本地路径引用生成的 Serverpod Client：

```yaml
shipin_backend_client:
  path: ../shipin_backend/shipin_backend_client
```

因此当前项目目录预期类似：

```text
workspace/
│
├── shipin/
│
└── shipin_backend/
    ├── shipin_backend_server/
    └── shipin_backend_client/
```

如果只单独 Clone `shipin`，需要另外准备对应的 Serverpod backend/client，或者修改 `pubspec.yaml` 中的依赖路径。

---

# Getting Started

## 1. Clone

```bash
git clone https://github.com/chengyang1017/shipin.git
cd shipin
```

---

## 2. Prepare Backend Client

确保项目能够找到：

```text
../shipin_backend/shipin_backend_client
```

或者修改：

```yaml
shipin_backend_client:
  path: ...
```

使其指向你本地实际的 Serverpod Client。

---

## 3. Install Dependencies

```bash
flutter pub get
```

---

## 4. Run

启动对应的 Serverpod 后端之后：

```bash
flutter run
```

选择 Android、iOS、Windows 或其他 Flutter 支持的平台运行。

---

# Project Structure

```text
shipin/
│
├── lib/
│   │
│   ├── core/
│   │   └── serverpod/
│   │       └── serverpod_client_provider.dart
│   │
│   ├── features/
│   │   │
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── comments/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── creator/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── history/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   ├── home/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       ├── providers/
│   │   │       └── widgets/
│   │   │
│   │   ├── notifications/
│   │   │
│   │   ├── profile/
│   │   │
│   │   ├── video/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │
│   │   └── video_interactions/
│   │       ├── data/
│   │       └── presentation/
│   │
│   └── main.dart
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
└── pubspec.yaml
```

---

# State Management

应用入口使用：

```dart
ProviderScope
```

包装整个应用：

```text
ProviderScope
     │
     ▼
VideoApp
     │
     ▼
AuthGate
     │
     ▼
Application
```

各个 Feature 可以拥有自己的 Provider，并通过 Riverpod 管理：

```text
Loading
Data
Error
User Actions
```

避免让页面 Widget 直接承担数据请求和业务状态。

---

# Design Direction

这个项目不是单独实现一个：

```text
VideoPlayer
```

而是在逐步实现完整的视频平台结构：

```text
Authentication
      │
      ▼
Video Feed
      │
 ┌────┼─────┐
 ▼    ▼     ▼
Search Video Creator
      │
      ▼
Video Detail
      │
 ┌────┼────────┐
 ▼    ▼        ▼
Like Comment Follow
      │
      ▼
History / Notifications / Profile
```

前端功能按照业务领域拆分，使后续继续增加功能时能够保持代码结构清晰。

---

# Roadmap

* [x] Flutter 客户端基础结构
* [x] Riverpod 状态管理
* [x] Serverpod Client 集成
* [x] 用户认证入口
* [x] 首页结构
* [x] 发现页面
* [x] 视频搜索
* [x] 视频详情
* [x] 视频播放
* [x] 视频投稿基础流程
* [x] 评论模块
* [x] 创作者模块
* [x] 视频互动模块
* [x] 历史模块
* [x] 通知模块
* [x] 个人资料模块
* [ ] 完善大型视频上传流程
* [ ] 完善投稿任务管理
* [ ] 完善视频处理与封面流程
* [ ] 完善推荐系统
* [ ] 完善通知系统
* [ ] 完善播放体验
* [ ] 完善错误恢复与网络状态处理
* [ ] 完善生产环境部署

---

# Status

This project is currently under active development.

现阶段重点是建立视频平台的完整客户端架构与 Serverpod 后端通信流程。

部分功能仍处于开发和完善阶段，不代表生产环境最终实现。

---

# Author

**Cheng Yang**

A Flutter video platform project exploring modular client architecture, Riverpod state management, Serverpod backend integration, media processing, and scalable video platform features.

> From video playback to a complete video platform.
