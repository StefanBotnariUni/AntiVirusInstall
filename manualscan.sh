#!/bin/bash
# Written entirely by Stefan Botnari with proper documentation

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