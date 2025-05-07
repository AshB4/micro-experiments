#!/bin/bash

# 🌍 Dynamically detect this script's folder
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CRONLOG="$SCRIPT_DIR/../logs/cronlog.txt"  # Assuming logs/ is one level up
DAILY_SCRIPT="$SCRIPT_DIR/daily-square.sh"
TODAY=$(date +%Y-%m-%d)

# 📅 Check if ritual already succeeded today
if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
  echo "[$(date)] 🔁 Ritual missed — triggering safety commit." >> "$CRONLOG"
  /bin/bash "$DAILY_SCRIPT"
else
  echo "[$(date)] ✅ Ritual already completed. No action taken." >> "$CRONLOG"
fi

# 🧿 Nosy Nerd Trap Check
TRAP_FILE="$SCRIPT_DIR/decryption-key.sh"

if [ -f "$TRAP_FILE" ]; then
  echo "🕵️  Intrusion detected: $TRAP_FILE was triggered."

  # 🎵 Rickroll
  open "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

  # 🗣️ Sass voice – uses YOUR current system voice
  say "Baby, you tried it. But this ain't your key. Enjoy the Rick-roll."
  sleep 2
  say "You nosy little turd. Now watch the video and think about your life choices."
sleep 2 
say "You could of bought this in the time it took to hack this file!"

  # 🧼 Clean up trap file if you want to reset it
  rm "$TRAP_FILE"
  exit 1
fi
