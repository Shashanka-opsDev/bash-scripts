#!/bin/bash

# Service Name
SERVICE="nginx"

# Log File
LOG_FILE="/var/log/service_monitor.log"

echo "Checking service status..." >> $LOG_FILE

# Check service status
systemctl is-active --quiet $SERVICE

if [ $? -ne 0 ]; then
    echo "$(date) : $SERVICE is DOWN. Restarting..." >> $LOG_FILE

    # Restart service
    systemctl restart $SERVICE

    # Verify restart
    systemctl is-active --quiet $SERVICE

    if [ $? -eq 0 ]; then
        echo "$(date) : $SERVICE restarted successfully." >> $LOG_FILE
    else
        echo "$(date) : Failed to restart $SERVICE." >> $LOG_FILE
    fi
else
    echo "$(date) : $SERVICE is running fine." >> $LOG_FILE
fi
