#!/usr/bin/env bash
set -e

SRC_DIR="$(pwd)/site"
NGINX_CONF="$(pwd)/nginx/site-ssl.conf"
DEST_DIR="/var/www/devops-site"
VERSION_FILE="$DEST_DIR/VERSION"
VERSION=$(date +"%Y%m%d%H%M%S")

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: site directory not found"
    exit 1
fi

if [ -f "$NGINX_CONF" ]; then
    sudo cp "$NGINX_CONF" /etc/nginx/sites-available/devops-site
    if [ ! -f /etc/nginx/sites-enabled/devops-site ]; then
        sudo ln -s /etc/nginx/sites-available/devops-site /etc/nginx/sites-enabled/
    fi
    if [ -f /etc/nginx/sites-enabled/default ]; then
        sudo rm /etc/nginx/sites-enabled/default
    fi
fi

sudo nginx -t

sudo cp -r "$SRC_DIR/"* "$DEST_DIR/"
echo "$VERSION" | sudo tee "$VERSION_FILE" > /dev/null

sudo chown -R webdeploy:webdeploy "$DEST_DIR"

sudo systemctl reload nginx

echo "Deployment successful. Version: $VERSION"
