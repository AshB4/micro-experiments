#!/bin/bash
echo "🌀 Starting your GitHub Green Square Ritual setup..."

# 🗂️ Detect script folder and root project folder
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/daily-square.sh"
SCHEDULER="$SCRIPT_DIR/schedule-ritual.sh"
LOGFILE="$ROOT_DIR/logs/ritual-log.txt"
SETUP_SCRIPT="$SCRIPT_DIR/StartRitualSetup.command"

# Prompt for GitHub username and repo name
read -p "Enter your GitHub username: " USERNAME
read -p "Enter the name of the repo to use (e.g. green-garden, config-sandbox): " REPONAME

REPO_LINE="REPO=\"$USERNAME/$REPONAME\""

# 🛡️ Check if ritual script exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ Could not find daily-square.sh at: $SCRIPT_PATH"
  exit 1
fi

# 📝 Replace the REPO= line in daily-square.sh
sed -i '' "s|^REPO=.*|$REPO_LINE|" "$SCRIPT_PATH"
echo "🔧 Updated REPO line in daily-square.sh → $REPO_LINE"
echo "REPO=\"$USERNAME/$REPONAME\"" > "$SCRIPT_DIR/.ritualconfig"

# 🕒 Schedule daily wakeup at 6:59 AM (M–F)
echo "⏰ Scheduling daily system wake-up..."
sudo pmset repeat wakeorpoweron MTWRF 06:59:00

# 🕠 Failsafe wakeup today at 4:54 PM (proper format!)
TODAY=$(date '+%Y-%m-%d')
sudo pmset schedule wakeorpoweron "$TODAY 16:54:00"

# ✅ Make scheduler script executable (with full path)
chmod +x "$SCHEDULER"

# 🧪 Run the ritual scheduler once now for testing
echo "✨ Running test ritual now..."
sudo bash "$SCHEDULER"

# 🪄 Make this script re-runnable
chmod +x "$SETUP_SCRIPT"

# 📓 Log setup success
mkdir -p "$(dirname "$LOGFILE")"
echo "$(date) – Ritual setup complete for $USERNAME/$REPONAME" >> "$LOGFILE"

# 🌱 Tell the user it’s done
echo "✅ Ritual scheduled. Your system will now wake and commit automatically."
osascript -e 'display notification "Ritual setup complete." with title "GitHub Garden 🌱"'
