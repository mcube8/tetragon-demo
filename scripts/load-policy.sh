#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <policy.yaml> [monitor|enforce]"
  exit 64
fi

policy_file=$1
mode=${2:-}

if ! command -v tetra >/dev/null 2>&1; then
  echo "tetra CLI is not installed in this WSL environment"
  exit 69
fi

if [ -n "$mode" ]; then
  tetra tracingpolicy add --mode "$mode" "$policy_file"
else
  tetra tracingpolicy add "$policy_file"
fi
