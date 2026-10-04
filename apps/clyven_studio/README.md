# clyven_studio

**English** | [简体中文](README.zh-CN.md)

The creator back office of Clyven, built with Jaspr (Dart web). Creators use it to upload and manage videos, manage subtitles and dictionaries, and manage comments.

It talks to the shared Serverpod backend (`server/clyven_backend_server`) through the generated `clyven_backend_client` package, and reuses the subtitle editor from `clyven_subtitle_editor`.

## Run

From the repository root, with the backend already running:

```bash
melos run dev:studio   # serves on http://localhost:8083
```

Or directly:

```bash
cd apps/clyven_studio
jaspr serve --port 8083
```

## Build

```bash
cd apps/clyven_studio
jaspr build
```

The output is written to `build/jaspr/`.
