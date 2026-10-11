#!/usr/bin/env bash
# Read-only network reachability probe for a staged Glyphora API endpoint.
set -euo pipefail
if ! command -v curl >/dev/null 2>&1; then
  echo 'curl is required.' >&2
  exit 2
fi
url="${1:-}"
if [[ -z "$url" || "$url" != https://* ]]; then
  echo 'Usage: smoke_api.sh https://staging-api.example.com/' >&2
  exit 2
fi
host="${url#https://}"
host="${host%%/*}"
if [[ -z "$host" || "$host" == *:* || "$host" == *'@'* || "$host" == *[!A-Za-z0-9.-]* ]]; then
  echo 'Unsafe or unsupported host. Use a plain HTTPS DNS hostname.' >&2
  exit 2
fi
case "$host" in
  localhost|127.*|10.*|192.168.*|169.254.*|*.local|*.internal)
    echo 'Private network targets are not accepted by this probe.' >&2
    exit 2
    ;;
esac
status="$(curl --silent --show-error --output /dev/null --write-out '%{http_code}' \
  --max-time 20 --connect-timeout 10 --max-redirs 0 "https://$host/")"
echo "Glyphora staged API HTTP status: $status"
if [[ ! "$status" =~ ^2[0-9][0-9]$ ]]; then
  echo 'Expected HTTP 2xx; redirects may mask routing back to Google Cloud or another endpoint.' >&2
  exit 1
fi
echo 'HTTPS endpoint returned 2xx without redirect. This is reachability ONLY, not auth, WebSocket, R2 or Stream validation.'
