#!/bin/bash

# MySQL Credentials
MYSQL_USER="your_mysql_username"
MYSQL_PASS="your_mysql_password"
MYSQL_HOST="localhost"

# Backup Directory (ensure this directory exists)
BACKUP_DIR="/path/to/your/backup/directory"

# Email settings
EMAIL_TO="you@example.com"
EMAIL_SUBJECT="MySQL Backup Report - $(date +"%Y-%m-%d %H:%M:%S")"
EMAIL_BODY=""

# Get current date to append to backup filename
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Databases to back up (list the names of the databases you want to back up)
DATABASES=("db1" "db2" "db3")

# Loop through each database and back it up
for DB in "${DATABASES[@]}"; do
    BACKUP_FILE="$BACKUP_DIR/$DB_$DATE.sql"
    
    echo "Backing up database $DB to $BACKUP_FILE..."
    
    # Perform the backup using mysqldump
    mysqldump -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST $DB > $BACKUP_FILE
    
    # Check if the backup was successful
    if [ $? -eq 0 ]; then
        echo "Backup of $DB completed successfully!"
    else
        echo "Backup of $DB failed!"
    fi
done

# Clean up backups older than 30 days (optional)
find $BACKUP_DIR -type f -name "*.sql" -mtime +30 -exec rm -f {} \;

# Send email alert
echo -e "$EMAIL_BODY" | mail -s "$EMAIL_SUBJECT" "$EMAIL_TO"

# Sync backup to remote server (optional but recommended)

SSH_KEY="/path/to/your/private/key.pem"           # Path to your SSH private key
REMOTE_USER="your_remote_user"                    # Remote server username
REMOTE_HOST="your.remote.server.com"              # Remote server address
REMOTE_DIR="/path/on/remote/server"               # Target directory on remote server

rsync -avz \
  -e "ssh -i $SSH_KEY -o StrictHostKeyChecking=no" \
  --delete-after \
  "$BACKUP_DIR/" \
  "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
