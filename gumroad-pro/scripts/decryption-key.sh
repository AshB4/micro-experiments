#!/bin/bash

# 📅 Daily Ritual Log Check
CRONLOG="$HOME/Desktop/micro-experiments/logs/cronlog.txt"
TODAY=$(date +%Y-%m-%d)

if ! grep -q "$TODAY" "$CRONLOG" || ! grep -q "✅ Commit + Push successful" "$CRONLOG"; then
  echo "[$(date)] 🔁 Ritual missed — triggering safety commit." >> "$CRONLOG"
  /bin/bash ~/Desktop/micro-experiments/scripts/daily-square.sh
else
  echo "[$(date)] ✅ Ritual already completed. No action taken." >> "$CRONLOG"
fi

# 🧿 Nosy Nerd Trap Check
TRAP_FILE="scripts/decryption-key.sh"

if [ -f "$TRAP_FILE" ]; then
  echo "🕵️  Intrusion detected: $TRAP_FILE was triggered."

  # 🎵 Rickroll
  open "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

  # 🗣️ Sass voice – uses YOUR current system voice
  say "Baby, you tried it. But this ain't your key. Enjoy the Rick-roll."
  sleep 2
  say "You nosy little turd. Now watch the video and think about your life choices."

  # 🧼 Clean up trap file if you want to reset it
  rm "$TRAP_FILE"
  exit 1
fi
