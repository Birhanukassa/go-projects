#!/bin/bash

# Check Development Tools Installation Status

echo "🔍 Kubernetes Development Tools Check"
echo "===================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_tool() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✅ $1${NC} - $(command -v "$1")"
    else
        echo -e "${RED}❌ $1${NC} - Not installed"
    fi
}

check_go_tool() {
    if [ -f "/home/birhanu/go-projects/bin/$1" ]; then
        echo -e "${GREEN}✅ $1${NC} - /home/birhanu/go-projects/bin/$1"
    else
        echo -e "${RED}❌ $1${NC} - Not in go-projects/bin/"
    fi
}

echo -e "${YELLOW}📦 System Tools${NC}"
check_tool "git"
check_tool "docker"
check_tool "podman"
check_tool "htop"
check_tool "strace"
check_tool "tcpdump"

echo -e "\n${YELLOW}☸️  Kubernetes Tools${NC}"
check_tool "kubectl"
check_tool "kind"
check_tool "minikube"
check_tool "helm"
check_tool "kubectx"
check_tool "kubens"
check_tool "k9s"

echo -e "\n${YELLOW}🔧 Go Development Tools${NC}"
check_go_tool "goimports"
check_go_tool "golangci-lint"
check_go_tool "staticcheck"
check_go_tool "gotests"
check_go_tool "gofumpt"
check_go_tool "govulncheck"
check_go_tool "mockery"
check_go_tool "gotestsum"
check_go_tool "dlv"

echo -e "\n${YELLOW}⚡ Performance Tools${NC}"
check_tool "hey"
check_tool "vegeta"
check_tool "dive"

echo -e "\n${YELLOW}🐹 Go Environment${NC}"
echo -e "${GREEN}✅ Go Version:${NC} $(/home/birhanu/go-projects/go/bin/go version)"
echo -e "${GREEN}✅ GOROOT:${NC} /home/birhanu/go-projects/go"

echo -e "\n💡 To install missing tools, check individual installation commands"