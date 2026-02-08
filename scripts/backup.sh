#!/usr/bin/env bash
set -e

BACKUP_DIR="/var/backups/devops-site"
SRC="/var/www/devops-site"
TS=$(date +"%Y%m%d%H%M%S")

sudo mkdir -p "$BACKUP_DIR"

sudo tar czf "$BACKUP_DIR/site-$TS.tar.gz" -C "$SRC" .

# Keep last 5 backups
ls -1t "$BACKUP_DIR"/site-*.tar.gz | tail -n +6 | xargs -r sudo rm -f

echo "Backup created: site-$TS.tar.gz"
