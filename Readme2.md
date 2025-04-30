# 🧙‍♂️ GitHub Green Square Ritual Setup for Jerod

This guide ensures that your GitHub contribution calendar stays green **every weekday** by running a ritual commit at a randomized time, with a failsafe check at the end of the day.

---

## 🔧 Step 1: Required Files
Place these files inside:
```bash
~/Desktop/micro-experiments/
```

- `schedule-ritual.sh` – schedules a random `at` job to run later
- `daily-square.sh` – does the actual commit, push, and visibility flip
- `ritual-safety-check.sh` – checks at 4:55 PM and runs the ritual if it failed

Make all scripts executable:
```bash
chmod +x ~/Desktop/micro-experiments/*.sh
```

---

## ⚙️ Step 2: Add These Cron Jobs
Edit your crontab:
```bash
crontab -e
```
Paste the following:
```bash
# Schedule ritual every weekday at 7:00 AM
0 7 * * * /bin/bash /Users/jerod/Desktop/micro-experiments/schedule-ritual.sh >> /Users/jerod/Desktop/micro-experiments/cronlog.txt 2>> /Users/jerod/Desktop/micro-experiments/cronerror.txt

# Failsafe backup ritual at 4:55 PM
55 16 * * * /bin/bash /Users/jerod/Desktop/micro-experiments/ritual-safety-check.sh
```

---

## ☕ Step 3: Prevent Sleep (Important!)
Your Mac **must be awake** for the ritual to run. Options:

- Install **Amphetamine** from the Mac App Store and set it to stay awake from 6:55 AM to 5:00 PM.
- Or, run this terminal command once:
```bash
sudo pmset repeat wakeorpoweron MTWRFSU 06:59:00
```

---

## ✅ Step 4: Confirm It's Working
Check the log:
```bash
tail ~/Desktop/micro-experiments/cronlog.txt
```

Check upcoming `at` jobs:
```bash
atq
```

Check today’s GitHub square:
- Visit [github.com/jerod](https://github.com/jerod)
- Hover over today’s contribution square

---

## 💬 Optional Bonus
Get an audio or popup notification by adding to `daily-square.sh`:
```bash
say "Your ritual has been offered to the Git gods."
osascript -e 'display notification "✅ Ritual complete!" with title "GitHub Garden"'
```

---

You’re now protected by the ritual gods. Green squares shall flourish. 🌱

