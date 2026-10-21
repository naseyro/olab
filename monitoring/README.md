# Kubernetes observability

This directory is reconciled by Flux from `clusters/homelab/monitoring.yaml`.

## Components

- **Node Exporter** runs as a DaemonSet on every Linux Kubernetes node. It reads host `/proc`, `/sys`, and `/` read-only and exposes metrics on each node's TCP 9100. It uses host networking so Alloy can discover each node by its Kubernetes InternalIP.
- **kube-state-metrics (KSM)** runs as one Deployment and exposes selected Kubernetes object-state metrics on the internal `kube-state-metrics.monitoring.svc.cluster.local:8080` Service. Its ClusterRole is limited to list/watch for the resource types enabled with `--resources`.
- **Grafana Alloy** discovers node InternalIP addresses through the Kubernetes API, scrapes Node Exporter on port 9100 and KSM on port 8080, and remote-writes samples to the VPS.

## Metric routing

Alloy remote-writes to `http://10.200.0.1:8429/api/v1/write`. Port 8429 is intended to be reachable over the OpenVPN interface only; Caddy forwards only `/api/v1/write` to the loopback-bound VictoriaMetrics endpoint. Do not publish VictoriaMetrics port 8428 publicly.

Metric labels:

- Node Exporter: `job="node-exporter"`, `instance` is the Kubernetes node name, `cluster="olab-homelab"`.
- KSM: `job="kube-state-metrics"`, `instance="olab-homelab"`, `cluster="olab-homelab"`.

## Operational notes

- Alloy's remote-write WAL is in an `emptyDir`; it helps buffer during temporary network interruptions while the Pod remains alive, but does not survive Pod replacement. A persistent volume can be added later if needed.
- Node Exporter listens on host-network TCP 9100. The node firewall should only permit that port from the cluster Pod CIDR if the firewall blocks it by default. Verify scrape health before adding firewall rules.
- Container CPU/memory usage metrics from kubelet/cAdvisor are not included in this first phase; they can be added after Node Exporter and KSM are verified.
