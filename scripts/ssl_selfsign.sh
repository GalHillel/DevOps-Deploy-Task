#!/usr/bin/env bash
set -e

CERT_DIR="/etc/nginx/ssl"
CERT_KEY="$CERT_DIR/devops.key"
CERT_CRT="$CERT_DIR/devops.crt"

# ensure directory exists
if [ ! -d "$CERT_DIR" ]; then
    echo "Error: $CERT_DIR does not exist. Run setup.sh first." >&2
    exit 1
fi

if [ -f "$CERT_KEY" ] && [ -f "$CERT_CRT" ]; then
    echo "Certificates already exist at $CERT_DIR"
    exit 0
fi

echo "Generating self-signed SSL certificate..."
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$CERT_KEY" \
  -out "$CERT_CRT" \
  -subj "/CN=localhost" 2>/dev/null

chmod 600 "$CERT_KEY"
echo "SSL Certificates generated successfully at $CERT_DIR"
