# Go-Projects Kubernetes Development Environment Rules

## 🏗️ CRITICAL STRUCTURE - DO NOT BREAK

### **Directory Structure (IMMUTABLE)**
```
/home/birhanu/go-projects/           # Parent directory (git repo)
├── kubernetes/                      # Git worktree: master branch
├── learning/                        # Git worktree: test-experiments branch  
├── bin/                            # All development tools (21 tools)
├── go/                             # Custom Go 1.21.5 installation
├── .amazonq/rules/                 # AI assistant rules
├── .vscode/                        # VS Code configuration
└── go-projects.code-workspace      # Multi-root workspace file
```

### **Git Worktree Configuration (NEVER MODIFY)**
- `kubernetes/` = upstream/master worktree (always synced, never push changes here)
- `learning/` = upstream/master worktree (always synced, never push changes here)  
- Parent `go-projects/` = main repository for development tools, scripts, and environment

### **VS Code Multi-Root Workspace (PROTECTED)**
```json
{
  "folders": [
    {"name": "Kubernetes (Main)", "path": "./kubernetes"},
    {"name": "Learning (Experiments)", "path": "./learning"}, 
    {"name": "Go Tools & Config", "path": "."}
  ]
}
```

## 🚫 NEVER DO THESE ACTIONS

### **Git Operations - FORBIDDEN**
- ❌ `git push` from kubernetes/ or learning/ directories
- ❌ Commit Kubernetes source changes to kubernetes/ or learning/
- ❌ Modify .git/config in kubernetes/ or learning/ directories
- ❌ Delete or rename kubernetes/ or learning/ directories
- ❌ Change remote URLs in worktree directories

### **Directory Structure - PROTECTED**
- ❌ Move bin/ directory (breaks all tool paths)
- ❌ Delete go/ directory (breaks Go environment)
- ❌ Modify go-projects.code-workspace structure
- ❌ Change .amazonq/rules/ location

### **Environment Variables - IMMUTABLE**
- ❌ Change GOROOT from `/home/birhanu/go-projects/go`
- ❌ Remove `/home/birhanu/go-projects/bin` from PATH
- ❌ Modify Go tool paths in VS Code settings

## ✅ SAFE OPERATIONS

### **Development Workflow - ALLOWED**
- ✅ Create feature branches: `git checkout -b feature-name` in kubernetes/ or learning/
- ✅ Add files to parent go-projects/ directory
- ✅ Modify scripts in go-projects/ root
- ✅ Install new tools to bin/ directory
- ✅ Update VS Code settings (but preserve multi-root structure)

### **Sync Operations - AUTOMATED**
- ✅ Run `./local-sync-only.sh` (syncs both worktrees)
- ✅ Cron job runs hourly sync automatically
- ✅ GitHub Actions sync daily at 3 AM UTC

## 🔧 TOOL CONFIGURATION

### **Required Tools (21 total)**
```bash
# System Tools (6)
git, docker, podman, htop, strace, tcpdump

# Kubernetes Tools (7)  
kubectl, kind, minikube, helm, kubectx, kubens, k9s

# Go Development Tools (9)
goimports, golangci-lint, staticcheck, gotests, gofumpt, 
govulncheck, mockery, gotestsum, dlv

# Performance Tools (3)
hey, vegeta, dive
```

### **VS Code Source Control Settings (REQUIRED)**
```json
{
  "scm.repositories.visible": 10,
  "scm.alwaysShowRepositories": true, 
  "scm.autoReveal": true,
  "scm.repositories.sortOrder": "path"
}
```

## 🎯 CONTRIBUTION WORKFLOW

### **For Kubernetes PRs - CORRECT METHOD**
1. `cd kubernetes` or `cd learning`
2. `git checkout -b feature/my-improvement`
3. Make changes and commit
4. `git push origin feature/my-improvement` 
5. Create PR from your fork to kubernetes/kubernetes

### **For Local Development - SAFE ZONE**
- Work in `/home/birhanu/go-projects/` directory (main repository)
- Add scripts, tools, configurations, experiments
- Commit all changes to go-projects repository
- Kubernetes source code stays pristine in worktrees

## 🚨 RECOVERY PROCEDURES

### **If Worktree Breaks**
```bash
cd /home/birhanu/go-projects
./local-sync-only.sh  # Reset both worktrees to upstream
```

### **If Tools Missing**
```bash
./check-dev-tools.sh     # Verify installation
./install-missing-tools.sh  # Reinstall if needed
```

### **If VS Code Loses Multi-Root**
```bash
code go-projects.code-workspace  # Reopen workspace file
```

## 📋 VALIDATION CHECKLIST

### **Environment Health Check**
- [ ] `./check-dev-tools.sh` shows 21/21 tools ✅
- [ ] VS Code shows 3 repositories in Source Control
- [ ] `git worktree list` shows both kubernetes/ and learning/
- [ ] `./local-sync-only.sh` runs without errors
- [ ] Terminal `cd` commands switch Source Control context

### **Daily Verification**
- [ ] Both worktrees sync with upstream automatically
- [ ] No pending changes in kubernetes/ or learning/ (should be clean)
- [ ] All development work stays in parent directory
- [ ] VS Code workspace opens correctly

## 🤖 AI ASSISTANT GUIDELINES

### **When User Asks for Changes**
1. **ALWAYS** verify the change won't break the structure above
2. **NEVER** suggest modifying worktree git configurations  
3. **ALWAYS** keep development work in parent directory
4. **VERIFY** VS Code multi-root workspace remains intact
5. **CONFIRM** sync automation continues working

### **Safe Modifications**
- Adding new tools to bin/
- Creating new scripts in parent directory
- Updating VS Code settings (preserving multi-root)
- Installing system packages
- Modifying zsh configuration

### **Dangerous Operations - REQUIRE CONFIRMATION**
- Any git operations in kubernetes/ or learning/
- Moving or deleting core directories
- Changing GOROOT or PATH variables
- Modifying workspace file structure

---

**🎯 GOAL: The go-projects repository is your complete Kubernetes development environment. It contains pristine Kubernetes source code (via worktrees) plus all your tools, scripts, and configurations for productive development.**