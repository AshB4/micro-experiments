#!/bin/bash

# 📜 compile-all.sh
# Obfuscates all eligible .sh ritual scripts using shc
# Author: AshB4 (FleurDeVie)

SOURCE_DIR="./scripts"

echo "🛡️  Beginning sacred obfuscation ritual in $SOURCE_DIR..."

for FILE in "$SOURCE_DIR"/*.sh; do
  BASENAME=$(basename "$FILE")
  EXT="${BASENAME##*.}"

  # Skip .command files or anything you manually exclude
  if [[ "$FILE" == *".command" || "$FILE" == *"README.sh" ]]; then
    echo "⏭️  Skipping $BASENAME (ritual not required)"
    continue
  fi

  echo "🔒 Obfuscating $BASENAME..."
  shc -f "$FILE" -o "${FILE}.x"
done

echo "✅ Obfuscation complete. Spells sealed in binaries."
osascript -e 'display notification "Ritual complete. Obfuscated binaries conjured. You’re welcome, mortal." with title "GitHub Green Square Ritual" sound name "Glass"'
say "Ritual complete. Your scripts are now encoded in the language of the ancients. GitHub shall tremble."
