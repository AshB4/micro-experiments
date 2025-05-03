#!/bin/bash
set -euo pipefail

CRONDIR="$HOME/Desktop/micro-experiments"
CRONLOG="$CRONDIR/cronlog.txt"
ERRORLOG="$CRONDIR/cronerror.txt"
SCRIPT="$CRONDIR/daily-square.sh"
WAKEFILE="$CRONDIR/next-ritual-time.txt"

trap 'echo "[$(date)] ❌ Failed to schedule ritual!" | tee -a "$ERRORLOG" "$CRONLOG"' ERR

# Skip weekends
DAYOFWEEK=$(date +%u)
if [ "$DAYOFWEEK" -gt 5 ]; then
  echo "[$(date)] ⚠️ Weekend detected. Ritual skipped." | tee -a "$CRONLOG"
  exit 0
fi

# Randomize time between 7:00 AM and 4:59 PM
HOUR=$((RANDOM % 10 + 7))  # 7–16
MINUTE=$((RANDOM % 60))
RUNTIME=$(printf "%02d:%02d:00" "$HOUR" "$MINUTE")
DATE=$(date +%Y-%m-%d)
WAKE_TIME="$DATE $RUNTIME"

# Save ritual time
echo "$WAKE_TIME" > "$WAKEFILE"

# Schedule wake for ritual
sudo pmset schedule wakeorpoweron "$WAKE_TIME"

# Schedule the ritual job
echo "/bin/bash \"$SCRIPT\" >> \"$CRONLOG\" 2>> \"$ERRORLOG\"" | at "${HOUR}:${MINUTE}"

# Log it
echo "[$(date)] 🔮 Ritual scheduled for $RUNTIME and system will wake then too." | tee -a "$CRONLOG"
