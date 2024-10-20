#!/bin/bash
# Written entirely by Stefan Botnari with proper documentation

#Starting the clamAV services
sudo systemctl start clamav-daemon
sudo systemctl start clamav-freshclam

# Getting the current directory in which to scan and the datetime required to create the log
CurrentDirectory=`pwd`
DateTime=`date +%d%m%y`

#Asking the user whether to log the results
echo "Would you like to log the scan?[yes/no]"
read UserDecisionlog
echo "Would you like to scan recursively?[yes/no]"
read UserDecisionRecurse

#if condition to see which version of the clamscan command to run
if [ UserDecisionlog==yes ];
then
  if [ UserDecisionRecurse==yes ];
  then
    clamscan -r --log=manualscan$DateTime.log $CurrentDirectory
  else
    clamscan --log=manualscan$DateTime.log $CurrentDirectory
  fi
else
  if [ UserDecisionRecurse==yes ];
  then
    clamscan -r $CurrentDirectory
  else
    clamscan $CurrentDirectory
  fi
fi

#Stopping the clamAV services
sudo systemctl stop clamav-daemon
sudo systemctl stop clamav-freshclam
sudo systemctl disable clamav-daemon.service
sudo systemctl disable clamav-freshclam.service
