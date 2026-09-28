# Clyven

> A multilingual video + subtitle language-learning platform, built as a Flutter/Jaspr + Serverpod monorepo.

**Clyven** 早期是一个视频平台项目，目前已经演进为一个**多语言视频与字幕学习平台**：用户观看视频的同时可以查看双语/精校字幕，点词查词典、收藏生词、管理生词本，并追踪自己对词汇的掌握程度（Knowledge State）。项目还包含越南语 Chữ Nôm ↔ Quốc Ngữ script 转换、AI 字幕生成（ASR）与人工字幕审核（Review）等围绕"字幕生产"的完整工作流。

客户端使用 **Riverpod**（Flutter）管理状态，Web 端使用 **Jaspr**（Dart Web 框架），均通过 **Serverpod** 与统一的后端通信。

---

# Apps in this Monorepo

Clyven 由 5 个前端应用、1 个后端服务和 3 个共享 package 组成，用 Melos 统一管理。

| App | 技术栈 | 定位 | 本地端口 |
| --- | --- | --- | --- |
| `apps/clyven_app` | Flutter (iOS/Android/Desktop) | 面向普通用户的主客户端：视频流、字幕学习、词典、生词本 | - |
| `apps/clyven_web` | Jaspr (Dart Web) | 面向普通用户的公开 Web 端，功能对齐 `clyven_app` | 8084 |
| `apps/clyven_studio` | Jaspr (Dart Web) | 创作者后台：视频上传/管理、字幕与词典管理、评论管理 | 8083 |
| `apps/clyven_admin` | Jaspr (Dart Web) | 内部管理后台：用户管理、越南语 script 转换工具 | 8082 |
| `apps/clyven_review` | Jaspr (Dart Web) | 字幕审核工作台：审核队列、审核任务详情 | 8081 |
| `server/clyven_backend_server` | Serverpod | 统一后端服务，所有前端共用 | 8080 |

---

## Features

### Video

* 视频首页 / 发现页 / 搜索
* 视频详情与播放（含字幕联动）
* 视频投稿（本地视频选择、时长读取、FFmpeg 处理、上传）
* 视频系列（Series）
* 点赞 / 收藏 / 观看历史

### Subtitles & Language Learning

* 字幕轨道、逐句/逐词（token）级字幕数据结构
* 卡拉OK式逐字高亮播放（karaoke segments）
* SRT 字幕导入 / 导出
* AI 自动生成字幕（基于 Deepgram ASR，`asr_job_processor`）
* 字幕人工审核工作流：审核队列、审核任务、审核仪表盘（Review Dashboard）
* 播放页内嵌"字幕学习面板"（点词查词、逐句跟读）

### Dictionary & Vocabulary

* 词典查词（释义 / 例句 / 词形 / 词条关系）
* 词典批量导入（导入预览、字段映射、提交）
* 生词本（Word List）管理
* 用户"已掌握词条"（Known Entry）与掌握程度追踪（Knowledge State）

### Script Conversion

* 越南语 Chữ Nôm ↔ Quốc Ngữ 转换（`clyven_nom_converter`）
* 转换 profile 管理、批量导入预览与提交

### Creator (Studio)

* 创作者仪表盘
* 视频管理、字幕管理、词典管理
* 评论管理

### Interaction

* 点赞、评论（含回复、回复点赞）
* 关注创作者 / 已关注创作者列表
* 分享

### User

* 用户认证（Serverpod Auth IDP）、Auth Gate
* 个人主页 / 个人资料统计
* 观看历史
* 通知中心 + 通知设置 + 隐私设置

### Admin

* 用户管理
* 越南语 script 转换后台工具
* Excel 数据导入（词典 / 转换表）

---

# Tech Stack

## Client (Mobile / Desktop)

* Flutter, Dart
* Riverpod (`flutter_riverpod`)
* `video_player`, `video_duration_native`
* `ffmpeg_kit_flutter_new_min_gpl`（视频处理）
* `image_picker`, `share_plus`

## Web (public / studio / admin / review)

* Jaspr（`jaspr`, `jaspr_router`, `jaspr_flutter_embed`）

## Backend Communication

* Serverpod
* `serverpod_client` / `serverpod_flutter`
* `serverpod_auth_idp_flutter` / `serverpod_auth_core_client`

## Backend (Serverpod Server)

* Serverpod (PostgreSQL, migrations)
* Deepgram ASR（自动语音识别生成字幕）
* `excel`（词典 / 转换表导入）
* `serverpod_cloud_storage_gcp`（媒体存储）
* `mailer`, `googleapis_auth`

## Shared Packages

* `clyven_nom_converter` — 越南语 Latin ↔ Chữ Nôm 转换核心库（含 CLI）
* `clyven_subtitle_editor` — Studio 与 Review 共用的字幕编辑组件（时间轴、卡拉OK分段、SRT 导入导出）
* `clyven_backend_client` — Serverpod 自动生成的客户端代码，所有前端共用

## Monorepo Tooling

* Dart Workspace（`pubspec.yaml` workspace）
* Melos（`melos.yaml` 脚本，统一 dev / build / analyze / test）

---

# Architecture

`clyven_app` 客户端采用以 Feature 为单位的模块化结构（`clyven_web` / `clyven_studio` / `clyven_admin` / `clyven_review` 遵循类似的 pages/components/services 划分）：

```text
lib/
│
├── core/
│   ├── serverpod/
│   ├── navigation/
│   ├── localization/
│   ├── theme/
│   └── errors/
│
├── features/
│   ├── auth/
│   ├── comments/
│   ├── creator/
│   ├── dictionary/
│   ├── history/
│   ├── home/
│   ├── known_entry/
│   ├── notifications/
│   ├── profile/
│   ├── subtitle/
│   ├── video/
│   ├── video_interactions/
│   └── word_list/
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
Backend (Serverpod Endpoint)
 │
 ▼
Database / Cloud Storage
```

---

# Backend Modules (Serverpod Endpoints)

```text
video_endpoint                 视频 CRUD、系列、转码触发
comment_endpoint               评论 / 回复 / 点赞
social_endpoint                关注、互动状态
notification_endpoint          通知
notification_settings_endpoint 通知设置
privacy_settings_endpoint      隐私设置
subtitle_endpoint              字幕轨道 / cue / token / karaoke
review_endpoint                字幕审核队列与任务
dictionary_endpoint            词典查询
dictionary_import_endpoint     词典批量导入
word_list_endpoint             生词本
known_entry_endpoint           已掌握词条 / 掌握程度
script_conversion_endpoint     越南语 script 转换
admin_endpoint                 管理后台相关
```

后端服务（`lib/src/services/`）还包括：

```text
asr_job_processor              ASR 字幕生成任务处理
deepgram_asr_service           Deepgram 语音识别集成
video_transcode_service        视频转码
subtitle_analysis_service      字幕分析
subtitle_review_task_service   字幕审核任务流转
subtitle_srt_parser / exporter SRT 导入导出
dictionary_import_writer       词典导入写入
vietnamese_nom_conversion_service  越南语 Nôm 转换
notification_service           通知下发
```

---

# Monorepo Layout

```text
clyven/
│
├── apps/
│   ├── clyven_app/            # Flutter 主客户端
│   ├── clyven_web/            # Jaspr 公开 Web 端
│   ├── clyven_studio/         # Jaspr 创作者后台
│   ├── clyven_admin/          # Jaspr 内部管理后台
│   └── clyven_review/         # Jaspr 字幕审核工作台
│
├── packages/
│   ├── clyven_backend_client/    # 生成的 Serverpod 客户端
│   ├── clyven_subtitle_editor/   # 共享字幕编辑组件
│   └── clyven_nom_converter/     # 越南语 script 转换核心库
│
├── server/
│   └── clyven_backend_server/    # Serverpod 后端 + 数据库迁移
│
├── tool/                      # Melos / dev 辅助脚本
├── docs/                      # 调查笔记等
├── pubspec.yaml                # Dart workspace 定义
└── melos.yaml (embedded)       # Melos 任务脚本
```

Flutter App、生成的 Serverpod Client、Serverpod 后端以及各个 Jaspr Web 应用均由同一个 Dart workspace 管理，无需分开克隆多个仓库。

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
ClyvenApp
     │
     ▼
AuthGate
     │
     ▼
Application
```

各个 Feature 拥有自己的 Provider，并通过 Riverpod 管理：

```text
Loading
Data
Error
User Actions
```

避免让页面 Widget 直接承担数据请求和业务状态。

---

# Getting Started

## 1. Clone

```bash
git clone https://github.com/chengyang1017/clyven.git
cd clyven
```

## 2. Install Workspace Dependencies

```bash
dart pub get
```

## 3. Generate Serverpod Code

```bash
cd server/clyven_backend_server
serverpod generate
cd ../..
```

## 4. Run Backend

```bash
cd server/clyven_backend_server
dart run bin/main.dart --apply-migrations
```

## 5. Run a Frontend

Flutter 客户端：

```bash
cd apps/clyven_app
flutter run
```

Jaspr Web 应用（任选其一，或用 Melos 一次启动多个）：

```bash
melos run dev:web      # clyven_web    -> :8084
melos run dev:studio   # clyven_studio -> :8083
melos run dev:admin    # clyven_admin  -> :8082
melos run dev:review   # clyven_review -> :8081
melos run dev:all      # 同时启动 web / studio / admin / review
melos run dev:stop     # 停止残留的本地 dev 服务
```

## 6. Validate

Flutter app：

```bash
cd apps/clyven_app
flutter test
flutter analyze
```

或在根目录用 Melos 跑全部 workspace 包：

```bash
melos run analyze
melos run test
```

Backend：

```bash
cd server/clyven_backend_server
dart analyze
dart test
```

---

# Roadmap

* [x] Flutter 客户端基础结构 + Riverpod 状态管理
* [x] Serverpod Client 集成 + 用户认证入口
* [x] 首页 / 发现页 / 视频搜索 / 视频详情 / 播放
* [x] 视频投稿基础流程 + 视频系列
* [x] 评论、创作者、视频互动、历史、通知、个人资料模块
* [x] 字幕数据结构（轨道 / cue / token / karaoke）与播放联动
* [x] SRT 导入导出 + 字幕人工审核工作流（Review）
* [x] ASR 自动生成字幕（Deepgram 集成）
* [x] 词典查词 + 词典批量导入
* [x] 生词本 + 已掌握词条 / 掌握程度追踪
* [x] 越南语 Chữ Nôm ↔ Quốc Ngữ script 转换
* [x] 创作者 Studio / 管理后台 / 审核工作台（Jaspr）
* [ ] 完善大型视频上传与转码流程
* [ ] 完善推荐系统
* [ ] 完善字幕学习体验（跟读、复习提醒等）
* [ ] 完善错误恢复与网络状态处理
* [ ] 完善生产环境部署

---

# Status

This project is currently under active development.

现阶段重点是在"视频 + 字幕 + 词汇学习"这条主线上打通客户端、Web 端、创作者后台、审核后台与 Serverpod 后端之间的完整数据流转。

部分功能仍处于开发和完善阶段，不代表生产环境最终实现。

---

# Author

**Cheng Yang**

A multilingual video and subtitle learning platform exploring modular client architecture, Riverpod/Jaspr front-ends, Serverpod backend integration, ASR-driven subtitle production, dictionary/vocabulary tooling, and Vietnamese script conversion.

> From video playback to a complete multilingual learning platform.
