#!/bin/bash

# Unified Sync Strategy - Keep Both Branches Always Synced
# Tests and experiments live in parent go-projects directory

set -e

echo "🔄 Unified Kubernetes Sync - Both Branches Always Current"
echo "========================================================"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

# Check we're in the right place
if [[ ! -d "kubernetes" || ! -d "learning" ]]; then
    echo "❌ Must be run from go-projects directory"
    exit 1
fi

print_step "1. Syncing kubernetes/ (master) with upstream"
cd kubernetes
git fetch upstream
git checkout master
git reset --hard upstream/master
print_info "✅ kubernetes/master synced with upstream"
cd ..

print_step "2. Syncing learning/ (test-experiments) with upstream" 
cd learning
git fetch upstream
git checkout test-experiments
git reset --hard upstream/master
print_info "✅ learning/test-experiments synced with upstream"
cd ..

print_step "3. Pushing both branches to your fork"
cd kubernetes
git push origin master --force
print_info "✅ Pushed kubernetes/master"
cd ..

cd learning  
git push origin test-experiments --force
print_info "✅ Pushed learning/test-experiments"
cd ..

print_info "🎉 Both worktrees now identical and current!"
echo "📋 Status:"
echo "  ✓ kubernetes/master = upstream/master"
echo "  ✓ learning/test-experiments = upstream/master" 
echo "  ✓ All your tests/experiments in go-projects/ preserved"
echo ""
echo "💡 Both branches are now identical - use either for development"