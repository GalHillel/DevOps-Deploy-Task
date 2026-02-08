#!/usr/bin/env bash
set -e

BACKUP_DIR="/var/backups/devops-site"
DEST="/var/www/devops-site"

LAST_BACKUP=$(ls -1t "$BACKUP_DIR"/site-*.tar.gz | sed -n '2p')

if [ -z "$LAST_BACKUP" ]; then
    echo "No previous backup found to rollback to."
    exit 1
fi

echo "Rolling back to: $LAST_BACKUP"

sudo rm -rf "${DEST:?}"/*
sudo tar xzf "$LAST_BACKUP" -C "$DEST"

sudo chown -R webdeploy:webdeploy "$DEST"
sudo systemctl reload nginx

echo "Rollback completed."
