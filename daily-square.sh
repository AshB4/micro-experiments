#!/bin/bash
set -euo pipefail
trap 'echo "[$(date)] ❌ Script exited unexpectedly" >> "$LOG"' ERR


REPO_DIR=~/Desktop/micro-experiments
LOG="$REPO_DIR/cronlog.txt"
REPO="AshB4/micro-experiments"

cd "$REPO_DIR" || {
  echo "[$(date)] ❌ Failed to cd into $REPO_DIR" >> "$LOG"
  exit 1
}

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
files=("notes/scratch.js" "notes/logs.js" "notes/ideas.js" "notes/agorithms.js" "notes/square.js" "notes/garden.js" "notes/README.md")
mkdir -p notes
for f in "${files[@]}"; do touch "$f"; done

# Choose one file randomly to update
chosen_file=${files[$RANDOM % ${#files[@]}]}
echo "// $(date)" >> "$chosen_file"

# Commit messages
COMMIT_MESSAGES=("chore: update notes" "docs: update snippet" "style: tweak formatting" "refactor: code stub" "test: verify output" "fix: minor bug" "feat: add new feature" "build: update dependencies" "ci: fix CI pipeline" "perf: optimize performance" "revert: undo last change" "ci: update workflow" "chore: daily ritual" "docs: add comments" "style: improve readability" "fix: typo in comment" "feat: new function added" "test: add unit tests" "build: update README")
msg=${COMMIT_MESSAGES[$RANDOM % ${#COMMIT_MESSAGES[@]}]}

RANDOM_DELAY=$((RANDOM % 20))
echo "[$(date)] ⏳ Sleeping $RANDOM_DELAY seconds to mimic human chaos" >> "$LOG"
sleep "$RANDOM_DELAY"

# Git commit + push
git add .
if git commit -m "$msg" && git push origin main; then
  echo "[$(date)] ✅ Commit + Push successful: $msg" >> "$LOG"
else
  echo "[$(date)] ❌ Commit or Push FAILED: $msg" >> "$LOG"
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

echo "[$(date)] 🔮 Coding magic complete" >> "$LOG"