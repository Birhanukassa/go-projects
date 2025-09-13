# Branching & PR Workflow Guide

##  Branching Workflow Diagram

```
┌─────────────────────┐        git pull upstream/master
│ UPSTREAM            │ ◄─────────────────────────────────
│ kubernetes/kubernetes│
│ branch: master      │
└─────────────────────┘
          ▲
          │ fetch + merge fast-forward
          │
┌─────────────────────┐        git push origin master
│ YOUR FORK (origin)  │ ──────────────────────────────────►
│ branch: origin/master│
└─────────────────────┘
          │
          │ branch from origin/master
          ▼
┌─────────────────────┐    (submodule: kubernetes/)
│ LOCAL SUBMODULE     │
│ path: .../kubernetes│
│ branch: master      │
└─────────────────────┘
          │
          │ create topic branch
          ▼
┌─────────────────────┐     push → origin/feature-branch → PR → upstream/master
│ FEATURE BRANCH      │  ─────────────────────────────────────────────────────►
│ branch: fix/... or  │
│         feat/...    │
└─────────────────────┘
          ▲
          │
          │ apply selected commits from experiments
          │
┌─────────────────────┐
│ LEARNING WORKTREE   │
│ path: .../learning  │
│ branch: test-experiments
└─────────────────────┘
```

##  Step-by-Step Commands

### 1. Ensure Remotes and Worktrees
```bash
cd /home/birhanu/go-projects/kubernetes
git remote -v     # verify origin and upstream

# If upstream missing:
git remote add upstream https://github.com/kubernetes/kubernetes.git
```

### 2. Sync Your Fork Master with Upstream Safely
```bash
cd /home/birhanu/go-projects/kubernetes
git fetch upstream
git checkout master
git merge --ff-only upstream/master   # fail if non-fast-forward
git push origin master                # push fast-forwarded master to your fork
```

### 3. Create Clean Feature Branch from Synced Master
```bash
git checkout -b fix/scheduler-memory-leak
```

### 4. Move Only Good Commits from Learning to Feature Branch

**Option A: Cherry-pick by hash**
```bash
# Find commit in learning
cd /home/birhanu/go-projects/learning
git log --oneline experiment-branch

# Note commit hash(s), then apply in kubernetes worktree
cd /home/birhanu/go-projects/kubernetes
git cherry-pick <commit-hash-1> <commit-hash-2>
```

**Option B: Format-patch and apply (keeps author metadata)**
```bash
cd /home/birhanu/go-projects/learning
git format-patch -k -1 <commit-hash> -o /tmp/patches
cd /home/birhanu/go-projects/kubernetes
git am /tmp/patches/0001-*.patch
```

### 5. Clean History and Polish Commit Messages
```bash
git rebase -i master    # squash, reorder, edit messages

# Edit commit messages to follow style:
# "fix: short description"
# 
# body with explanation and "Fixes #<upstream-issue>" where relevant
```

### 6. Run Tests and Linters Locally
```bash
make test
make verify
golangci-lint run
gofumpt -w .
```

### 7. Push Feature Branch to Your Fork and Open PR
```bash
git push origin fix/scheduler-memory-leak

# Use GitHub UI or CLI to create PR
# Example with GitHub CLI:
gh pr create --base master --head your-username:fix/scheduler-memory-leak \
  --title "fix: resolve scheduler memory leak" \
  --body "Problem, solution, tests, fixes #12345"
```

### 8. Iterate on Review
```bash
# Make changes locally, commit, push
git add .
git commit -m "fix: address review feedback - handle nil pointer"
git push origin fix/scheduler-memory-leak
```

### 9. After PR Merge, Fast-forward Your Fork Master Again
```bash
cd /home/birhanu/go-projects/kubernetes
git fetch upstream
git checkout master
git merge --ff-only upstream/master
git push origin master
```

### 10. Clean Local Branches
```bash
git branch -d fix/scheduler-memory-leak
git push origin --delete fix/scheduler-memory-leak    # optional remove remote branch
```

##  Quick Checklist (Daily Habit)

- [ ] Verify remotes: `git remote -v`
- [ ] Sync master with upstream before starting: `git fetch upstream; git merge --ff-only upstream/master`
- [ ] Create topic branch from master: `git checkout -b fix/…`
- [ ] Move only selected commits from learning with cherry-pick or format-patch
- [ ] Run tests and linters: `make test; make verify; golangci-lint run`
- [ ] Push branch and open PR from fork to upstream
- [ ] Address reviews on the same branch by pushing new commits
- [ ] After merge, re-sync master and remove topic branch

##  Branch Naming Standards

- **Fixes**: `fix/<component>-<short>` (e.g., `fix/scheduler-memory-leak`)
- **Features**: `feat/<component>-<short>` (e.g., `feat/api-validation`)
- **Documentation**: `docs/<topic>` (e.g., `docs/contributing-guide`)
- **Environment**: `env/<short>` (e.g., `env/update-tools`)

## 🔧 Pro Tips

### Use Fast-Forward Only Merges
```bash
git merge --ff-only upstream/master
```
This prevents accidental rebase or complex merges in master.

### Preserve Authorship with Format-Patch
```bash
git format-patch -k -1 <commit-hash> -o /tmp/patches
git am /tmp/patches/0001-*.patch
```
This keeps your authorship from learning commits.

### Use GitHub CLI for Consistency
```bash
gh pr create --base master --head your-username:feature-branch
```
Consistent PR creation and automatic issue linking.

### Keep Master as Stable Base Only
- Never commit directly to master
- Always branch from master for new work
- Master should only receive fast-forward merges from upstream

##  Common Mistakes to Avoid

1. **Don't push directly to master** - Always use feature branches
2. **Don't cherry-pick failed experiments** - Only pick working commits
3. **Don't skip tests** - Always run `make test` before pushing
4. **Don't forget to sync** - Always start from latest upstream
5. **Don't leave debugging code** - Clean up before submitting PR

---

**This workflow ensures professional, clean contributions that Kubernetes maintainers will appreciate and that showcase your development skills to employers.**