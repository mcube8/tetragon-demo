#!/usr/bin/env bash
set -euo pipefail

container_name="${TETRAGON_DEMO_CONTAINER:-tetragon-demo}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! docker ps --format '{{.Names}}' | grep -qx "$container_name"; then
    echo "Container is not running: $container_name"
    exit 69
fi

docker exec -t "$container_name" \
    tetra getevents -o json --timestamps "$@" \
    | stdbuf -oL tr '\r' '\n' \
    | stdbuf -oL python3 -u "${SCRIPT_DIR}/summarize-events.py"