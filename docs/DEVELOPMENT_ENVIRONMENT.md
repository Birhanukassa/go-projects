# Kubernetes Development Environment Documentation

## Environment Overview

This repository contains a complete Kubernetes development environment with automated syncing, branch protection, and experiment management capabilities.

### Directory Structure
```
/home/birhanu/go-projects/           # Main development environment
├── kubernetes/                      # Worktree: master branch (production contributions)
├── learning/                        # Worktree: test-experiments branch (safe experimentation)
├── bin/                            # Development tools (21 tools)
├── go/                             # Custom Go 1.21.5 installation
├── .amazonq/rules/                 # AI assistant rules
└── scripts/                        # Automation scripts
```

##  Automated Sync System

### Dual Sync Strategy
1. **GitHub Actions** - Cloud-based daily sync at 3 AM UTC
2. **Local Cron Job** - Hourly local sync + terminal startup check
3. **Manual Scripts** - On-demand sync capabilities

### Sync Targets
- **kubernetes/master** ← Always syncs with upstream/master
- **learning/test-experiments** ← Conditionally syncs (can be paused)
- **GitHub fork branches** ← Updated to match local state

## Experiment Pause System

### Purpose
Prevents active experiments from being overwritten by daily upstream syncs during development.

### Control Mechanism
- **Local Flag**: `/tmp/pause-experiments` (controls local scripts)
- **GitHub Flag**: `.pause-experiments` (controls GitHub Actions)
- **Unified Control**: Scripts manage both flags simultaneously

### Usage
```bash
# Pause experiment syncing
./pause-experiments.sh

# Resume experiment syncing  
./resume-experiments.sh

# Check sync status
./daily-sync-check.sh
```

##  Branch Protection Strategy

### Repository Security
- **All branches protected** - Requires PR workflow
- **Owner bypass enabled** - Emergency access maintained
- **Professional workflow** - Shows best practices to employers

### Protection Rules
- Require pull request before merging
- Block force pushes
- Require conversation resolution
- Squash and merge preferred (clean history)

##  Development Workflows

### Professional Kubernetes Contribution Workflow

This is the recommended workflow that follows Kubernetes community standards and ensures clean, professional contributions.

#### Step 1: Experiment Safely in Learning Environment
```bash
cd learning                          # Go to experimental environment
./pause-experiments.sh              # Prevent your work from being overwritten
git checkout test-experiments        # Start from experimental base
git checkout -b experiment-scheduler-fix  # Create experiment branch

# Work freely for days or weeks:
# - Try different approaches
# - Make messy commits (it's okay!)
# - Break things and learn from failures
# - Add debugging code and temporary fixes
# - Don't worry about commit message quality
# - Focus on learning and solving the problem
```

#### Step 2: Review Your Experimental Work
```bash
# Look at what you accomplished:
git log --oneline experiment-scheduler-fix

# Example output might look like:
# abc123f Try approach 3 - this actually works!
# def456g Fix the memory leak in scheduler
# ghi789j Add tons of debug logging (temporary)
# jkl012m Try approach 2 - doesn't work
# mno345p Try approach 1 - partial success
# pqr678s Initial broken attempt
# stu901v Add debugging to understand the problem

# Identify which commits contain the actual solution
# In this example: def456g and abc123f are the real fixes
```

#### Step 3: Create Clean Production Branch
```bash
cd ../kubernetes                     # Switch to production environment
git checkout master                  # Start from clean upstream code
git pull upstream master             # Make sure you have latest changes
git checkout -b fix-scheduler-memory-leak  # Descriptive branch name

# Cherry-pick only the commits that contain the actual fix:
git cherry-pick def456g              # The memory leak fix
git cherry-pick abc123f              # The working approach

# Skip the experimental commits:
# - Don't include debugging code
# - Don't include failed attempts
# - Don't include temporary workarounds
```

#### Step 4: Polish for Professional Submission
```bash
# Clean up commit messages if needed:
git rebase -i master                 # Interactive rebase to edit commits

# During interactive rebase, you can:
# - Squash multiple commits into one
# - Rewrite commit messages to be professional
# - Reorder commits logically

# Example of good commit message:
# "fix: resolve scheduler memory leak during pod cleanup
# 
# The scheduler was not properly releasing memory when pods
# were deleted, causing memory usage to grow over time.
# This fix ensures proper cleanup in the deletion path.
# 
# Fixes #12345"

# Test everything works properly:
make test                           # Run Kubernetes tests
golangci-lint run                   # Check code quality
gofumpt -w .                        # Format code properly
```

#### Step 5: Submit Professional PR
```bash
# Push your clean branch:
git push origin fix-scheduler-memory-leak

# Create PR on GitHub:
# From: your-fork:fix-scheduler-memory-leak
# To: kubernetes/kubernetes:master
# 
# Write a good PR description explaining:
# - What problem you solved
# - How you solved it
# - What testing you did
# - Any relevant issue numbers
```

#### Step 6: Clean Up and Resume
```bash
cd ../learning
./resume-experiments.sh             # Resume normal syncing

# Your experiment branch stays available for:
# - Future reference
# - Additional improvements
# - Learning from your process
```

### Why This Workflow is Professional

**Clean Separation:**
- **learning/** = Messy experimentation, trial and error, learning
- **kubernetes/** = Clean, production-ready code only
- **master branch** = Never modified directly, always pristine

**Follows Kubernetes Standards:**
- **Topic branches** - Each PR comes from a descriptive branch name
- **Clean history** - Only relevant commits, no experimental mess
- **Proper testing** - Code is tested before submission
- **Good commit messages** - Professional, descriptive commits

**Professional Benefits:**
- **No duplicate work** - Cherry-pick preserves your commits and authorship
- **Selective inclusion** - Include only the good parts, leave experiments behind
- **Clean PR history** - Reviewers see only relevant changes
- **Maintainable code** - No debugging code or temporary hacks in production

**Real-World Example:**
You spend 2 weeks experimenting with a scheduler improvement. You make 47 commits trying different approaches, adding debug code, and learning how the scheduler works. In the end, only 3 commits actually contain the fix. You cherry-pick those 3 commits into a clean production branch and submit a professional PR with clean history.

### Simple Learning Workflow (No Contribution Intent)

For when you just want to learn and experiment without contributing back:

```bash
cd learning
./pause-experiments.sh              # Pause auto-sync
git checkout test-experiments        # Start from experimental base
git checkout -b learn-api-internals  # Learning branch

# Experiment freely:
# - Follow tutorials
# - Try examples from documentation
# - Break things to understand how they work
# - Make notes in commit messages about what you learned

# When finished learning:
./resume-experiments.sh             # Resume normal syncing
# Keep the branch for future reference and notes
```

### Environment Maintenance Workflow

For updating your development environment, automation scripts, or documentation:

```bash
# Work in the main go-projects repository
cd /home/birhanu/go-projects        # Main environment repository
git checkout master
git checkout -b update-sync-workflow

# Make changes to:
# - Automation scripts (daily-sync-check.sh, etc.)
# - GitHub Actions workflows
# - Tool configurations
# - Documentation updates
# - Environment setup scripts

git add .
git commit -m "feat: improve sync reliability with better error handling"
git push origin update-sync-workflow

# Create PR to your own fork (branch protection requires it)
# This shows professional practices even for personal environment updates
```

##  Monitoring & Validation

### Health Checks
- **Tool Count**: 21/21 development tools installed
- **Worktree Status**: Both worktrees in sync with upstream
- **Sync Frequency**: Daily GitHub Actions + hourly local
- **Branch Protection**: All branches protected, bypass functional

### Log Locations
- **Daily Sync**: `/tmp/daily-sync.log`
- **GitHub Actions**: Repository Actions tab
- **Cron Jobs**: `crontab -l` to view schedule

##  Professional Benefits

### Career Showcase Features
- **Public repository** - Visible to employers
- **Protected branches** - Shows security awareness
- **Automated workflows** - Demonstrates DevOps skills
- **Clean commit history** - Professional development practices
- **Comprehensive documentation** - Shows attention to detail

### Development Advantages
- **Safe experimentation** - No fear of losing work
- **Always current** - Automatic upstream synchronization
- **Flexible workflow** - Can pause/resume as needed
- **Dual environments** - Production and experimental separation
- **Tool isolation** - All tools in dedicated directory

##  Getting Started

### Initial Setup
1. Clone this repository
2. Run `./setup-daily-sync.sh` to enable automation
3. Verify tools with `./check-dev-tools.sh`
4. Test sync with `./daily-sync-check.sh`

### Daily Usage
1. **Normal development**: Auto-sync keeps everything current
2. **Start experiments**: `./pause-experiments.sh`
3. **Finish experiments**: `./resume-experiments.sh`
4. **Contribute to Kubernetes**: Use kubernetes/ directory
5. **Learn and prototype**: Use learning/ directory

##  Maintenance

### Regular Tasks
- Monitor GitHub Actions for sync failures
- Update development tools as needed
- Review and merge environment improvement PRs
- Validate worktree synchronization status

### Troubleshooting
- **Sync failures**: Check `/tmp/daily-sync.log`
- **Tool issues**: Run `./install-missing-tools.sh`
- **Worktree problems**: Run `./local-sync-only.sh`
- **Branch protection**: Use bypass for emergency access

---

**This environment enables professional Kubernetes development with safety, automation, and showcase value for career advancement.**
