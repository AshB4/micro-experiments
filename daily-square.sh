#!/bin/bash

cd ~/Desktop/micro-experiments || {
  echo "[$(date)] ❌ Failed to cd into repo folder" >> ~/Desktop/micro-experiments/cronlog.txt
  exit 1
}

# Create a believable edit
echo "// $(date)" >> notes/scratch.js

# Pick a commit message
messages=("chore: update notes" "docs: update snippet" "style: tweak formatting" "refactor: code stub" "test: verify output")
msg=${messages[$RANDOM % ${#messages[@]}]}

# Stage, commit, and push
if git add . && git commit -m "$msg" && git push origin main; then
  echo "[$(date)] ✅ Commit + Push successful: $msg" >> cronlog.txt
else
  echo "[$(date)] ❌ Commit or Push FAILED: $msg" >> cronlog.txt
  exit 1
fi

# Flip visibility to public, wait, then private again
if gh repo edit AshB4/micro-experiments --visibility public --accept-visibility-change-consequences &&
   sleep 15 &&
   gh repo edit AshB4/micro-experiments --visibility private --accept-visibility-change-consequences; then
  echo "[$(date)] ✅ Repo visibility flipped (public ➜ private)" >> cronlog.txt
else
  echo "[$(date)] ❌ Repo visibility flip FAILED" >> cronlog.txt
  exit 1
fi
