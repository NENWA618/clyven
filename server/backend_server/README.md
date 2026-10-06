# glyphora_backend_server

**English** | [简体中文](README.zh-CN.md)

The Serverpod backend shared by every Glyphora front-end: video, subtitles, dictionary, review, notifications, push, and administration. Endpoints are in `lib/src/endpoints/`, services in `lib/src/services/`, data models in `lib/src/models/` (`*.spy.yaml`), and database migrations in `migrations/`.

## Run locally

Start PostgreSQL and Redis with Docker, then the server:

```bash
docker compose up --build --detach
dart bin/main.dart --apply-migrations
```

Stop the server with `Ctrl-C`, then stop the containers:

```bash
docker compose stop
```

Local ports: API `8080`, Insights `8081`, web server `8082`; PostgreSQL `8090` and Redis `8091` in Docker (`9090` / `9091` for the test instances).

## After changing a model or endpoint

```bash
serverpod generate
serverpod create-migration --tag <short-description>
```

`create-migration` writes a new folder under `migrations/` and appends it to `migrations/migration_registry.txt`. Deploy with `--apply-migrations` so the database picks it up.

## Configuration

Serverpod passwords (`config/passwords.yaml` locally, or environment variables named `SERVERPOD_PASSWORD_<name>` in production):

| Name | Purpose |
| --- | --- |
| `fcmServiceAccountJson` | Full Firebase service-account JSON used to send push notifications. Without it, push is skipped. See [Push notifications](../../docs/en/push-notifications.md). |

Environment variables:

| Name | Purpose |
| --- | --- |
| `SMTP_EMAIL`, `SMTP_APP_PASSWORD` | Mail account used to send verification and password-reset codes |
| `DEEPGRAM_API_KEY` | Deepgram key for automatic subtitle generation |
| `GLYPHORA_ADMIN_EMAIL` | Email that is granted admin access at start-up; bootstrap is skipped if unset |
| `GLYPHORA_NOM_DICTIONARY_PATH` | Optional path override for the Vietnamese Nôm dictionary JSON |

## Test

```bash
dart analyze
dart test
```

Integration tests need the test PostgreSQL and Redis containers from `docker-compose.yaml`.

## Deploy

The `Dockerfile` builds the server image; `cloudbuild.server.yaml` in the repository root builds it on Google Cloud Build. The production server runs on Cloud Run.
