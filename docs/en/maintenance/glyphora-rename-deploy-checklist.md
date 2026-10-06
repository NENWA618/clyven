# Glyphora Rename: Required Steps Before Deploying

**English** | [简体中文](../../zh-CN/maintenance/glyphora-rename-deploy-checklist.md)

Date: 2026-10-06

The brand name changed from Clyven to Glyphora everywhere in the repository, and the brand prefix was dropped from directory and file names. The code changes are done, but several of them **affect the live environment**. Work through this list before deploying; otherwise the backend may fail to start, admin access may be lost, or the web app may point at the wrong address.

> None of this was verified against production. Where it depends on the state of the live database, Cloud Run or build triggers, the steps below are checks for you to run, not known facts.

## Overview

| # | Item | If skipped | Affects |
| --- | --- | --- | --- |
| 1 | Serverpod module name in the database | Backend fails at start-up by re-creating existing tables | Backend, database |
| 2 | Renamed build and runtime variables | Admin access lost, web links to localhost, app uses the wrong address | Backend, Web, App, scripts |
| 3 | Build paths and directory renames | Build and deploy pipelines cannot find directories | CI, Cloud Build, Firebase Hosting |
| 4 | Android / iOS identifiers | Not compatible with the old package; share links and push cannot be verified | App, share site |
| 5 | Local storage keys and custom URL scheme | Local preferences reset once; old-scheme links stop opening the app | Web, App |

Suggested order: item 1 (database) first, then items 2 and 3, then deploy the backend and Web, and release the App last.

## 1. Serverpod module name in the database

### What changed

The Serverpod backend module name changed from `clyven_backend` to `glyphora_backend`. It appears in:

- `moduleName` in the migration files under `server/backend_server/migrations/*/`.
- Generated code (`server/backend_server/lib/src/generated/`, `packages/backend_client/lib/src/protocol/`).
- The backend package name in `pubspec.yaml` (`glyphora_backend_server`).

Serverpod records which migration version each module has reached in the `serverpod_migrations` table, keyed by module name. If the live database still has `clyven_backend`, the new backend treats `glyphora_backend` as a brand-new module and tries to apply every migration from scratch. That runs `CREATE TABLE` on tables that already exist and the start-up fails.

### Steps

1. **Back up the database first.** For example, create an on-demand backup in the Cloud SQL console and confirm it finished.
2. **Check the live state:**
   ```sql
   SELECT module, version FROM serverpod_migrations ORDER BY module, version;
   ```
   - If `clyven_backend` is listed, continue with step 3.
   - If it is not (the database never applied migrations, or already uses `glyphora_backend`), skip step 3.
3. **Rename the module:**
   ```sql
   UPDATE serverpod_migrations
   SET module = 'glyphora_backend'
   WHERE module = 'clyven_backend';
   ```
4. **Then deploy the new backend**, not the other way round. If the deploy uses `--apply-migrations`, it should now only apply new migrations, if any.
5. **Verify:** no migration or table-creation errors in the backend logs, and the query from step 2 returns only `glyphora_backend`.

### Rollback

To go back to the old backend, run the `UPDATE` in reverse (`glyphora_backend` to `clyven_backend`).

## 2. Renamed variables

Every variable starting with `CLYVEN_` is now `GLYPHORA_`. **The old names are no longer read.** Update every place that used them: build commands, Cloud Run environment variables, Cloud Build triggers, CI secrets and local scripts.

### Backend runtime variables

Set these on the Cloud Run service (or wherever the backend runs):

| New name | Old name | Purpose | If not updated |
| --- | --- | --- | --- |
| `GLYPHORA_ADMIN_EMAIL` | `CLYVEN_ADMIN_EMAIL` | Email granted admin access at start-up | When unset, **admin bootstrap is skipped**. The log has a single notice and no error, so it is easy to miss |
| `GLYPHORA_NOM_DICTIONARY_PATH` | `CLYVEN_NOM_DICTIONARY_PATH` | Optional override for the Vietnamese Nôm dictionary JSON | The old variable is ignored and the backend looks in its built-in default paths. Only matters if the variable was actually set in production |

Add the new variables first and remove the old ones after the deploy succeeds.

### Build-time values (`--dart-define`)

These are baked into the build, so rebuild with the new names:

| New name | Old name | Used by | Notes |
| --- | --- | --- | --- |
| `GLYPHORA_STUDIO_URL` | `CLYVEN_STUDIO_URL` | `apps/web` | Address of the "Studio" button in the web header. **The default is `http://localhost:8083`**, so production builds must set `https://studio.glyphora.net`, otherwise the button goes to localhost and the session hand-off does not work |
| `GLYPHORA_API_URL` | `CLYVEN_API_URL` | `apps/app` | Overrides the backend address |
| `GLYPHORA_BUILD_REVISION` | `CLYVEN_BUILD_REVISION` | `apps/app` | Build revision label |
| `GLYPHORA_SHARE_BASE_URL` | `CLYVEN_SHARE_BASE_URL` | `apps/app` | Share-link domain, default `https://share.glyphora.net`; must match `deploy/share_site`, `AndroidManifest.xml` and `Runner.entitlements` |
| `GLYPHORA_MEDIA_CDN_BASE` | `CLYVEN_MEDIA_CDN_BASE` | `apps/app` | Media CDN address |
| `GLYPHORA_FEED_DIAGNOSTICS` | `CLYVEN_FEED_DIAGNOSTICS` | `apps/app` | Enables feed diagnostics in release builds |

Example production Web build:

```bash
cd apps/web
jaspr build --dart-define=GLYPHORA_STUDIO_URL=https://studio.glyphora.net
```

### Scripts only

The test scripts in `server/backend_client/bin/` read `GLYPHORA_TEST_EMAIL` and `GLYPHORA_TEST_PASSWORD` (formerly `CLYVEN_TEST_*`). Only relevant if you run them by hand or in CI.

### How to check

Search the repository for leftovers, then check the live places yourself:

```bash
git grep -n "CLYVEN_"
```

Places that are not in the repository: Cloud Run environment variables and secrets, Cloud Build trigger substitutions, GitHub Actions secrets and variables, and any hand-written deploy scripts.

## 3. Build paths and directory renames

The `clyven_` prefix was removed from directory names:

| Old path | New path |
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
| `server/clyven_backend_client` (scripts only) | `server/backend_client` |
| `tool/clyven_dev.dart` | `tool/dev.dart` |

Note that **directory names no longer match Dart package names**. Packages are `glyphora_app`, `glyphora_web`, `glyphora_backend_client` and so on; the directories have no `glyphora_` prefix. Melos `scope` and `--filter` use package names, not directory names.

Already updated in the repository: `.github/workflows/ci.yml`, `cloudbuild.server.yaml`, `.gcloudignore`, `server/backend_server/Dockerfile`, the root `pubspec.yaml` (workspace and Melos scripts), the `path:` dependencies in each `pubspec.yaml`, and `dev.cmd`.

**To check outside the repository:**

- If a Cloud Build trigger hard-codes the Dockerfile path or source directory (the old one was `server/clyven_backend_server/Dockerfile`), change it to `server/backend_server/Dockerfile`.
- Build output directories referenced by Firebase Hosting, Cloud Run or any deploy script, for example `apps/clyven_web/build/web` becomes `apps/web/build/web`.
- Local IDE run configurations, terminal aliases and saved workspace paths.
- After pulling this change into an existing clone, ignored directories such as `.dart_tool` and `build` stay behind at the old paths (for example `apps/clyven_app/build`). Delete them by hand to save disk space and avoid confusion.
- The working directory `D:\clyven` itself was not renamed; do that yourself if you want to.

## 4. Android / iOS identifiers

### What changed

| Where | Old | New |
| --- | --- | --- |
| Android `applicationId` and `namespace` | `com.example.clyven` | `com.example.glyphora` |
| iOS Bundle Identifier | `com.example.clyven` | `com.example.glyphora` |
| Kotlin package | `com.example.clyven` | `com.example.glyphora` (the `MainActivity.kt` directory moved with it) |
| Picture-in-picture MethodChannel | `clyven/pip` | `glyphora/pip` (updated on both Android and iOS) |

Effect on users: with a new package name the system treats this as a different app. **A previously side-loaded build is not upgraded; the two install side by side**, and the old build's local data is not carried over. If you have not distributed any build yet, this does not matter.

### Configuration still to do

Follow sections 0, 1 and 3 of the [owner checklist](../owner-checklist.md), using the new package name:

- [ ] Settle on the final package name. `com.example.*` cannot be published on Google Play. If you plan to publish, change it once now instead of renaming `com.example.glyphora` again later.
- [ ] Register the Android and iOS apps in Firebase with the new identifier and download `google-services.json` and `GoogleService-Info.plist`. Both files record the identifier, and push will not work if it does not match.
- [ ] `deploy/share_site/public/.well-known/assetlinks.json`: `package_name` is now `com.example.glyphora`; `sha256_cert_fingerprints` is still the placeholder `REPLACE_WITH_SIGNING_CERT_SHA256` and needs the signing certificate fingerprint.
- [ ] `deploy/share_site/public/.well-known/apple-app-site-association`: `appIDs` is `REPLACE_WITH_TEAM_ID.com.example.glyphora`; fill in the Team ID.
- [ ] Redeploy the share site (`deploy/share_site`), otherwise phones cannot verify link ownership.

## 5. Local storage keys and custom URL scheme

These are strings in the code. After the rename, **values users saved locally under the old keys are not read any more**:

| Where | Old | New | Effect |
| --- | --- | --- | --- |
| Review theme (browser localStorage) | `clyven_review_theme` | `glyphora_review_theme` | Review console theme resets to default once |
| App language, theme, display mode, data saver (local storage) | `clyven.app_locale`, `clyven.theme_mode`, `clyven.theme_color`, `clyven.theme_companion_color`, `clyven.display_mode`, `clyven.playback_data_saver` | same, prefix changed to `glyphora.` | These settings reset to defaults once and users must choose again |
| App custom URL scheme | `clyven://` | `glyphora://` | Links using the old scheme no longer open the app (HTTPS share links are not affected) |

**Not affected:** login sessions. The key is `serverpod_auth_success_key`, defined by Serverpod and unchanged, so signed-in users stay signed in.

If resetting preferences is not acceptable, add a one-time migration at the read sites (fall back to the old key when the new one is empty). It has not been added.

## Post-deploy checks

- [ ] No migration or table-creation errors in the backend start-up log, and `serverpod_migrations` only has `glyphora_backend`.
- [ ] The backend log does not say `GLYPHORA_ADMIN_EMAIL is not configured`. Sign in to Admin with the admin email and confirm access.
- [ ] Open the live web app (`www.glyphora.net`), sign in, click "Studio": it should land on `studio.glyphora.net` without asking you to sign in again.
- [ ] The Studio address bar does not keep `#sso=...` (it should be stripped after it is read).
- [ ] The Android build with the new package name installs, signs in and plays; picture-in-picture works.
- [ ] `https://share.glyphora.net/v/<videoId>` opens in the app (needs the fingerprint and Team ID from section 4 first).
- [ ] Push: a build made with the new `google-services.json` receives a test push.
