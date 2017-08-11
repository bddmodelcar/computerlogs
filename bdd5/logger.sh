#!/bin/bash
LOGDATE=$(date +%Y-%m[%b]-%d_%H:%M:%S)
cd /home/sauhaarda/working-directory/computerlogs/bdd5 # insert path here

PIDS=$(nvidia-smi | awk '$2$3 ~ /^[0-9]+$/{print $3}')
# Print GPU Users
echo "  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND" >> $LOGDATE
while read -r line; do
	top -n1 -b -p "$line" | tail -n 1 >> $LOGDATE
done <<< "$PIDS"

# Print GPU Statistics
nvidia-smi >> $LOGDATE
nvidia-smi -q -d UTILIZATION >> $LOGDATE

# Push to GitHub
git pull
git add -A
git commit -m "automated commit"
git push
