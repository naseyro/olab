---
title: "Projects"
---

### [olab / This site!](https://github.com/naseyro/olab)
A self-hosted Kubernetes homelab running a containerized Hugo site with kubeadm, Traefik, Cloudflare Tunnel, Flux GitOps, GitHub Actions CI/CD, and a private Zot container registry.

### [minictr](https://github.com/naseyro/minictr)
A container runtime built from scratch in Go, exploring Linux namespaces, cgroups, networking, OverlayFS, OCI images, and the container lifecycle behind Docker.


### [SecretsManager](https://github.com/naseyro/sekrets)
A Kubernetes controller built with pure client-go that automatically injects secrets into workloads and triggers immediate rollouts when secret values change.

### [ms3](https://github.com/ms3-system/ms3)
Simple object storage system in Go, featuring an API gateway that routes REST and gRPC traffic acrosstt dedicated metadata, and data storage microservices. The project is orchestrated on Kubernetes and deployed using a modern GitOps CI/CD pipeline powered by Prow, Kustomize, and Argo CD.