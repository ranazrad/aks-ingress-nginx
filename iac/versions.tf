terraform {
  required_version = "1.2.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.15.1"
    }
	
	helm = {
	  source  = "hashicorp/helm"
      version = "2.6.0"
	}	
	
	kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ACDResourceGroup"
    storage_account_name = "acdstorage"
    container_name       = "tfstate"
    key                  = "%secretkey%"
  }
}