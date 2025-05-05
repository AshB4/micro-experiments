#!/bin/bash
set -euo pipefail

REPO_DIR="$HOME/Desktop/micro-experiments"
LOG="$REPO_DIR/logs/cronlog.txt"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$REPO_DIR/.ritualconfig"

if [[ -z "$REPO" ]]; then
  echo "❌ REPO is not set. Please run StartRitualSetup.command first."
  exit 1
fi

# Update this to the correct repo folder
# ⛱️ Check for vacation mode FIRST
cd "$REPO_DIR" || {
  echo "[$(date)] ❌ Failed to cd into $REPO_DIR" >> "$LOG"
  exit 1
}

if [ -f "vacation.flag" ]; then
  echo "[$(date)] 🌴 Vacation mode active. Ritual skipped." >> "$LOG"
  exit 0
fi

# trap must come AFTER cd + checks
trap 'echo "[$(date)] ❌ Script exited unexpectedly" >> "$LOG"' ERR

# Check current visibility
CURRENT_VISIBILITY=$(gh repo view "$REPO" --json visibility -q .visibility)

# Flip to PUBLIC if needed
if [ "$CURRENT_VISIBILITY" != "public" ]; then
  if gh repo edit "$REPO" --visibility public --accept-visibility-change-consequences; then
    echo "[$(date)] ✅ Repo set to PUBLIC" >> "$LOG"
  else
    echo "[$(date)] ❌ Failed to set repo to PUBLIC" >> "$LOG"
    exit 1
  fi
else
  echo "[$(date)] ℹ️ Repo already PUBLIC" >> "$LOG"
fi

# Give GitHub time to process visibility flip
sleep 60

# Create a tiny believable edit
mkdir -p notes
files=("notes/scratch.js" "notes/logs.js" "notes/ideas.js" "notes/agorithms.js" "notes/square.js" "notes/garden.js" "notes/README.md")
for f in "${files[@]}"; do touch "$f"; done

# Choose one file randomly to update
chosen_file=${files[$RANDOM % ${#files[@]}]}
echo "// $(date)" >> "$chosen_file"

# Commit messages
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

RANDOM_DELAY=$((RANDOM % 20))
echo "[$(date)] ⏳ Sleeping $RANDOM_DELAY seconds to mimic human chaos" >> "$LOG"
sleep "$RANDOM_DELAY"

# Git commit + push
# Git commit + push
git add .
if git commit -m "$msg"; then
  git pull --rebase origin main
  if git push origin main; then
    echo "[$(date)] ✅ Commit + Push successful: $msg" >> "$LOG"
  else
    echo "[$(date)] ❌ Push failed after rebase: $msg" >> "$LOG"
    echo "☠️  GitHub gods have rejected your sacrifice. The ritual has failed."
    exit 1
  fi
else
  echo "[$(date)] ❌ Commit failed: $msg" >> "$LOG"
  echo "☠️  Your offering could not even be wrapped. The altar is silent."
  exit 1
fi

# Let GitHub process your beautiful contribution
sleep 120

# Flip back to PRIVATE if it wasn't already private
if [ "$CURRENT_VISIBILITY" != "private" ]; then
  if gh repo edit "$REPO" --visibility private --accept-visibility-change-consequences; then
    echo "[$(date)] ✅ Repo set to PRIVATE again" >> "$LOG"
  else
    echo "[$(date)] ❌ Failed to set repo back to PRIVATE" >> "$LOG"
    exit 1
  fi
else
  echo "[$(date)] ℹ️ Repo was already PRIVATE; no need to flip back" >> "$LOG"
fi

# Finalize the ritual
echo "[$(date)] 🔮 Coding magic complete" >> "$LOG"

