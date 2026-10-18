# Glyphora Studio

**English** | [简体中文](README.zh-CN.md)

The creator back office of Glyphora, built with Jaspr (Dart web). Creators use it to upload and manage videos, manage subtitles and dictionaries, and manage comments.

It talks to the shared Serverpod backend (`server/backend_server`) through the generated `glyphora_backend_client` package, and reuses the subtitle editor from `glyphora_subtitle_editor`.

## Run

From the repository root, with the backend already running:

```bash
melos run dev:studio   # serves on http://localhost:8083
```

Or directly:

```bash
cd apps/studio
jaspr serve --port 8083
```

## Build

```bash
cd apps/studio
jaspr build
```

The output is written to `build/jaspr/`.

## Isolated Cloudflare staging build

The Studio Serverpod API URL defaults to the existing Cloud Run backend. For an
**isolated testing build**, use a Jaspr build-time environment declaration:

```json
{
  "GLYPHORA_API_URL": "https://glyphora-api-staging.chengyang1017.workers.dev/"
}
```

Save this as a local `studio.staging.json` outside tracked source files, then:

```bash
cd apps/studio
jaspr build --dart-define-from-file=../../studio.staging.json
```

Deploy the resulting `build/jaspr/` to a **separate staging origin**, not
`studio.glyphora.net`. The Studio browser session storage is origin-scoped;
separate origins protect production login state from staging credentials.
Staging uses its own Neon database, R2 bucket and identity sessions, so sign in
with an independent staging account. Verify the request URL in browser DevTools
before uploading anything. Do not promote the staging build to production.
The R2 staging bucket CORS policy must allow the exact staging Studio origin,
not just `https://studio.glyphora.net`. Do not include privileged credentials
in the JSON: build-time definitions become public client-side code.
