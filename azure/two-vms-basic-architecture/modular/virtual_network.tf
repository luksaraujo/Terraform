module "vnet" {
  source              = "./modules/virtual-network"
  resource_group_name = azurerm_resource_group.rg-01.name
  vnet_address_space  = "192.168.0.0/16"
  vnet_name           = "lab-lucas-souza-tf-simple-infra-vn01"
  depends_on          = [azurerm_resource_group.rg-01]
  subnets = {
    lab-lucas-souza-tf-simple-infra-sn01 = {
      address_prefix = "192.168.0.0/24"
    }
    /* lab-lucas-souza-tf-simple-infra-sn02 = {
      address_prefix = "192.168.1.0/24"
      delegation = {
        name = "fs"
        service_delegation = {
          name = "Microsoft.DBforMySQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      }
    } */
  }
}