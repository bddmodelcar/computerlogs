#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGDATE=$(date +%Y-%m[%b]-%d_%H:%M:%S)
LOGDATE="$DIR/$LOGDATE.md"

# cd /home/sauhaarda/working-directory/computerlogs/bdd5 # insert path here

echo "# GPU Process top Output" >> $LOGDATE
echo "\`\`\`" >> $LOGDATE
PIDS=$(nvidia-smi | awk '$2$3 ~ /^[0-9]+$/{print $3}')
# Print GPU Users
echo "  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND" >> $LOGDATE
while read -r line; do
	top -n1 -b -p "$line" | tail -n 1 >> $LOGDATE
done <<< "$PIDS"
echo "\`\`\`" >> $LOGDATE

# Print GPU Statistics
echo "# NVIDIA SMI Output" >> $LOGDATE
echo "\`\`\`" >> $LOGDATE
nvidia-smi >> $LOGDATE
echo "\`\`\`" >> $LOGDATE

cd $DIR
# Push to GitHub
git pull
git add -A
git commit -m "automated commit"
