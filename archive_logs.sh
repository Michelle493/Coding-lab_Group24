#!/bin/bash
#create a path variable
ACTIVE_LOGS="hospital_data/active_logs"
ARCHIVED_LOGS="hospital_data/archived_logs"
#prompt user to select file
echo "select log to archive: "
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter you choice(1-3)" user_input

#
if [ "$user_input" -eq 1 ]; then
	log=$ACTIVE_LOGS/heart_rate_log.log
	archived=$ARCHIVED_LOGS/heart_rate/heart_rate_"$(date +'Y%-%m-%d_%h:%m:%s')".log

elif [ "$user_input" -eq 2 ]; then
        log=$ACTIVE_LOGS/temperature_log.log
        archived=$ARCHIVED_LOGS/temperature/temperature__"$(date +'Y%-%m-%d_%h:%m:%s')".log

elif [ "$user_input" -eq 3 ]; then
        log=$ACTIVE_LOGS/water_usage_log.log
        archived=$ARCHIVED_LOGS/water_usage/water_usage_"$(date +'Y%-%m-%d_%h:%m:%s')".log
else
	echo "Invalid input"
	exit 1
fi

#then move the file to archive directory
echo "Archiving $log"

if [ -f "$log" ]; then
    mkdir -p "$(dirname "$archived")"
    mv "$log" "$archived"
    touch "$log"
    echo "Successfully archived to $archived"
else
    echo "File $log not found!"
    exit 2
fi
