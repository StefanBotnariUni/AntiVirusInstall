#!/bin/bash
LOG_DIR="/var/log"
NFS_DIR="/mnt/nfs/logs"
DATE=$(date +%Y-%m-%d)
tar -czf $NFS_DIR/logs_$DATE.tar.gz $LOG_DIR