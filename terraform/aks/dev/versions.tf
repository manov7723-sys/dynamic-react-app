terraform {
  required_version = ">= 1.5.0"
  backend "azurerm" {
    resource_group_name  = "rg-devops"
    storage_account_name = "agentaccount7723"
    container_name       = "tfstate"
    key                  = "aks/dev.tfstate"
  }
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.80" }
  }
}

provider "azurerm" {
  features {}
}
