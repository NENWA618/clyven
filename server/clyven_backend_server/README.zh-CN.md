# clyven_backend_server

[English](README.md) | **简体中文**

所有 Clyven 前端共用的 Serverpod 后端，涵盖视频、字幕、词典、审核、通知、推送和管理。端点在 `lib/src/endpoints/`，服务在 `lib/src/services/`，数据模型在 `lib/src/models/`（`*.spy.yaml`），数据库迁移在 `migrations/`。

## 本地运行

先用 Docker 启动 PostgreSQL 和 Redis，再启动服务端：

```bash
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```

用 `Ctrl-C` 停止服务端，然后停止容器：

```bash
docker compose stop
```

本地端口：API `8080`、Insights `8081`、Web 服务 `8082`；Docker 中的 PostgreSQL 为 `8090`、Redis 为 `8091`（测试实例为 `9090` / `9091`）。

## 修改模型或端点之后

```bash
serverpod generate
serverpod create-migration --tag <简短描述>
```

`create-migration` 会在 `migrations/` 下新建一个目录，并追加到 `migrations/migration_registry.txt`。部署时带 `--apply-migrations`，数据库才会应用它。

## 配置

Serverpod 密码（本地写在 `config/passwords.yaml`，生产环境用名为 `SERVERPOD_PASSWORD_<名称>` 的环境变量）：

| 名称 | 用途 |
| --- | --- |
| `fcmServiceAccountJson` | 发送推送用的完整 Firebase 服务账号 JSON。未配置时跳过推送。见[消息推送](../../docs/zh-CN/push-notifications.md)。 |

环境变量：

| 名称 | 用途 |
| --- | --- |
| `SMTP_EMAIL`、`SMTP_APP_PASSWORD` | 用于发送验证码和重置密码验证码的邮箱账号 |
| `DEEPGRAM_API_KEY` | 自动生成字幕所用的 Deepgram 密钥 |
| `CLYVEN_ADMIN_EMAIL` | 启动时被授予管理员权限的邮箱；未设置则跳过 |
| `CLYVEN_NOM_DICTIONARY_PATH` | 可选，覆盖越南语 Nôm 词典 JSON 的路径 |

## 测试

```bash
dart analyze
dart test
```

集成测试需要 `docker-compose.yaml` 里的测试用 PostgreSQL 和 Redis 容器。

## 部署

`Dockerfile` 用于构建服务端镜像；仓库根目录的 `cloudbuild.server.yaml` 在 Google Cloud Build 上构建它。生产环境的服务运行在 Cloud Run 上。
