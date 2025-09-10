#!/bin/bash

# LOCAL SYNC ONLY - Never Push to Upstream
# Keeps local branches current with upstream 24/7
# For PRs: create new branches separately

set -e

echo "🔄 Local-Only Sync - Keep Current with Upstream"
echo "=============================================="

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_info() { echo -e "${GREEN}[SYNC]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_safe() { echo -e "${RED}[SAFE]${NC} $1"; }

print_safe "🛡️  LOCAL SYNC ONLY - NO UPSTREAM PUSHES"
print_warn "For PRs: create new branch with 'git checkout -b feature-name'"

# Sync kubernetes/master
print_info "Syncing kubernetes/master with upstream..."
cd kubernetes

git fetch upstream
git checkout master
git reset --hard upstream/master

print_info "✅ kubernetes/master synced with upstream"
print_safe "🚫 NOT pushing to origin (your fork)"

cd ..

# Sync learning/test-experiments  
print_info "Syncing learning/test-experiments with upstream..."
cd learning

git fetch upstream  
git checkout test-experiments
git reset --hard upstream/master

print_info "✅ learning/test-experiments synced with upstream"
print_safe "🚫 NOT pushing to origin (your fork)"

cd ..

print_info "🎉 Local sync completed!"
echo ""
echo "📋 Status:"
echo "  ✅ kubernetes/master = upstream/master (local only)"
echo "  ✅ learning/test-experiments = upstream/master (local only)"
echo "  🔒 Your fork remains unchanged"
echo ""
echo "💡 To contribute:"
echo "  1. cd kubernetes (or learning)"
echo "  2. git checkout -b my-feature-branch"
echo "  3. Make changes and commit"
echo "  4. git push origin my-feature-branch"
echo "  5. Create PR from your fork to kubernetes/kubernetes"