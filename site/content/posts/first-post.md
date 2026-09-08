---
title: "Building a Lightweight Kubernetes Homelab"
date: 2026-09-09
draft: false
---

Running production-grade Kubernetes workloads on a strict **2 GB RAM** worker node budget requires aggressive resource tuning.

### Key Optimization Steps
1. Offload image compilation completely to GitHub Actions CI.
2. Disable unused services like Argo CD Dex/SSO to save ~80 MB RAM.
3. Enforce strict CPU and memory limits across all application pods.
