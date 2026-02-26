#!/usr/bin/env bash

URL="https://localhost/health.html"

if curl -fsk "$URL" > /dev/null 2>&1; then
    echo "Site is healthy."
    exit 0
else
    echo "Site is UNHEALTHY or unreachable." >&2
    exit 1
fi
