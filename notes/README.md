# 🔍 Check what time today's ritual is scheduled to run
atq

# 📜 See what the scheduled job will actually do
at -c <job-number>  # Replace <job-number> with the number from atq

# 🌱 Manually grow your green square (run this if you want it now)
bash ~/Desktop/micro-experiments/daily-square.sh

# ✅ Confirm the last commit went through
git log -1 --pretty=format:"%h - %s (%cr)"

# 🟩 Go to your GitHub profile and hover today’s square:
#    https://github.com/YOUR_USERNAME
#    You should see: "1 contribution on April 24"

# 📁 Check the log
cat ~/Desktop/micro-experiments/cronlog.txt


## 🛑 **How to Turn Off the Ritual (Temporarily or Permanently)**
 If you're taking a break or going off the grid 🏖️, you don’t want your GitHub looking like you're a workaholic bot 🤖.


### ✅ Option 1: **Turn Off – Comment It Out**
1. Run:
   ```bash
   crontab -e
   ```
2. Find the line that says:
   ```bash
   0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/daily.sh
   ```
3. Just **add a `#` at the start**:
   ```bash
   # 0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/daily.sh
   ```
4. Save and exit (`Ctrl+X`, then `Y`, then `Enter` if using nano)

✅ This keeps it in place for when you come back — just remove the `#` to turn it back on.

---

### 🔥 Option 2: **Turn Off – Full Uninstall**
If you’re like “yo, I’m out for the year” and want to nuke it:
```bash
crontab -l | grep -v daily.sh | crontab -
```

That deletes only the ritual line and keeps everything else in your crontab (if any).

---

### 🔁 How to Turn It Back On

1. Open your crontab again:
   ```bash
   crontab -e
   ```
2. Add the line back if you removed it:
   ```bash
   0 7 * * 1-5 /bin/bash ~/Desktop/micro-experiments/daily.sh
   ```
3. Save and exit.

Done. The ritual resumes on the next weekday.

---