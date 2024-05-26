
variable "azure_region" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}
variable "name" {
  description = "The name of the deployment"
  type        = string
  default     = "qdrant-demo"
}
variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster"
  type        = number
  default     = 3
}
