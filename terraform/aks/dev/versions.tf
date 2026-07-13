terraform {
  required_version = ">= 1.5.0"
  # No azurerm backend configured — state is local. Create a Storage
  # Account + container and set them for production use.
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.80" }
  }
}

provider "azurerm" {
  features {}
}
