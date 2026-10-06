# Glyphora

**English** | [简体中文](README.zh-CN.md)

> A multilingual video and subtitle language-learning platform, built as a Flutter/Jaspr + Serverpod monorepo.

**Glyphora** started as a video platform and has grown into a **multilingual video and subtitle learning platform**. While watching a video, users can read bilingual or reviewed subtitles, tap a word to look it up in a dictionary, save words to word lists, and track how well they know each word (Knowledge State). The project also covers the full subtitle-production workflow: Vietnamese Chữ Nôm ↔ Quốc Ngữ script conversion, AI subtitle generation (ASR), and human subtitle review.

The mobile client manages state with **Riverpod** (Flutter). The web front-ends use **Jaspr** (Dart web framework). All of them talk to one shared **Serverpod** backend.

---

## Documentation

| Document | Description |
| --- | --- |
| [Documentation index](docs/en/README.md) | All documents, in English and Chinese |
| [Owner checklist](docs/en/owner-checklist.md) | Everything that still needs to be configured by hand (Firebase, Apple, DNS, signing keys) |
| [Picture-in-picture](docs/en/picture-in-picture.md) | How video continues in a floating window on Android and iOS |
| [Push notifications](docs/en/push-notifications.md) | System-level push through Firebase Cloud Messaging |
| [Share links](docs/en/share-links.md) | Shared links that open the video inside the app |

---

## Apps in this Monorepo

Glyphora consists of 5 front-end applications, 1 backend service, and 3 shared packages, managed together with Melos.

| App | Stack | Purpose | Local port |
| --- | --- | --- | --- |
| `apps/app` | Flutter (iOS / Android / desktop) | Main client for end users: video feed, subtitle learning, dictionary, word lists | - |
| `apps/web` | Jaspr (Dart web) | Public web client with the same features as `glyphora_app` | 8084 |
| `apps/studio` | Jaspr (Dart web) | Creator back office: video upload and management, subtitle and dictionary management, comment management | 8083 |
| `apps/admin` | Jaspr (Dart web) | Internal admin console: user management, Vietnamese script conversion tools | 8082 |
| `apps/review` | Jaspr (Dart web) | Subtitle review workbench: review queue and review task details | 8081 |
| `server/backend_server` | Serverpod | Shared backend for every front-end | 8080 |

---

## Features

### Video

* Home feed, discover page, and search
* Video detail and playback, synchronized with subtitles
* Video upload (local video picker, duration detection, FFmpeg processing, upload)
* Video series
* Likes, favorites, and watch history
* Picture-in-picture playback on Android and iOS
* HLS adaptive streaming with local segment caching

### Subtitles and Language Learning

* Subtitle tracks with sentence-level and word-level (token) data
* Karaoke-style word-by-word highlighting (karaoke segments)
* SRT import and export
* AI subtitle generation (Deepgram ASR, `asr_job_processor`)
* Human review workflow: review queue, review tasks, and a review dashboard
* In-player subtitle learning panel (tap a word to look it up, repeat sentence by sentence)

### Dictionary and Vocabulary

* Dictionary lookup (definitions, examples, word forms, entry relations)
* Bulk dictionary import (import preview, field mapping, commit)
* Word list management
* Known entries and mastery tracking (Knowledge State)

### Script Conversion

* Vietnamese Chữ Nôm ↔ Quốc Ngữ conversion (`glyphora_nom_converter`)
* Conversion profile management, bulk import preview, and commit

### Creator (Studio)

* Creator dashboard
* Video, subtitle, and dictionary management
* Comment management

### Interaction

* Likes and comments, including replies and reply likes
* Follow creators and a list of followed creators
* Sharing: a shared link opens the video directly in the app ([details](docs/en/share-links.md))

### User

* Authentication (Serverpod Auth IDP) and an auth gate
* Profile page and profile statistics
* Watch history
* Notification center, notification settings, and privacy settings
* System push notifications for likes, comments, and follows, localized to the app language ([details](docs/en/push-notifications.md))

### Admin

* User management
* Vietnamese script conversion tools
* Excel data import (dictionary and conversion tables)

---

## Tech Stack

### Client (mobile / desktop)

* Flutter, Dart
* Riverpod (`flutter_riverpod`)
* `video_player`, `video_duration_native`, `flutter_video_caching`
* `ffmpeg_kit_flutter_new_min_gpl` (video processing)
* `image_picker`, `share_plus`
* `firebase_core`, `firebase_messaging` (push notifications)
* `app_links` (opening shared links inside the app)

### Web (public / studio / admin / review)

* Jaspr (`jaspr`, `jaspr_router`, `jaspr_flutter_embed`)

### Backend communication

* Serverpod
* `serverpod_client` / `serverpod_flutter`
* `serverpod_auth_idp_flutter` / `serverpod_auth_core_client`

### Backend (Serverpod server)

* Serverpod (PostgreSQL, migrations)
* Deepgram ASR (speech recognition for subtitle generation)
* `excel` (dictionary and conversion table import)
* `serverpod_cloud_storage_gcp` (media storage)
* `mailer`, `googleapis_auth`
* Firebase Cloud Messaging HTTP v1 (push delivery, authenticated with `googleapis_auth`)

### Hosting

* Backend: Google Cloud Run
* Share landing page and domain-verification files: Firebase Hosting (`deploy/share_site`)

### Shared packages

* `glyphora_nom_converter`: core library for Vietnamese Latin ↔ Chữ Nôm conversion (includes a CLI)
* `glyphora_subtitle_editor`: subtitle editing components shared by Studio and Review (timeline, karaoke segments, SRT import and export)
* `glyphora_backend_client`: client code generated by Serverpod, shared by all front-ends

### Monorepo tooling

* Dart workspace (`pubspec.yaml`)
* Melos (scripts in `pubspec.yaml` for dev, build, analyze, and test)

---

## Architecture

`glyphora_app` is organized into feature modules. `glyphora_web`, `glyphora_studio`, `glyphora_admin`, and `glyphora_review` follow a similar pages / components / services split.

```text
lib/
│
├── core/
│   ├── errors/
│   ├── localization/
│   ├── media/            # video cache, picture-in-picture bridge
│   ├── navigation/
│   ├── push/             # Firebase Cloud Messaging integration
│   ├── serverpod/
│   ├── sharing/          # share links and deep-link handling
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

Each feature is split further as needed:

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

The overall data flow:

```text
UI
 │
 ▼
Riverpod provider
 │
 ▼
Repository
 │
 ▼
Serverpod client
 │
 ▼
Backend (Serverpod endpoint)
 │
 ▼
Database / cloud storage
```

---

## Backend Modules (Serverpod Endpoints)

```text
video_endpoint                 Video CRUD, series, transcoding trigger
comment_endpoint               Comments, replies, likes
social_endpoint                Follows and interaction state
notification_endpoint          Notification feed
notification_settings_endpoint Notification settings
push_device_endpoint           Registers and removes device push tokens
privacy_settings_endpoint      Privacy settings
subtitle_endpoint              Subtitle tracks, cues, tokens, karaoke
review_endpoint                Subtitle review queue and tasks
dictionary_endpoint            Dictionary lookup
dictionary_import_endpoint     Bulk dictionary import
word_list_endpoint             Word lists
known_entry_endpoint           Known entries and mastery
script_conversion_endpoint     Vietnamese script conversion
admin_endpoint                 Admin console
```

Services (`lib/src/services/`):

```text
asr_job_processor                  Processes ASR subtitle-generation jobs
deepgram_asr_service               Deepgram speech recognition integration
video_transcode_service            Video transcoding
subtitle_analysis_service          Subtitle analysis
subtitle_review_task_service       Review task workflow
subtitle_srt_parser / exporter     SRT import and export
dictionary_import_writer           Writes imported dictionary data
vietnamese_nom_conversion_service  Vietnamese Nôm conversion
notification_service               Creates in-app notifications and triggers push
push_service                       Sends push messages through Firebase Cloud Messaging
```

---

## Monorepo Layout

```text
glyphora/
│
├── apps/
│   ├── app/            # Flutter main client
│   ├── web/            # Jaspr public web client
│   ├── studio/         # Jaspr creator back office
│   ├── admin/          # Jaspr internal admin console
│   └── review/         # Jaspr subtitle review workbench
│
├── packages/
│   ├── backend_client/    # Generated Serverpod client
│   ├── subtitle_editor/   # Shared subtitle editor components
│   └── nom_converter/     # Vietnamese script conversion core
│
├── server/
│   └── backend_server/    # Serverpod backend and database migrations
│
├── deploy/
│   └── share_site/            # Firebase Hosting site for share links
│
├── tool/                      # Melos and development helper scripts
├── docs/                      # Documentation (docs/en and docs/zh-CN)
└── pubspec.yaml               # Dart workspace and Melos scripts
```

The Flutter app, the generated Serverpod client, the Serverpod backend, and every Jaspr web app live in the same Dart workspace, so there is no need to clone several repositories.

---

## State Management

The application entry point wraps everything in a `ProviderScope`:

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

Each feature owns its providers, which model:

```text
Loading
Data
Error
User actions
```

Page widgets do not issue data requests or hold business state themselves.

---

## Getting Started

### 1. Clone

```bash
git clone https://github.com/chengyang1017/glyphora.git
cd glyphora
```

### 2. Install workspace dependencies

```bash
dart pub get
```

### 3. Generate Serverpod code

```bash
cd server/backend_server
serverpod generate
cd ../..
```

### 4. Run the backend

```bash
cd server/backend_server
dart run bin/main.dart --apply-migrations
```

### 5. Run a front-end

Flutter client (generate the localization files first if `lib/l10n/app_localizations.dart` is missing):

```bash
cd apps/app
flutter gen-l10n
flutter run
```

Jaspr web apps (run one, or start several with Melos):

```bash
melos run dev:web      # glyphora_web    -> :8084
melos run dev:studio   # glyphora_studio -> :8083
melos run dev:admin    # glyphora_admin  -> :8082
melos run dev:review   # glyphora_review -> :8081
melos run dev:all      # start web, studio, admin, and review together
melos run dev:stop     # stop leftover local dev servers
```

### 6. Validate

Flutter app:

```bash
cd apps/app
flutter test
flutter analyze
```

Or run everything from the repository root with Melos:

```bash
melos run analyze
melos run test
```

Backend:

```bash
cd server/backend_server
dart analyze
dart test
```

---

## Configuration

Push notifications and share links work only after some one-time setup outside the code: a Firebase project, Apple and Google signing information, a DNS record, and a server secret. Without it the app still runs normally; push is skipped and shared links fall back to the landing page.

The complete step-by-step list is in the [owner checklist](docs/en/owner-checklist.md).

---

## Roadmap

* [x] Flutter client foundation with Riverpod state management
* [x] Serverpod client integration and authentication entry
* [x] Home, discover, search, video detail, and playback
* [x] Basic video upload flow and video series
* [x] Comments, creators, video interactions, history, notifications, and profile modules
* [x] Subtitle data model (tracks, cues, tokens, karaoke) linked to playback
* [x] SRT import and export, and the human review workflow
* [x] ASR subtitle generation (Deepgram)
* [x] Dictionary lookup and bulk import
* [x] Word lists, known entries, and mastery tracking
* [x] Vietnamese Chữ Nôm ↔ Quốc Ngữ conversion
* [x] Creator Studio, admin console, and review workbench (Jaspr)
* [x] Picture-in-picture playback (Android and iOS; iOS needs device verification)
* [x] System push notifications (needs Firebase configuration)
* [x] Share links that open videos in the app (needs domain setup)
* [ ] Improve large-video upload and transcoding
* [ ] Improve the recommendation system
* [ ] Improve the subtitle learning experience (shadowing, review reminders)
* [ ] Improve error recovery and network-state handling
* [ ] Improve production deployment
* [ ] Manual video quality selection
* [ ] Per-video link previews for shared links

---

## Status

This project is under active development. The current focus is the "video + subtitles + vocabulary learning" path, connecting the client, web apps, creator back office, review back office, and the Serverpod backend end to end.

Some features are still being built or refined and do not represent the final production implementation.

---

## Author

**Cheng Yang**

A multilingual video and subtitle learning platform exploring modular client architecture, Riverpod/Jaspr front-ends, Serverpod backend integration, ASR-driven subtitle production, dictionary and vocabulary tooling, and Vietnamese script conversion.

> From video playback to a complete multilingual learning platform.
