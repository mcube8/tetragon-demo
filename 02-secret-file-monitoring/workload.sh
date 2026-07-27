#!/usr/bin/env bash
set -euo pipefail

secret_file=${1:-/tmp/tetragon-demo-secret}

echo "Creating demo secret at $secret_file"
umask 077
printf 'demo-secret=%s\n' "$(date +%s)" > "$secret_file"

echo "Reading the secret"
cat "$secret_file" >/dev/null

echo "Appending to the secret"
printf 'demo-update=%s\n' "$$" >> "$secret_file"

echo "Truncating the secret"
: > "$secret_file"

echo "Secret file workload complete"
