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
  # TODO: Implementing mechanism of remote state and locking state for executing TF from Azure Release pipeline and for working together as a team
  # backend "azurerm" {}
}