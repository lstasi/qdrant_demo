
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "azurerm_kubernetes_cluster" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.cluster.name
}
