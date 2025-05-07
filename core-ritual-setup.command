#!/bin/bash
set -e

echo "🌀 Starting your Core Ritual setup..."

# 🧙 GitHub Config Prompt
read -p "🌐 Enter your GitHub username: " USERNAME
read -p "📦 Enter the repo name to use (e.g., green-garden): " REPONAME

REPO_LINE="REPO=\"$USERNAME/$REPONAME\""
echo "$REPO_LINE" > .ritualconfig

echo "✅ GitHub repo set as $USERNAME/$REPONAME"

echo "🔧 Setting up your Core Ritual permissions..."
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/daily-square.sh.x"

# Check for main ritual script
if [ -f "$SCRIPT_PATH" ]; then
    chmod +x "$SCRIPT_PATH"
    echo "✅ daily-square.sh.x is now executable."
else
    echo "❌ daily-square.sh.x not found in /scripts/. Please don’t move files around like a goblin."
    exit 1
fi

# Verify and prefill logs + notes
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$BASE_DIR/logs" "$BASE_DIR/notes"

touch "$BASE_DIR/logs/cronlog.txt" "$BASE_DIR/logs/cronerror.txt"

files=("scratch.js" "logs.js" "ideas.js" "algorithms.js" "square.js" "garden.js" "README.md")
for f in "${files[@]}"; do
    touch "$BASE_DIR/notes/$f"
done

echo "🗃️ Notes and logs initialized. Your spellbook is ready."
echo "🧙 Ritual setup complete. You may now run:"
echo "   ./scripts/daily-square.sh.x"
echo "🌿 May your commits be evergreen."
