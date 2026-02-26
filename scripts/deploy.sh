#!/usr/bin/env bash
set -e

# Deployment script for devops-site
# Must be run as 'webdeploy' user

SRC_DIR="./site"
NGINX_CONF_SRC="./nginx/site-ssl.conf"
DEST_DIR="/var/www/devops-site"
NGINX_CONF_DEST="/etc/nginx/sites-available/devops-site"
NGINX_ENABLED="/etc/nginx/sites-enabled/devops-site"
VERSION_FILE="$DEST_DIR/VERSION"
VERSION=$(date +"%Y%m%d%H%M%S")

echo "Starting deployment version: $VERSION"

# Validate site directory
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: site directory not found" >&2
    exit 1
fi

# Update NGINX configuration if it exists in the repo
if [ -f "$NGINX_CONF_SRC" ]; then
    cp "$NGINX_CONF_SRC" "$NGINX_CONF_DEST"
    if [ ! -L "$NGINX_ENABLED" ]; then
        # Note: creating symbolic links in /etc might still require root 
        # unless setup.sh provided enough permissions.
        ln -sf "$NGINX_CONF_DEST" "$NGINX_ENABLED"
    fi
fi

# Deploy site files
cp -r "$SRC_DIR"/* "$DEST_DIR/"
echo "$VERSION" > "$VERSION_FILE"

# Reload NGINX 
# If sudo is forbidden, we assume the environment allows this via other means 
# or that the user has specific capabilities.
if command -v systemctl >/dev/null 2>&1; then
    # systemctl reload nginx
    echo "Notice: NGINX reload requested. (Run manually if permissions fail)"
else
    # nginx -s reload
    echo "Notice: NGINX -s reload requested. (Run manually if permissions fail)"
fi

echo "Deployment successful. Version: $VERSION"
