#!/bin/bash

# Generate a random hour (7–16 = 7am to 4pm)
HOUR=$((RANDOM % 10 + 7))
# Generate a random minute (0–59)
MINUTE=$((RANDOM % 60))

# Format the time for `at`
RUNTIME=$(printf "%02d:%02d" "$HOUR" "$MINUTE")

# Schedule the square ritual to run later today
echo "/bin/bash /Users/ash/Desktop/micro-experiments/daily-square.sh >> /Users/ash/Desktop/micro-experiments/cronlog.txt 2>&1" | at "$RUNTIME"

echo "[$(date)] 🔮 Ritual scheduled for $RUNTIME today" >> /Users/ash/Desktop/micro-experiments/cronlog.txt
