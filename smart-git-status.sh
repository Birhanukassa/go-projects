#!/bin/bash

# Smart Git Status - Shows git status for current directory context
# Add this to your .zshrc for automatic git status on directory change

smart_git_status() {
    local current_dir=$(pwd)
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "📁 Not in a git repository"
        return
    fi
    
    # Get repository root and name
    local git_root=$(git rev-parse --show-toplevel)
    local repo_name=$(basename "$git_root")
    local branch=$(git branch --show-current)
    
    # Determine context
    case "$current_dir" in
        */go-projects/kubernetes*)
            echo "🏠 kubernetes (main) - branch: $branch"
            ;;
        */go-projects/learning*)
            echo "🧪 learning (experiments) - branch: $branch"
            ;;
        */go-projects)
            echo "📦 go-projects (parent) - branch: $branch"
            ;;
        *)
            echo "📁 $repo_name - branch: $branch"
            ;;
    esac
    
    # Show compact status
    local status=$(git status --porcelain)
    if [[ -n "$status" ]]; then
        local modified=$(echo "$status" | grep "^ M" | wc -l)
        local added=$(echo "$status" | grep "^A" | wc -l)
        local untracked=$(echo "$status" | grep "^??" | wc -l)
        
        echo -n "📊 "
        [[ $modified -gt 0 ]] && echo -n "Modified: $modified "
        [[ $added -gt 0 ]] && echo -n "Added: $added "
        [[ $untracked -gt 0 ]] && echo -n "Untracked: $untracked "
        echo
    else
        echo "✅ Working tree clean"
    fi
    
    # Show sync status with upstream (if exists)
    if git remote | grep -q upstream; then
        local behind=$(git rev-list --count HEAD..upstream/$(git branch --show-current) 2>/dev/null || echo "0")
        local ahead=$(git rev-list --count upstream/$(git branch --show-current)..HEAD 2>/dev/null || echo "0")
        
        if [[ $behind -gt 0 || $ahead -gt 0 ]]; then
            echo "🔄 Sync: $ahead ahead, $behind behind upstream"
        else
            echo "🎯 In sync with upstream"
        fi
    fi
}

# Function to change directory and show git status
cds() {
    cd "$1" && smart_git_status
}

# Alias for quick navigation
alias cdp='cds /home/birhanu/go-projects'
alias cdk='cds /home/birhanu/go-projects/kubernetes' 
alias cdl='cds /home/birhanu/go-projects/learning'

# Show status for current directory
alias gs='smart_git_status'