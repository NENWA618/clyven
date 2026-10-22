# Glyphora Cloudflare 迁移交接记录（截至 2026-10-22）

> **用途：下次接着迁移时先阅读本文件。不要重新执行已完成的命令，也不要要求用户重做已通过的测试。**
>
> 记录依据：本次聊天里用户粘贴的 PowerShell / Wrangler / rclone 输出、截图，以及前面已经完成并在对话中确认的 Staging 迁移步骤。凡未看到足够证据的事项均明确标为“未确认”。
>
> **用户明确要求：停止重复的视频播放、Network、数据库状态等测试；集中推进实际迁移；不拆成大量小 commit；不要反复要求复制已提供过的配置或密钥。**

## 0. 一页结论：从哪里继续

**最后停在：准备 Production 私密媒体清单及批量迁移工具，尚未执行 Production 私密文件搬运，也尚未部署正式 Serverpod Container。**

Production 的公共媒体 `rclone copy` 已执行，结果 `Transferred: 0 B`、`Checks: 725/725`、`Listed 1642`，说明本轮没有新内容需要复制；它**不能证明**生产私密对象已从公共存储隔离。

Production Cloudflare Worker `glyphora-api` **已存在但仍是仅返回 503 的 Bootstrap Worker**；部署版本 `9350af0a-dab9-4eac-b94f-89c7e9b84c0d` 是首次 Bootstrap 部署时报告的版本，后续 Secret 上传可能生成了新版本。`glyphora-api-staging` 则已部署真正的 Serverpod Container，且已有视频可播放。

**下一步正事：**设计并编写 Production 私密对象迁移工具，使用数据库导出的 `id, isPublic, videoStorageId, coverStorageId, videoStorageKey, coverStorageKey` 为依据，处理视频和封面各自存储位置；必要时兼容旧数据 `StorageId = NULL`。先确保私密对象进入 `glyphora-media-private`，才可处理 `glyphora-media` 的私密副本。**严禁提前启用公共媒体域名、批量删除 R2 对象或直接切 Production 流量。**

---

## 1. 环境和架构

- 项目本地根目录：`C:\Users\USER\Documents\Flutter\flutter_application_3`
- PowerShell：Windows PowerShell 5.1（注意 CRLF 和静态 RNG `GetBytes` 兼容性）。
- 现有正式 API：`https://glyphora-server-11129163384.asia-southeast1.run.app/`，Google Cloud Run，地区 `asia-southeast1`。
- Cloudflare Staging Worker：`glyphora-api-staging`，`https://glyphora-api-staging.chengyang1017.workers.dev/`。
- Cloudflare Production Worker：`glyphora-api`，`https://glyphora-api.chengyang1017.workers.dev/`；**目前是 Bootstrap，503，不是可用正式 API**。
- Neon Production 数据库：`neondb`，Staging 数据库：`glyphora_staging`。**不要混接**。
- Production R2：公共 `glyphora-media`、私密 `glyphora-media-private`。
- Staging R2：公共 `glyphora-staging`、私密 `glyphora-staging-private`。
- Production 媒体域名目标：`media.glyphora.net`；之前 Staging `media-staging.glyphora.net` 关闭公共访问。**不能因代码配置存在就认定媒体域名已经安全启用**。
- Staging Stream 转码采用 `cloudflare_stream`；私密播放通过 `requireSignedURLs` 以及 Cloudflare Stream `/token` API。
- 生产运行计划：保留 Cloud Run 直到安全切换；Production Worker 和 Staging 通过不同 Durable Object 类隔离。

## 2. Staging：已做操作与确实有证据的测试

### 2.1 Staging Worker / Container

- `wrangler.staging.jsonc`：Worker `glyphora-api-staging`，Container 类 `GlyphoraServerStaging`，绑定 `GLYPHORA_SERVER`，`GLYPHORA_PRIVATE_R2` 指向 `glyphora-staging-private`；私密导入基址是 Staging Worker。
- 容器镜像来自 `Dockerfile.cloudflare`，入口脚本 `cloudflare/container-entrypoint.sh`。
- 已解决 Linux 容器执行脚本 CRLF 错误及 Serverpod `production.yaml` CRLF 导致的 `sed` 匹配失败问题；Staging Container 启动成功，曾输出 `Serverpod startup completed in 35737 ms`、`Port 8080 is ready`，Worker 根路径 HTTP 200。
- Staging 最后一次在此聊天中确认的上传部署版本：`4341dd08-6c95-4110-891a-e521123e8cca`，时间 `2026-10-22T11:43:31.653Z`。此后主要修改了本地源码和 Worker Secrets，不能把版本号当作今后永久最新版本。

### 2.2 数据库与私密对象

- Staging 数据库 migration `20261022090527013` 已加入 `videoStorageId`、`coverStorageId`（均 nullable）。
- Staging **视频 ID 6**：私密，`isPublic=false`；视频和封面的 Storage ID 为 `private`。先前其 `transcodeState` 和 `transcoderJobName` 为 `NULL`。
- 视频对象：`videos/01a14cfe-608b-7930-82be-ba1acb4c5c8a/1792648030899000.mp4`，大小 1,961,778 B。
- 封面对象：`covers/01a14cfe-608b-7930-82be-ba1acb4c5c8a/1792648030899000.jpg`，大小 69,498 B。
- 视频与封面已确认位于 Staging 私密 Bucket `glyphora-staging-private`，并在 Staging 公共 Bucket 中确认不存在同名副本。

### 2.3 私密播放与访问测试（**不再重复**）

- 第一次匿名 `curl.exe --data-raw '{"videoId":6}'` 在 Windows PowerShell 发生引号丢失，响应 `HTTP 400 Invalid JSON in body`；这是命令问题，非权限失败。
- 改用 PowerShell `Invoke-WebRequest`，匿名 POST `/video/getPlaybackManifestUrl`，body `{"videoId":6}`，收到 **HTTP 200、BODY `null`**。
- 随后查询 Staging DB，`current_database() = glyphora_staging`，ID 6 的 `transcodeState`、`transcoderJobName` 均保持 NULL：匿名调用没有触发导入。
- Studio 原本无法预览私密视频：`apps/studio/lib/pages/video_edit_page.dart` 使用旧接口 `studioClient.video.getVideoUrl(path: loaded.videoStorageKey)`。已替换为 `studioClient.video.getPlaybackManifestUrl(videoId: loaded.id!)`，`dart analyze lib/pages/video_edit_page.dart` 为 `No issues found!`。
- 用户在 `http://localhost:8083` 登录 Staging Studio，Network 中确认 `POST https://glyphora-api-staging.chengyang1017.workers.dev/video` HTTP 200，携带认证（对话曾误贴完整 Bearer Token；**应撤销/轮换该会话，且今后不再贴 Headers 中的凭证**）。
- 视频 ID 6「测试迁移」已显示画面，用户明确回答**可以完整播放**。Network 截图中 `video.m3u8` 和数条媒体片段均为 HTTP 200。
- **未通过截图单独核实媒体请求的域名、Stream 资源 UID、Production 侧签名保护；也没有确证 Staging 视频最后数据库转码状态是 `SUCCEEDED`。不要把它们写成已验证。用户明确不想继续这些测试。**

### 2.4 Studio 构建修复

- 本地 Jaspr 启动方式：

```powershell
cd apps/studio
dart pub global run jaspr_cli:jaspr serve `
  --port 8083 `
  --dart-define=GLYPHORA_API_URL=https://glyphora-api-staging.chengyang1017.workers.dev/
```

- 初次构建失败因为 `packages/subtitle_editor/pubspec.yaml` 缺少它直接导入的 `glyphora_language_core`（Git 来源 `https://github.com/chengyang1017/flutter-languages-config.git`, ref `main`）。已加入依赖，`dart pub get` 成功；`dart analyze packages/subtitle_editor/lib` 只有 10 条旧 `dart:html` 信息，无 Error/Warning；最终 Jaspr 输出 `Done building web assets`、`Serving at http://localhost:8083`。
- Studio 源码默认 API 仍指向 Google Cloud Run，通过 `GLYPHORA_API_URL` 编译参数选择 Staging；**页面中显示“生产环境”的标签不足以判断 API，Network 已确认当时确实是 Staging。**

## 3. 客户端和工具：已完成代码迁移

所有项目均保留 Cloud Run 默认 API，增加或原本具有 `GLYPHORA_API_URL` 编译参数；**尚未切换正式发布客户端**。

- `apps/studio/lib/services/studio_client.dart`：早已支持，无须改。
- `apps/app/lib/core/serverpod/serverpod_client_provider.dart`：早已支持，无须改。
- `apps/web/lib/services/web_client.dart`：新增环境参数并格式化、分析。
- `apps/admin/lib/services/admin_client.dart`：新增环境参数并格式化、分析。
- `apps/review/lib/services/review_client.dart`：新增环境参数并格式化、分析。
- 以上三文件 `dart analyze`：仅三条 `dart:html` deprecated 信息，0 Error、0 Warning。
- `apps/app/tool/test_dictionary.dart`、`test_subtitle.dart`、`test_word_list.dart`：三文件统一为 `GLYPHORA_API_URL`，`dart analyze` **No issues found!**。
- `server/backend_client/bin/create_vietnamese_import_profile.dart`、`test_dictionary_commit.dart`、`test_excel_preview.dart`、`test_import_preview.dart`、`verify_dictionary_import.dart`：五文件改为 `GLYPHORA_API_URL`，`dart analyze` **No issues found!**。
- 这些只是代码修改和静态分析，未意味着各客户端正式部署。

## 4. Production Cloudflare 基础设施：已完成的真实操作

### 4.1 R2 与公共媒体复制

- `npx wrangler r2 bucket list` 曾显示 `glyphora-media`、`glyphora-staging`、`glyphora-staging-private`。
- 成功执行 `npx wrangler r2 bucket create glyphora-media-private`：新建 Production 专用私密 Bucket。
- `wrangler.jsonc` 已添加：
  - R2 binding `GLYPHORA_PRIVATE_R2` → `glyphora-media-private`。
  - `CLOUDFLARE_R2_BUCKET` = `glyphora-media`。
  - `CLOUDFLARE_R2_PRIVATE_BUCKET` = `glyphora-media-private`。
  - `GLYPHORA_CLOUDFLARE_PUBLIC_HOST` = `glyphora-api.chengyang1017.workers.dev`。
  - `GLYPHORA_PRIVATE_INGEST_BASE_URL` = `https://glyphora-api.chengyang1017.workers.dev`。
  - `CLOUDFLARE_R2_PUBLIC_HOST` = `media.glyphora.net`。
  - `SMTP_EMAIL`、`GLYPHORA_ADMIN_EMAIL` 正式邮箱配置。
- rclone remotes：`gcs:`、`r2:`、`r2-private:`、`r2-staging-read:`。
- `rclone lsf r2: --dirs-only` 曾返回 ListBuckets 403：Bucket 限定 Token 没有列出账号所有 Bucket 的权限，**不表示 `r2:` 失效**。
- `rclone lsf r2:glyphora-media --max-depth 1` 成功，目录包含 `covers/`、`serverpod/`、`transcoded/`、`videos/`。
- Production 公共媒体复制命令已执行：

```powershell
rclone copy `
  gcs:glyphora-video-storage-11129163384 `
  r2:glyphora-media `
  --immutable --progress --transfers 4 --checkers 8
```

实际输出：`Transferred: 0 B / 0 B`，`Checks: 725 / 725, 100%, Listed 1642`，`Elapsed time: 11.5s`。说明这一轮没有需传输的对象，**不是私密对象隔离完成的证明**。

### 4.2 Production Worker Bootstrap

- 最初 `npx wrangler secret list --name glyphora-api` 返回 `Worker "glyphora-api" not found`。
- 创建 `wrangler.bootstrap.jsonc`，Worker `glyphora-api`，入口 `cloudflare/bootstrap-worker.ts`：所有请求固定返回 503 `Production bootstrap: not ready`。
- 已真实执行：`npx wrangler deploy --config wrangler.bootstrap.jsonc`，成功创建 Worker，URL `https://glyphora-api.chengyang1017.workers.dev`，初始版本 ID `9350af0a-dab9-4eac-b94f-89c7e9b84c0d`。
- **从未在此聊天中执行 `wrangler deploy --config wrangler.jsonc`；Production Serverpod Container 尚未部署，Production 服务尚不可用。**
- `wrangler.staging.jsonc` 继续独立 Staging；没有切换正式客户端，也未关闭 Cloud Run。

### 4.3 Container 入口脚本

- `cloudflare/container-entrypoint.sh` 将 `sed -i 's/\r$//' config/production.yaml` 移至 Staging 条件判断之前，以支持 Production 的 CRLF 配置替换。
- Staging 仅在 `GLYPHORA_STAGING=true` 时覆盖数据库 Host/Name/User；Production 没有 Staging 覆盖时保留原 `config/production.yaml` 的 Neon 正式数据库。
- Container 在启动时把 Cloud Run API `publicHost` 替换为 Cloudflare Worker Host；当前 `GLYPHORA_TRANSCODER` 在 Worker 中设为 `cloudflare_stream`。
- `server.dart` 使用 `await pod.start()`；已搜索 `FutureCall|cron|schedule|PeriodicTask` 等，**未发现显式自定义定时任务**，但不能据此证明双 Production 实例同启绝对安全。

### 4.4 部署命令/防误操作

- `package.json` 已设置：`cf:deploy:staging` → `wrangler deploy --config wrangler.staging.jsonc`。
- `cf:deploy` → `node tool/confirm-production-deploy.cjs`；新脚本要求 `GLYPHORA_CONFIRM_PRODUCTION_DEPLOY=yes` 才执行 `wrangler deploy --config wrangler.jsonc`。
- `npm run cf:deploy` 未执行。**这是防误部署门槛，不是生产发布就绪保证。**

## 5. Production Secrets：实际已上传项目

Production Worker `glyphora-api` 已创建后，上传操作全部报告 `Success! Uploaded secret`。**不要再要求重做以下上传，也不要在聊天中询问/回显密钥值。**

### 5.1 Google Secret Manager → Production Worker（6 项成功）

- `SERVERPOD_PASSWORD_database` ← `glyphora-database-password:2`
- `SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey` ← `glyphora-jwt-hmac-key:1`
- `SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper` ← `glyphora-jwt-refresh-pepper:1`
- `SERVERPOD_PASSWORD_emailSecretHashPepper` ← `glyphora-email-secret-pepper:1`
- `SMTP_APP_PASSWORD` ← `glyphora-smtp-app-password:1`
- `SERVERPOD_PASSWORD_HMACSecretKey` ← `glyphora-hmac-secret-key:1`

脚本：`cloudflare/production-secret-map.txt`（名称与版本，无值）；`cloudflare/import-production-secrets.ps1`（已创建并随后修订，真实执行 `-AllowProductionSecretDeployment` 成功）。后续版本使用 `gcloud secrets versions access --out-file` 写临时文件、检查非空、通过 `cmd` 输入重定向传至 Wrangler 并删除临时文件；**注意本机临时明文文件不是零风险，文件删除不等于安全擦除**。

### 5.2 Cloudflare / R2 / Stream 等（全部成功上传）

- `SERVERPOD_R2_PRIVATE_ACCESS_KEY_ID`
- `SERVERPOD_R2_PRIVATE_SECRET_KEY`
- `SERVERPOD_R2_ACCESS_KEY_ID`
- `SERVERPOD_R2_SECRET_KEY`
- `CLOUDFLARE_STREAM_API_TOKEN`
- `GLYPHORA_PRIVATE_INGEST_KEY`
- `CLOUDFLARE_ACCOUNT_ID`
- `SERVERPOD_PASSWORD_serviceSecret`

细节：
- Production 私密 R2 Token `glyphora-production-private` 是用户在 Cloudflare Dashboard 新建的，目标 Bucket `glyphora-media-private`；两项凭证通过 `wrangler secret put` 成功上传。
- Production 公共 R2 凭证因用户没有保存原 Token，最终从既有 rclone `r2:` 配置安全读取并成功上传；**不需新建公共 R2 Token**。`rclone lsf r2:glyphora-media` 已证明配置可读 Bucket。
- Production Stream API Token 由于本地 `.env`、`.env.production`、`.dev.vars` 等没有保存而新建，并通过 `wrangler secret put CLOUDFLARE_STREAM_API_TOKEN --name glyphora-api` 成功上传。
- `GLYPHORA_PRIVATE_INGEST_KEY` 首次生成失败：PowerShell 5.1 不支持静态 `RandomNumberGenerator.GetBytes(32)`；由于命令仍继续运行，首次上传可能为空。随后已用 `RandomNumberGenerator.Create(); $rng.GetBytes($bytes)` 正确生成 32 字节随机密钥并**重新覆盖成功**；不要再重复生成，否则会使现有签名失效。
- `CLOUDFLARE_ACCOUNT_ID` 已通过 `wrangler whoami` 获取并上传。
- `SERVERPOD_PASSWORD_serviceSecret` 由本地不受 Git 跟踪的 `server/backend_server/config/passwords.yaml` 中 `production:` 段提取并上传成功；没有新建。
- 生产邮件与管理员邮箱已经写入 `wrangler.jsonc`，不必再要求上传这些非敏感值为 Secret。

### 5.3 已知未齐全 / 不可误判

- `SERVERPOD_PASSWORD_HMACAccessKeyId` 和 `DEEPGRAM_API_KEY` 曾存在 Cloud Run 明文环境变量中；**没有证据表明已迁入 Cloudflare Production**。其中 Deepgram API Key 曾被粘贴到聊天中；推荐适时轮换，在不中断服务的前提下更新相关服务。
- Cloud Run `SERVERPOD_PASSWORD_HMACSecretKey` 已由 Secret Manager 导入，但对应 Access Key ID 可能仍需处理。如果 Cloudflare 路径不使用旧 GCS HMAC，则需先确认依赖，再决定是否迁移。
- `CLOUDFLARE_R2_PUBLIC_HOST` 已写入 `wrangler.jsonc`，不需要单独 Secret。
- Cloudflare Worker Secret 配置成功只是上传证据，**不是 Production Container 已成功读取和使用的证明**。

## 6. 用户曾执行且不必重复的扫描 / 检查

- `Select-String` 查找所有客户端 `run.app` / `GLYPHORA_API_URL`：发现并修复 3 个 Web 客户端 + 3 个 App 工具 + 5 个 Serverpod 客户端工具的硬编码。
- 后端扫描 `googleapis`, `transcoder.googleapis.com`, `GoogleCloudStorage`, `run.app` 等：发现 `server/backend_server/lib/server.dart` 仍有 GCS fallback；`video_transcode_service.dart` 保留旧 Google Transcoder 回退；`push_service.dart` 的 Firebase FCM 仍需保留（迁到 Cloudflare 不等于去掉 Firebase）；Container 启动脚本会替换 Cloud Run Host。
- `Get-ChildItem` 定位 Wrangler：项目根目录 `wrangler.jsonc`、`wrangler.staging.jsonc`，不是 `cloudflare/` 目录。全仓递归时碰到 Flutter build 临时路径消失错误，只是扫描噪声。
- `npx wrangler deployments list --name glyphora-api-staging` 已确认 Staging 正常部署。
- `npx wrangler secret list --name glyphora-api-staging` 曾列出 Staging 21 项 Secret 名称，不包含值；不要重复要求用户提供。
- Cloud Run 环境配置读取已完成；曾经使用错误格式路径得到 `null`，后来查询容器 env 成功。**输出曾包含敏感 Deepgram Key、GCS HMAC ID，不要重印或让用户再次粘贴全量配置。**
- `git ls-files --error-unmatch server/backend_server/config/passwords.yaml` 返回 **not tracked**；这只说明当前没有跟踪，不保证从未进过 Git 历史。不要删除/覆盖 `passwords.yaml`。
- Production Serverpod 模型 `server/backend_server/lib/src/models/video.spy.yaml` 已确认字段：`videoStorageId: String?`, `coverStorageId: String?`, `videoStorageKey: String`, `coverStorageKey: String?`, `isPublic: bool`。模型注释明确说 `Do not infer legacy storage from isPublic: visibility can change.`
- 迁移脚本 `cloudflare/migrate_gcs_to_r2.sh` 已阅读：支持 `inventory`、`dry-run`、`copy --immutable`、`verify --size-only`、`verify-deep --download`，不要重新发明简单的 GCS→R2 copy。
- 搜索私密导出脚本 `isPublic|videoStorageKey|coverStorageKey` 限定迁移/导出/备份路径，**无匹配**，尚无现成 Production 私密清单生成器。

## 7. 必须避免的错误和安全边界

1. **绝不再把私密视频简单按 `isPublic=false` 全部作为“原本存私密 Bucket”的证据**：可见性与实际 Storage ID 分离。需按每条视频和封面分别确定物理对象位置，旧记录需明确迁移规则。
2. **不要直接开启 `media.glyphora.net` 的公开访问**：Production 公共 Bucket 当前可能含私密对象副本；先完成隔离再开放。
3. 不执行 `rclone sync` / `purge` / 批量 `delete`；迁移期间用非破坏性复制并保留 GCS 原件。后续删公共私密副本时要有确定清单、保障物理副本已存在、考虑并发改动。
4. 不运行 `npm run cf:deploy` 或直接 `wrangler deploy --config wrangler.jsonc`，直到明确 Production Container 安全上线方案；Bootstrap Worker 503 不影响旧 Cloud Run，但不能作为正式 API。
5. 不复制 Staging 数据库配置、JWT/pepper、私密 R2 Token 到 Production；已迁移 Production 正式认证密钥。
6. 不用 `Get-Content passwords.yaml | Select-String` 打印密钥，不贴完整 Authorization header、Stream Token、R2 Key 或数据库 URI。
7. Windows PowerShell 5.1：处理 LF/CRLF 时避免严格多行字符串 `.Contains()` 无法匹配；随机数使用 `.Create()` 实例化 API。
8. 用户明确停止 Staging 视频重复测试；已完成的 9 秒视频播放、Network HLS 200、匿名访问 200/null 等足够，不再拿这些当新关卡。
9. 对 `rclone copy` 的零字节传输要正确解释：已存在或未需复制，本轮成功完成检查；不等于全流程 Cutover 或私密隔离完成。
10. 生产 Secret 导入流程已完成，不再让用户找已配置的 R2/Stream Token。

## 8. 下次建议继续的工作（**未完成，不要写成已完成**）

1. **Production 私密媒体导出与迁移**：实现可控的只读清单生成器，从 Production 数据库导出必要字段（`id`, `isPublic`, `videoStorageId`, `coverStorageId`, `videoStorageKey`, `coverStorageKey`），并核查旧记录的存储语义；尽量沿用现有安全连接，不要求用户把密码贴到聊天。
2. 基于清单，将需要保护的对象分别复制到 `glyphora-media-private`，保存审计/恢复清单；对于仍被现有 Cloud Run 使用的对象和路径，考虑双写/切换窗口，避免并发上传或可见性更新导致状态不一致。
3. 仅在确认安全之后处理公共 Bucket 私密副本；**先把 Production 公共媒体公开入口保持关闭/受限**。GCS 保留作回退。
4. 审查 Production Cloudflare Worker 启动所需的缺失参数和生产依赖，尤其可能缺少 `DEEPGRAM_API_KEY` / HMAC Access Key ID；优先解决实际使用的必要项，不盲目复制所有 Google 环境变量。
5. 决定正式 Neon 双后端并存的安全策略（Serverpod 内部 job/后台任务、数据库写入与迁移竞争），必要时增加只读/影子部署模式。随后才运行完整 Production Container 首次部署。
6. 安全发布与切换：确认媒体公开策略、安全认证、回滚方案，逐个切换客户端 API；原 Cloud Run 不应过早退役。
7. 待相关工作足够集中后一次性整理 Git 变更和 commit，不要每个小修复都催 commit。

---

## 9. 极简恢复提示（可复制给下一次 ChatGPT）

> 阅读 `GLYPHORA_CLOUDFLARE_MIGRATION_HANDOFF_2026-10-22.md` 后从 **第 8 节 Production 私密媒体数据迁移**继续。Staging 私密视频已能播放；匿名访问已测试，用户要求**不再重复播放/Network/数据库状态测试**。Production Worker `glyphora-api` 已 Bootstrap 部署，但仍是 503，正式 Container 未部署；公共 GCS→R2 复制已运行，`Checks 725/725, Transferred 0 B`；独立 Production 私密 Bucket 与 R2/Stream/认证密钥已配置。下一步要解决的是**按数据库真实存储位置安全导出私密媒体清单并迁移，不要把 `isPublic` 当物理存储位置**。不要让用户再次找密钥，不要提前开放公共 Bucket，不要切正式流量。
