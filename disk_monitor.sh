#!/bin/bash

# Threshold percentage
THRESHOLD=80

# Log file
LOG_FILE="/var/log/disk_monitor.log"

echo "Disk Space Monitoring Started..." >> $LOG_FILE

# Get disk usage
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "$(date) : Current Disk Usage = $USAGE%" >> $LOG_FILE

# Check threshold
if [ $USAGE -gt $THRESHOLD ]; then
    echo "$(date) : ALERT! Disk usage exceeded $THRESHOLD%" >> $LOG_FILE
else
    echo "$(date) : Disk usage is under control." >> $LOG_FILE
fi

echo "Monitoring completed." >> $LOG_FILE
