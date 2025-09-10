# Kubernetes Development Rules

## Project Context
- Working on Kubernetes codebase contribution
- Using Git worktrees: `/kubernetes` (main) and `/learning` (experiments)
- All Go tools isolated in `/home/birhanu/go-projects/bin/`

## Code Quality Standards
- Use `gofumpt` for stricter formatting than `gofmt`
- Run `golangci-lint` before commits
- Use `staticcheck` for advanced static analysis
- Run `govulncheck` for security vulnerabilities

## Testing Requirements
- Use `gotestsum` for enhanced test output
- Generate tests with `gotests` when needed
- Create mocks with `mockery` for interfaces
- Always run tests before pushing changes

## Git Workflow
- Work in `test-experiments` branch for development
- GitHub Actions syncs upstream daily at 3AM UTC
- Email notifications on sync failures
- Auto-conflict resolution prefers upstream changes

## Tool Paths
- Go binary: `/home/birhanu/go-projects/go/bin/go`
- All tools in: `/home/birhanu/go-projects/bin/`
- VS Code configured with proper Go paths

## Development Focus
- Kubernetes API validation and testing
- Kubelet functionality improvements
- Follow Kubernetes coding standards and conventions