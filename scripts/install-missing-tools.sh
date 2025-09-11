#!/bin/bash

# Install All Missing Development Tools
# Installs to parent go-projects directory (not in Kubernetes repos)

set -e

echo "🚀 Installing Missing Development Tools"
echo "======================================"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() { echo -e "${BLUE}[INSTALL]${NC} $1"; }
print_done() { echo -e "${GREEN}✅${NC} $1"; }

BIN_DIR="/home/birhanu/go-projects/bin"
mkdir -p "$BIN_DIR"

# System tools
print_step "Installing system tools..."
sudo apt update -qq
sudo apt install -y htop tcpdump podman-docker

# Kubernetes tools
print_step "Installing kind..."
curl -Lo "$BIN_DIR/kind" https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x "$BIN_DIR/kind"

print_step "Installing helm..."
curl -fsSL https://get.helm.sh/helm-v3.13.0-linux-amd64.tar.gz | tar -xz -C /tmp
mv /tmp/linux-amd64/helm "$BIN_DIR/"

print_step "Installing kubectx/kubens..."
curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz | tar -xz -C "$BIN_DIR" kubectx
curl -L https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz | tar -xz -C "$BIN_DIR" kubens

print_step "Installing k9s..."
curl -L https://github.com/derailed/k9s/releases/download/v0.28.2/k9s_Linux_amd64.tar.gz | tar -xz -C /tmp
mv /tmp/k9s "$BIN_DIR/"

print_step "Installing minikube..."
curl -Lo "$BIN_DIR/minikube" https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x "$BIN_DIR/minikube"

# Performance tools
print_step "Installing performance tools..."
go install github.com/rakyll/hey@latest
go install github.com/tsenart/vegeta@latest
curl -L https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.tar.gz | tar -xz -C /tmp
mv /tmp/dive "$BIN_DIR/"

# Move Go tools to our bin directory
mv ~/go/bin/* "$BIN_DIR/" 2>/dev/null || true

print_done "All tools installed to $BIN_DIR"

# Add to PATH if not already there
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.zshrc
    print_done "Added $BIN_DIR to PATH in ~/.zshrc"
fi

echo ""
echo "🎉 Installation Complete!"
echo "📋 Run './check-dev-tools.sh' to verify"
echo "🔄 Restart terminal or run: source ~/.zshrc"