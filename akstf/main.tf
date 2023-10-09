# AKS cluster
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.72.0"
    }
  }
}
provider "azurerm" {
  features {}
}
# backend config
terraform {
  backend "azurerm" {
    resource_group_name  = "dev-rg"
    storage_account_name = "devxyzstorageac01"
    container_name       = "devconatiner"
    key                  = "devaks.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "learnk8sResourceGroup"
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "learnk8scluster"

  default_node_pool {
    name       = "default"
    node_count = "1"
    vm_size    = "standard_d2_v2"
  }
  identity {
    type = "SystemAssigned"
  }

}
