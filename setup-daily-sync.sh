#!/bin/bash

# Setup Daily Sync - Add to cron and shell startup

echo "🔧 Setting up daily sync automation..."

# Add to cron (runs every day at 8 AM)
(crontab -l 2>/dev/null; echo "0 8 * * * cd /home/birhanu/go-projects && ./daily-sync-check.sh >> /tmp/daily-sync.log 2>&1") | crontab -

# Add to .zshrc for terminal startup check
if ! grep -q "daily-sync-check" ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# Daily sync check on terminal startup (once per day)
SYNC_CHECK_FILE="/tmp/last-sync-check"
if [ ! -f "$SYNC_CHECK_FILE" ] || [ $(find "$SYNC_CHECK_FILE" -mtime +1 2>/dev/null) ]; then
    echo "🔄 Running daily sync check..."
    cd /home/birhanu/go-projects && ./daily-sync-check.sh
    touch "$SYNC_CHECK_FILE"
fi
EOF
fi

echo "✅ Daily sync automation setup complete!"
echo ""
echo "📋 What's configured:"
echo "  • Cron job: Runs daily at 8 AM"
echo "  • Terminal startup: Checks once per day when you open terminal"
echo "  • Manual run: ./daily-sync-check.sh"
echo ""
echo "🔄 To test now: ./daily-sync-check.sh"