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

### Change `daily-square.sh`

```bash
REPO="AshB4/micro-experiments"  # 👈 CHANGE THIS to yourusername/your-repo-name
```

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

## 🚚 .command Launcher Script (fastest and easiest)

If you're not a terminal wizard, no worries:

1. Double-click `StartRitualSetup.command`
2. Enter your Mac password when prompted (needed for system wake scheduling)
3. Done. Your ritual is now automated and your Mac will wake itself.

Default location:

```bash
~/Desktop/micro-experiments/StartRitualSetup.command
```

---

## ⚙️ Cron Setup + Dual Wake Scheduling

Run:

```bash
crontab -e
```

Paste:

```bash
# 🌿 GitHub Green Square Ritual

# Morning trigger to randomize ritual
0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/scripts/schedule-ritual.sh >> ~/Desktop/micro-experiments/logs/cronlog.txt 2>> ~/Desktop/micro-experiments/logs/cronerror.txt

# Failsafe ritual at 4:55 PM
55 16 * * 1-5 /bin/bash ~/Desktop/micro-experiments/scripts/ritual-safety-check.sh

# System wake at 6:59 AM and backup at 4:54 PM
sudo pmset repeat wakeorpoweron MTWRF 06:59:00
sudo pmset schedule wakeorpoweron "$(date +\%Y-\%m-\%d) 16:54:00"
```

---

## 🚧 Vacation Mode

To pause all rituals:

```bash
touch ~/Desktop/micro-experiments/logs/vacation.flag
```

To resume:

```bash
rm ~/Desktop/micro-experiments/logs/vacation.flag
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
bash ~/Desktop/micro-experiments/scripts/daily-square.sh
```

### View Logs

```bash
cat ~/Desktop/micro-experiments/logs/cronlog.txt
cat ~/Desktop/micro-experiments/logs/cronerror.txt
```

### View Last Commit

```bash
git log -1 --pretty=format:"%h - %s (%cr)"
```

---

## ☕️ Prevent Mac From Sleeping (Optional but Important)

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
notes/
├── scratch.js
├── logs.js
├── ideas.js
├── agorithms.js   # typo intended because chaos
├── square.js
├── garden.js
└── README.md
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
# 0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/schedule-ritual.sh
```

### Permanently:

```bash
crontab -l | grep -v schedule-ritual.sh | crontab -
```

---

## 🌈 You’re Done

You’re now protected by the ritual gods. May your green squares flourish.

```bash
osascript -e 'display notification "✅ Ritual complete!" with title "GitHub Garden"'
say "The commit has been accepted. The algorithm smiles upon you."
```
