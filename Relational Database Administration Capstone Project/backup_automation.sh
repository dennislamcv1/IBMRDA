#!/bin/bash

# === Configuration ===
DB_NAME="sales"
BACKUP_DIR="$HOME/db_backups"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
BACKUP_FILE="backup_${DB_NAME}_${TIMESTAMP}.gz"
RETENTION_DAYS=10

# === Ensure backup directory exists ===
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory does not exist. Creating: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# === Check if database exists ===
DB_EXISTS=$(mysql -u root -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep "${DB_NAME}")

if [ "$DB_EXISTS" != "$DB_NAME" ]; then
    echo "❌ Database '${DB_NAME}' does not exist. Backup aborted."
    exit 1
fi

# === Perform the backup ===
echo "Creating backup for database '${DB_NAME}'..."
mysqldump -u root "$DB_NAME" | gzip > "$BACKUP_DIR/$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "✔️ Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "❌ Backup failed!"
    exit 1
fi

# === Clean up old backups ===
echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "backup_${DB_NAME}_*.gz" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "✅ Done."
