#!/bin/bash

CRONLOG="$HOME/Desktop/micro-experiments/cronlog.txt"
TODAY=$(date +%Y-%m-%d)

if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
  echo "[$(date)] 🔁 Ritual missed — triggering safety commit." >> "$CRONLOG"
  /bin/bash ~/Desktop/micro-experiments/daily-square.sh
else
  echo "[$(date)] ✅ Ritual already completed. No action taken." >> "$CRONLOG"
fi
