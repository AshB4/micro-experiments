#!/bin/bash
set -euo pipefail

# 💾 Paths
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG="$REPO_DIR/../logs/cronlog.txt"
ERRORLOG="$REPO_DIR/../logs/cronerror.txt"


# 📍 Start Ritual
echo "[$(date)] 🔧 Core Ritual manually triggered" >> "$LOG"

# ⛩️ Run basic GitHub commit ritual
mkdir -p notes
files=("notes/scratch.js" "notes/logs.js" "notes/ideas.js" "notes/algorithms.js" "notes/square.js" "notes/garden.js" "notes/README.md")
for f in "${files[@]}"; do touch "$f"; done

chosen_file=${files[$RANDOM % ${#files[@]}]}
echo "// Core ritual touched this file on $(date)" >> "$chosen_file"
echo "[$(date)] 📝 Updated: $chosen_file" >> "$LOG"

COMMIT_MESSAGES=(
  "chore: daily core commit"
  "docs: updated log via ritual"
  "fix: ghost commit"
  "style: touched by the ritual"
)
msg=${COMMIT_MESSAGES[$RANDOM % ${#COMMIT_MESSAGES[@]}]}

git add . || echo "[$(date)] ⚠️ git add failed" >> "$LOG"
if git commit -m "$msg"; then
  git push origin main && echo "[$(date)] ✅ Commit + Push: $msg" >> "$LOG"
else
  echo "[$(date)] ❌ Commit failed" >> "$LOG"
  git status >> "$LOG"
  exit 1
fi

# ✨ Dev Blessing
echo "[$(date)] ✨ The GitHub gods accept your offering." >> "$LOG"
