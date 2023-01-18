# Cria uma VNet e uma Subnet de acordo com os parâmetros.

resource "azurerm_resource_group" "rg-01" {
  name     = var.rg_name
  location = var.rg_location
}

module "vnet" {
  source              = "../"
  resource_group_name = azurerm_resource_group.rg-01.name
  vnet_address_space  = "192.168.0.0/16"
  vnet_name           = "lab-lucas-souza-tf-simple-infra-vn01"
  depends_on          = [azurerm_resource_group.rg-01]
  subnets = {
    lab-lucas-souza-tf-simple-infra-sn01 = {
      address_prefix = "192.168.0.0/24"
    }
  }
}