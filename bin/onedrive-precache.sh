#!/bin/bash
# OneDrive Pre-cache Script (dynamic adaptive version)
# Continuously adjusts parallelism based on real-time throughput

FOLDERS=(
  "Pictures"
)

LOG="$HOME/.cache/rclone/precache.log"
FIFO="/tmp/precache_files_$$"
PARALLEL=4          # starting parallelism
MIN_PARALLEL=2
MAX_PARALLEL=32
ADJUST_INTERVAL=10  # seconds between adjustments

cleanup() {
  rm -f "$FIFO"
  pkill -P $$ 2>/dev/null
  exit 0
}
trap cleanup EXIT INT TERM

get_cache_size() {
  du -sb ~/.cache/rclone/vfs/ 2>/dev/null | cut -f1
}

# Worker process - reads files from FIFO
worker() {
  while read -r file; do
    cat "$file" > /dev/null 2>&1
  done
}

echo "$(date): Starting dynamic precache..." | tee -a "$LOG"

for folder in "${FOLDERS[@]}"; do
  FULLPATH="$HOME/OneDrive/$folder"
  if [[ ! -d "$FULLPATH" ]]; then
    echo "$(date): Folder not found: $folder" | tee -a "$LOG"
    continue
  fi

  # Get file list
  mapfile -t FILES < <(find "$FULLPATH" -type f 2>/dev/null)
  TOTAL=${#FILES[@]}
  echo "$(date): Found $folder: $TOTAL files" | tee -a "$LOG"

  if [[ $TOTAL -eq 0 ]]; then
    continue
  fi

  # Create FIFO for distributing work
  mkfifo "$FIFO"

  # Track progress
  PROCESSED=0
  LAST_SIZE=$(get_cache_size)
  LAST_TIME=$(date +%s)
  LAST_SPEED=0

  # Start initial workers
  for ((i=0; i<PARALLEL; i++)); do
    worker < "$FIFO" &
  done
  WORKER_PIDS=$(jobs -p)

  echo "$(date): Starting with $PARALLEL workers..." | tee -a "$LOG"

  # Feed files and dynamically adjust
  (
    for file in "${FILES[@]}"; do
      echo "$file"
    done
  ) > "$FIFO" &
  FEEDER_PID=$!

  # Monitor and adjust loop
  while kill -0 $FEEDER_PID 2>/dev/null; do
    sleep $ADJUST_INTERVAL

    # Calculate current speed
    NOW=$(date +%s)
    NOW_SIZE=$(get_cache_size)
    ELAPSED=$((NOW - LAST_TIME))
    BYTES=$((NOW_SIZE - LAST_SIZE))
    SPEED=$(echo "scale=2; $BYTES / $ELAPSED / 1024 / 1024" | bc 2>/dev/null || echo "0")

    # Calculate progress
    CACHED_MB=$(echo "scale=0; $NOW_SIZE / 1024 / 1024" | bc)

    echo -ne "\r  Speed: ${SPEED} MB/s | Workers: $PARALLEL | Cached: ${CACHED_MB}MB    "

    # Adjust parallelism based on speed change
    if [[ "$LAST_SPEED" != "0" ]]; then
      # Compare to last speed
      RATIO=$(echo "scale=2; $SPEED / $LAST_SPEED" | bc 2>/dev/null || echo "1")

      if (( $(echo "$RATIO > 1.15" | bc -l) )); then
        # Speed increased >15%, try more workers
        if [[ $PARALLEL -lt $MAX_PARALLEL ]]; then
          NEW_PARALLEL=$((PARALLEL * 2))
          [[ $NEW_PARALLEL -gt $MAX_PARALLEL ]] && NEW_PARALLEL=$MAX_PARALLEL

          # Add more workers
          for ((i=PARALLEL; i<NEW_PARALLEL; i++)); do
            worker < "$FIFO" &
          done
          PARALLEL=$NEW_PARALLEL
          echo ""
          echo "$(date): ↑ Increased to $PARALLEL workers (speed up)" | tee -a "$LOG"
        fi
      elif (( $(echo "$RATIO < 0.7" | bc -l) )); then
        # Speed dropped >30%, reduce workers
        if [[ $PARALLEL -gt $MIN_PARALLEL ]]; then
          # Kill half the workers
          KILL_COUNT=$((PARALLEL / 2))
          pkill -n -P $$ -x bash 2>/dev/null
          PARALLEL=$((PARALLEL - KILL_COUNT))
          [[ $PARALLEL -lt $MIN_PARALLEL ]] && PARALLEL=$MIN_PARALLEL
          echo ""
          echo "$(date): ↓ Reduced to $PARALLEL workers (slowdown)" | tee -a "$LOG"
        fi
      fi
    fi

    LAST_SIZE=$NOW_SIZE
    LAST_TIME=$NOW
    LAST_SPEED=$SPEED
  done

  wait
  rm -f "$FIFO"
  echo ""
  echo "$(date): Finished $folder" | tee -a "$LOG"
done

CACHE_SIZE=$(du -sh ~/.cache/rclone/vfs/ 2>/dev/null | cut -f1)
echo "$(date): Precache complete. Cache size: $CACHE_SIZE" | tee -a "$LOG"
