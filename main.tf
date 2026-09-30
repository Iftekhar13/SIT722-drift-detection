terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-sit722-tfstate"
    storage_account_name = "sit722tfstate50733"
    container_name       = "tfstate"
    key                  = "drift-demo.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "drift_demo" {
  name     = "rg-sit722-drift-demo"
  location = "Australia East"

  tags = {
    environment = "development"
    managed_by  = "terraform"
  }
}