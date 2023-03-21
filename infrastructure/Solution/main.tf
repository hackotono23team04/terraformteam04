terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

locals {
  common_tags = { name = "test"
  value = "hackoton" }

  extra_tags = {}

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "3cb9fb18-979f-4537-99ff-165c73f50d82"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "team04rg"
    storage_account_name = "team04stg"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

//RG
module "RGgroups" {
  source          = "./Modules/RGgroups"
  name = var.name
  location = var.location
}

//Log Analytics
module "LogAnalitycs" {
  source              = "./Modules/LogAnalytics"
  name                = "mshack"
  depends_on          = [module.RGgroups]                                    // Dependencia Explicita.
  resource_group_name = module.RGgroups.name    // Dependencia implicita
  location            = module.RGgroups.location // Dependencia implicita
  sku                 = "Premium"
  retention_in_days   = 7
  tags                = merge(local.common_tags, local.extra_tags)
  solutions = [
    {
      solution_name = "AzureActivity",
      publisher     = "Microsoft",
      product       = "OMSGallery/AzureActivity",
    },
  ]
}
