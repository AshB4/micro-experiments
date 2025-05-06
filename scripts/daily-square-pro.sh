#!/bin/bash
set -euo pipefail
echo "tail -n 15 \"$CRONLOG\" >> \"$CRONLOG\"" | at "${HOUR}:${MINUTE}"
echo "[$(date)] 🔥 daily-square.sh STARTED (manual marker)" >> ~/Desktop/micro-experiments/logs/cronlog.txt
trap 'echo "[$(date)] ❌ Script crashed early" >> ~/Desktop/micro-experiments/logs/cronlog.txt' ERR
echo "[$(date)] 🎯 Ritual actually triggered" >> "$LOG"

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG="$(dirname "$REPO_DIR")/logs/cronlog.txt"
source "$REPO_DIR/.ritualconfig"

# ☕ Keep the system awake
caffeinate -dimsu &
CAFFEINATE_PID=$!
trap "kill $CAFFEINATE_PID" EXIT
echo "[$(date)] ☕ Caffeinate engaged with PID $CAFFEINATE_PID" >> "$LOG"

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
  say "GitHub ritual skipped. You are on vacation."
  osascript -e 'display notification "🌴 Ritual paused." with title "GitHub Garden" subtitle "Vacation Mode Active"'
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
  "chore: update notes"
  "docs: update snippet"
  "style: tweak formatting"
  "refactor: code stub"
  "test: verify output"
  "fix: minor bug"
  "feat: add new feature"
  "build: update dependencies"
  "ci: fix CI pipeline"
  "perf: optimize performance"
  "revert: undo last change"
  "ci: update workflow"
  "chore: daily ritual"
  "docs: add comments"
  "style: improve readability"
  "fix: typo in comment"
  "feat: new function added"
  "test: add unit tests"
  "build: update README"
  "docs: improve onboarding clarity"
  "fix: whitespace that nobody asked for"
  "style: applied extra ✨ polish"
  "chore: fed the commit bot"
  "docs: added context to confuse future devs"
  "test: prepared for the worst"
  "refactor: made it marginally less ugly"
  "feat: improved user flow that only I understand"
  "fix: fixed the fix that fixed nothing"
  "chore: applied duct tape"
  "docs: clarified things I still don’t understand"
  "fix: off by one because of course it was"
  "chore: renamed things for emotional clarity"
  "feat: added feature nobody asked for but they’ll love"
  "refactor: cleaned up code because my future self deserves better"
  "docs: documented the arcane ritual"
  "fix: removed existential crisis from function name"
  "test: added tests so I can sleep tonight"
  "perf: optimized like my laptop was on fire"
  "chore: aligned pixels for my soul"
  "feat: implemented the thing that unblocked everything"
  "fix: magic number made slightly less magic"
  "style: spaced things out for inner peace"
  "chore: added parentheses and emotional stability"
  "docs: wrote a haiku about the code"
  "feat: survival patch"
  "fix: gremlins in the code"  
  "chore: prep work if you dont plan you plan to fail"
  "docs: added a comment that makes no sense"
  "style: made it look pretty for the sake of it"
  "refactor: made it less of a dumpster fire"
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
    say "GitHub gods have rejected your sacrifice. The ritual has failed."
    osascript -e 'display notification "☠️ Ritual rejected." with title "GitHub Garden" subtitle "Sacrifice was unworthy"'
    exit 1
  fi
else
  echo "[$(date)] ❌ Commit failed: $msg" >> "$LOG"
  echo "☠️  Your offering could not even be wrapped. The altar is silent."
  say "The commit offering failed. The ritual is broken."
  osascript -e 'display notification "💀 Commit failed." with title "GitHub Garden" subtitle "You brought nothing"'
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

CHANTS=(
  "The commit is cast. The graph glows green. All is in balance."
  "Push accepted. The algorithm smiles."
  "Today, the repo obeyed. Tomorrow, it shall serve again."
  "Ritual complete. Productivity sanctified."
  "Git bless this day’s offering."
  "The spirits of Open Source are pleased."
)

# Pick a random chant
RANDOM_INDEX=$((RANDOM % ${#CHANTS[@]}))
say "${CHANTS[$RANDOM_INDEX]}"

# Finalize the ritual
echo "[$(date)] 🔮 Coding magic complete" >> "$LOG"
say "The commit has been accepted. The algorithm smiles upon you."
osascript -e 'display notification "🌿 GitHub gods smile upon your offering." with title "Ritual Complete"'
echo "[$(date)] 🔥 daily-square.sh STARTED" >> ~/Desktop/micro-experiments/logs/cronlog.txt
echo "[$(date)] 🎯 Test line executed" >> ~/Desktop/micro-experiments/logs/cronlog.txt

