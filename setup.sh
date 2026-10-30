#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "      Environment Analysis & Setup        "
echo "=========================================="

echo "[1/4] Checking system information..."
echo "  OS Kernel: $(uname -s -r -m)"
if [ -f /etc/os-release ]; then
  . /etc/os-release
  echo "  OS Name:   ${PRETTY_NAME:-$NAME}"
fi
echo "  User:      $(whoami)"
echo "  Workdir:   $(pwd)"

echo ""
echo "[2/4] Checking required runtime & build tool dependencies..."

check_tool() {
  local tool="$1"
  if command -v "$tool" >/dev/null 2>&1; then
    local path
    path=$(command -v "$tool")
    echo "  [✓] $tool: found at $path"
  else
    echo "  [✗] $tool: not found"
  fi
}

check_tool bash
check_tool git
check_tool python3
check_tool node
check_tool npm
check_tool go
check_tool java

echo ""
echo "[3/4] Reporting language runtime versions..."
if command -v python3 >/dev/null 2>&1; then
  echo "  Python: $(python3 --version 2>&1)"
fi
if command -v node >/dev/null 2>&1; then
  echo "  Node:   $(node --version 2>&1)"
fi
if command -v go >/dev/null 2>&1; then
  echo "  Go:     $(go version 2>&1)"
fi
if command -v java >/dev/null 2>&1; then
  echo "  Java:   $(java -version 2>&1 | head -n 1)"
fi
if command -v git >/dev/null 2>&1; then
  echo "  Git:    $(git --version 2>&1)"
fi

echo ""
echo "[4/4] Environment verification completed successfully!"
echo "=========================================="
