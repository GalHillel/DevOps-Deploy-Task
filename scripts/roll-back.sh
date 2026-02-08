#!/usr/bin/env bash

set -e

BACKUP_DIR="/var/backups/devops-site"
DEST="/var/www/devops-site"

LAST_BACKUP=$(ls -1t "$BACKUP_DIR"/site-*.tar.gz | sed -n '2p')

[ -z "$LAST_BACKUP" ] && echo "No backup to rollback" && exit 1

sudo rm -rf "$DEST"
sudo tar xzf "$LAST_BACKUP" -C /

sudo systemctl reload nginx

echo "Rollback completed using $LAST_BACKUP"
