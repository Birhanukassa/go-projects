#!/bin/bash

# Clean Sync Strategy for Kubernetes Development
# Keeps master pristine, development in test-experiments

set -e

echo "🧹 Clean Kubernetes Sync Strategy"
echo "================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

# 1. Sync master (keep pristine)
print_step "1. Syncing master branch (pristine upstream mirror)"
cd kubernetes

# Reset master to exactly match upstream
print_info "Fetching upstream..."
git fetch upstream

print_info "Hard reset master to upstream/master (removes any local changes)"
git checkout master
git reset --hard upstream/master

print_info "Force push to keep your fork's master clean"
git push origin master --force

cd ..

# 2. Update development branch
print_step "2. Updating test-experiments branch with latest changes"
cd learning

print_info "Fetching latest master..."
git fetch origin

# Rebase your work on clean master
print_info "Rebasing your experiments on clean master..."
git checkout test-experiments

if git rebase origin/master; then
    print_info "✅ Rebase successful - your changes preserved on latest code"
    
    # Optional: push with force-with-lease (safer than --force)
    read -p "Push updated test-experiments branch? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin test-experiments --force-with-lease
        print_info "✅ Pushed updated test-experiments"
    fi
else
    print_warn "⚠️  Rebase conflicts detected"
    echo "Options:"
    echo "  1. Resolve conflicts manually, then: git rebase --continue"
    echo "  2. Abort rebase: git rebase --abort"
    echo "  3. Skip problematic commit: git rebase --skip"
    exit 1
fi

cd ..

print_info "🎉 Clean sync completed!"
echo "📋 Summary:"
echo "  ✓ master: pristine copy of upstream/master"
echo "  ✓ test-experiments: your work rebased on latest master"