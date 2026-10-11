#!/bin/sh
set -eu
host="${GLYPHORA_CLOUDFLARE_PUBLIC_HOST:-}"
case "$host" in
  ""|*/*|*:*|*' '*|*.run.app|*.googleapis.com|*.examplepod.com)
    echo 'Cloudflare API public hostname is missing or invalid.' >&2
    exit 1
    ;;
esac
# Only mutate the Cloudflare container's copied runtime configuration.
# Original Google Cloud production.yaml remains untouched in the repository.
sed -i "s|^  publicHost: glyphora-server-11129163384.asia-southeast1.run.app$|  publicHost: $host|" config/production.yaml
if grep -q 'publicHost: glyphora-server-11129163384.asia-southeast1.run.app' config/production.yaml; then
  echo 'Cannot apply Cloudflare hostname overlay.' >&2
  exit 1
fi
exec ./server --mode="${runmode:-production}" --server-id="${serverid:-default}" --logging="${logging:-normal}" --role="${role:-monolith}"
