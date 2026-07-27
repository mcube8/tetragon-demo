# Scenario 04: Privilege Escalation Monitoring

This scenario monitors when a process changes credentials, which is a common
privilege-escalation signal. The demo uses a kprobe on `commit_creds` so you
can observe the transition without needing to run any privileged workload on
the host.

## Run from WSL with Docker

From one WSL terminal:

```bash
cd tetragon-demo
./scripts/preflight.sh
./scripts/run-with-docker.sh 04-privilege-escalation/policy.yaml
./scripts/watch-docker-events.sh --processes su
```

From another WSL terminal:

```bash
cd tetragon-demo/04-privilege-escalation
./workload.sh
```

Expected workload output:

```text
Current identity:
...
Running command as nobody...
Identity inside child process:
...
Privilege-monitoring workload complete
```

Expected event signal:

```text
process credentials changed
```

## Run with an existing local Tetragon daemon

```bash
cd tetragon-demo
./scripts/load-policy.sh 04-privilege-escalation/policy.yaml monitor
tetra getevents -o compact --processes su
```

Then run `./workload.sh` from this directory.
