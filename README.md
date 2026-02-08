# DevOps Static Website Deployment

Automated deployment with NGINX, SSL, and Backup/Rollback scripts.

## Setup
```sh
sudo ./scripts/setup.sh
sudo ./scripts/ssl_selfsign.sh
```

## Usage
- **Deploy**: `./scripts/deploy.sh`
- **Backup**: `./scripts/backup.sh`
- **Rollback**: `./scripts/roll-back.sh`
- **Health Check**: `./scripts/health_check.sh`

## Files
- `site/`: HTML content
- `nginx/`: NGINX configurations
- `scripts/`: Automation scripts
- `backups`: Stored in `/var/backups/devops-site`
