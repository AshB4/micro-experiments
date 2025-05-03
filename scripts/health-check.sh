#!/bin/bash
<<<<<<< HEAD

File: ~/Desktop/micro-experiments/health-check.sh
=======
set -euo pipefail
>>>>>>> b0f9de6 (chore: update notes)

CRONLOG="$HOME/Desktop/micro-experiments/cronlog.txt"
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d)  # Mac BSD date format
HOUR_NOW=$(date +%H)

<<<<<<< HEAD
Check if yesterday had a successful ritual

if grep -q "$YESTERDAY" "$CRONLOG" && grep -q "✅ Commit + Push successful" "$CRONLOG"; then
echo "[$(date)] 🟢 Ritual on $YESTERDAY was successful." >> "$CRONLOG"
else
echo "[$(date)] 🔴 WARNING: No successful ritual found for $YESTERDAY!" >> "$CRONLOG"
osascript -e 'tell application "System Events" to display dialog "⚠️ No ritual found for yesterday!" buttons {"OK"} default button "OK" with title "Ritual Health Check"'
fi

Check if today’s ritual is missing (after 4PM)

if [ "$HOUR_NOW" -ge 16 ]; then
if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
echo "[$(date)] ⚠️ Reminder: No ritual detected yet for today ($TODAY)." >> "$CRONLOG"
osascript -e 'tell application "System Events" to display dialog "⚠️ No ritual detected yet today!" buttons {"OK"} default button "OK" with title "Ritual Health Check"'
fi
fi

=======
# 🕵️ Check if yesterday had a successful ritual
if grep -q "$YESTERDAY" "$CRONLOG" && grep -q "✅ Commit + Push successful" "$CRONLOG"; then
  echo "[$(date)] 🟢 Ritual on $YESTERDAY was successful." >> "$CRONLOG"
else
  echo "[$(date)] 🔴 WARNING: No successful ritual found for $YESTERDAY!" >> "$CRONLOG"
  osascript -e 'tell application "System Events" to display dialog "⚠️ No ritual found for yesterday!" buttons {"OK"} default button "OK" with title "Ritual Health Check"'
fi

# ⏳ Check if today’s ritual is missing (after 4PM)
if [ "$HOUR_NOW" -ge 16 ]; then
  if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
    echo "[$(date)] ⚠️ Reminder: No ritual detected yet for today ($TODAY)." >> "$CRONLOG"
    osascript -e 'tell application "System Events" to display dialog "⚠️ No ritual detected yet today!" buttons {"OK"} default button "OK" with title "Ritual Health Check"'
  fi
fi
>>>>>>> b0f9de6 (chore: update notes)
