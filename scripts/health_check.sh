#!/usr/bin/env bash
if curl -fsk https://localhost/health.html > /dev/null; then
    exit 0
else
    exit 1
fi
