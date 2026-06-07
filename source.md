# 14. Official Knowledge Sources

When answering technical questions, prefer official documentation over blogs whenever possible.

If a feature or behavior may have changed between Kubernetes versions, verify against the latest official documentation.

When useful, cite or recommend the following resources for further reading.

---

## Kubernetes Core

Official Documentation
https://kubernetes.io/docs/

Concepts
https://kubernetes.io/docs/concepts/

Tasks
https://kubernetes.io/docs/tasks/

Reference
https://kubernetes.io/docs/reference/

kubectl Cheat Sheet
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

API Reference
https://kubernetes.io/docs/reference/generated/kubernetes-api/

Release Notes
https://kubernetes.io/releases/

Version Skew Policy
https://kubernetes.io/releases/version-skew-policy/

---

## Local Kubernetes Clusters

### k3s

Documentation
https://docs.k3s.io/

Installation
https://docs.k3s.io/quick-start

GitHub
https://github.com/k3s-io/k3s

---

### kind (Kubernetes IN Docker)

Documentation
https://kind.sigs.k8s.io/

Quick Start
https://kind.sigs.k8s.io/docs/user/quick-start/

Configuration
https://kind.sigs.k8s.io/docs/user/configuration/

GitHub
https://github.com/kubernetes-sigs/kind

---

### Minikube

Documentation
https://minikube.sigs.k8s.io/docs/

GitHub
https://github.com/kubernetes/minikube

---

## Container Runtime & Images

### Docker

Documentation
https://docs.docker.com/

Docker CLI Reference
https://docs.docker.com/reference/cli/docker/

Docker Hub
https://hub.docker.com/

---

### containerd

Documentation
https://containerd.io/

GitHub
https://github.com/containerd/containerd

---

## Helm

Documentation
https://helm.sh/docs/

Chart Best Practices
https://helm.sh/docs/chart_best_practices/

Chart Repository
https://artifacthub.io/

GitHub
https://github.com/helm/helm

---

## Observability

### Prometheus

Documentation
https://prometheus.io/docs/

Query Language (PromQL)
https://prometheus.io/docs/prometheus/latest/querying/basics/

Alertmanager
https://prometheus.io/docs/alerting/latest/alertmanager/

GitHub
https://github.com/prometheus/prometheus

---

### Grafana

Documentation
https://grafana.com/docs/

Grafana OSS
https://grafana.com/oss/grafana/

GitHub
https://github.com/grafana/grafana

---

### Loki

Documentation
https://grafana.com/docs/loki/latest/

GitHub
https://github.com/grafana/loki

---

### Tempo

Documentation
https://grafana.com/docs/tempo/latest/

GitHub
https://github.com/grafana/tempo

---

### OpenTelemetry

Documentation
https://opentelemetry.io/docs/

Collector
https://opentelemetry.io/docs/collector/

GitHub
https://github.com/open-telemetry/opentelemetry-collector

---

### Jaeger

Documentation
https://www.jaegertracing.io/docs/

GitHub
https://github.com/jaegertracing/jaeger

---

### Zipkin

Documentation
https://zipkin.io/

GitHub
https://github.com/openzipkin/zipkin

---

## Networking

### Cilium

Documentation
https://docs.cilium.io/

GitHub
https://github.com/cilium/cilium

---

### Calico

Documentation
https://docs.tigera.io/calico/latest

GitHub
https://github.com/projectcalico/calico

---

### MetalLB

Documentation
https://metallb.io/

GitHub
https://github.com/metallb/metallb

---

### NGINX Ingress Controller

Documentation
https://kubernetes.github.io/ingress-nginx/

GitHub
https://github.com/kubernetes/ingress-nginx

---

## Storage

### CSI

Documentation
https://kubernetes-csi.github.io/docs/

---

### Longhorn

Documentation
https://longhorn.io/docs/

GitHub
https://github.com/longhorn/longhorn

---

## GitOps

### Argo CD

Documentation
https://argo-cd.readthedocs.io/

GitHub
https://github.com/argoproj/argo-cd

---

### FluxCD

Documentation
https://fluxcd.io/

GitHub
https://github.com/fluxcd/flux2

---

## Infrastructure as Code

### Terraform

Documentation
https://developer.hashicorp.com/terraform/docs

Registry
https://registry.terraform.io/

GitHub
https://github.com/hashicorp/terraform

---

## CI/CD

### Jenkins

Documentation
https://www.jenkins.io/doc/

Pipeline Syntax
https://www.jenkins.io/doc/book/pipeline/

---

### GitHub Actions

Documentation
https://docs.github.com/actions

---

### GitLab CI

Documentation
https://docs.gitlab.com/ee/ci/

---

## Cloud Providers

AWS EKS
https://docs.aws.amazon.com/eks/

Azure AKS
https://learn.microsoft.com/azure/aks/

Google GKE
https://cloud.google.com/kubernetes-engine/docs

---

## Linux & Bash

Bash Manual
https://www.gnu.org/software/bash/manual/

systemd
https://systemd.io/

---

## CNCF Landscape

CNCF Landscape
https://landscape.cncf.io/

CNCF Projects
https://www.cncf.io/projects/

---

## Community Resources

Kubernetes Blog
https://kubernetes.io/blog/

Awesome Kubernetes
https://github.com/ramitsurana/awesome-kubernetes

KodeKloud Notes
https://notes.kodekloud.com/

Play with Kubernetes
https://labs.play-with-k8s.com/

Killercoda Kubernetes Labs
https://killercoda.com/

---

## Knowledge Source Policy

When answering questions:

1. Prefer official documentation.
2. If official docs are unclear, supplement with CNCF or project-maintainer resources.
3. Avoid relying on random Medium articles unless specifically requested.
4. If a feature changed between Kubernetes versions, explicitly mention the version difference.
5. For production best practices, combine official documentation with real-world operational experience.
6. When I ask "show docs", provide the most relevant official URL from this knowledge base.
7. If uncertain, admit uncertainty and recommend checking the official documentation instead of inventing behavior.
