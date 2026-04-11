
# GCP GKE Terraform Configuration

This Terraform configuration sets up a Google Kubernetes Engine (GKE) cluster along with the necessary networking and security configurations.

## Files Overview

- **main.tf**: 
  - Sets up the core infrastructure including VPC network, subnetwork, and GKE cluster.
  - Creates a Google Cloud VPC network.
  - Creates a subnetwork within the specified VPC network.
  - Creates a GKE cluster with a specified node count and machine type.
- **outputs.tf**: Defines outputs for the Terraform configuration, specifically the VPC name and GKE cluster name.
- **variables.tf**: Defines input variables for the Terraform configuration, including the GCP project ID, region, node count, and cluster name.
- **versions.tf**: Specifies the required provider version for Terraform (Google).

## Usage

1. **Initialize Terraform**:
   ```sh
   terraform init
   ```

2. **Plan the Infrastructure**:
   ```sh
   terraform plan
   ```

3. **Apply the Configuration**:
   ```sh
   terraform apply
   ```

## Inputs

- **gcp_project**: The GCP project ID.
- **gcp_region**: The GCP region to deploy resources (default: "us-central1").
- **node_count**: The number of nodes in the Kubernetes cluster (default: 3).
- **name**: The name of the Kubernetes cluster.

## Outputs

- **vpc_name**: The name of the VPC.
- **gke_cluster_name**: The name of the GKE cluster.

## Notes

- Ensure that you have the necessary GCP credentials configured.
- This configuration uses the Google provider from the Terraform registry.
