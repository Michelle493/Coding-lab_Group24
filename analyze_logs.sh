#!/bin/bash
# Define log file paths
HEART_RATE_LOG="hospital_data/active_logs/heart_rate.log"
TEMPERATURE_LOG="hospital_data/active_logs/temperature.log"
WATER_USAGE_LOG="hospital_data/active_logs/water_usage.log"
ANALYSIS_REPORT="reports/analysis_report.txt"

# Function to display the menu and get user choice
display_menu() {
    echo ""
    echo "Select log file to analyze:"
    echo "1) Heart Rate ($HEART_RATE_LOG)"
    echo "2) Temperature ($TEMPERATURE_LOG)"
    echo "3) Water Usage ($WATER_USAGE_LOG)"
    echo -n "Enter choice (1-3): "
}

# Main script logic
while true; do
    display_menu
    read choice

    case $choice in
        1)
            LOG_FILE=$HEART_RATE_LOG
            LOG_NAME="Heart Rate"
            break
            ;;
        2)
            LOG_FILE=$TEMPERATURE_LOG
            LOG_NAME="Temperature"
            break
            ;;
        3)
            LOG_FILE=$WATER_USAGE_LOG
            LOG_NAME="Water Usage"
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 3."
            ;;
    esac
done

echo ""
echo "Analyzing $LOG_NAME log file: $LOG_FILE"

# --- Analysis functionality will go here ---

# --- Reporting functionality will go here ---

echo "Analysis complete. Results appended to $ANALYSIS_REPORT"
# Check if the log file exists before proceeding
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found." | tee -a "$ANALYSIS_REPORT"
    exit 1
fi

echo "--- Analysis Report for $LOG_NAME ($LOG_FILE) ---" | tee -a "$ANALYSIS_REPORT"
echo "Generated on: $(date)" | tee -a "$ANALYSIS_REPORT"
echo "" | tee -a "$ANALYSIS_REPORT"

# Use awk to process the log file
# It extracts the device, counts occurrences, and finds first/last timestamps.

awk '{
    # $2 is the DEVICE
    device = $2
    timestamp = $1

    if (!(device in count)) {
        count[device] = 0;
        first_ts[device] = timestamp;
    }
    count[device]++;
    last_ts[device] = timestamp;
}
END {
    print "Device | Total Count | First Entry Timestamp | Last Entry Timestamp"
    print "-------|-------------|-----------------------|---------------------"
    for (dev in count) {
        printf "%-6s | %-11s | %-21s | %-20s\n", dev, count[dev], first_ts[dev], last_ts[dev]
    }
}' "$LOG_FILE" | tee -a "$ANALYSIS_REPORT"

echo "" | tee -a "$ANALYSIS_REPORT"
echo "--- End of Report ---" | tee -a "$ANALYSIS_REPORT"
echo "" | tee -a "$ANALYSIS_REPORT"
