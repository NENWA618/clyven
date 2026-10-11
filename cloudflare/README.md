# Cloudflare deployment scaffold (not yet a completed cutover)

This directory contains the Cloudflare Containers entrypoint for the Dart / Serverpod backend. The GitHub main branch is not automatically deployed by these files.

## Deployment prerequisites

1. Enable Cloudflare Containers and install Node.js and Docker locally.
2. Install dependencies with `npm install`.
3. Set Cloudflare Worker secrets for the existing Serverpod database/auth configuration; never commit secrets. Check actual Serverpod environment variable names against the deployed version.
4. Run `npx wrangler deploy` from the monorepo root.
5. Verify API, websocket, authentication, migrations, Neon database connectivity, mail and uploads on the new endpoint **before** changing mobile/web clients or DNS.

## NOT YET MIGRATED

- Storage: `server/backend_server/lib/server.dart` uses `serverpod_cloud_storage_gcp` and GCS.
- HLS: `video_transcode_service.dart` calls Google Cloud Transcoder, with Google Storage keys and retry state.
- Existing clients point to the old Cloud Run endpoint, while the public API host in production config is still Cloud Run.
- Historical files, HLS manifests and database references must be copied and migrated carefully.
- The Google Cloud Build file is retained until Cloudflare deployment and video playback have passed validation.
- Port 8080 is routed; Serverpod's ports 8081 and 8082 are not exposed through the Worker yet.

Do not shut down GCP resources just because the scaffold has been committed. This is an incremental, non-disruptive first step in a complete migration.

## R2 upload support (implementation present, not validated in production)

The Serverpod `public` storage integration selects R2 when all three
environment variables are present:
`CLOUDFLARE_ACCOUNT_ID`, `CLOUDFLARE_R2_BUCKET`, and
`CLOUDFLARE_R2_PUBLIC_HOST` (hostname without scheme, for example
`media.glyphora.net`). Set `SERVERPOD_R2_ACCESS_KEY_ID` and
`SERVERPOD_R2_SECRET_KEY` as Cloudflare Worker secrets. R2's bucket
must be configured with a public custom domain, appropriate CORS for direct
browser uploads, and upload permissions scoped to that bucket.

When the three R2 settings are absent, the existing GCS backend remains
active; this is explicitly an interim migration mode, **not** a finished
Google Cloud removal. Always test presigned PUT, public URLs, cover uploads,
video upload and playback. Existing database rows still point to historical
GCS objects, and Google Transcoder still requires that bucket.

Run `dart pub get` at the workspace root and commit the regenerated
`pubspec.lock` after dependency resolution. The lockfile has not yet been
regenerated in this commit. Do not deploy a frozen-lockfile build until it is.

## Cloudflare Stream optional transcoding path

Set `GLYPHORA_TRANSCODER=cloudflare_stream` and configure
`CLOUDFLARE_ACCOUNT_ID` and the secret `CLOUDFLARE_STREAM_API_TOKEN`
to import **new** public R2 video uploads into Cloudflare Stream. Existing
Google Transcoder jobs remain readable through the legacy job name format.
Cloudflare Stream reports its own HLS manifest URL, so no GCS-style HLS
object is expected. Test uploads, processing, video visibility and playback
before enabling this switch.

Limitations: Stream's managed HLS segments are not identical to the former
fixed 3/6-second segment configuration. Stream imports require a fetchable
public HTTPS source (do not enable this path for private uploads). This
integration currently does not retry failed Stream jobs automatically, and
does not implement signed playback tokens. Do not cut over protected video
content until signed playback and access policy are implemented.

Private video safety: Cloudflare Stream copy mode deliberately refuses videos with `isPublic=false` until signed playback is implemented.

## Fail-closed behavior

The Cloudflare Container supplies `GLYPHORA_REQUIRE_CLOUDFLARE=true`, so startup fails rather than silently reverting to GCS if R2 account, bucket or public host settings are absent. Existing Google Cloud Run deployments retain their original interim fallback unless this variable is enabled.

Check GitHub Actions before attempting cutover: the 2026-10-11 main workflow failed at `dart format` for `lib/server.dart` and `video_transcode_service.dart`. Dependency installation succeeded, but static analysis and tests were skipped. These have not yet been validated.

Cloudflare Containers explicitly select `GLYPHORA_TRANSCODER=cloudflare_stream` for new videos. New jobs on Cloudflare are refused if this setting is missing instead of silently creating a new Google Transcoder job. Legacy in-progress Google jobs may still require Google credentials until migration completes.
