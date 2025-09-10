# Environment Validation Rules

## 🔍 AUTOMATED HEALTH CHECKS

### **Critical Structure Validation**
```bash
# Directory structure must exist
[ -d "/home/birhanu/go-projects/kubernetes" ] || echo "❌ kubernetes worktree missing"
[ -d "/home/birhanu/go-projects/learning" ] || echo "❌ learning worktree missing"  
[ -d "/home/birhanu/go-projects/bin" ] || echo "❌ tools directory missing"
[ -f "/home/birhanu/go-projects/go-projects.code-workspace" ] || echo "❌ workspace file missing"

# Git worktree validation
cd /home/birhanu/go-projects/kubernetes && git branch --show-current | grep -q "master" || echo "❌ kubernetes not on master"
cd /home/birhanu/go-projects/learning && git branch --show-current | grep -q "test-experiments" || echo "❌ learning not on test-experiments"

# Tool count validation  
ls /home/birhanu/go-projects/bin/ | wc -l | grep -q "21" || echo "❌ Missing development tools"
```

### **VS Code Configuration Validation**
```bash
# Multi-root workspace structure
grep -q "Kubernetes (Main)" /home/birhanu/go-projects/go-projects.code-workspace || echo "❌ Workspace missing kubernetes folder"
grep -q "Learning (Experiments)" /home/birhanu/go-projects/go-projects.code-workspace || echo "❌ Workspace missing learning folder"
grep -q "scm.alwaysShowRepositories" /home/birhanu/go-projects/go-projects.code-workspace || echo "❌ Missing SCM settings"
```

## 🚨 DANGER DETECTION

### **Forbidden Operations Detection**
- Monitor for `git push` commands in kubernetes/ or learning/ directories
- Alert if GOROOT changes from `/home/birhanu/go-projects/go`
- Detect if bin/ directory is moved or deleted
- Watch for workspace file modifications that break multi-root structure

### **Sync Status Monitoring**
```bash
# Check if worktrees are behind upstream
cd /home/birhanu/go-projects/kubernetes
BEHIND_K=$(git rev-list --count HEAD..upstream/master 2>/dev/null || echo "0")
[ "$BEHIND_K" -gt 10 ] && echo "⚠️ kubernetes worktree $BEHIND_K commits behind"

cd /home/birhanu/go-projects/learning  
BEHIND_L=$(git rev-list --count HEAD..upstream/master 2>/dev/null || echo "0")
[ "$BEHIND_L" -gt 10 ] && echo "⚠️ learning worktree $BEHIND_L commits behind"
```

## 🔧 AUTO-REPAIR PROCEDURES

### **Self-Healing Commands**
```bash
# Reset worktrees if corrupted
reset_worktrees() {
    cd /home/birhanu/go-projects
    ./local-sync-only.sh
}

# Reinstall missing tools
repair_tools() {
    cd /home/birhanu/go-projects
    ./install-missing-tools.sh
}

# Fix VS Code workspace
repair_vscode() {
    cd /home/birhanu/go-projects
    code go-projects.code-workspace
}
```

## 📊 ENVIRONMENT METRICS

### **Success Indicators**
- ✅ 21/21 development tools installed
- ✅ 3 repositories visible in VS Code Source Control
- ✅ Automatic sync running (cron + GitHub Actions)
- ✅ Clean worktrees (no uncommitted Kubernetes changes)
- ✅ Multi-root workspace functional

### **Warning Thresholds**
- ⚠️ Worktrees >5 commits behind upstream
- ⚠️ Missing >2 development tools
- ⚠️ VS Code showing <3 repositories
- ⚠️ Sync failed >24 hours ago

### **Critical Failures**
- 🚨 Worktree directories missing
- 🚨 GOROOT pointing to wrong location
- 🚨 bin/ directory deleted or moved
- 🚨 Workspace file corrupted
- 🚨 Git remotes modified in worktrees

---

**🎯 PURPOSE: Provide AI assistant with clear validation rules to detect and prevent environment corruption while maintaining optimal Kubernetes development workflow.**