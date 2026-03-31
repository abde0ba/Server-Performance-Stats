# Server Performance Stats

Project URL: https://roadmap.sh/projects/server-stats

A lightweight Bash script to quickly view key Linux server metrics from the terminal.

## Features

The script prints:

- CPU usage (calculated from `/proc/stat`)
- Memory usage (`free`)
- Total disk usage (`df --total`)
- Top 5 processes by CPU
- Top 5 processes by memory
- Basic system info:
  - OS and kernel version
  - Uptime and load average
  - Number of logged-in users

## Files

- `server-stats.sh` - Main script
- `Dockerfile` - Run the script in a Debian container

## Requirements

- Linux environment with:
  - `bash`
  - `procps` (for `ps`)
  - `coreutils` tools like `df`, `who`, `uptime`

Note: This script reads Linux `/proc` data, so it is intended for Linux systems (or WSL on Windows).

## Run Locally

1. Clone the repository:

```bash
git clone https://github.com/abde0ba/Server-Performance-Stats
cd Server-Performance-Stats
```

2. Make the script executable:

```bash
chmod +x server-stats.sh
```

3. Run the script:

```bash
./server-stats.sh
```

## Run with Docker

Build the image:

```bash
docker build -t server-stats .
```

Run the container:

```bash
docker run --rm server-stats
```

## Example Output

```text
CPU Usage: 17%
Memory usage: Used: 62.41% | Available: 35.82%
Disk usage: Used: 71.26% | Free: 28.74%
===== Top 5 Processes by CPU =====
  PID COMMAND         %CPU %MEM
  ...
===== Top 5 Processes by Memory =====
  PID COMMAND         %CPU %MEM
  ...
===== System Info =====
OS: Linux 6.8.0
Uptime: 14:20:11 up 3 days,  2:08,  2 users,  load average: 0.42, 0.34, 0.29
Load Average:  0.42, 0.34, 0.29
Logged in users: 2
```

## Optional: Add Alias

To run it quickly, add an alias:

```bash
alias server-stats="$PWD/server-stats.sh"
```

Then run:

```bash
server-stats
```