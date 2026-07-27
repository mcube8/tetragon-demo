#!/usr/bin/env bash
set -euo pipefail

echo "Tetragon demo preflight"

if grep -qiE "microsoft|wsl" /proc/version; then
  echo "WSL detected"
else
  echo "WSL was not detected. The demos can still run on Linux, but these notes target WSL2."
fi

if [ ! -f /sys/kernel/btf/vmlinux ]; then
  echo "Missing /sys/kernel/btf/vmlinux"
  echo "On WSL, update from Windows PowerShell with: wsl --update"
  exit 1
fi
echo "Kernel BTF is present"

if mount | grep -q " on /sys/fs/bpf "; then
  echo "bpffs is mounted"
else
  echo "bpffs is not mounted at /sys/fs/bpf"
  echo "Try: sudo mount -t bpf bpf /sys/fs/bpf"
fi

if command -v docker >/dev/null 2>&1; then
  echo "Docker CLI found"
else
  echo "Docker CLI not found. Install Docker Desktop or use a local Tetragon daemon with tetra."
fi

if command -v tetra >/dev/null 2>&1; then
  echo "tetra CLI found"
else
  echo "tetra CLI not found locally. Docker-based runs can still use tetra inside the container."
fi

echo "Preflight complete"
