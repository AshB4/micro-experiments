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


### 🚀 Ritual Setup (Zero Terminal Required)

- Just double-click the setup file:
- Open the folder where you unzipped the ritual
- Double-click StartRitualSetup.command
- Enter your GitHub username and repo name when prompted
- Approve your Mac password when asked (needed for system wake scheduling)

That’s it — the ritual now runs automatically

🪄 No terminal magic required. It sets up everything — wake times, crontab jobs, commit automation, and logs.

### Set Up Repo Info (Automatic)

When you run the setup, it will ask for:

1. Your GitHub username  
2. The name of the repo you want to use

It will automatically update your settings inside `daily-square.sh`, no editing required.

### 1. Unzip Anywhere

Unzip the folder wherever you'd like — it works from any directory. No need to use `Desktop`.

Just make sure you keep all folders together (especially `scripts/` and `logs/`).


### 2. Make everything executable:
# From inside the ritual folder
chmod +x scripts/*.sh
chmod +x StartRitualSetup.command

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
0 7 * * 1-5 /bin/bash /path/to/your/ritual-folder/scripts/schedule-ritual.sh >> /path/to/your/ritual-folder/logs/cronlog.txt 2>> /path/to/your/ritual-folder/logs/cronerror.txt

# Failsafe backup at 4:55 PM if nothing was committed
55 16 * * 1-5 /bin/bash /path/to/your/ritual-folder/scripts/ritual-safety-check.sh

---
> 💡 Tip: You can get the full path by dragging your ritual folder into the Terminal window.


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

## ⏰ System Wake Scheduling (Handled Automatically)

When you run `StartRitualSetup.command`, your Mac will be set to wake up automatically before your ritual.

### 💡 Already included:
- A **daily wake** at `06:59 AM` (Mon–Fri)
- A **randomized ritual time** later that morning
- A **failsafe wake** at `4:54 PM` in case your Mac was sleeping earlier

You *do not* need to run this manually unless something breaks.

---

If needed, you can manually re-run this:

```bash
sudo pmset repeat wakeorpoweron MTWRF 06:59:00
---

### ✅ Bonus: Mention re-canceling (advanced users)

```md
To remove wake timers:
```bash
sudo pmset repeat cancel
sudo pmset schedule cancel

---

## 🚧 Vacation Mode

Need a break? You can pause your ritual at any time.

To **pause** all activity:

```bash
touch /path/to/your/ritual-folder/logs/vacation.flag


To resume:

```bash
rm /path/to/your/ritual-folder/logs/vacation.flag
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
bash /path/to/your/ritual-folder/scripts/daily-square.sh
```

### View Logs

```bash
cat /path/to/your/ritual-folder/logs/cronlog.txt
cat /path/to/your/ritual-folder/logs/cronerror.txt
```

### View Last Commit

```bash
git log -1 --pretty=format:"%h - %s (%cr)"
```

---

## ☕️ Prevent Mac From Sleeping (Optional but Important)

✅ The setup script already schedules wake times.
But if you need to do it manually:

```bash
sudo pmset repeat wakeorpoweron MTWRF 06:59:00
```

The script will also auto-schedule a specific wake time like:

```bash
sudo pmset schedule wakeorpoweron "2025-05-04 09:27:00"

```

Stored here:

```bash
/path/to/your/ritual-folder/logs/next-ritual-time.txt
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
# 0 7 * * 1-5 /bin/bash /path/to/your/ritual-folder/scripts/schedule-ritual.sh
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
