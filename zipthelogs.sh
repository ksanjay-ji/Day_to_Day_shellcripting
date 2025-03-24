#!/bin/bash

set -x
LOG_DIR="/var/logs/"
LOG_FILE=="/Users/sanjaykohar/go/src/shellscript/zip.log"

working_func(){
    #check if log directory present or not
    # if [ ! -f "$LOG_FILE" ]; then
    #     echo "No such file or directory .... Creating file $LOG_FILE"
    #     # touch /Users/sanjaykohar/go/src/shellscript/zip.log
    #     exit 1;
    if [ ! -d "$LOG_DIR" ];then
        echo "Directory not present on the server quiting the program" | tee -a $LOG_FILE
        exit 1;
    fi
    echo "$(date): Starting searching for file" | tee -a $LOG_FILE
    FILE=$(find $LOG_DIR -type f -name "usermanagerd.log.0")
    # cat $FILE
    zip -r "/Users/sanjaykohar/go/src/shellscript/user.zip" $FILE
    echo "$(date): - zip completed" | tee -a $LOG_FILE
}
working_func