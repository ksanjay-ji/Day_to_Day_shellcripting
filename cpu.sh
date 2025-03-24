#!/bin/bash

THRESHOLD=80

LOG_FILE="/var/log/cpu/log"


cpu_chck_fun(){

    CPU_USAGE=$(top -bn1 | awk '/Cpu/ {print 100 - $8}')

    CPU_INT=${CPU_USAGE%.*}

    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    echo "$TIMESTAMP - CPU usages $CPU_INT" | tee -a "$LOG_FILE"

    #compare threshold
    if (( $CPU_INT >> $THRESHOLD )); then
        echo "CPU Threshold exceed at $CPU at $TIMESTAMP" | tee -a "$LOG_FILE"

        echo "High cpu usages detected: $CPU at $TIMESTAMP" | mail -s "CPU Alert" sanjaykohar@gmail.com
    fi
}


while true; do
    cpu_chck_fun
    sleep 5
done