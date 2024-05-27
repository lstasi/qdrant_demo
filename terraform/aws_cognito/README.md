# AWS Cognito Module

This module creates an AWS Cognito User Pool and associated resources.

## Variables

- `aws_region`: The region in which the Cognito Instance should be created (default: "us-east-1").
- `name`: The name of the Cognito Instance (default: "qdrant-demo").

## Outputs

- `cognito_user_pool_id`: The ID of the Cognito User Pool.
- `user_pool_client_id`: The ID of the Cognito User Pool Client.
- `token_signing_key`: The URL for the token signing key.
- `cognito_login_url`: The login URL for the Cognito User Pool.

## Resources

- `aws_cognito_user_pool_domain.main`: The Cognito User Pool Domain.
- `aws_cognito_user_pool.user_pool`: The Cognito User Pool.
- `aws_cognito_user_pool_client.user_pool_client`: The Cognito User Pool Client.

## Providers

- `aws`: The AWS provider.

## Required Version

- Terraform: `>= 1.7.5`
- AWS Provider: `~> 5.0`

