# Scenario 01: Process Ancestry

This scenario shows how Tetragon links process execution events with parent and
child process metadata. The workload starts a short Bash process tree with a
recognizable marker so it is easy to spot in `tetra getevents`.

## Run from WSL with Docker

From one WSL terminal:

```bash
cd tetragon-demo
./scripts/preflight.sh
./scripts/run-with-docker.sh 01-process-ancestry/policy.yaml
./scripts/watch-docker-events.sh --processes bash
```

From another WSL terminal:

```bash
cd tetragon-demo/01-process-ancestry
./workload.sh
```

Expected event shape:

```text
process /usr/bin/bash ./workload.sh
process /usr/bin/bash -c ...
process /usr/bin/env bash -c ...
exit    /usr/bin/bash ... 0
```

Look for the `tetragon-process-ancestry` marker in the command arguments and
compare each event's process and parent process fields.

## Run with an existing local Tetragon daemon

```bash
cd tetragon-demo
./scripts/load-policy.sh 01-process-ancestry/policy.yaml monitor
tetra getevents -o compact --processes bash
```

Then run `./workload.sh` from this directory.
