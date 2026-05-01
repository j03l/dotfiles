#!/usr/bin/env bash
# Watch rclone's iCloud mount log for auth failures and trigger refresh.
set -euo pipefail

MOUNT_LOG="$HOME/.cache/rclone/icloud-mount.log"
WATCH_LOG="$HOME/.cache/rclone/icloud-2fa-watch.log"

mkdir -p "$(dirname "$WATCH_LOG")"
exec >>"$WATCH_LOG" 2>&1
echo "=== $(date -Is) watcher started (pid $$) ==="

while [[ ! -f "$MOUNT_LOG" ]]; do
    echo "Waiting for $MOUNT_LOG to appear..."
    sleep 5
done

tail -F -n 0 "$MOUNT_LOG" 2>/dev/null \
    | grep --line-buffered -E -i 'unauthorized|trust.?token|session.?expired|\b401\b|\b403\b|authentication.failed|invalid.?credentials' \
    | while IFS= read -r line; do
        echo "[$(date -Is)] auth pattern matched: $line"
        systemctl --user start --no-block icloud-2fa-refresh.service || true
    done
