# Tetragon Demo

This directory contains four small Tetragon demo scenarios that can be run from
WSL2. Each scenario includes:

- `policy.yaml` - a Tetragon `TracingPolicy`
- `workload.sh` - a small workload that creates observable activity
- `README.md` - scenario-specific run notes and expected output

## WSL2 prerequisites

Run the demos from a WSL2 distribution with a Linux kernel that exposes BTF:

```bash
test -f /sys/kernel/btf/vmlinux
```

The easiest local setup is Docker Desktop with WSL integration enabled. The
helper scripts run Tetragon as a privileged container and mount the selected
policy into Tetragon at startup.

You can also use an already running local Tetragon daemon plus the `tetra` CLI.
The scenario READMEs include both paths.

## Quick start from WSL

```bash
cd tetragon-demo
./scripts/preflight.sh
./scripts/run-with-docker.sh 01-process-ancestry/policy.yaml
```

In a second WSL terminal:

```bash
cd tetragon-demo
./scripts/watch-docker-events.sh
```

In a third WSL terminal, run a workload:

```bash
cd tetragon-demo/01-process-ancestry
./workload.sh
```

Stop the container when you are done with a scenario:

```bash
docker stop tetragon-demo
```

Start the next scenario by passing its policy to `run-with-docker.sh`.

## Demo sections

- `01-process-ancestry/` - observe parent/child process relationships.
- `02-secret-file-monitoring/` - monitor access to sensitive files.
- `03-network-connections/` - observe outbound network activity.
- `04-runtime-enforcement/` - demonstrate runtime policy enforcement.

## Notes for WSL

- Use WSL2, not WSL1. eBPF requires the Linux kernel provided by WSL2.
- Docker Desktop must have integration enabled for your WSL distribution.
- These demos avoid `systemctl` because many WSL setups do not run systemd.
- If `/sys/kernel/btf/vmlinux` is missing, update WSL with `wsl --update` from
  Windows PowerShell and restart the distribution.

## Assets

`assets/architecture.png` and `assets/demo.gif` are placeholders for the
architecture diagram and recorded demo.
