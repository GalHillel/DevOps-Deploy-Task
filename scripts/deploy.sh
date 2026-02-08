#!/usr/bin/env bash

set -e

SRC_DIR="$(pwd)/site"
DEST_DIR="/var/www/devops-site"
VERSION_FILE="$DEST_DIR/VERSION"
VERSION=$(date +"%Y%m%d%H%M%S")

sudo cp -r "$SRC_DIR"/* "$DEST_DIR"

echo "$VERSION" | sudo tee "$VERSION_FILE" > /dev/null

sudo nginx -t
sudo systemctl reload nginx

echo "Deployment successful. Version: $VERSION"
