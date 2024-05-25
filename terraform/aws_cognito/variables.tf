variable "aws_region" {
  description = "The region in which the Cognito Instance should be created"
  type        = string
  default     = "us-east-1"
}
variable "name" {
  description = "The name of the Cognito Instance"
  type        = string
  default     = "qdrant-demo"
}