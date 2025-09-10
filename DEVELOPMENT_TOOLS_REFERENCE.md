# Kubernetes Development Environment - Tools Reference

## 🔧 System Tools

### **git** - `/usr/bin/git`
- **Use:** Version control for Kubernetes source code
- **Commands:** `git clone`, `git commit`, `git push`, `git rebase`
- **Workflow:** Track changes, sync with upstream, create PRs

### **docker** - `/usr/bin/docker`
- **Use:** Container runtime for building/testing Kubernetes components
- **Commands:** `docker build`, `docker run`, `docker ps`, `docker logs`
- **Workflow:** Build container images, test deployments

### **podman** - `/usr/bin/podman`
- **Use:** Alternative container runtime (rootless, daemonless)
- **Commands:** `podman build`, `podman run`, `podman pod create`
- **Workflow:** Secure container development, pod testing

### **htop** - `/usr/bin/htop`
- **Use:** Interactive process monitor
- **Commands:** `htop`
- **Workflow:** Monitor CPU/memory during builds, find resource bottlenecks

### **strace** - `/usr/bin/strace`
- **Use:** System call tracer for debugging
- **Commands:** `strace -p PID`, `strace ./binary`
- **Workflow:** Debug kubelet issues, trace API calls

### **tcpdump** - `/usr/bin/tcpdump`
- **Use:** Network packet analyzer
- **Commands:** `tcpdump -i eth0`, `tcpdump port 6443`
- **Workflow:** Debug API server connectivity, network policies

---

## ☸️ Kubernetes Tools

### **kubectl** - `/usr/local/bin/kubectl`
- **Use:** Kubernetes CLI for cluster management
- **Commands:** `kubectl get pods`, `kubectl apply -f`, `kubectl logs`
- **Workflow:** Deploy resources, debug clusters, manage workloads

### **kind** - `/home/birhanu/go-projects/bin/kind`
- **Use:** Kubernetes in Docker - local clusters
- **Commands:** `kind create cluster`, `kind load docker-image`
- **Workflow:** Test Kubernetes changes locally, CI/CD testing

### **minikube** - `/home/birhanu/go-projects/bin/minikube`
- **Use:** Local Kubernetes cluster (VM-based)
- **Commands:** `minikube start`, `minikube dashboard`, `minikube tunnel`
- **Workflow:** Local development, feature testing, demos

### **helm** - `/home/birhanu/go-projects/bin/helm`
- **Use:** Kubernetes package manager
- **Commands:** `helm install`, `helm upgrade`, `helm template`
- **Workflow:** Deploy complex applications, manage releases

### **kubectx** - `/home/birhanu/go-projects/bin/kubectx`
- **Use:** Switch between Kubernetes contexts
- **Commands:** `kubectx`, `kubectx dev-cluster`
- **Workflow:** Manage multiple clusters, quick context switching

### **kubens** - `/home/birhanu/go-projects/bin/kubens`
- **Use:** Switch between Kubernetes namespaces
- **Commands:** `kubens`, `kubens kube-system`
- **Workflow:** Navigate namespaces quickly, avoid typing `-n namespace`

### **k9s** - `/home/birhanu/go-projects/bin/k9s`
- **Use:** Terminal-based Kubernetes dashboard
- **Commands:** `k9s`
- **Workflow:** Visual cluster management, real-time monitoring, log viewing

---

## 🐹 Go Development Tools

### **goimports** - `/home/birhanu/go-projects/bin/goimports`
- **Use:** Auto-format Go code and manage imports
- **Commands:** `goimports -w file.go`, `goimports -d .`
- **Workflow:** Format code before commits, fix import statements

### **golangci-lint** - `/home/birhanu/go-projects/bin/golangci-lint`
- **Use:** Comprehensive Go linter (runs 40+ linters)
- **Commands:** `golangci-lint run`, `golangci-lint run --fix`
- **Workflow:** Code quality checks, pre-commit hooks, CI/CD

### **staticcheck** - `/home/birhanu/go-projects/bin/staticcheck`
- **Use:** Advanced static analysis for Go
- **Commands:** `staticcheck ./...`, `staticcheck -f stylish ./...`
- **Workflow:** Find bugs, performance issues, code smells

### **gotests** - `/home/birhanu/go-projects/bin/gotests`
- **Use:** Generate Go test boilerplate
- **Commands:** `gotests -w -all file.go`, `gotests -template testify`
- **Workflow:** Quickly create test files, maintain test coverage

### **gofumpt** - `/home/birhanu/go-projects/bin/gofumpt`
- **Use:** Stricter Go formatter (superset of gofmt)
- **Commands:** `gofumpt -w .`, `gofumpt -d file.go`
- **Workflow:** Enforce consistent code style, pre-commit formatting

### **govulncheck** - `/home/birhanu/go-projects/bin/govulncheck`
- **Use:** Security vulnerability scanner
- **Commands:** `govulncheck ./...`, `govulncheck -mode=source ./...`
- **Workflow:** Security audits, dependency vulnerability checks

### **mockery** - `/home/birhanu/go-projects/bin/mockery`
- **Use:** Generate mocks for Go interfaces
- **Commands:** `mockery --name=Interface`, `mockery --all`
- **Workflow:** Unit testing, dependency injection, test isolation

### **gotestsum** - `/home/birhanu/go-projects/bin/gotestsum`
- **Use:** Enhanced test runner with better output
- **Commands:** `gotestsum --format=short`, `gotestsum --watch`
- **Workflow:** Readable test results, CI/CD integration, test monitoring

### **dlv** (Delve) - `/home/birhanu/go-projects/bin/dlv`
- **Use:** Go debugger
- **Commands:** `dlv debug`, `dlv attach PID`, `dlv test`
- **Workflow:** Debug Kubernetes components, step through code, inspect variables

---

## ⚡ Performance & Analysis Tools

### **hey** - `/home/birhanu/go-projects/bin/hey`
- **Use:** HTTP load testing tool
- **Commands:** `hey -n 1000 -c 10 http://api-server:6443/api/v1/pods`
- **Workflow:** API server performance testing, load benchmarking

### **vegeta** - `/home/birhanu/go-projects/bin/vegeta`
- **Use:** HTTP load testing and benchmarking
- **Commands:** `echo "GET http://localhost:8080" | vegeta attack -rate=100 -duration=30s`
- **Workflow:** Stress testing, performance regression testing

### **dive** - `/home/birhanu/go-projects/bin/dive`
- **Use:** Docker image layer analyzer
- **Commands:** `dive image:tag`, `dive --ci image:tag`
- **Workflow:** Optimize container images, reduce image size, security analysis

---

## 🔄 Sync & Automation Scripts

### **local-sync-only.sh**
- **Use:** Sync both worktrees with upstream (no pushes)
- **Commands:** `./local-sync-only.sh`
- **Workflow:** Daily sync, keep current with upstream changes

### **check-dev-tools.sh**
- **Use:** Verify all development tools installation
- **Commands:** `./check-dev-tools.sh`
- **Workflow:** Environment validation, troubleshooting setup

### **setup-auto-sync.sh**
- **Use:** Configure automatic hourly sync via cron
- **Commands:** `./setup-auto-sync.sh`
- **Workflow:** One-time setup for 24/7 sync automation

---

## 🛠️ Development Workflow Examples

### **Daily Development**
```bash
# Check environment
./check-dev-tools.sh

# Sync with upstream
./local-sync-only.sh

# Create feature branch
cd kubernetes
git checkout -b feature/my-improvement

# Code with quality checks
gofumpt -w .
golangci-lint run
govulncheck ./...
gotestsum ./...
```

### **Local Testing**
```bash
# Start local cluster
kind create cluster --name dev

# Build and test
make quick-release
kubectl apply -f test-manifests/

# Monitor with k9s
k9s
```

### **Performance Testing**
```bash
# Load test API server
hey -n 1000 -c 10 https://api-server:6443/api/v1/nodes

# Analyze container images
dive k8s.gcr.io/kube-apiserver:latest
```

### **Debugging**
```bash
# Debug with delve
dlv debug ./cmd/kubelet

# Monitor processes
htop

# Trace system calls
strace -p $(pgrep kubelet)

# Network analysis
tcpdump -i any port 6443
```

---

## 📍 Tool Locations
- **System tools:** `/usr/bin/` or `/usr/local/bin/`
- **Custom tools:** `/home/birhanu/go-projects/bin/`
- **Go binary:** `/home/birhanu/go-projects/go/bin/go`
- **PATH:** Updated in `~/.zshrc` to include custom bin directory

## 🔧 Environment Variables
- **GOROOT:** `/home/birhanu/go-projects/go`
- **PATH:** Includes `/home/birhanu/go-projects/bin`
- **Auto-sync:** Runs every hour via cron job

---

*This reference covers all 21 development tools in your Kubernetes environment. Keep this handy for daily development workflows!*