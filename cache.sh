#!/bin/bash




#Only PageCache	echo 1 > /proc/sys/vm/drop_caches
#Only Dentries & Inodes	echo 2 > /proc/sys/vm/drop_caches
#All Caches	echo 3 > /proc/sys/vm/drop_caches


if [[ $EUID -ne 0 ]];then
    echo "Please use root user to run the script"
    exit 1
fi 

echo "Clearing cache......"

sync; echo 3 > /proc/sys/vm/drop_cahce

echo "cache are cleared ......."

free -mh

