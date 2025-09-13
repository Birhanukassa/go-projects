# Go Development Environment

> **Professional Go development setup with automated syncing, branch protection, and safe experimentation capabilities.**

[![Sync Status](https://github.com/Birhanukassa/go-projects/actions/workflows/auto-sync.yml/badge.svg)](https://github.com/Birhanukassa/go-projects/actions/workflows/auto-sync.yml)

## Overview

This repository contains a complete development environment for Go projects, featuring:

- **Dual Worktrees** - Separate environments for production contributions and safe experimentation
- **Automated Syncing** - GitHub Actions + local cron jobs keep everything current with upstream
- **Experiment Protection** - Pause system prevents work from being overwritten during development
- **Professional Workflow** - Branch protection and PR requirements showcase best practices
- **Complete Toolchain** - 21 development tools for Go and Kubernetes development

## Quick Start

```bash
# Clone the repository and its submodule
git clone --recurse-submodules https://github.com/Birhanukassa/go-projects.git
cd go-projects

# If you already cloned without the flag, run this:
git submodule update --init --recursive

# Enable automation
scripts/setup-daily-sync.sh

# Verify installation
scripts/check-dev-tools.sh

# Start developing
cd kubernetes          # For Kubernetes contributions
cd learning           # For experiments and learning
```

## Sync Management

### Automatic Syncing
- **GitHub Actions**: Daily sync at 3 AM UTC
- **Local Cron**: Hourly sync + terminal startup check
- **Manual**: `scripts/daily-sync-check.sh`

### Experiment Control
```bash
scripts/pause-experiments.sh    # Pause test-experiments sync
scripts/resume-experiments.sh   # Resume test-experiments sync
```

## Security Features

- **Branch Protection**: All branches require PR workflow
- **Owner Bypass**: Emergency access for repository owner
- **Force Push Prevention**: Protects against accidental history rewriting
- **Automated Validation**: Continuous sync monitoring

## Structure

```
go-projects/
├── kubernetes/          # Submodule: Your fork of the Kubernetes project
├── learning/           # Worktree (inside submodule) for safe experimentation
├── bin/               # Development tools (kubectl, golangci-lint, etc.)
├── scripts/           # Automation and utility scripts
├── src/               # Go source code projects
├── docs/             # Environment documentation
└── tools/            # Installation files and utilities
```

## Learning Path

1. **Explore** - Use `learning/` for safe experimentation
2. **Learn** - Follow Go and Kubernetes development patterns
3. **Contribute** - Create features in `kubernetes/` 
4. **Showcase** - Professional workflow visible to employers

## Monitoring

- **Sync Status**: [GitHub Actions](https://github.com/Birhanukassa/go-projects/actions)
- **Tool Health**: `scripts/check-dev-tools.sh`
- **Environment Status**: `scripts/daily-sync-check.sh`

## Development Workflow

### Professional Contribution Process
See [Branching & PR Workflow Guide](docs/BRANCHING_WORKFLOW.md) for complete workflow diagram, exact git commands, and professional PR checklist.

**Quick Overview:**
1. **Experiment safely** in `learning/` - break things, try approaches
2. **Cherry-pick solutions** to clean `kubernetes/` branch
3. **Polish and test** - professional commit messages and quality checks
4. **Submit clean PR** - reviewers see only relevant, tested changes

### Safe Experimentation
```bash
cd learning
scripts/pause-experiments.sh
git checkout -b learn-api-internals
# Experiment freely without sync interference
scripts/resume-experiments.sh  # When finished
```

## Documentation

- **[Development Environment](docs/DEVELOPMENT_ENVIRONMENT.md)** - Complete setup documentation
- **[Branching & PR Workflow](docs/BRANCHING_WORKFLOW.md)** - Professional contribution workflow
- **[Technical Architecture](docs/TECHNICAL_ARCHITECTURE.md)** - Design decisions and rationale
- **[Environment Rules](.amazonq/rules/)** - AI assistant guidelines
- **[Tool Reference](docs/DEVELOPMENT_TOOLS_REFERENCE.md)** - Complete tool documentation

## Professional Benefits

- **Visible Contributions** - Public showcase of Go development skills
- **Best Practices** - Demonstrates professional development workflows
- **Automation Skills** - Shows DevOps and CI/CD capabilities
- **Security Awareness** - Branch protection and proper git workflows
- **Documentation** - Comprehensive project documentation

---

**Built for professional Go development and career advancement.**

*This environment showcases modern development practices, automation skills, and commitment to open-source contribution.*