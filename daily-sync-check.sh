#!/bin/bash

# Daily Sync Check - Ensure all branches are synced with upstream
# Run this daily to keep everything in sync

set -e

echo "🔄 Daily Kubernetes Sync Check"
echo "=============================="

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

# Check if we're in the right directory
if [ ! -d "/home/birhanu/go-projects/kubernetes" ]; then
    echo -e "${RED}❌ Not in go-projects directory${NC}"
    exit 1
fi

cd /home/birhanu/go-projects

echo -e "${YELLOW}📡 Syncing with upstream...${NC}"

# Sync kubernetes worktree (master branch)
echo "🏠 Syncing kubernetes/ (master)..."
cd kubernetes
git fetch upstream
git checkout master
git reset --hard upstream/master
git push --force origin master
print_status $? "Kubernetes master synced"

# Sync learning worktree (test-experiments branch)  
echo "🧪 Syncing learning/ (test-experiments)..."
cd ../learning

# Check if experiments are paused
if [ -f "/tmp/pause-experiments" ]; then
    echo "⏸️ Experiments paused - skipping test-experiments sync"
else
    git fetch upstream
    git checkout test-experiments
    git reset --hard upstream/master
    git push --force origin test-experiments
    print_status $? "Learning test-experiments synced"
fi

# Back to parent directory
cd ..

echo ""
echo -e "${YELLOW}📊 Sync Status Summary:${NC}"

# Check kubernetes status
cd kubernetes
BEHIND_K=$(git rev-list --count HEAD..upstream/master 2>/dev/null || echo "0")
if [ "$BEHIND_K" -eq 0 ]; then
    echo -e "${GREEN}✅ kubernetes/master: In sync${NC}"
else
    echo -e "${RED}❌ kubernetes/master: $BEHIND_K commits behind${NC}"
fi

# Check learning status  
cd ../learning
BEHIND_L=$(git rev-list --count HEAD..upstream/master 2>/dev/null || echo "0")
if [ "$BEHIND_L" -eq 0 ]; then
    echo -e "${GREEN}✅ learning/test-experiments: In sync${NC}"
else
    echo -e "${RED}❌ learning/test-experiments: $BEHIND_L commits behind${NC}"
fi

cd ..

echo ""
echo -e "${GREEN}🎉 Daily sync complete!${NC}"
echo "📅 Last synced: $(date)"
echo "📝 Log: /tmp/daily-sync.log"

# Log the sync
echo "$(date): Daily sync completed successfully" >> /tmp/daily-sync.log