terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {

  features {}

  subscription_id = var.subscription_id

  tenant_id       = var.tenant_id

}

provider "random" {
  
}