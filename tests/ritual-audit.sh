#!/bin/bash
set -euo pipefail

# 📍 Resolve absolute paths
TESTS_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$HOME/Desktop/micro-experiments"
LOG="$REPO_DIR/logs/cronlog.txt"
ERRLOG="$REPO_DIR/logs/cronerror.txt"
SCRIPT="$REPO_DIR/scripts/daily-square.sh"

echo ""
echo "🧵 RITUAL-AUDIT REPORT — $(date)"
echo "===================================================="
echo "📍 Audit launched from: $TESTS_DIR"
echo ""

# 🧾 Logs
echo "📜 Last 25 lines of $LOG:"
tail -n 25 "$LOG" 2>/dev/null || echo "❌ Log not found."
echo ""

echo "🚨 Contents of $ERRLOG (if any):"
cat "$ERRLOG" 2>/dev/null || echo "✅ No errors logged."
echo ""

# ⏱️ at jobs
echo "⏰ Remaining scheduled 'at' jobs:"
atq || echo "✅ No pending at jobs."
echo ""

# 🔋 Wake schedule
echo "🛌 pmset wake schedule:"
pmset -g sched | grep -E 'pmset|wake' || echo "⚠️ No wake events found."
echo ""

# 🔐 Permission check
echo "🔐 Script permission check:"
if [ -x "$SCRIPT" ]; then
  echo "✅ $SCRIPT is executable."
else
  echo "❌ $SCRIPT is NOT executable — run: chmod +x \"$SCRIPT\""
fi
echo ""

# 📂 Repo status
echo "📂 Git repo status:"
cd "$REPO_DIR"
git status -s || echo "⚠️ git status failed — is this a Git repo?"
echo ""

# 🧬 Env test
echo "🧬 Environment Snapshot (core vars):"
env | grep -E 'NVM|GH|PATH|TERM|SHELL|USER|HOME' || echo "⚠️ No expected environment vars."
echo ""

echo "✅ Ritual audit complete."
echo "===================================================="
