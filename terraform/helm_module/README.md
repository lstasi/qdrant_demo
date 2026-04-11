# Helm Module

This module deploys various Helm charts including Istio and Qdrant.

## Variables

- `replicaCount`: The number of Qdrant replicas to deploy (default: 1).

## Resources

- `helm_release.istio-base`: The Istio base Helm release.
- `helm_release.istiod`: The Istio control plane Helm release.
- `helm_release.istio-ingress`: The Istio ingress Helm release.
- `helm_release.qdrant_demo`: The Qdrant demo Helm release.
- `helm_release.qdrant`: The Qdrant Helm release.
- `kubernetes_namespace.qdrant-services`: The Kubernetes namespace for Qdrant services.
- `kubernetes_namespace.istio-ingress`: The Kubernetes namespace for Istio ingress.

## Providers

- `helm`: The Helm provider.
- `kubernetes`: The Kubernetes provider.

## Required Version

- Terraform: `>= 1.7.5`
- Helm Provider: `~> 2.13.2`
- Kubernetes Provider: `~> 2.30`

