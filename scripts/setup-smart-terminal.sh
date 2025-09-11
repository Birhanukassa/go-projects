#!/bin/bash

# Setup Smart Terminal Navigation for Multi-Repository Workflow

echo "🔧 Setting up smart terminal navigation..."

# Add to .zshrc
cat >> ~/.zshrc << 'EOF'

# === Smart Git Navigation for Kubernetes Development ===
source /home/birhanu/go-projects/smart-git-status.sh

# Auto-show git status when changing directories
chpwd() {
    smart_git_status
}

# Quick navigation aliases
alias cdp='cds /home/birhanu/go-projects'      # Parent directory
alias cdk='cds /home/birhanu/go-projects/kubernetes'  # Main K8s repo
alias cdl='cds /home/birhanu/go-projects/learning'    # Experiments repo

# Git status shortcuts
alias gs='smart_git_status'                    # Smart git status
alias gss='git status --short'                # Short git status
alias gsl='git status'                        # Long git status

# Multi-repo status check
alias status-all='echo "=== Parent ===" && cd /home/birhanu/go-projects && gs && echo -e "\n=== Kubernetes ===" && cd kubernetes && gs && echo -e "\n=== Learning ===" && cd ../learning && gs'

# Sync shortcuts
alias sync-now='/home/birhanu/go-projects/local-sync-only.sh'
alias check-tools='/home/birhanu/go-projects/check-dev-tools.sh'

EOF

echo "✅ Smart terminal setup complete!"
echo ""
echo "🎯 New Commands Available:"
echo "  cdp  - Go to parent directory (go-projects)"
echo "  cdk  - Go to kubernetes directory" 
echo "  cdl  - Go to learning directory"
echo "  gs   - Smart git status (context-aware)"
echo "  status-all - Check all repositories at once"
echo "  sync-now   - Sync both repos with upstream"
echo ""
echo "🔄 Restart terminal or run: source ~/.zshrc"