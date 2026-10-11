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
