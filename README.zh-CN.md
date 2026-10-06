# Glyphora

[English](README.md) | **简体中文**

> 一个多语言视频与字幕学习平台，采用 Flutter / Jaspr + Serverpod 的 Monorepo 架构。

**Glyphora** 最初是一个视频平台项目，现已发展为**多语言视频与字幕学习平台**：用户在观看视频的同时，可以查看双语或精校字幕，点击单词查词典、收藏生词、管理生词本，并追踪自己对词汇的掌握程度（Knowledge State）。项目还覆盖完整的字幕生产工作流：越南语 Chữ Nôm ↔ Quốc Ngữ 文字转换、AI 字幕生成（ASR）以及人工字幕审核。

移动客户端使用 **Riverpod**（Flutter）管理状态，Web 前端使用 **Jaspr**（Dart Web 框架），它们都通过统一的 **Serverpod** 后端通信。

---

## 文档

| 文档 | 说明 |
| --- | --- |
| [文档索引](docs/zh-CN/README.md) | 所有文档（中英文） |
| [待办清单](docs/zh-CN/owner-checklist.md) | 仍需手动完成的配置（Firebase、Apple、DNS、签名密钥） |
| [画中画](docs/zh-CN/picture-in-picture.md) | 视频在 Android 和 iOS 上以悬浮小窗继续播放 |
| [消息推送](docs/zh-CN/push-notifications.md) | 基于 Firebase Cloud Messaging 的系统级推送 |
| [分享链接](docs/zh-CN/share-links.md) | 点击分享链接后直接在 App 内打开视频 |

---

## 项目组成

Glyphora 由 5 个前端应用、1 个后端服务和 3 个共享包组成，使用 Melos 统一管理。

| 应用 | 技术栈 | 定位 | 本地端口 |
| --- | --- | --- | --- |
| `apps/app` | Flutter（iOS / Android / 桌面） | 面向普通用户的主客户端：视频流、字幕学习、词典、生词本 | - |
| `apps/web` | Jaspr（Dart Web） | 面向普通用户的公开 Web 端，功能与 `glyphora_app` 对齐 | 8084 |
| `apps/studio` | Jaspr（Dart Web） | 创作者后台：视频上传与管理、字幕与词典管理、评论管理 | 8083 |
| `apps/admin` | Jaspr（Dart Web） | 内部管理后台：用户管理、越南语文字转换工具 | 8082 |
| `apps/review` | Jaspr（Dart Web） | 字幕审核工作台：审核队列、审核任务详情 | 8081 |
| `server/backend_server` | Serverpod | 所有前端共用的统一后端 | 8080 |

---

## 功能

### 视频

* 首页、发现页与搜索
* 视频详情与播放（与字幕联动）
* 视频投稿（选择本地视频、读取时长、FFmpeg 处理、上传）
* 视频系列
* 点赞、收藏、观看历史
* Android 与 iOS 画中画播放
* HLS 自适应码率播放与本地分片缓存

### 字幕与语言学习

* 字幕轨道，支持逐句和逐词（token）级数据
* 卡拉 OK 式逐字高亮（karaoke segments）
* SRT 导入与导出
* AI 自动生成字幕（Deepgram ASR，`asr_job_processor`）
* 人工审核工作流：审核队列、审核任务、审核仪表盘
* 播放页内嵌字幕学习面板（点词查词、逐句跟读）

### 词典与词汇

* 词典查词（释义、例句、词形、词条关系）
* 词典批量导入（导入预览、字段映射、提交）
* 生词本管理
* 已掌握词条与掌握程度追踪（Knowledge State）

### 文字转换

* 越南语 Chữ Nôm ↔ Quốc Ngữ 转换（`glyphora_nom_converter`）
* 转换配置管理、批量导入预览与提交

### 创作者（Studio）

* 创作者仪表盘
* 视频、字幕、词典管理
* 评论管理

### 互动

* 点赞、评论（含回复与回复点赞）
* 关注创作者、已关注创作者列表
* 分享：点击分享链接后直接在 App 内打开视频（[详情](docs/zh-CN/share-links.md)）

### 用户

* 用户认证（Serverpod Auth IDP）与登录入口守卫（Auth Gate）
* 个人主页与个人资料统计
* 观看历史
* 通知中心、通知设置与隐私设置
* 点赞、评论、关注的系统级推送，文案随 App 语言变化（[详情](docs/zh-CN/push-notifications.md)）

### 管理

* 用户管理
* 越南语文字转换后台工具
* Excel 数据导入（词典、转换表）

---

## 技术栈

### 客户端（移动端 / 桌面端）

* Flutter、Dart
* Riverpod（`flutter_riverpod`）
* `video_player`、`video_duration_native`、`flutter_video_caching`
* `ffmpeg_kit_flutter_new_min_gpl`（视频处理）
* `image_picker`、`share_plus`
* `firebase_core`、`firebase_messaging`（消息推送）
* `app_links`（在 App 内打开分享链接）

### Web（公开端 / Studio / Admin / Review）

* Jaspr（`jaspr`、`jaspr_router`、`jaspr_flutter_embed`）

### 前后端通信

* Serverpod
* `serverpod_client` / `serverpod_flutter`
* `serverpod_auth_idp_flutter` / `serverpod_auth_core_client`

### 后端（Serverpod 服务）

* Serverpod（PostgreSQL、数据库迁移）
* Deepgram ASR（语音识别，用于生成字幕）
* `excel`（词典与转换表导入）
* `serverpod_cloud_storage_gcp`（媒体存储）
* `mailer`、`googleapis_auth`
* Firebase Cloud Messaging HTTP v1（推送下发，使用 `googleapis_auth` 认证）

### 部署

* 后端：Google Cloud Run
* 分享落地页与域名校验文件：Firebase Hosting（`deploy/share_site`）

### 共享包

* `glyphora_nom_converter`：越南语 Latin ↔ Chữ Nôm 转换核心库（含命令行工具）
* `glyphora_subtitle_editor`：Studio 与 Review 共用的字幕编辑组件（时间轴、卡拉 OK 分段、SRT 导入导出）
* `glyphora_backend_client`：Serverpod 自动生成的客户端代码，所有前端共用

### Monorepo 工具

* Dart Workspace（`pubspec.yaml`）
* Melos（脚本定义在 `pubspec.yaml` 中，统一 dev、build、analyze、test）

---

## 架构

`glyphora_app` 按功能（Feature）划分模块。`glyphora_web`、`glyphora_studio`、`glyphora_admin`、`glyphora_review` 采用类似的 pages / components / services 结构。

```text
lib/
│
├── core/
│   ├── errors/
│   ├── localization/
│   ├── media/            # 视频缓存、画中画桥接
│   ├── navigation/
│   ├── push/             # Firebase Cloud Messaging 集成
│   ├── serverpod/
│   ├── sharing/          # 分享链接与深度链接处理
│   └── theme/
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

每个功能模块按需继续拆分：

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

整体数据流：

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
后端（Serverpod Endpoint）
 │
 ▼
数据库 / 云存储
```

---

## 后端模块（Serverpod Endpoint）

```text
video_endpoint                 视频增删改查、系列、触发转码
comment_endpoint               评论、回复、点赞
social_endpoint                关注与互动状态
notification_endpoint          通知列表
notification_settings_endpoint 通知设置
push_device_endpoint           登记与注销设备推送令牌
privacy_settings_endpoint      隐私设置
subtitle_endpoint              字幕轨道、cue、token、karaoke
review_endpoint                字幕审核队列与任务
dictionary_endpoint            词典查询
dictionary_import_endpoint     词典批量导入
word_list_endpoint             生词本
known_entry_endpoint           已掌握词条与掌握程度
script_conversion_endpoint     越南语文字转换
admin_endpoint                 管理后台
```

后端服务（`lib/src/services/`）：

```text
asr_job_processor                  处理 ASR 字幕生成任务
deepgram_asr_service               Deepgram 语音识别集成
video_transcode_service            视频转码
subtitle_analysis_service          字幕分析
subtitle_review_task_service       审核任务流转
subtitle_srt_parser / exporter     SRT 导入与导出
dictionary_import_writer           写入导入的词典数据
vietnamese_nom_conversion_service  越南语 Nôm 转换
notification_service               创建站内通知并触发推送
push_service                       通过 Firebase Cloud Messaging 发送推送
```

---

## 目录结构

```text
glyphora/
│
├── apps/
│   ├── app/            # Flutter 主客户端
│   ├── web/            # Jaspr 公开 Web 端
│   ├── studio/         # Jaspr 创作者后台
│   ├── admin/          # Jaspr 内部管理后台
│   └── review/         # Jaspr 字幕审核工作台
│
├── packages/
│   ├── backend_client/    # 生成的 Serverpod 客户端
│   ├── subtitle_editor/   # 共享字幕编辑组件
│   └── nom_converter/     # 越南语文字转换核心库
│
├── server/
│   └── backend_server/    # Serverpod 后端与数据库迁移
│
├── deploy/
│   └── share_site/            # 分享链接使用的 Firebase Hosting 站点
│
├── tool/                      # Melos 与开发辅助脚本
├── docs/                      # 文档（docs/en 与 docs/zh-CN）
└── pubspec.yaml               # Dart workspace 与 Melos 脚本
```

Flutter 应用、生成的 Serverpod 客户端、Serverpod 后端以及各个 Jaspr Web 应用都由同一个 Dart workspace 管理，不需要分别克隆多个仓库。

---

## 状态管理

应用入口用 `ProviderScope` 包裹整个应用：

```text
ProviderScope
     │
     ▼
GlyphoraApp
     │
     ▼
AuthGate
     │
     ▼
Application
```

每个功能模块拥有自己的 Provider，用 Riverpod 管理以下状态：

```text
加载中（Loading）
数据（Data）
错误（Error）
用户操作（User actions）
```

页面 Widget 不直接承担数据请求和业务状态。

---

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/chengyang1017/glyphora.git
cd glyphora
```

### 2. 安装 workspace 依赖

```bash
dart pub get
```

### 3. 生成 Serverpod 代码

```bash
cd server/backend_server
serverpod generate
cd ../..
```

### 4. 启动后端

```bash
cd server/backend_server
dart run bin/main.dart --apply-migrations
```

### 5. 启动前端

Flutter 客户端（如果缺少 `lib/l10n/app_localizations.dart`，先生成本地化文件）：

```bash
cd apps/app
flutter gen-l10n
flutter run
```

Jaspr Web 应用（任选其一，或用 Melos 同时启动多个）：

```bash
melos run dev:web      # glyphora_web    -> :8084
melos run dev:studio   # glyphora_studio -> :8083
melos run dev:admin    # glyphora_admin  -> :8082
melos run dev:review   # glyphora_review -> :8081
melos run dev:all      # 同时启动 web、studio、admin、review
melos run dev:stop     # 停止残留的本地开发服务
```

### 6. 校验

Flutter 应用：

```bash
cd apps/app
flutter test
flutter analyze
```

或在仓库根目录用 Melos 校验全部包：

```bash
melos run analyze
melos run test
```

后端：

```bash
cd server/backend_server
dart analyze
dart test
```

---

## 配置

消息推送和分享链接需要一些代码之外的一次性配置：Firebase 项目、Apple 与 Google 的签名信息、一条 DNS 记录，以及一个服务端密钥。未配置时 App 仍可正常运行，只是不会推送，分享链接会退回到落地页。

完整的分步清单见[待办清单](docs/zh-CN/owner-checklist.md)。

---

## 路线图

* [x] Flutter 客户端基础结构与 Riverpod 状态管理
* [x] Serverpod 客户端集成与用户认证入口
* [x] 首页、发现页、视频搜索、视频详情与播放
* [x] 视频投稿基础流程与视频系列
* [x] 评论、创作者、视频互动、历史、通知、个人资料模块
* [x] 字幕数据结构（轨道、cue、token、karaoke）与播放联动
* [x] SRT 导入导出与人工审核工作流
* [x] ASR 自动生成字幕（Deepgram）
* [x] 词典查词与批量导入
* [x] 生词本、已掌握词条与掌握程度追踪
* [x] 越南语 Chữ Nôm ↔ Quốc Ngữ 转换
* [x] 创作者 Studio、管理后台与审核工作台（Jaspr）
* [x] 画中画播放（Android 与 iOS；iOS 需真机验证）
* [x] 系统级消息推送（需配置 Firebase）
* [x] 在 App 内打开视频的分享链接（需配置域名）
* [ ] 完善大视频上传与转码流程
* [ ] 完善推荐系统
* [ ] 完善字幕学习体验（跟读、复习提醒等）
* [ ] 完善错误恢复与网络状态处理
* [ ] 完善生产环境部署
* [ ] 手动选择视频清晰度
* [ ] 分享链接的单视频预览

---

## 当前状态

本项目正处于积极开发阶段。当前重点是打通“视频 + 字幕 + 词汇学习”这条主线，让客户端、Web 端、创作者后台、审核后台与 Serverpod 后端之间的数据完整流转。

部分功能仍在开发和完善中，不代表最终的生产环境实现。

---

## 作者

**Cheng Yang**

一个多语言视频与字幕学习平台，探索模块化客户端架构、Riverpod / Jaspr 前端、Serverpod 后端集成、基于 ASR 的字幕生产、词典与词汇工具，以及越南语文字转换。

> 从视频播放，到完整的多语言学习平台。
