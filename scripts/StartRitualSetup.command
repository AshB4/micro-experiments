#!/bin/bash
echo "🌀 Starting your GitHub Green Square Ritual setup..."

# Prompt for username and repo name
read -p "Enter your GitHub username: " USERNAME
read -p "Enter the name of the repo to use (e.g. green-garden, config-sandbox): " REPONAME
REPO_LINE="REPO=\"$USERNAME/$REPONAME\""

# Replace the REPO= line in daily-square.sh
sed -i '' "s|^REPO=.*|$REPO_LINE|" ~/Desktop/micro-experiments/scripts/daily-square.sh

# Move to scripts folder
cd ~/Desktop/micro-experiments/scripts || {
  echo "❌ Failed to find the setup folder."
  exit 1
}

# Set default wake time for daily ritual
sudo pmset repeat wakeorpoweron MTWRF 06:59:00

# Set wake time for failsafe check at 4:54 PM
sudo pmset schedule wakeorpoweron "$(date -v+0d '+%Y-%m-%d') 16:54:00"

# Run the ritual scheduler
sudo bash schedule-ritual.sh

# Optional: ensure .command is executable
chmod +x ~/Desktop/micro-experiments/StartRitualSetup.command

echo "✅ Done! Your ritual has been scheduled and your system will wake up automatically."
osascript -e 'display notification "Ritual setup complete." with title "GitHub Garden"'
