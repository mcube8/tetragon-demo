#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <policy.yaml> [tetragon-image]"
  exit 64
fi

policy_file=$1
image=${2:-quay.io/cilium/tetragon:v1.7.0}
container_name=${TETRAGON_DEMO_CONTAINER:-tetragon-demo}

if [ ! -f "$policy_file" ]; then
  echo "Policy not found: $policy_file"
  exit 66
fi

if [ ! -f /sys/kernel/btf/vmlinux ]; then
  echo "Missing /sys/kernel/btf/vmlinux. Run ./scripts/preflight.sh for WSL checks."
  exit 1
fi

policy_abs=$(cd "$(dirname "$policy_file")" && pwd)/$(basename "$policy_file")

if docker ps -a --format '{{.Names}}' | grep -qx "$container_name"; then
  echo "Stopping existing $container_name container"
  docker stop "$container_name" >/dev/null
fi

echo "Starting $container_name with policy: $policy_abs"
docker run -d --name "$container_name" --rm --pull always \
  --pid=host \
  --cgroupns=host \
  --privileged \
  -v "$policy_abs:/etc/tetragon/tetragon.tp.d/demo-policy.yaml:ro" \
  -v /sys/kernel/btf/vmlinux:/var/lib/tetragon/btf:ro \
  "$image" >/dev/null

echo "Tetragon is starting. Watch events with:"
echo "  ./scripts/watch-docker-events.sh"
