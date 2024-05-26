variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "qdrant-demo"
}
variable "user_arn" {
  description = "The ARN of the user to grant access to the EKS cluster"
  type        = string
  default     = ""
}
variable "gcp_project" {
  description = "The GCP project to deploy resources"
  type        = string
  default     = "qdrant-eks"
}
variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}
variable "gcp_zone" {
  description = "The GCP zone to deploy resources"
  type        = string
  default     = "us-central1-c"
}