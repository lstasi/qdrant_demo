# Terraform Modules

This repository contains Terraform modules for deploying various cloud resources and services.

## AWS Cognito Module

This module creates an AWS Cognito User Pool and associated resources.

### Variables

- `aws_region`: The region in which the Cognito Instance should be created (default: "us-east-1").
- `name`: The name of the Cognito Instance (default: "qdrant-demo").

### Outputs

- `cognito_user_pool_id`: The ID of the Cognito User Pool.
- `user_pool_client_id`: The ID of the Cognito User Pool Client.
- `token_signing_key`: The URL for the token signing key.
- `cognito_login_url`: The login URL for the Cognito User Pool.

### Resources

- `aws_cognito_user_pool_domain.main`: The Cognito User Pool Domain.
- `aws_cognito_user_pool.user_pool`: The Cognito User Pool.
- `aws_cognito_user_pool_client.user_pool_client`: The Cognito User Pool Client.

### Providers

- `aws`: The AWS provider.

### Required Version

- Terraform: `>= 1.7.5`
- AWS Provider: `~> 5.0`

## Helm Module

This module deploys various Helm charts including Istio and Qdrant.

### Variables

- `replicaCount`: The number of Qdrant replicas to deploy (default: 1).

### Resources

- `helm_release.istio-base`: The Istio base Helm release.
- `helm_release.istiod`: The Istio control plane Helm release.
- `helm_release.istio-ingress`: The Istio ingress Helm release.
- `helm_release.qdrant_demo`: The Qdrant demo Helm release.
- `helm_release.qdrant`: The Qdrant Helm release.
- `kubernetes_namespace.qdrant-services`: The Kubernetes namespace for Qdrant services.
- `kubernetes_namespace.istio-ingress`: The Kubernetes namespace for Istio ingress.

### Providers

- `helm`: The Helm provider.
- `kubernetes`: The Kubernetes provider.

### Required Version

- Terraform: `>= 1.7.5`
- Helm Provider: `~> 2.13.2`
- Kubernetes Provider: `~> 2.30`

## Cloud Deployment Guides

### AWS Deployment

Refer to [AWS.md](AWS.md) for detailed instructions on deploying the neural search demo on AWS.

### Azure Deployment

Refer to [AZURE.md](AZURE.md) for detailed instructions on deploying the neural search demo on Azure.

### Google Cloud Deployment

Refer to [GOOGLE.md](GOOGLE.md) for detailed instructions on deploying the neural search demo on Google Cloud.

### To-Do

Refer to [ToDo.md](ToDo.md) for the list of tasks and future improvements.

