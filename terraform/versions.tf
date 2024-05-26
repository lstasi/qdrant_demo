terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.51.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.105.0"
    }
    google = {
      source = "hashicorp/google"
      version = "~> 5.30.0"
    }
  }
}