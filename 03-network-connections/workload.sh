#!/usr/bin/env bash
set -euo pipefail

url=${1:-http://172.17.0.1:9090/tetragon-alert}

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required for this workload"
  exit 69
fi

echo "Connecting to $url"

response=$(curl -fsSL "$url")

echo
echo "Server response:"
echo "$response"
echo
echo "Network workload complete"