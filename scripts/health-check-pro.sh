#!/bin/bash
set -euo pipefail

CRONLOG="$HOME/Desktop/micro-experiments/cronlog.txt"
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d)  # Mac BSD date format
HOUR_NOW=$(date +%H)

Check if yesterday had a successful ritual

if grep -q "$YESTERDAY" "$CRONLOG" && grep -q "✅ Commit + Push successful" "$CRONLOG"; then
echo "[$(date)] 🟢 Ritual on $YESTERDAY was successful." >> "$CRONLOG"
else
echo "[$(date)] 🔴 WARNING: No successful ritual found for $YESTERDAY!" >> "$CRONLOG"
fi

Check if today’s ritual is missing (after 4PM)

if [ "$HOUR_NOW" -ge 16 ]; then
if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
echo "[$(date)] ⚠️ Reminder: No ritual detected yet for today ($TODAY)." >> "$CRONLOG"
fi
fi
