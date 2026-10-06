# Glyphora 品牌更名：部署前必须处理的事项

[English](../../en/maintenance/glyphora-rename-deploy-checklist.md) | **简体中文**

日期：2026-10-06

项目品牌名从 Clyven 统一改为 Glyphora，同时去掉了目录和文件名里的品牌前缀。代码里的替换已经完成，但有几项改动**会影响线上环境**，部署新版本之前必须按本文逐项处理，否则可能导致后端启动失败、管理员权限丢失或网页指向错误的地址。

> 本文没有在线上环境验证过。涉及线上数据库、Cloud Run、构建触发器的状态时，下面写的是“需要你先确认”的检查步骤，而不是已知结论。

## 总览

| # | 事项 | 不处理的后果 | 影响范围 |
| --- | --- | --- | --- |
| 1 | 数据库里的 Serverpod 模块名 | 后端启动时重复建表而失败 | 后端、数据库 |
| 2 | 构建和运行环境变量改名 | 管理员权限丢失、网页跳到 localhost、App 连错地址 | 后端、Web、App、脚本 |
| 3 | 构建路径和目录改名 | 构建、部署流水线找不到目录 | CI、Cloud Build、Firebase Hosting |
| 4 | Android / iOS 标识 | 与旧包不兼容；分享链接和推送无法校验 | App、分享站 |
| 5 | 本地存储键和自定义 URL scheme | 用户的本地偏好重置一次；旧 scheme 链接失效 | Web、App |

建议顺序：先做第 1 项（数据库），再做第 2、3 项，最后部署后端、Web，再发布 App。

## 1. 数据库里的 Serverpod 模块名

### 改了什么

Serverpod 后端的模块名从 `clyven_backend` 改成了 `glyphora_backend`。它出现在：

- `server/backend_server/migrations/*/definition_project.json` 等迁移文件的 `moduleName`。
- 生成代码（`server/backend_server/lib/src/generated/`、`packages/backend_client/lib/src/protocol/`）。
- 后端 `pubspec.yaml` 的包名（`glyphora_backend_server`）。

Serverpod 把“某个模块已经应用到哪个迁移版本”记录在数据库的 `serverpod_migrations` 表里，用模块名区分。如果线上库里记录的还是 `clyven_backend`，新版后端会认为 `glyphora_backend` 是一个全新的模块，尝试从头应用所有迁移，结果是对已存在的表重复执行 `CREATE TABLE`，启动失败。

### 处理步骤

1. **先备份数据库。** 例如在 Cloud SQL 控制台创建一份按需备份，并确认备份完成。
2. **检查线上现状：**
   ```sql
   SELECT module, version FROM serverpod_migrations ORDER BY module, version;
   ```
   - 如果能看到 `clyven_backend`，继续第 3 步。
   - 如果表里没有 `clyven_backend`（比如这个库还从没应用过迁移，或者已经是 `glyphora_backend`），则跳过第 3 步。
3. **改模块名：**
   ```sql
   UPDATE serverpod_migrations
   SET module = 'glyphora_backend'
   WHERE module = 'clyven_backend';
   ```
4. **再部署新版后端**，不要反过来。部署时如果带 `--apply-migrations`，此时它应该只应用新增的迁移（如果有）。
5. **验证**：后端日志里没有建表或迁移错误；再执行第 2 步的查询，应该只剩 `glyphora_backend`。

### 回滚

如果需要退回旧版后端，把上面的 `UPDATE` 反过来执行即可（`glyphora_backend` → `clyven_backend`）。

## 2. 环境变量改名

所有以 `CLYVEN_` 开头的变量改成了 `GLYPHORA_`。**旧名不再生效**，代码不会读取旧变量。线上的构建命令、Cloud Run 环境变量、Cloud Build 触发器、CI 密钥和本地脚本里凡是用了旧名的，都要同步改。

### 后端运行时环境变量

在 Cloud Run 服务（或其他运行后端的地方）里设置：

| 新名 | 旧名 | 作用 | 不改的后果 |
| --- | --- | --- | --- |
| `GLYPHORA_ADMIN_EMAIL` | `CLYVEN_ADMIN_EMAIL` | 启动时被授予管理员权限的邮箱 | 未设置时会**跳过管理员初始化**，日志里只有一行提示，不会报错，容易漏看 |
| `GLYPHORA_NOM_DICTIONARY_PATH` | `CLYVEN_NOM_DICTIONARY_PATH` | 可选，覆盖越南语 Nôm 词典 JSON 的路径 | 旧变量被忽略，后端改按内置的默认路径查找词典；只有线上确实设置过这个变量时才需要处理 |

操作时先**新增**新名变量，部署成功后再删掉旧名变量。

### 构建参数（`--dart-define`）

这些值在**构建时**写进产物，改名后必须用新名重新构建：

| 新名 | 旧名 | 用于 | 说明 |
| --- | --- | --- | --- |
| `GLYPHORA_STUDIO_URL` | `CLYVEN_STUDIO_URL` | `apps/web` | Web 头部“创作工坊”按钮的地址。**默认值是 `http://localhost:8083`**，线上构建必须设为 `https://studio.glyphora.net`，否则按钮会跳到 localhost，登录会话交接也不会生效 |
| `GLYPHORA_API_URL` | `CLYVEN_API_URL` | `apps/app` | 覆盖后端地址 |
| `GLYPHORA_BUILD_REVISION` | `CLYVEN_BUILD_REVISION` | `apps/app` | 构建版本标识 |
| `GLYPHORA_SHARE_BASE_URL` | `CLYVEN_SHARE_BASE_URL` | `apps/app` | 分享链接域名，默认 `https://share.glyphora.net`，必须和 `deploy/share_site`、`AndroidManifest.xml`、`Runner.entitlements` 保持一致 |
| `GLYPHORA_MEDIA_CDN_BASE` | `CLYVEN_MEDIA_CDN_BASE` | `apps/app` | 媒体 CDN 地址 |
| `GLYPHORA_FEED_DIAGNOSTICS` | `CLYVEN_FEED_DIAGNOSTICS` | `apps/app` | 在 release 包里开启信息流诊断日志 |

Web 线上构建示例：

```bash
cd apps/web
jaspr build --dart-define=GLYPHORA_STUDIO_URL=https://studio.glyphora.net
```

### 仅脚本使用

`server/backend_client/bin/` 下的测试脚本读取 `GLYPHORA_TEST_EMAIL` 和 `GLYPHORA_TEST_PASSWORD`（旧名 `CLYVEN_TEST_*`）。只在本地或 CI 手动运行这些脚本时需要改。

### 自查方法

在仓库里搜旧名，确认已经没有残留；再到线上各处确认：

```bash
git grep -n "CLYVEN_"
```

线上需要自己检查的地方：Cloud Run 服务的环境变量与密钥、Cloud Build 触发器的替换变量、GitHub Actions 的 secrets 和 variables、任何手写的部署脚本。仓库里看不到这些配置。

## 3. 构建路径和目录改名

目录名去掉了 `clyven_` 前缀：

| 旧路径 | 新路径 |
| --- | --- |
| `apps/clyven_app` | `apps/app` |
| `apps/clyven_web` | `apps/web` |
| `apps/clyven_studio` | `apps/studio` |
| `apps/clyven_admin` | `apps/admin` |
| `apps/clyven_review` | `apps/review` |
| `packages/clyven_backend_client` | `packages/backend_client` |
| `packages/clyven_subtitle_editor` | `packages/subtitle_editor` |
| `packages/clyven_nom_converter` | `packages/nom_converter` |
| `server/clyven_backend_server` | `server/backend_server` |
| `server/clyven_backend_client`（仅脚本） | `server/backend_client` |
| `tool/clyven_dev.dart` | `tool/dev.dart` |

注意：**目录名和 Dart 包名不再一致**。包名是 `glyphora_app`、`glyphora_web`、`glyphora_backend_client` 等，目录里没有 `glyphora_` 前缀。Melos 的 `scope` 和 `--filter` 用的是包名，不是目录名。

仓库里已经同步修改的：`.github/workflows/ci.yml`、`cloudbuild.server.yaml`、`.gcloudignore`、`server/backend_server/Dockerfile`、根 `pubspec.yaml`（workspace 和 Melos 脚本）、各 `pubspec.yaml` 里的 `path:` 依赖、`dev.cmd`。

**仓库外需要你检查的：**

- Cloud Build 触发器里如果写死了 Dockerfile 路径或源目录（旧的是 `server/clyven_backend_server/Dockerfile`），改成 `server/backend_server/Dockerfile`。
- Firebase Hosting、Cloud Run 或任何部署脚本里引用的构建输出目录，例如 `apps/clyven_web/build/web` 要改成 `apps/web/build/web`。
- 本机 IDE 的运行配置、终端别名、已打开的工作区路径。
- 已有的本地克隆在拉取这次改动后，`.dart_tool`、`build` 等被忽略的旧目录会残留在原地（比如 `apps/clyven_app/build`），可以手动删除，避免占磁盘和混淆。
- 工作目录 `D:\clyven` 本身没有改名，需要的话自行处理。

## 4. Android / iOS 标识

### 改了什么

| 位置 | 旧值 | 新值 |
| --- | --- | --- |
| Android `applicationId` 和 `namespace` | `com.example.clyven` | `com.example.glyphora` |
| iOS Bundle Identifier | `com.example.clyven` | `com.example.glyphora` |
| Kotlin 包 | `com.example.clyven` | `com.example.glyphora`（`MainActivity.kt` 目录已一起移动） |
| 画中画 MethodChannel | `clyven/pip` | `glyphora/pip`（Android 与 iOS 两端已同步） |

对用户的影响：包名变了，系统会把它当成一个新应用。**之前侧载安装的旧版不会被升级，而是并存**，旧版的本地数据不会带过去。如果还没有向用户分发过任何安装包，这一点没有影响。

### 需要补的配置

按 [待办清单](../owner-checklist.md) 的第 0、1、3 节处理，并以新包名为准：

- [ ] 确认最终包名。`com.example.*` 无法上架 Google Play。如果打算上架，现在就一次改到位，不要在 `com.example.glyphora` 上再改一轮。
- [ ] 在 Firebase 里按新包名添加 Android 应用和 iOS 应用，下载 `google-services.json` 和 `GoogleService-Info.plist`。这两个文件里记录了包名，包名对不上推送不会生效。
- [ ] `deploy/share_site/public/.well-known/assetlinks.json`：`package_name` 已改成 `com.example.glyphora`，`sha256_cert_fingerprints` 仍是占位符 `REPLACE_WITH_SIGNING_CERT_SHA256`，要填入对应签名证书的指纹。
- [ ] `deploy/share_site/public/.well-known/apple-app-site-association`：`appIDs` 里是 `REPLACE_WITH_TEAM_ID.com.example.glyphora`，填入 Team ID。
- [ ] 重新部署分享站（`deploy/share_site`），否则手机无法校验链接归属。

## 5. 本地存储键和自定义 URL scheme

这些值是代码里的字符串，改名后**用户本地保存的旧值读不到了**：

| 位置 | 旧值 | 新值 | 后果 |
| --- | --- | --- | --- |
| Review 主题（浏览器 localStorage） | `clyven_review_theme` | `glyphora_review_theme` | 审核台主题恢复默认一次 |
| App 语言、主题、显示模式、流量节省（本地存储） | `clyven.app_locale`、`clyven.theme_mode`、`clyven.theme_color`、`clyven.theme_companion_color`、`clyven.display_mode`、`clyven.playback_data_saver` | 同名，前缀换成 `glyphora.` | 这些设置恢复默认一次，用户需要重新选择 |
| App 自定义 URL scheme | `clyven://` | `glyphora://` | 旧 scheme 的链接不再能打开 App（HTTPS 分享链接不受影响） |

**不受影响**：登录会话。它的键是 `serverpod_auth_success_key`，由 Serverpod 决定，没有改动，所以已登录用户不会被登出。

如果觉得“偏好重置”不可接受，可以在读取处增加一次性迁移（读新键为空时回退读旧键）。目前没有加。

## 部署后验证清单

- [ ] 后端启动日志没有迁移或建表错误，`serverpod_migrations` 里只有 `glyphora_backend`。
- [ ] 后端日志里没有“`GLYPHORA_ADMIN_EMAIL` is not configured”。用管理员邮箱登录 Admin，确认有权限。
- [ ] 打开线上 Web（`www.glyphora.net`），登录后点“创作工坊”，应跳到 `studio.glyphora.net` 并且不需要再次登录。
- [ ] Studio 的网址里不会残留 `#sso=...`（读完应被清掉）。
- [ ] 新包名的 Android 包能安装、登录、播放；画中画能进入。
- [ ] 点击 `https://share.glyphora.net/v/<videoId>` 能在 App 内打开（需要先完成第 4 节的指纹和 Team ID）。
- [ ] 推送：用新的 `google-services.json` 构建的包能收到测试推送。
