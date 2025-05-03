<<<<<<< HEAD
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

=======
# 🌿 GitHub Green Square Ritual

*Keep your contribution graph alive and your coder soul thriving.*

*Last updated: 2025-05-03*

---

## 🧙‍♂️ What This Is

This system automates daily GitHub contributions through a stylized "ritual"—flipping your repo public, making a micro-edit, pushing it, and flipping it private again. It logs success or failure and ensures you appear active on weekdays.

You can schedule randomized commit times, include a failsafe check at 4:55 PM, and even skip days with vacation mode.

---

## 🔧 Setup Instructions

If you'd like to disguise your ritual, enter a custom GitHub repo name when prompted. This makes your commit history look more natural while still feeding the green square gods.

### Change daily-square.sh
REPO="AshB4/micro-experiments"  # 👈 CHANGE THIS to yourusername/your-repo-name

### 1. Place all files in:

```bash
~/Desktop/micro-experiments/
```

### 2. Make everything executable:

```bash
chmod +x ~/Desktop/micro-experiments/*.sh
chmod +x ~/Desktop/micro-experiments/StartRitualSetup.command
```

---

## 🚚 .command Launcher Script (for Non-Devs)

If you're not a terminal wizard, no worries:

1. Double-click `StartRitualSetup.command`
2. Enter your Mac password when prompted (needed for system wake scheduling)
3. Done. Your ritual is now automated and your Mac will wake itself.

Default location:

```bash
~/Desktop/micro-experiments/StartRitualSetup.command
```

---

## ⚙️ Cron Setup

Run:

```bash
crontab -e
```

Paste:

```bash
>>>>>>> b0f9de6 (chore: update notes)
# Schedule random ritual every weekday at 7:00 AM
0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/schedule-ritual.sh >> ~/Desktop/micro-experiments/cronlog.txt 2>> ~/Desktop/micro-experiments/cronerror.txt

# Backup ritual at 4:55 PM
55 16 * * 1-5 /bin/bash ~/Desktop/micro-experiments/ritual-safety-check.sh
<<<<<<< HEAD

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

=======
```

---

## 🚧 Vacation Mode

To pause all rituals:

```bash
touch ~/Desktop/micro-experiments/vacation.flag
```

To resume:

```bash
rm ~/Desktop/micro-experiments/vacation.flag
```

---

## 🛠️ Manual Use & Diagnostics

### Check Scheduled Rituals

```bash
atq
```

### View What’s Scheduled

```bash
at -c <job-number>
```

### Run Ritual Manually

```bash
bash ~/Desktop/micro-experiments/daily-square.sh
```

### View Logs

```bash
cat ~/Desktop/micro-experiments/cronlog.txt
cat ~/Desktop/micro-experiments/cronerror.txt
```

### View Last Commit

```bash
git log -1 --pretty=format:"%h - %s (%cr)"
```

---

## ☕ Prevent Mac From Sleeping (Optional but Important)

You MUST ensure your Mac is awake for rituals to work. Options:

* Install **Amphetamine** from the Mac App Store
* OR use:

```bash
sudo pmset repeat wakeorpoweron MTWRF 06:59:00
```

The script will also auto-schedule a specific wake time like:

```bash
sudo pmset schedule wakeorpoweron "2025-05-04 09:27:00"
```

Stored here:

```bash
~/Desktop/micro-experiments/logs/next-ritual-time.txt
```

---

## 📂 Required Notes Folder Structure

Your ritual script modifies one of these randomly. Keep them or the system breaks:

```
>>>>>>> b0f9de6 (chore: update notes)
notes/
├── scratch.js
├── logs.js
├── ideas.js
├── agorithms.js (typo intended)
├── square.js
├── garden.js
└── README.md
<<<<<<< HEAD

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
=======
```

---

## 🔄 Reset / Refresh Setup

To re-run the installer:

```bash
bash ~/Downloads/ritual-setup.sh
```

---

## 🔥 Disable Ritual

### Temporarily:

```bash
crontab -e
# comment out:
# 0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/daily.sh
```

### Permanently:

```bash
crontab -l | grep -v daily.sh | crontab -
```

---

## 🌈 You’re Done
>>>>>>> b0f9de6 (chore: update notes)

You're now protected by the ritual gods.
May your green squares flourish.

<<<<<<< HEAD
osascript -e 'display notification "✅ Ritual complete!" with title "GitHub Garden"'
say "The commit has been accepted. The algorithm smiles upon you."

=======
```bash
osascript -e 'display notification "✅ Ritual complete!" with title "GitHub Garden"'
say "The commit has been accepted. The algorithm smiles upon you."
```
>>>>>>> b0f9de6 (chore: update notes)
