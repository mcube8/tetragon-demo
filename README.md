# Tetragon Demo

This directory contains four small Tetragon demo scenarios that can be run on
Ubuntu. Each scenario includes:

- `policy.yaml` - a Tetragon `TracingPolicy`
- `workload.sh` - a small workload that creates observable activity
- `README.md` - scenario-specific notes and expected output

## Ubuntu prerequisites

Run the demos on an Ubuntu host or VM with a Linux kernel that exposes BTF:

```bash
test -f /sys/kernel/btf/vmlinux
```

A typical local setup uses Docker. The helper scripts run Tetragon as a
privileged container and mount the selected policy into Tetragon at startup.

Each scenario README includes the specific runtime steps for that demo.

## Demo sections

- `01-process-ancestry/` - observe parent/child process relationships.
- `02-secret-file-monitoring/` - monitor access to sensitive files.
- `03-network-connections/` - observe outbound network activity.
- `04-privilege-escalation/` - monitor privilege-related activity.

## Notes for Ubuntu

- Use a recent Ubuntu/Linux kernel with BTF support.
- Docker must be available and able to run privileged containers.
- These demos avoid `systemctl` because some minimal environments do not run
  systemd.
- If `/sys/kernel/btf/vmlinux` is missing, use a newer kernel or a host/VM with
  BTF enabled.

## Assets

`assets/architecture.png` and `assets/demo.gif` are placeholders for the
architecture diagram and recorded demo.
