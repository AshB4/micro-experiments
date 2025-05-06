#!/bin/bash
set -euo pipefail

# 💾 Paths
REPO_DIR="$HOME/Desktop/micro-experiments"
LOG="$REPO_DIR/logs/cronlog.txt"
ERRORLOG="$REPO_DIR/logs/cronerror.txt"
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_PATH/.ritualconfig" 2>/dev/null || echo "[$(date)] ⚠️ .ritualconfig not found or failed to load" >> "$LOG"

# 📍 Start Ritual
echo "[$(date)] 🎯 Ritual actually triggered" >> "$LOG"
echo "[$(date)] 📍 Running from $SCRIPT_PATH" >> "$LOG"
echo "[$(date)] ⚡ User: $(whoami) | Host: $(hostname)" >> "$LOG"
echo "[$(date)] 🔗 Current branch: $(git rev-parse --abbrev-ref HEAD)" >> "$LOG"

# ☕ Keep the system awake during ritual
caffeinate -dimsu &
CAFFEINATE_PID=$!
trap "kill $CAFFEINATE_PID" EXIT
echo "[$(date)] ☕ Caffeinate engaged with PID $CAFFEINATE_PID" >> "$LOG"

# 🛡️ Trap unexpected exit
trap 'echo "[$(date)] ❌ Script exited unexpectedly or failed" >> "$LOG"' ERR

# 🔌 Power State Check
POWER_STATE=$(pmset -g ps | head -1)
echo "[$(date)] 🔌 Power State: $POWER_STATE" >> "$LOG"

# 💻 Wake confirmation
echo "[$(date)] 🛌 Wake event detected, continuing..." >> "$LOG"

# 🏝️ Vacation Check
cd "$REPO_DIR" || {
  echo "[$(date)] ❌ Failed to cd into $REPO_DIR" >> "$LOG"
  exit 1
}

if [ -f "vacation.flag" ]; then
  echo "[$(date)] 🌴 Vacation mode active. Ritual skipped." >> "$LOG"
  exit 0
fi

# 🔐 GitHub Repo Visibility Check
REPO_STATUS="UNKNOWN"
if command -v gh >/dev/null 2>&1; then
  REPO_STATUS=$(gh repo view "$REPO" --json visibility -q .visibility 2>/dev/null || echo "FAILED")
else
  echo "[$(date)] ⚠️ GitHub CLI (gh) not found in PATH." >> "$LOG"
fi

echo "[$(date)] 🔍 Current Repo Visibility: $REPO_STATUS" >> "$LOG"

if [ "$REPO_STATUS" != "public" ] && [ "$REPO_STATUS" != "FAILED" ]; then
  gh repo edit "$REPO" --visibility public --accept-visibility-change-consequences &&
  echo "[$(date)] ✅ Repo set to PUBLIC" >> "$LOG" ||
  echo "[$(date)] ❌ Failed to set repo to PUBLIC" >> "$LOG"
else
  echo "[$(date)] ℹ️ Repo already PUBLIC or unknown visibility." >> "$LOG"
fi

# ⏳ Sleep to give GitHub time to register change
sleep 60

# 📂 File Ritual
mkdir -p notes
files=("notes/scratch.js" "notes/logs.js" "notes/ideas.js" "notes/algorithms.js" "notes/square.js" "notes/garden.js" "notes/README.md")
for f in "${files[@]}"; do touch "$f"; done

chosen_file=${files[$RANDOM % ${#files[@]}]}
echo "// $(date)" >> "$chosen_file"
echo "[$(date)] ✍️ Updated file: $chosen_file" >> "$LOG"

# 💬 Commit Message Roulette
COMMIT_MESSAGES=(
  "chore: daily ritual"
  "docs: documented the arcane ritual"
  "fix: off by one because of course it was"
  "chore: applied duct tape"
  "refactor: made it marginally less ugly"
  "feat: added feature nobody asked for but they’ll love"
  "docs: added context to confuse future devs"
  "fix: removed existential crisis from function name"
  "style: spaced things out for inner peace"
  "test: added tests so I can sleep tonight"
)
msg=${COMMIT_MESSAGES[$RANDOM % ${#COMMIT_MESSAGES[@]}]}
msg=${msg:-"chore: emergency fallback ritual commit"}

# 🤖 Sleep randomly to simulate human chaos
RANDOM_DELAY=$((RANDOM % 20))
echo "[$(date)] ⏳ Sleeping $RANDOM_DELAY seconds to mimic human chaos" >> "$LOG"
sleep "$RANDOM_DELAY"

# 🧙 Git Ritual
git add . || echo "[$(date)] ⚠️ git add failed" >> "$LOG"
if git commit -m "$msg"; then
  git pull --rebase origin main || echo "[$(date)] ⚠️ Rebase failed or not needed" >> "$LOG"
  if git push origin main; then
    echo "[$(date)] ✅ Commit + Push successful: $msg" >> "$LOG"
  else
    echo "[$(date)] ❌ Push failed: $msg" >> "$LOG"
    git status >> "$LOG"
    exit 1
  fi
else
  echo "[$(date)] ❌ Commit failed: $msg" >> "$LOG"
  git status >> "$LOG"
  exit 1
fi

# 😴 Cooldown
sleep 120

# 🔒 Revert visibility
if [ "$REPO_STATUS" == "private" ]; then
  echo "[$(date)] ℹ️ Repo was already private. No revert needed." >> "$LOG"
elif [ "$REPO_STATUS" == "public" ]; then
  if gh repo edit "$REPO" --visibility private --accept-visibility-change-consequences; then
    echo "[$(date)] ✅ Repo set to PRIVATE again" >> "$LOG"
  else
    echo "[$(date)] ❌ Failed to revert repo to PRIVATE" >> "$LOG"
  fi
fi

# 🔚 Ritual Complete
echo "[$(date)] 🔮 Ritual complete. GitHub should now show your sacred square." >> "$LOG"
