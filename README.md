🌿 GitHub Green Square Ritual

Keep your contribution graph alive and your coder soul thriving.

Last updated: 2025-05-03

🧙‍♂️ What This Is

This system automates daily GitHub contributions through a stylized "ritual" — flipping your repo public, making a micro-edit, pushing it, and flipping it private again. It logs success or failure and ensures you appear active on weekdays.

You can schedule randomized commit times, include a failsafe check at 4:55 PM, and even skip days with a vacation mode.

🔧 Setup Instructions

Place all files in:

~/Desktop/micro-experiments/

Then make them executable:

chmod +x ~/Desktop/micro-experiments/*.sh

Required Files:

daily-square.sh – core ritual script

schedule-ritual.sh – randomly schedules the ritual for today

ritual-safety-check.sh – runs at 4:55 PM if no commit was made

health-check.sh – optional, alerts if yesterday or today missed

⚙️ Cron Setup

Run:

crontab -e

Paste:

# Schedule random ritual every weekday at 7:00 AM
0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/schedule-ritual.sh >> ~/Desktop/micro-experiments/cronlog.txt 2>> ~/Desktop/micro-experiments/cronerror.txt

# Backup ritual at 4:55 PM
55 16 * * 1-5 /bin/bash ~/Desktop/micro-experiments/ritual-safety-check.sh

🛑 Vacation Mode

To pause all rituals:

touch ~/Desktop/micro-experiments/vacation.flag

To resume:

rm ~/Desktop/micro-experiments/vacation.flag

🛠️ Manual Use & Diagnostics

Check Scheduled Rituals

atq

View What’s Scheduled:

at -c <job-number>

Run Ritual Manually:

bash ~/Desktop/micro-experiments/daily-square.sh

View Logs:

cat ~/Desktop/micro-experiments/cronlog.txt
cat ~/Desktop/micro-experiments/cronerror.txt

View Last Commit:

git log -1 --pretty=format:"%h - %s (%cr)"

☕ Prevent Mac From Sleeping (Optional but Important)

Install Amphetamine from Mac App Store

Or use:

sudo pmset repeat wakeorpoweron MTWRFSU 06:59:00

🗃 Notes Folder Structure (Required)

Your ritual script modifies one of these randomly:

notes/
├── scratch.js
├── logs.js
├── ideas.js
├── agorithms.js (typo intended)
├── square.js
├── garden.js
└── README.md

Keep these to preserve functionality.

🔄 Reset / Refresh Setup

You can re-run the installer if things break:

bash ~/Downloads/ritual-setup.sh

🔥 Disable Ritual

Temporarily:

Edit crontab and comment out the line:

# 0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/daily.sh

Permanently:

crontab -l | grep -v daily.sh | crontab -

🌈 You're Done

You're now protected by the ritual gods.
May your green squares flourish.

osascript -e 'display notification "✅ Ritual complete!" with title "GitHub Garden"'
say "The commit has been accepted. The algorithm smiles upon you."

