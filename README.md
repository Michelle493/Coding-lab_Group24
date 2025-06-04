## Table Of Centent
  *Project Overview
1) How to use it
2) Directory structure
3) Collaborators

# Hospital Data Monitoring, and achival system

 *Project Overview*
A Linux-based system use to;
1) Collect real-time patient health metrics and resource usage data
2) Provide controlled log archiving with user selection
3) Generate analytical reports with device statistics and temporal patterns

## How to use it

*Run device simulators*
 ```bash
   python3 heart_monitor.py start
   python3 temp_sensor.py start
   python3 water_meter.py start

        ./archive_logs.sh
        ./analyze_logs.sh
------------------------------------------------------------------------
Directory Structure
hospital_data/
  active_logs/
  heart_data_archive/
  temperature_data_archive/
  water_data_archive/
  reports/

Collaborators

Coding-lab_Group24
 1) Angel Umukundwa
 2) Hategekimana Eric
 3) Michelle Oluwayemisis Odusanwo
 4) Andrew Thon Riem Alier
