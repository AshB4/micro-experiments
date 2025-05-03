# 🌿 GitHub Green Square Ritual

*Keep your contribution graph alive and your coder soul thriving.*

*Last updated: 2025-05-03*

---

## 🧙‍♂️ What This Is

This system automates daily GitHub contributions through a stylized "ritual"—flipping your repo public, making a micro-edit, pushing it, and flipping it private again. It logs success or failure and ensures you appear active on weekdays.

You can schedule randomized commit times, include a failsafe check at 4:55 PM, and even skip days with vacation mode.

---

## 🌟 PRO Version Includes

- Voice alerts (macOS `say`)
- On-screen notifications
- Extra commit message flavor (humorous + chaotic)
- Repo flip (public → private dance)
- GitHub gods chanting (no, seriously)

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
chmod +x ~/Desktop/micro-experiments/scripts/*.sh
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

## ⚙️ Cron Setup

Run:

```bash
crontab -e
```

Paste:

```cron
# 🌿 GitHub Green Square Ritual Cron Jobs

# Random ritual scheduler (runs at 7:00 AM Mon–Fri)
0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/scripts/schedule-ritual.sh >> ~/Desktop/micro-experiments/logs/cronlog.txt 2>> ~/Desktop/micro-experiments/logs/cronerror.txt

# Failsafe backup at 4:55 PM if nothing was committed
55 16 * * 1-5 /bin/bash ~/Desktop/micro-experiments/scripts/ritual-safety-check.sh
```

---
### Step 1: Open your crontab

```bash
crontab -e
```

### Step 2: Clean it up

❌ Remove or fix any broken lines, such as:

* Lines starting with `sudo`
* Any `-1>>` or malformed redirects
* Anything that’s not an actual cron job line

✅ Your crontab should match what’s shown above exactly.

### 🧽 How to Clean Up Bad Crontab Entries (Fixing Noob Oopsies)

If you accidentally pasted junk or broken lines (like `sudo` commands or weird redirection), here's how to fix it.

Step 1: Open your crontab

crontab -e

Step 2: Clean it up

🔚 Remove or fix any broken lines, such as:

Lines starting with sudo

Any -1>> or malformed redirects

Anything that’s not an actual cron job line

🔜 Your crontab should match what’s shown above exactly.

### ✅ How to Fix Crontab in vi

Use arrow keys to move the cursor to the line you want to delete(for example: the malformed -1>> line or duplicate cron jobs)

Press dd (yes, double "d") to delete the whole line

Repeat dd on all the extra/duplicate/broken lines

Type :wq then press Enter to save and exit

### ✅ How to Fix Crontab in nano

Use arrow keys to move the cursor to the bad line

Press Control + K to delete (cut) the whole line

Repeat Control + K on any other lines you want to delete

Press Control + X, then Y, then Enter to save and exit

### Step 3: Save and exit

If you're in `vi` or `vim`, type:

```
:wq
```

If you're in `nano`, press:

```
Control + X → Y → Enter
```

---

## ⏰ Set System Wake Time

This ensures your Mac wakes before the ritual starts. Run this **once** in the terminal:

```bash
sudo pmset repeat wakeorpoweron MTWRF 06:59:00
```

The `schedule-ritual.sh` script will dynamically add a second wake time for the randomized ritual.

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
# 0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/scripts/schedule-ritual.sh
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
