
# AWS EKS Terraform Configuration

This Terraform configuration sets up an AWS Elastic Kubernetes Service (EKS) cluster along with the necessary networking and security configurations.

## Files Overview

- **locals.tf**: Defines local variables for Istio ports and creates ingress and egress rules based on these ports.
- **main.tf**: 
  - Sets up the core infrastructure including VPC and EKS cluster.
  - Uses the `terraform-aws-modules/vpc/aws` module to create a VPC with public and private subnets.
  - Uses the `terraform-aws-modules/eks/aws` module to create an EKS cluster with managed node groups.
  - Configures security group rules for Istio sidecar injection.
- **outputs.tf**: Defines outputs for the Terraform configuration, specifically the EKS cluster name.
- **ssm.tf**: Stores the VPC ID and EKS cluster name in AWS Systems Manager (SSM) parameters.
- **variables.tf**: Defines input variables for the Terraform configuration, including the cluster name, user ARN, and autoscaling group capacities.
- **versions.tf**: Specifies the required versions for Terraform and its providers (AWS and Kubernetes).

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

- **name**: The name of the EKS cluster (default: "qdrant-demo").
- **user_arn**: The ARN of the user to grant access to the EKS cluster.
- **desired_capacity**: The desired capacity of the autoscaling group (default: 2).
- **max_capacity**: The max capacity of the autoscaling group (default: 4).
- **min_capacity**: The min capacity of the autoscaling group (default: 2).

## Outputs

- **cluster_name**: The name of the EKS cluster.

## Notes

- Ensure that you have the necessary AWS credentials configured.
- This configuration uses spot instances for the EKS managed node groups.
- The VPC and EKS modules are sourced from the Terraform AWS modules registry.
