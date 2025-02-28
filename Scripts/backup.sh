#!/bin/bash
# Author: [KEMAL ERDEM CICEK]
# Description: Advanced Linux Backup Script with Logging, Date Format & Error Handling
# Tested on: Ubuntu 22.04.5 LTS

# ------------------- CONFIG -------------------
BACKUP_DIR="/home/$(whoami)/linux-backup-script/backups"          # Yedeklerin kaydedileceği klasör
SOURCE_DIR="/home/$(whoami)/linux-backup-script/important-files"  # Yedeklenecek kritik klasör
RETENTION_DAYS=7                             # Kaç günlük yedek tutulacak?
DATE_SUFFIX=$(date +"%Y-%m-%d_%H-%M-%S")     # Detaylı tarih formatı: "2024-01-05_14-30-00"
LOG_FILE="/var/log/backup_script.log"        # Log dosyası yolu

# ------------------- FUNCTIONS -------------------
log_message() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE"
}

# ------------------- SCRIPT START -------------------
# Log başlangıcı
log_message "=== Backup started ==="

# Klasör kontrolleri
if [ ! -d "$SOURCE_DIR" ]; then
  log_message "ERROR: Source directory ($SOURCE_DIR) not found!"
  exit 1
fi

mkdir -p "$BACKUP_DIR" || { log_message "ERROR: Failed to create backup directory!"; exit 1; }

# Yedekleme işlemi (Progress bar ile)
log_message "Compressing $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/backup_$DATE_SUFFIX.tar.gz" "$SOURCE_DIR" 2>&1 | while read line; do
  log_message "Progress: $line"
done

# Sıkıştırma başarılı mı?
if [ $? -ne 0 ]; then
  log_message "ERROR: Backup compression failed!"
  exit 1
fi

# Eski yedekleri temizleme
log_message "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +"$RETENTION_DAYS" -exec rm -fv {} \; | sudo tee -a "$LOG_FILE"

# Başarılı tamamlandı
log_message "Backup completed: $BACKUP_DIR/backup_$DATE_SUFFIX.tar.gz"
log_message "=== Backup finished ==="
