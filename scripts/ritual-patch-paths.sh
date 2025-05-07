#!/bin/bash
set -euo pipefail

OLD_PATH="/Users/ash/Automation/GreenSquare"
NEW_PATH="/Users/ash/Automation/GreenSquare"
TARGET_DIR="$HOME/Automation/GreenSquare"

echo "🔍 Scanning for hardcoded paths in: $TARGET_DIR"
echo "🛠 Replacing:"
echo "    $OLD_PATH"
echo "    ➜ $NEW_PATH"
echo ""

# Find and patch
FILES=$(grep -rl "$OLD_PATH" "$TARGET_DIR" || true)

if [ -z "$FILES" ]; then
    echo "✅ No files found with old path. You're clean!"
    exit 0
fi

for file in $FILES; do
    echo "⚙️  Patching $file"
    sed -i '' "s|$OLD_PATH|$NEW_PATH|g" "$file"
done

echo ""
echo "✅ All references to Desktop path replaced."

