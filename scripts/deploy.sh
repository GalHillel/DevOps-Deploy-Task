#!/usr/bin/env bash
set -e

SRC_DIR="./site"
NGINX_CONF_SRC="./nginx/site-ssl.conf"
DEST_DIR="/var/www/devops-site"
NGINX_CONF_DEST="/etc/nginx/sites-available/devops-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/devops-site"
VERSION_FILE="$DEST_DIR/VERSION"
VERSION=$(date +"%Y%m%d%H%M%S")

echo "Starting deployment version: $VERSION"

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: site directory not found" >&2
    exit 1
fi

if [ -f "$NGINX_CONF_SRC" ]; then
    cp "$NGINX_CONF_SRC" "$NGINX_CONF_DEST"
    if [ ! -L "$NGINX_ENABLED" ]; then
        ln -sf "$NGINX_CONF_DEST" "$NGINX_ENABLED"
    fi
fi

cp -r "$SRC_DIR"/* "$DEST_DIR/"
echo "$VERSION" > "$VERSION_FILE"

if command -v systemctl >/dev/null 2>&1; then
    echo "Notice: NGINX reload requested"
else
    echo "Notice: NGINX -s reload requested"
fi

echo "Deployment successful. Version: $VERSION"
