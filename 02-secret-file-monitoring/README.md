# Scenario 02: Secret File Monitoring

This scenario monitors reads and writes to `/tmp/tetragon-demo-secret`. It uses
Linux Security Module hooks that Tetragon can observe with kprobes, so it works
well in a WSL2 environment where the workload is running on the WSL kernel.

## Run from WSL with Docker

From one WSL terminal:

```bash
cd tetragon-demo
./scripts/preflight.sh
./scripts/run-with-docker.sh 02-secret-file-monitoring/policy.yaml
./scripts/watch-docker-events.sh --processes cat
```

From another WSL terminal:

```bash
cd tetragon-demo/02-secret-file-monitoring
./workload.sh
```

Expected event shape:

```text
process /usr/bin/cat /tmp/tetragon-demo-secret
read    /usr/bin/cat /tmp/tetragon-demo-secret
exit    /usr/bin/cat /tmp/tetragon-demo-secret 0
```

## Run with an existing local Tetragon daemon

```bash
cd tetragon-demo
./scripts/load-policy.sh 02-secret-file-monitoring/policy.yaml monitor
tetra getevents -o compact --processes cat
```

Then run `./workload.sh` from this directory.
