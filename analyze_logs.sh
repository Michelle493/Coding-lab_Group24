#!/bin/bash


                                # part 1: user interactive Prompt
			  #-------------------------------------------	




# creating variables for file paths

HEART_RATE_LOG="hospital_data/active_logs/heart_rate.log"
TEMPERATURE_LOG="hospital_data/active_logs/temperature.log"
WATER_USAGE_LOG="hospital_data/active_logs/water_usage.log"
ANALYSIS_REPORT="hospital_data/reports/analysis_report.txt"


# this function is aim to display the menu, but it don't really do anything(just to display choice)

display_menu() {
    echo ""
    echo "Select log file to analyze:"
    echo "1) Heart Rate ($HEART_RATE_LOG)"
    echo "2) Temperature ($TEMPERATURE_LOG)"
    echo "3) Water Usage ($WATER_USAGE_LOG)"
    echo -n "Enter choice (1-3): "
    echo ""
}


# here is a function that will let user select one the displayed choice

while true; do
    display_menu
    read choice

    case $choice in
        1)
            LOG_FILES=$HEART_RATE_LOG
            LOG_NAME="Heart Rate"
            break
            ;;
        2)
            LOG_FILES=$TEMPERATURE_LOG
            LOG_NAME="Temperature"
            break
            ;;
        3)
            LOG_FILES=$WATER_USAGE_LOG
            LOG_NAME="Water Usage"
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 3."
            ;;
    esac
done

echo ""


                                       # part 2: anlysis functionality
				    #-----------------------------------
   


echo ""
echo "Analyzing $LOG_NAME log file: $LOG_FILES"


#checking if we arleady have $ANALYSIS REPORT file. if not exist, then create it

if [ ! -f "$ANALYSIS_REPORT" ]; then
	touch hospital_data/reports/analysis_report.txt
fi

# from this part, everything we do, will be saved into $ANALYSIS REPORT file(including "echo" messages)

# this code block is for checking if the log file exists before proceeding other commands
if [ ! -f "$LOG_FILES" ]; then
    echo "Error: Log file '$LOG_FILES' not found." | tee -a "$ANALYSIS_REPORT"
    exit 1
fi
{
# if file exist, then we print echo for the user that analysis proccess has started
echo "--- Analysis Report for $LOG_NAME ($LOG_FILES) ---"
echo "Generated on: "$(date +'%Y-%m-%d_%H:%M:%S')""
echo ""
# Use awk to process the log file
# It extracts the device, counts occurrences, and finds first/last timestamps.

echo "---------- $LOG_NAME analysis -------" 
echo ""
echo "Counts of accurrances for each Device"
echo "-------------------------------------"
echo ""
awk '{print $3}' "$LOG_FILES" | sort | uniq -c
echo "Fist recorded entry:"
head -n 1 $LOG_FILES
echo ""
echo "Last recorded entry:"
tail -n 1 $LOG_FILES
echo ""
echo ""
echo "--- End of Report ---"
echo ""
echo ""
echo ""
echo ""
} | tee -a "$ANALYSIS_REPORT"
