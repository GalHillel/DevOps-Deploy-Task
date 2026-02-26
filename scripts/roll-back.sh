#!/usr/bin/env bash
set -e


BACKUP_DIR="/var/backups/devops-site"
DEST="/var/www/devops-site"

LAST_BACKUP=$(ls -1t "$BACKUP_DIR"/site-*.tar.gz 2>/dev/null | sed -n '2p')

if [ -z "$LAST_BACKUP" ]; then
    echo "Error: No previous backup found to rollback to." >&2
    exit 1
fi

echo "Rolling back to: $LAST_BACKUP"

rm -rf "${DEST:?}"/*
tar xzf "$LAST_BACKUP" -C "$DEST"

echo "Rollback completed. (NGINX reload may be required manually if permissions fail)"
