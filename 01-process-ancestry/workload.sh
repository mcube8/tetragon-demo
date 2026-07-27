#!/usr/bin/env bash
set -euo pipefail

marker=${1:-tetragon-process-ancestry}

echo "Starting process ancestry workload with marker: $marker"

bash -c '
  set -euo pipefail
  marker=$1
  echo "parent-shell marker=${marker} pid=$$ ppid=$PPID"
  /usr/bin/env bash -c '"'"'
    set -euo pipefail
    marker=$1
    echo "child-shell marker=${marker} pid=$$ ppid=$PPID"
    /usr/bin/id >/dev/null
    /bin/echo "grandchild marker=${marker}"
  '"'"' bash "$marker"
  echo "parent-shell observed child completion"
' bash "$marker"

echo "Process ancestry workload complete"
