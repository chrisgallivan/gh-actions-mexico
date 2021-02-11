#terraform remote state
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  backend "remote" {
    organization = "KATA-FRIDAYS"
    workspaces {
      name = "kata-friday-test"
    }
  }
}
provider "azurerm" {
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
  features {}
}

module "azure_app_service_container" {
  source                = "git::https://github.com/chrisgallivan/azure_app_service_container.git"
  resource_group_name   = "kata-friday-resources"
  app_service_plan_name = "kata-friday-test"
  app_service_name      = "kata-friday-test"
  location              = "eastus"
  image_name            = "chrisgallivan/hugo-cicd:latest"
}
