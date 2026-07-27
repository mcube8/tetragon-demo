#!/usr/bin/env bash
set -euo pipefail

echo "Current identity:"
id

echo
echo "Running command as nobody..."

su -s /bin/sh nobody -c '
    echo "Identity inside child process:"
    id
'

echo
echo "Privilege-monitoring workload complete"