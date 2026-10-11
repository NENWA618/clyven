#!/usr/bin/env bash
# Release gate for moving Glyphora API traffic away from Cloud Run.
# Read-only: does not connect to clouds or change any configuration.
set -euo pipefail
CONFIG="${1:-server/backend_server/config/production.yaml}"
if [[ ! -f "$CONFIG" ]]; then
  echo "Missing Serverpod production config: $CONFIG" >&2
  exit 2
fi
host="$(awk '/^apiServer:/ { in_api=1; next } in_api && /^[^[:space:]#]/ { exit } in_api && /^[[:space:]]*publicHost:/ { print $2; exit }' "$CONFIG")"
if [[ -z "$host" ]]; then
  echo "Cannot identify apiServer.publicHost in $CONFIG" >&2
  exit 2
fi
if [[ "$host" == *run.app || "$host" == *googleapis.com ]]; then
  echo "CUTOVER BLOCKED: apiServer.publicHost still points to Google Cloud Run." >&2
  echo "Configure and verify the Cloudflare API hostname before any traffic switch." >&2
  exit 1
fi
if [[ "$host" == *examplepod.com || "$host" == localhost || "$host" == 127.0.0.1 ]]; then
  echo "CUTOVER BLOCKED: apiServer.publicHost is a placeholder/local address." >&2
  exit 1
fi
if [[ -n "${GLYPHORA_CLOUDFLARE_PUBLIC_HOST:-}" && "$host" != "$GLYPHORA_CLOUDFLARE_PUBLIC_HOST" ]]; then
  echo "CUTOVER BLOCKED: Serverpod public host differs from the intended Cloudflare host." >&2
  exit 1
fi
echo "Serverpod public host check passed: $host"
echo "This does NOT verify DNS, Container reachability, WebSocket, TLS, uploads or historical video playback."
