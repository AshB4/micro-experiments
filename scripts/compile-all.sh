#!/bin/bash

# 📜 compile-all.sh
# Obfuscates all eligible .sh ritual scripts using shc
# Author: AshB4 (FleurDeVie)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR"
BUILD_DIR="$SCRIPT_DIR/build"

echo "🛡️  Beginning sacred obfuscation ritual in $SOURCE_DIR..."

# Create build dir if it doesn't exist
mkdir -p "$BUILD_DIR"

# Grab all .sh files
sh_files=("$SOURCE_DIR"/*.sh)

# Abort if none found
if [ ! -e "${sh_files[0]}" ]; then
  echo "⚠️  No .sh files found in $SOURCE_DIR to obfuscate. Ritual aborted."
  exit 0
fi

for FILE in "${sh_files[@]}"; do
  BASENAME=$(basename "$FILE")

  if [[ "$BASENAME" == "compile-all.sh" || "$BASENAME" == *".command" || "$BASENAME" == *"README.sh" ]]; then
    echo "⏭️  Skipping $BASENAME (ritual not required)"
    continue
  fi

  echo "🔒 Obfuscating $BASENAME..."
  OUTPUT="$BUILD_DIR/${BASENAME%.sh}.bin"
  if shc -f "$FILE" -o "$OUTPUT"; then
    echo "✅ Obfuscated $BASENAME ➜ $OUTPUT"
  else
    echo "❌ Obfuscation failed for $BASENAME"
    continue
  fi
done

find "$BUILD_DIR" -type f -name "*.bin" > "$BUILD_DIR/obfuscated-manifest.txt"

echo "✅ Obfuscation complete. Spells sealed in binaries."
osascript -e 'display notification "Ritual complete. Obfuscated binaries conjured. You’re welcome, mortal." with title "GitHub Green Square Ritual" sound name "Glass"'
say "Ritual complete. Your scripts are now encoded in the language of the ancients. GitHub shall tremble."
echo "🔮 All scripts have been obfuscated and stored in $BUILD_DIR."
say "All scripts have been obfuscated and stored in $BUILD_DIR."
