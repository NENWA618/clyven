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
