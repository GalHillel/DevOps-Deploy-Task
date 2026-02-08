#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

if ! id "webdeploy" >/dev/null 2>&1; then
    useradd -r -s /bin/false webdeploy
fi

mkdir -p /var/www/devops-site
chown -R webdeploy:webdeploy /var/www/devops-site
chmod -R 755 /var/www/devops-site

mkdir -p /var/log/nginx
touch /var/log/nginx/devops-site.access.log
touch /var/log/nginx/devops-site.error.log
chown -R webdeploy:webdeploy /var/log/nginx/devops-site.*
