#!/bin/bash

LOG_FILE="/var/log/maintenance.log"


echo "===== Maintenance run at $(date '+%Y-%m-%d %H:%M:%S') =====" | sudo tee -a "$LOG_FILE"


sudo /home/ubuntu/log_rotate.sh /home/ubuntu/data /home/ubuntu/data_folder 2>&1 | sudo tee -a "$LOG_FILE"

sudo /home/ubuntu/backup.sh /home/ubuntu/data /home/ubuntu/backups 2>&1 | sudo tee -a "$LOG_FILE"

echo "===== End of run =====" | sudo tee -a "$LOG_FILE"