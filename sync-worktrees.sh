#!/bin/bash

# Kubernetes Worktree Sync Script
# Syncs both kubernetes (master) and learning (test-experiments) branches

set -e

echo "🔄 Starting Kubernetes worktree sync..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [[ ! -d "kubernetes" || ! -d "learning" ]]; then
    print_error "Must be run from go-projects directory with kubernetes and learning worktrees"
    exit 1
fi

# Sync kubernetes (master branch)
print_status "Syncing kubernetes worktree (master branch)..."
cd kubernetes

# Fetch latest from upstream
print_status "Fetching from upstream..."
git fetch upstream

# Check if there are changes
BEHIND=$(git rev-list --count HEAD..upstream/master)
if [[ $BEHIND -eq 0 ]]; then
    print_status "Master branch is already up to date"
else
    print_status "Master branch is $BEHIND commits behind upstream"
    
    # Merge upstream changes
    print_status "Merging upstream/master..."
    git merge upstream/master --no-edit
    
    print_status "Pushing to origin..."
    git push origin master
fi

cd ..

# Sync learning (test-experiments branch)
print_status "Syncing learning worktree (test-experiments branch)..."
cd learning

# Fetch latest changes
git fetch origin

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
if [[ "$CURRENT_BRANCH" != "test-experiments" ]]; then
    print_warning "Switching to test-experiments branch"
    git checkout test-experiments
fi

# Rebase on updated master
print_status "Rebasing test-experiments on updated master..."
if git rebase origin/master; then
    print_status "Rebase successful"
    
    # Push if no conflicts
    if git push origin test-experiments --force-with-lease; then
        print_status "Pushed test-experiments branch"
    else
        print_warning "Push failed - check for conflicts or force push needed"
    fi
else
    print_error "Rebase failed - manual conflict resolution needed"
    print_warning "Run 'git rebase --abort' to cancel or resolve conflicts manually"
    exit 1
fi

cd ..

print_status "✅ Worktree sync completed successfully!"
print_status "📊 Summary:"
echo "  - kubernetes (master): synced with upstream"
echo "  - learning (test-experiments): rebased on updated master"