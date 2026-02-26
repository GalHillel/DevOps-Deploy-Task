#!/usr/bin/env bash
set -e

BACKUP_DIR="/var/backups/devops-site"
SRC="/var/www/devops-site"
TS=$(date +"%Y%m%d%H%M%S")

mkdir -p "$BACKUP_DIR"

tar czf "$BACKUP_DIR/site-$TS.tar.gz" -C "$SRC" .

ls -1t "$BACKUP_DIR"/site-*.tar.gz 2>/dev/null | tail -n +6 | while read -r old_backup; do
    rm -f "$old_backup"
done

echo "Backup created: site-$TS.tar.gz"
