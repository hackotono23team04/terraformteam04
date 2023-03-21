terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "3cb9fb18-979f-4537-99ff-165c73f50d82"
}

terraform {
  backend "azurerm" {
    storage_account_name = "team04stg"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}