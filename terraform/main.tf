module "aws_k8s" {
  source           = "./aws_k8s"
  name             = var.name
  desired_capacity = 3
  max_capacity     = 6
  min_capacity     = 3
  user_arn         = var.user_arn
}
module "azure_k8s" {
  source     = "./azure"
  name       = var.name
  node_count = 3
}
module "gcp_k8s" {
  source      = "./gcp"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  name        = var.name
  node_count  = 1
}
/*
module "helm_module" {
  source     = "./helm_module"
  replicaCount = 3
  depends_on = [module.aws_k8s]
}*/