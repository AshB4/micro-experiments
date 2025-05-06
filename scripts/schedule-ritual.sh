#!/bin/bash
set -euo pipefail

CRONDIR="$(cd "$(dirname "$0")" && pwd)"
CRONLOG="$CRONDIR/../logs/cronlog.txt"
ERRORLOG="$CRONDIR/../logs/cronerror.txt"
SCRIPT="$CRONDIR/daily-square.sh"
WAKEFILE="$CRONDIR/../logs/next-ritual-time.txt"

# 🛑 Sanity checks first
if ! command -v at &>/dev/null; then
  echo "❌ 'at' command not found. Please install it with 'brew install at'." | tee -a "$ERRORLOG"
  exit 1
fi

if [ ! -f "$SCRIPT" ]; then
  echo "❌ Ritual script not found at $SCRIPT" | tee -a "$ERRORLOG"
  exit 1
fi

mkdir -p "$(dirname "$CRONLOG")"

# Trap for unexpected failures
trap 'echo "[$(date)] ❌ Failed to schedule ritual!" | tee -a "$ERRORLOG" "$CRONLOG"' ERR

# Skip weekends
DAYOFWEEK=$(date +%u)
if [ "$DAYOFWEEK" -gt 5 ]; then
  echo "[$(date)] ⚠️ Weekend detected. Ritual skipped." | tee -a "$CRONLOG"
  exit 0
fi

if [[ $(pmset -g | grep " sleep" | awk '{print $2}') -ne 0 ]]; then
  echo "[$(date)] ⚠️ WARNING: System sleep may block this script!" >> "$LOG"
fi

# Randomize time between 7:00 AM and 4:59 PM
HOUR=$((RANDOM % 10 + 7))  # 7–16
MINUTE=$((RANDOM % 60))
RUNTIME=$(printf "%02d:%02d:00" "$HOUR" "$MINUTE")
DATE=$(date +%m/%d/%y)
WAKE_TIME="$DATE $RUNTIME"


# Save ritual time
echo "$WAKE_TIME" > "$WAKEFILE"

# Schedule wake for ritual
sudo pmset schedule wakeorpoweron "$WAKE_TIME"

echo "[$(date)] 🔮 Ritual scheduled for $RUNTIME and system will wake then too." | tee -a "$CRONLOG"
# Schedule the ritual job
echo "/bin/bash \"$SCRIPT\" >> \"$CRONLOG\" 2>> \"$ERRORLOG\"" | at "${HOUR}:${MINUTE}"

# Log schedule details
echo "[$(date)] 🕒 Scheduled $SCRIPT for ${HOUR}:${MINUTE} today via 'at'" | tee -a "$CRONLOG"
echo "[$(date)] 🔋 System wake time set to $WAKE_TIME" | tee -a "$CRONLOG"
echo "[$(date)] 🔮 Ritual fully scheduled." | tee -a "$CRONLOG"
echo "[$(date)] ✨ build. build. build. ✨" >> "$CRONLOG"
