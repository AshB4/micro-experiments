# Set actual paths
RITUAL_DIR="/Users/ash/Automation/GreenSquare"
SCRIPT="$RITUAL_DIR/scripts/core-daily-square.sh"
DIST_DIR="$RITUAL_DIR/core-edition-release"

# Create output folder
mkdir -p "$DIST_DIR"

# Obfuscate the ritual script
base64 "$SCRIPT" > "$DIST_DIR/core-daily-square.sh.b64"

# Copy notes and config
cp -r "$RITUAL_DIR/notes" "$DIST_DIR/"
cp "$RITUAL_DIR/.ritualconfig" "$DIST_DIR/" 2>/dev/null || echo ".ritualconfig not found, skipping."

# Write README
cat <<EOF > "$DIST_DIR/README.txt"
# Core Ritual Edition

To run this obfuscated Core Edition:

1. Decode the ritual script:
   base64 -d core-daily-square.sh.b64 > core-daily-square.sh
   chmod +x core-daily-square.sh

2. Run it:
   ./core-daily-square.sh

This includes:
- Touched ritual files: core.md, README.md, devlog.md
- Random commit message
- Push to GitHub main
- Blessing from the GitHub gods 🕊️

EOF

# Zip it up
cd "$RITUAL_DIR"
zip -r core-edition-ritual.zip core-edition-release
