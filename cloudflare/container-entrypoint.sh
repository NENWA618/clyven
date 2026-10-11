#!/bin/sh
set -eu
host="${GLYPHORA_CLOUDFLARE_PUBLIC_HOST:-}"
case "$host" in
  ""|*[!A-Za-z0-9.-]*|.*|*..*|*.-*|*-.*|*.run.app|*.googleapis.com|*.examplepod.com)
    echo 'Cloudflare API public hostname is missing or invalid.' >&2
    exit 1
    ;;
esac
if [ "${GLYPHORA_STAGING:-}" = 'true' ]; then
  db_host="${GLYPHORA_STAGING_DB_HOST:-}"
  db_name="${GLYPHORA_STAGING_DB_NAME:-}"
  db_user="${GLYPHORA_STAGING_DB_USER:-}"
  case "$db_host" in
    ""|*[!A-Za-z0-9.-]*|.*|*..*|ep-wandering-frog-azudrqv6.c-3.ap-southeast-1.aws.neon.tech)
      echo 'Isolated staging database host is required.' >&2; exit 1 ;;
  esac
  case "$db_name" in
    ""|*[!A-Za-z0-9_]*|neondb) echo 'Isolated staging database name is required.' >&2; exit 1 ;;
  esac
  case "$db_user" in
    ""|*[!A-Za-z0-9_]*|neondb_owner) echo 'Isolated staging database user is required.' >&2; exit 1 ;;
  esac
  sed -i \
    -e "s|^  host: ep-wandering-frog-azudrqv6.c-3.ap-southeast-1.aws.neon.tech$|  host: $db_host|" \
    -e "s|^  name: neondb$|  name: $db_name|" \
    -e "s|^  user: neondb_owner$|  user: $db_user|" config/production.yaml
  if grep -q 'ep-wandering-frog-azudrqv6.c-3.ap-southeast-1.aws.neon.tech' config/production.yaml; then
    echo 'Staging database overlay failed.' >&2; exit 1
  fi
fi
# Only mutate the Cloudflare container's copied runtime configuration.
# Original Google Cloud production.yaml remains untouched in the repository.
sed -i "s|^  publicHost: glyphora-server-11129163384.asia-southeast1.run.app$|  publicHost: $host|" config/production.yaml
if grep -q 'publicHost: glyphora-server-11129163384.asia-southeast1.run.app' config/production.yaml; then
  echo 'Cannot apply Cloudflare hostname overlay.' >&2
  exit 1
fi
exec ./server --mode="${runmode:-production}" --server-id="${serverid:-default}" --logging="${logging:-normal}" --role="${role:-monolith}"
