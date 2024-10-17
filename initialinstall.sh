#!/bin/bash
# Written entirely by Stefan Botnari with proper documentation

echo "Make sure you have sudo permissions on your machine"

#Running updates on system
echo "Performing update"
sudo apt-get update
sudo apt-get upgrade
echo "System is up to date!"

#Installing ClamAV
echo "installing ClamAV and it's daemon"
sudo apt-get install clamav clamav-daemon
echo "ClamAV installed"

#Updating ClamAV
echo "Stopping ClamAV services"
sudo systemctl stop clamav-freshclam.service
sudo systemctl stop clamav-daemon.service
echo "Services Stopped"
echo "Updating ClamAV signatures"
sudo freshclam
sudo systemctl start clamav-freshclam.service
sudo systemctl start clamav-daemon.service
echo "ClamAV updated and Services Restarted!"

#Installing rkHunter
echo "Installing rkhunter"
sudo apt-get install rkhunter
rm /etc/rkhunter.conf
cp rkhunter.conf /etc/
echo "Installed rkhunter"
sudo rkhunter --update
echo "Updated rkhunter"

echo "ClamAV and Rkhunter installed!"