#!/bin/bash

CRON_BKP="/var/tmp/crontabs"
EMAIL=xyz.k@gmail.com
LOG_FILE="/var/log/cron_Monitor.log"

check_crontab(){

    #Get the current crontab entries
    crontab -l 2>/dev/null > /var/spool/cron/crontab

    #check if the backup files are present or not.

    if [ ! -f "$CRON_BKP" ]; then
        cp /var/spool/cron/crontab "$CRON_BKP"
        echo "$(date): Inital crontab saved " | tee -a "$LOG_FILE"
        exit 0
    fi

    if ! diff -q /var/spool/cron/crontab "$CRON_BKP" >/dev/null; then
        echo "$(date): Crontab has been modified" | tee -a "$LOG_FILE"
        echo "Changes are :" | tee -a "$LOG_FILE"
        diff "$CRON_BKP" /var/spool/cront/crontab  | tee -a $LOG_FILE"

        echo "Crontab has been modified cehck the logs $LOG_FILE" | mail -s "Crontab Alert" "$EMAIL"

        #update the backup after changes
        cp /var/spool/cron/crontab "$CRON_BKP"
    else
        echo "$(date): No Cahnges detected" | tee -a "$LOG_FILE"
    fi
}


#Run the functions
check_crontab
