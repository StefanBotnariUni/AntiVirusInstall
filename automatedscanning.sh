#!/bin/bash
#Written entirely by Stefan Botnari with proper documentation and AI assistance

#Updating rkhunter and ClamAV
sudo rkhunter --update
sudo freshclam

#Starting the ClamAV services
sudo systemctl start clamav-daemon
sudo systemctl start clamav-freshclam

#Define log files and date
DateTime=`date +%d%m%y`
logdir="/var/log/scanlogs"
logfile="$logdir/securityscan$DateTime.log"

#Creating a log directory if it doesn't exist
mkdir -p "$logdir"

#Start new log file
echo "Security Scan Report: $DateTime" > "$logdir/securityscan$DateTime.log"
echo "CLAMAV RESULTS:" >> $logfile

#Scanning using clamscan (Written using AI companion)
# Prompt [give me a script that will only output the result of a clamav scan and only the infected files it found and add it to a file]
sudo clamscan -r -i --exclude-dir="^/proc" --exclude-dir="^/sys" --exclude-dir"^/dev" / 2>/dev/null | while read -r infected_file; do
    echo "Infected file: $infected_file" >> $logfile
one
#End of AI response
clam_exit=$?
case $clam_exit in
    0) echo "ClamAV Status: No infections found" >> "$logfile" ;;
    1) echo "ClamAV Status: Infections found" >> "$logfile" ;;
    2) echo "ClamAV Status: Scanner error occured" >> "$logfile" ;;
esac
#Scanning using rkhunter (Written using AI companion)
# Prompt [add one that does the same but for rkhunter]
echo -e "\nRKHUNTER RESULTS:" >> "$logfile"
sudo rkhunter --checkall --skip-keypress --quiet --no-report-warnings=none | \
    while read -r line; do
        if [[ $line == *"Warning"*]]; then
            echo "$line" >> "$logfile"
        fi
done
#End of AI response
rkhunter_exit=$?
case $rkhunter_exit in
    0) echo "rkhunter Status: System Clean" >> "$logfile" ;;
    1) echo "rkhunter Status: Warnings found" >> "$logfile" ;;
    2) echo "rkhunter Status: Error occured" >> "$logfile" ;;
esac

#Shutting down clamav services
sudo systemctl stop clamav-daemon
sudo systemctl stop clamav-freshclam
sudo systemctl disable clamav-daemon.service
sudo systemctl disable clamav-freshclam.service