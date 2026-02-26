#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

echo "Setting up deployment user and directories..."

if ! id "webdeploy" >/dev/null 2>&1; then
    useradd -r -m -s /bin/bash webdeploy
fi

WEB_ROOT="/var/www/devops-site"
BACKUP_ROOT="/var/backups/devops-site"
SSL_DIR="/etc/nginx/ssl"
LOG_DIR="/var/log/nginx"

mkdir -p "$WEB_ROOT" "$BACKUP_ROOT" "$SSL_DIR"

chown -R webdeploy:webdeploy "$WEB_ROOT"
chown -R webdeploy:webdeploy "$BACKUP_ROOT"
chown -R webdeploy:webdeploy "$SSL_DIR"
chmod 755 "$WEB_ROOT"
chmod 700 "$BACKUP_ROOT"
chmod 700 "$SSL_DIR"

touch "$LOG_DIR/devops-site.access.log" "$LOG_DIR/devops-site.error.log"
chown webdeploy:adm "$LOG_DIR/devops-site.access.log" "$LOG_DIR/devops-site.error.log"
chmod 640 "$LOG_DIR/devops-site.access.log" "$LOG_DIR/devops-site.error.log"

mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
touch /etc/nginx/sites-available/devops-site
chown webdeploy:webdeploy /etc/nginx/sites-available/devops-site

echo "Setup complete. Please run subsequent scripts as the 'webdeploy' user."
