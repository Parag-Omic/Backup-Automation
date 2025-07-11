#!/bin/bash

# === CONFIG ===
DEVICE_LIST="devices.txt"
BACKUP_DIR="backups"
LOG_FILE="backup_log.txt"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
EMAIL="you@example.com" # Optional email alert
# ==============

mkdir -p "$BACKUP_DIR"
echo " Backup started at $DATE" >> "$LOG_FILE"

while read -r line; do
    IP=$(echo $line | awk '{print $1}')
    USER=$(echo $line | awk '{print $2}')
    PASS=$(echo $line | awk '{print $3}')
    CMD_OR_PATH=$(echo $line | cut -d' ' -f4-)

    HOST_DIR="$BACKUP_DIR/$IP"
    mkdir -p "$HOST_DIR"

    echo " Backing up $IP..."

    if [[ "$CMD_OR_PATH" == /* ]]; then
        # Linux server file backup
        sshpass -p "$PASS" rsync -avz -e ssh --rsync-path="sudo rsync" "$USER@$IP:$CMD_OR_PATH" "$HOST_DIR/" &>> "$LOG_FILE"
    else
        # Network device config backup (Cisco/Juniper)
        sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no "$USER@$IP" "$CMD_OR_PATH" > "$HOST_DIR/config_$DATE.txt" 2>> "$LOG_FILE"
    fi

    echo " $IP backed up successfully at $DATE" >> "$LOG_FILE"

done < "$DEVICE_LIST"

# Compress all backups
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$BACKUP_DIR"/*/ &>> "$LOG_FILE"

# Optional Email Report
mail -s " Backup Completed: $DATE" "$EMAIL" < "$LOG_FILE"

echo " All backups completed and logged in $LOG_FILE"
