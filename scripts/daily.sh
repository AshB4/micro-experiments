#!/bin/bash
set -euo pipefail

CRONDIR="/Users/ash/Desktop/micro-experiments"
CRONLOG="$CRONDIR/cronlog.txt"
ERRORLOG="$CRONDIR/cronerror.txt"
SCRIPT="$CRONDIR/daily-square.sh"

# Trap unexpected errors
trap 'echo "[$(date)] ❌ Failed to schedule ritual!" | tee -a "$ERRORLOG" "$CRONLOG"' ERR

# Skip weekends
DAYOFWEEK=$(date +%u) # 1 = Monday ... 7 = Sunday
if [ "$DAYOFWEEK" -gt 5 ]; then
  echo "[$(date)] ⚠️ Weekend detected. Ritual skipped." | tee -a "$CRONLOG"
  exit 0
fi

# Check for required commands
command -v at >/dev/null 2>&1 || {
  echo "[$(date)] ❌ 'at' command not found." | tee -a "$ERRORLOG" "$CRONLOG"
  exit 1
}

[ -f "$SCRIPT" ] || {
  echo "[$(date)] ❌ Ritual script not found at: $SCRIPT" | tee -a "$ERRORLOG" "$CRONLOG"
  exit 1
}

# Randomize time between 7:00 AM and 4:59 PM
HOUR=$((RANDOM % 10 + 7))
MINUTE=$((RANDOM % 60))
RUNTIME=$(printf "%02d:%02d" "$HOUR" "$MINUTE")

# Schedule the square ritual
echo "/bin/bash \"$SCRIPT\" >> \"$CRONLOG\" 2>> \"$ERRORLOG\"" | at "$RUNTIME"

# Log the schedule
echo "[$(date)] 🔮 Ritual scheduled for $RUNTIME today" | tee -a "$CRONLOG"