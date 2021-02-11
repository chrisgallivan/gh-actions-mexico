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
variable "CLIENT_ID" {
}
variable "CLIENT_SECRET" {
}
variable "SUBSCRIPTION_ID" {
}
variable "TENANT_ID" {
}

provider "azurerm" {
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
  features {}
}

module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "kata-friday-test"

  resource_group_name = "hugo-resources"

  container_type = "docker"

  container_image = "chrisgallivan/hugo-cicd:latest"
}
