output "aws_k8s_cluster_name" {
  value = "export KUBERNETES_MASTER=${module.aws_k8s.cluster_name}"
}
output "gke_k8s_cluster_name" {
  value = "export KUBERNETES_MASTER=${module.gcp_k8s.gke_cluster_name}"
}
