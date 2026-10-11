#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/config"
cp "$root/server/backend_server/config/production.yaml" "$tmp/config/production.yaml"
cat > "$tmp/server" <<'MOCK'
#!/bin/sh
printf '%s\n' "$*" > server-arguments.txt
MOCK
chmod +x "$tmp/server"
cd "$tmp"
if GLYPHORA_CLOUDFLARE_PUBLIC_HOST='' /bin/sh "$root/cloudflare/container-entrypoint.sh" > /dev/null 2>&1; then
  echo 'Missing Cloudflare hostname was accepted' >&2
  exit 1
fi
if GLYPHORA_CLOUDFLARE_PUBLIC_HOST='foo&evil.example' /bin/sh "$root/cloudflare/container-entrypoint.sh" > /dev/null 2>&1; then
  echo 'Unsafe hostname was accepted' >&2
  exit 1
fi
GLYPHORA_CLOUDFLARE_PUBLIC_HOST='api.glyphora.net' /bin/sh "$root/cloudflare/container-entrypoint.sh"
grep -q '^  publicHost: api.glyphora.net$' config/production.yaml
grep -q -- '--mode=production' server-arguments.txt
echo 'Cloudflare entrypoint overlay and failure checks passed'

# Verify staging refuses to start against the production database.
cp "$root/server/backend_server/config/production.yaml" config/production.yaml
if GLYPHORA_CLOUDFLARE_PUBLIC_HOST='api.glyphora.net' GLYPHORA_STAGING=true \
   /bin/sh "$root/cloudflare/container-entrypoint.sh" > /dev/null 2>&1; then
  echo 'Staging accepted missing isolated DB settings' >&2
  exit 1
fi
GLYPHORA_CLOUDFLARE_PUBLIC_HOST='api.glyphora.net' GLYPHORA_STAGING=true \
  GLYPHORA_STAGING_DB_HOST='staging-db.example.org' GLYPHORA_STAGING_DB_NAME='glyphora_test' \
  GLYPHORA_STAGING_DB_USER='glyphora_test_user' /bin/sh "$root/cloudflare/container-entrypoint.sh"
grep -q '^  host: staging-db.example.org$' config/production.yaml
grep -q '^  name: glyphora_test$' config/production.yaml
grep -q '^  user: glyphora_test_user$' config/production.yaml
