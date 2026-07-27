# Scenario 03: Network Connections

This scenario observes outbound TCP connections. The policy follows Tetragon's
documented `tcp_connect` pattern and filters loopback plus common private
address ranges so the demo focuses on external egress.

## Run from WSL with Docker

From one WSL terminal:

```bash
cd tetragon-demo
./scripts/preflight.sh
./scripts/run-with-docker.sh 03-network-connections/policy.yaml
./scripts/watch-docker-events.sh --processes curl


```

From another WSL terminal:

```bash
python error.py & 2>&1
cd tetragon-demo/03-network-connections
./workload.sh
```

Expected event shape:

```text
process /usr/bin/curl -fsSL https://example.com
connect /usr/bin/curl tcp <wsl-ip>:<port> -> <remote-ip>:443
exit    /usr/bin/curl -fsSL https://example.com 0
```

You can pass a different URL if your environment blocks `example.com`:

```bash
./workload.sh https://ebpf.io/
```

## Run with an existing local Tetragon daemon

```bash
cd tetragon-demo
./scripts/load-policy.sh 03-network-connections/policy.yaml monitor
tetra getevents -o compact --processes curl
```

Then run `./workload.sh` from this directory.
