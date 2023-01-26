terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vnet2_rg" {
  name     = "vnet2"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet2"
  location            = azurerm_resource_group.vnet2_rg.location
  resource_group_name = azurerm_resource_group.vnet2_rg.name
  address_space       = ["172.17.0.0/16"]

  subnet {
    name           = "subnet1"
    address_prefix = "172.17.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "172.17.2.0/24"
  }

  tags = {
    Name = "Vnet2"
  }
}