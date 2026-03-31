#!/bin/bash
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total1=$((user + nice + system + idle + iowait + irq + softirq))
idle1=$((idle + iowait))

sleep 1

read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total2=$((user + nice + system + idle + iowait + irq + softirq))
idle2=$((idle + iowait))

total_diff=$((total2 - total1))
idle_diff=$((idle2 - idle1))

usage=$((100 * (total_diff - idle_diff) / total_diff))

# show cpu usage
echo "CPU Usage: $usage%"

# show memory usage
free | awk '/Mem:/ {printf "Memory usage: Used: %.2f%% | Available: %.2f%%\n", $3/$2*100, $7/$2*100}'

# show total disk usage
df --total -B1 -x tmpfs -x devtmpfs | awk 'END {
  total=$2; used=$3; free=$4;
  printf "Disk usage: Used: %.2f%% | Free: %.2f%%\n",
  (used/total)*100, (free/total)*100
}'

# show top 5 processes by CPU usage
echo "===== Top 5 Processes by CPU ====="
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# show top 5 processes by MEM usage
echo "===== Top 5 Processes by Memory ====="
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

# show system info
echo "===== System Info ====="
echo "OS: $(uname -s) $(uname -r)"
echo "Uptime: $(uptime)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged in users: $(who | wc -l)"