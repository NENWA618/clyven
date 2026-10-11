#!/usr/bin/env bash
# Copy legacy Glyphora GCS objects to R2 without changing source or database.
set -euo pipefail

if ! command -v rclone >/dev/null 2>&1; then
  echo "Install rclone and configure a GCS source remote and an R2 S3 remote." >&2
  exit 1
fi

SOURCE="${GLYPHORA_GCS_REMOTE:-}"
DESTINATION="${GLYPHORA_R2_REMOTE:-}"
MODE="${1:-dry-run}"
if [[ -z "$SOURCE" || -z "$DESTINATION" ]]; then
  echo "Set GLYPHORA_GCS_REMOTE and GLYPHORA_R2_REMOTE as rclone remote paths." >&2
  echo "Example: GLYPHORA_GCS_REMOTE='gcs:glyphora-video-storage-11129163384'" >&2
  echo "         GLYPHORA_R2_REMOTE='r2:glyphora-video'" >&2
  exit 2
fi
# Require explicit bucket-scoped paths, never a bare remote or filesystem root.
if [[ ! "$SOURCE" =~ ^[A-Za-z0-9_-]+:[^/[:space:]][^[:space:]]*$ ||
      ! "$DESTINATION" =~ ^[A-Za-z0-9_-]+:[^/[:space:]][^[:space:]]*$ ||
      "$SOURCE" == "$DESTINATION" ]]; then
  echo "Refusing identical or root-only source/destination." >&2
  exit 2
fi
case "$MODE" in
  dry-run)
    echo "Dry-run copy: $SOURCE -> $DESTINATION (no writes)"
    rclone copy "$SOURCE" "$DESTINATION" --dry-run --progress --transfers 4 --checkers 8
    ;;
  copy)
    if [[ "${GLYPHORA_CONFIRM_R2_COPY:-}" != 'YES' ]]; then
      echo "Copy writes to R2. Set GLYPHORA_CONFIRM_R2_COPY=YES to proceed." >&2
      exit 2
    fi
    echo "Non-destructive copy: $SOURCE -> $DESTINATION"
    rclone copy "$SOURCE" "$DESTINATION" --immutable --progress --transfers 4 --checkers 8
    ;;
  verify)
    echo "Checking source/destination objects; no deletions or writes."
    rclone check "$SOURCE" "$DESTINATION" --one-way --size-only --progress
    echo "Size-based verification passed. Sample HLS manifests and segments with byte hashes or playback separately."
    ;;
  verify-deep)
    echo "Comparing actual source and destination bytes; this downloads both sides and may incur egress costs."
    rclone check "$SOURCE" "$DESTINATION" --one-way --download --progress
    echo "Byte-level verification passed. Still test public URLs, CORS and HLS playback."
    ;;
  *)
    echo "Usage: $0 [dry-run|copy|verify|verify-deep]" >&2
    exit 2
    ;;
esac
