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

The 2026-10-11 Dart / Flutter / Serverpod CI completed successfully at commit `9175f5a`. The workflow now also checks the Cloudflare Worker bundle using Wrangler dry-run, without publishing it. A successful dry-run does not test a live Container, R2 bucket or Stream API.

Cloudflare Containers explicitly select `GLYPHORA_TRANSCODER=cloudflare_stream` for new videos. New jobs on Cloudflare are refused if this setting is missing instead of silently creating a new Google Transcoder job. Legacy in-progress Google jobs may still require Google credentials until migration completes.

## HLS origin compatibility

The playback endpoint accepts Cloudflare Stream's customer-specific `*.cloudflarestream.com` HLS URLs and the standard `videodelivery.net` host. These URLs are returned directly from the Cloudflare Stream API rather than passed through bucket-relative object URL lookup. The host allowlist is intentional: do not accept arbitrary persisted HTTPS URLs.

## Required production secrets

The Worker now returns HTTP 503 (without starting a Container) if any of these settings are missing: `SERVERPOD_PASSWORD_database`, `SERVERPOD_PASSWORD_serviceSecret`, `SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey`, `CLOUDFLARE_ACCOUNT_ID`, `CLOUDFLARE_R2_BUCKET`, `CLOUDFLARE_R2_PUBLIC_HOST`, `SERVERPOD_R2_ACCESS_KEY_ID`, `SERVERPOD_R2_SECRET_KEY`, or `CLOUDFLARE_STREAM_API_TOKEN`. Put credentials in Wrangler secrets, never in source control. A dry-run cannot verify secret presence or real runtime connectivity.

## Docker image build gate

GitHub Actions builds `Dockerfile.cloudflare` from the repository root in a separate CI job. This catches Dart AOT compilation failures and missing runtime assets that a Wrangler Worker dry-run cannot detect. Neither the image nor the Worker is published. Do not deploy or cut over until Docker build, Wrangler dry-run and the original test suite all pass.

## Legacy transcoding behavior on Cloudflare

Cloudflare Containers no longer query Google Transcoder for existing legacy jobs. A legacy job already marked `SUCCEEDED` can retain its manifest path, but **the referenced objects must first be copied to R2 with their original keys**. Pending or failed legacy jobs cannot be finished by Cloudflare: complete or reprocess them before cutover. This does not migrate any existing GCS object. Verify covers, uploaded originals, HLS manifests and every referenced HLS segment before changing client endpoints. Retain the Google deployment until this inventory and parity check are finished.

## Non-destructive historical object backfill

Use `cloudflare/migrate_gcs_to_r2.sh` from a machine with `rclone` configured with a read-only Google Cloud Storage source remote and a Cloudflare R2 S3 remote. Provide remote paths through `GLYPHORA_GCS_REMOTE` and `GLYPHORA_R2_REMOTE`. The script defaults to `dry-run`; invoke `copy` explicitly to write R2 objects, then `verify` to compare paths and sizes. It uses `rclone copy`, not `sync`, so it never deletes objects on either side. Do not put credentials in the repository. Validation is size-only; independently test HLS manifest/segment consistency, metadata, CORS and actual media playback. Pause uploads or run a final reconciliation during cutover. No remote data is copied by GitHub CI.

For stronger integrity checking, invoke `verify-deep` after `copy`. It uses `rclone check --download` to compare actual bytes instead of relying on object sizes or incompatible provider checksums. It can download the entire dataset from **both** clouds and incur substantial GCS egress and request charges; estimate volume and costs before running. Neither verification mode deletes files. A successful byte comparison still does not establish correct public URLs, MIME headers or HLS playback.

The `copy` mode uses `--immutable`: it refuses to overwrite an existing destination object that differs from the source rather than silently replacing data. Resolve conflicts explicitly after inspection; do not force-overwrite the whole bucket. This is separate from `verify`/`verify-deep`, which are read-only.
