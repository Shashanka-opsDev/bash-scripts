#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=85

echo "System Health Check Started..."

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)

# Memory Usage
MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}' | cut -d'.' -f1)

# Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "CPU Usage: $CPU_USAGE%"
echo "Memory Usage: $MEM_USAGE%"
echo "Disk Usage: $DISK_USAGE%"

# Alerts
if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
    echo "ALERT: CPU usage is high!"
fi

if [ $MEM_USAGE -gt $MEM_THRESHOLD ]; then
    echo "ALERT: Memory usage is high!"
fi

if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "ALERT: Disk usage is high!"
fi

echo "Health check completed."
