#!/bin/bash

                            # ----- phase 1: promp user to select log -----


#create variables for paths and timestamp

ACTIVE_LOGS="hospital_data/active_logs"
ARCHIVED_LOGS="hospital_data/archived_logs"

TIMESTAMP="$(date +'%Y-%m-%d_%H:%M:%S')"



#this commands, will prompt a user to select file
echo "Select log file to archive: "
echo "1) Heart Rate "
echo "2) Temperature "
echo "3) Water Usage "
read -p "Enter you choice(1/2/3): " user_input



#here, program will check if user input match the exist file
if [ "$user_input" -eq 1 ]; then
	log_file=$ACTIVE_LOGS/heart_rate_log.log
	archived_file=$ARCHIVED_LOGS/heart_rate/heart_rate_"$TIMESTAMP".log

elif [ "$user_input" -eq 2 ]; then
        log_file=$ACTIVE_LOGS/temperature_log.log
        archived_file=$ARCHIVED_LOGS/temperature/temperature_"$TIMESTAMP".log

elif [ "$user_input" -eq 3 ]; then
        log_file=$ACTIVE_LOGS/water_usage_log.log
        archived_file=$ARCHIVED_LOGS/water_usage/water_usage_"$TIMESTAMP".log
#if user intered something apart from expected(1,2, or 3), then it will print error and exit the program
else
	echo "Invalid input! Try again."
	exit 1
fi

                                  #----- phase 2: archive selected log and create new file -----


#this is message to tell user that $log is being archied
echo "Archiving "$log_file"..."
#then move the file to archive directory if exist. if it don't, creat it first and proced
if [ -f "$log_file" ]; then
    mkdir -p "$(dirname "$archived_file")"
    mv "$log_file" "$archived_file"
    touch "$log_file"
    echo "Successfully archived to $archived_file"

#if $log file not found, print an error and then exit the program
else
    echo "File $log_file not found!"
    exit 2
fi
