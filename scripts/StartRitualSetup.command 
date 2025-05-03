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

# Run the ritual scheduler with elevated permissions
sudo bash schedule-ritual.sh

echo "✅ Done! Your ritual has been scheduled and your system will wake up automatically."
osascript -e 'display notification "Ritual setup complete." with title "GitHub Garden"'
