resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}