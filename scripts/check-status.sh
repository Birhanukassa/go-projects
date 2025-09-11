#!/bin/bash

# Quick status check for both worktrees

echo "🔍 Kubernetes Worktree Status Check"
echo "=================================="

# Check kubernetes worktree
echo "📁 kubernetes (master):"
cd kubernetes
echo "  Branch: $(git branch --show-current)"
echo "  Last commit: $(git log -1 --oneline)"
BEHIND_K=$(git rev-list --count HEAD..upstream/master 2>/dev/null || echo "unknown")
echo "  Behind upstream: $BEHIND_K commits"
echo

cd ..

# Check learning worktree  
echo "📁 learning (test-experiments):"
cd learning
echo "  Branch: $(git branch --show-current)"
echo "  Last commit: $(git log -1 --oneline)"
BEHIND_L=$(git rev-list --count HEAD..origin/master 2>/dev/null || echo "unknown")
echo "  Behind master: $BEHIND_L commits"
echo

cd ..

echo "💡 Run './sync-worktrees.sh' to sync both branches"