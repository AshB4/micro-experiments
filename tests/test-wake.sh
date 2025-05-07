#!/bin/bash
set -euo pipefail

# 🕰️ Get current time
MIN=$(date +%M)
HOUR=$(date +%H)

# 🧮 Add 2 minutes for ritual schedule
if [ "$MIN" -ge 58 ]; then
  SCHED_MIN=$(( (MIN + 2) % 60 ))
  SCHED_HOUR=$(( (HOUR + 1) % 24 ))
else
  SCHED_MIN=$((MIN + 2))
  SCHED_HOUR=$HOUR
fi

# 🗓️ Final scheduling time string
RUNTIME=$(printf "%02d:%02d:00" "$SCHED_HOUR" "$SCHED_MIN")
DATE=$(date +%m/%d/%y)
WAKE_TIME="$DATE $RUNTIME"

# 📍 Paths
REPO_DIR="$HOME/Desktop/micro-experiments"
SCRIPT="$REPO_DIR/scripts/daily-square.sh"
LOG="$REPO_DIR/logs/cronlog.txt"
ERRORLOG="$REPO_DIR/logs/cronerror.txt"

# 💬 Verbose startup
echo "[$(date)] 🧪 TEST MODE: Scheduling system wake + ritual at $RUNTIME" | tee -a "$LOG"
echo "[$(date)] 📁 Using script: $SCRIPT" | tee -a "$LOG"
echo "[$(date)] 🖊️  Log path: $LOG" | tee -a "$LOG"
echo "[$(date)] 🔧 PMSET wake command: sudo pmset schedule wakeorpoweron \"$WAKE_TIME\"" | tee -a "$LOG"

# 🛌 Schedule system wake
sudo pmset schedule wakeorpoweron "$WAKE_TIME"

# 🧙‍♀️ Schedule the actual ritual using `at`
echo "[$(date)] 🎯 Scheduling ritual via 'at' for $SCHED_HOUR:$SCHED_MIN" | tee -a "$LOG"
echo "echo \"[$(date)] 🧨 at job triggered from \$(pwd)\" >> \"$LOG\"; env >> \"$LOG\"; /bin/bash \"$SCRIPT\" >> \"$LOG\" 2>> \"$ERRORLOG\"" | at "$SCHED_HOUR:$SCHED_MIN"

# 🧾 Confirm scheduled `at` jobs
echo "[$(date)] 📜 'atq' job queue snapshot:" | tee -a "$LOG"
atq | tee -a "$LOG"

# 🔍 Add tail job 3 minutes after ritual runs
POST_MIN=$(( (SCHED_MIN + 3) % 60 ))
POST_HOUR=$SCHED_HOUR
if [ "$SCHED_MIN" -ge 57 ]; then
  POST_HOUR=$(( (SCHED_HOUR + 1) % 24 ))
fi

echo "[$(date)] 🧪 Scheduling log tail check for $(printf "%02d:%02d" "$POST_HOUR" "$POST_MIN")" | tee -a "$LOG"
echo "tail -n 50 \"$LOG\" >> \"$LOG\"" | at "$(printf "%02d:%02d" "$POST_HOUR" "$POST_MIN")"

# 🧠 PMSET diagnostics
echo "[$(date)] 🔍 pmset -g sched output:" >> "$LOG"
pmset -g sched >> "$LOG"

# 💤 Force system to sleep now
echo "[$(date)] 💤 Entering sleep now. Ritual should trigger upon wake." | tee -a "$LOG"
pmset sleepnow
