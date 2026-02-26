#!/usr/bin/env bash
set -e

# Backup script for devops-site
# Must be run as 'webdeploy' user

BACKUP_DIR="/var/backups/devops-site"
SRC="/var/www/devops-site"
TS=$(date +"%Y%m%d%H%M%S")

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create timestamped backup
tar czf "$BACKUP_DIR/site-$TS.tar.gz" -C "$SRC" .

# Keep last 5 backups
# POSIX compliant way to list, sort by time, skip first 5, and remove
ls -1t "$BACKUP_DIR"/site-*.tar.gz 2>/dev/null | tail -n +6 | while read -r old_backup; do
    rm -f "$old_backup"
done

echo "Backup created: site-$TS.tar.gz"
