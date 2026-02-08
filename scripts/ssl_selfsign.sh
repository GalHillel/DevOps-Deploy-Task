#!/usr/bin/env bash

set -e

CERT_DIR="/etc/nginx/ssl"
CERT_KEY="$CERT_DIR/devops.key"
CERT_CRT="$CERT_DIR/devops.crt"

sudo mkdir -p "$CERT_DIR"

sudo openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$CERT_KEY" \
  -out "$CERT_CRT" \
  -subj "/CN=localhost"

sudo chmod 600 "$CERT_KEY"
