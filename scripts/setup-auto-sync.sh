#!/bin/bash

# Setup automatic local sync every hour
echo "Setting up automatic Kubernetes sync..."

SCRIPT_PATH="/home/birhanu/go-projects/local-sync-only.sh"
CRON_JOB="0 */12 * * * cd /home/birhanu/go-projects && bash local-sync-only.sh >> /tmp/k8s-sync.log 2>&1"

# Add to crontab
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "✅ Auto-sync setup complete!"
echo "📋 Your Kubernetes branches will sync with upstream every 12 hours"
echo "📝 Logs: /tmp/k8s-sync.log"
echo ""
echo "To check cron job: crontab -l"
echo "To remove: crontab -e (delete the line)"