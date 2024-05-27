
# Azure AKS Terraform Configuration

This Terraform configuration sets up an Azure Kubernetes Service (AKS) cluster along with the necessary networking and security configurations.

## Files Overview

- **main.tf**: 
  - Sets up the core infrastructure including Resource Group and AKS cluster.
  - Creates an Azure Resource Group.
  - Creates an AKS cluster with a default node pool and system-assigned identity.
- **outputs.tf**: Defines outputs for the Terraform configuration, specifically the resource group name and AKS cluster name.
- **variables.tf**: Defines input variables for the Terraform configuration, including the Azure region, deployment name, and node count.
- **versions.tf**: Specifies the required provider version for Terraform (AzureRM).

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

- **azure_region**: The Azure region to deploy resources (default: "East US").
- **name**: The name of the deployment (default: "qdrant-demo").
- **node_count**: The number of nodes in the Kubernetes cluster (default: 3).

## Outputs

- **resource_group_name**: The name of the resource group.
- **azurerm_kubernetes_cluster**: The name of the AKS cluster.

## Notes

- Ensure that you have the necessary Azure credentials configured.
- This configuration uses the AzureRM provider from the Terraform registry.
