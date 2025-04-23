#!/bin/bash

cd ~/Desktop/micro-experiments || {
  echo "[$(date)] ❌ Failed to cd into repo folder" >> ~/Desktop/micro-experiments/cronlog.txt
  exit 1
}

# Flip repo visibility to PUBLIC so GitHub counts the commit
if gh repo edit AshB4/micro-experiments --visibility public --accept-visibility-change-consequences; then
  echo "[$(date)] ✅ Repo set to PUBLIC" >> cronlog.txt
else
  echo "[$(date)] ❌ Failed to set repo to PUBLIC" >> cronlog.txt
  exit 1
fi

# Give GitHub time to propagate visibility change
sleep 10

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

# Wait to let GitHub process contribution activity
sleep 20

# Flip repo visibility to PRIVATE again
if gh repo edit AshB4/micro-experiments --visibility private --accept-visibility-change-consequences; then
  echo "[$(date)] ✅ Repo set to PRIVATE again" >> cronlog.txt
else
  echo "[$(date)] ❌ Failed to set repo back to PRIVATE" >> cronlog.txt
  exit 1
fi
