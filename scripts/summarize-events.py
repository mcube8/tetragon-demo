#!/usr/bin/env python3

import json
import sys


def print_exec(obj):
    event = obj.get("process_exec")
    if not isinstance(event, dict):
        return False

    process = event.get("process", {})

    print()
    print("=== process_exec ===")
    print(f"time:   {obj.get('time')}")
    print(f"pid:    {process.get('pid')}")
    print(f"binary: {process.get('binary')}")

    if process.get("arguments"):
        print(f"args:   {process.get('arguments')}")

    print(f"exec:   {process.get('exec_id')}")
    print(f"parent: {process.get('parent_exec_id')}")
    print("=" * 60)

    return True


def print_kprobe(obj):
    event = obj.get("process_kprobe")
    if not isinstance(event, dict):
        return False

    process = event.get("process", {})

    # Depending on the event, the function name may be exposed
    # through function_name.
    function_name = (
        event.get("function_name")
        or event.get("function")
        or "kernel function"
    )

    print()

    if function_name == "commit_creds":
        print("=" * 60)
        print("⚠️  CREDENTIAL CHANGE DETECTED")
        print("=" * 60)
        print()
        print(f"process: {process.get('binary')}")
        print(f"pid:     {process.get('pid')}")
        print()
        print("hook:    commit_creds")
        print("event:   process_kprobe")
        print()
        print("credential transition observed")
        print("=" * 60)

    else:
        print("=== process_kprobe ===")
        print(f"time:     {obj.get('time')}")
        print(f"process:  {process.get('binary')}")
        print(f"pid:      {process.get('pid')}")
        print(f"function: {function_name}")
        print("=" * 60)

    return True


def main():
    for raw_line in sys.stdin:
        line = raw_line.strip()

        if not line:
            continue

        try:
            obj = json.loads(line)
        except json.JSONDecodeError:
            continue

        if print_kprobe(obj):
            sys.stdout.flush()
            continue

        if print_exec(obj):
            sys.stdout.flush()
            continue


if __name__ == "__main__":
    main()