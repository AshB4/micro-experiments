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

# 📁 Check the ritual log
cat ~/Desktop/micro-experiments/cronlog.txt
