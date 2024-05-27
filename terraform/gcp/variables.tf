
variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster"
  type        = number
  default     = 3
}

variable "name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "machine_type" {
  description = "The machine type of the nodes in the Kubernetes cluster"
  type        = string
  default     = "e2-medium"
}