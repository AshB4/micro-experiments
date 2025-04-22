#!/bin/bash

# Path to your stealth repo
cd ~/Desktop/micro-experiments || exit

# Make a small, boring-looking change
echo "// $(date)" >> notes/scratch.js

# Git add & commit with rotating messages
messages=("chore: update notes" "docs: update snippet" "style: tweak formatting" "refactor: code stub" "test: verify output")
msg=${messages[$RANDOM % ${#messages[@]}]}

git add .
git commit -m "$msg"
git push origin main

# Optional visibility flip for the green square
gh repo edit AshB4/micro-experiments --visibility public
sleep 15
gh repo edit AshB4/micro-experiments --visibility private
echo "[$(date)] daily-square.sh ran successfully" >> /Users/ash/Desktop/micro-experiments/cronlog.txt
