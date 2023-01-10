module "vnet" {
  source              = "./modules/virtual-network"
  resource_group_name = azurerm_resource_group.rg-01.name
  vnets = {
    lab-lucas-souza-tf-simple-infra-vn01 = {
      address_space = "192.168.0.0/16"
      subnet = {
        name           = "lab-lucas-souza-tf-simple-infra-sn01"
        address_prefix = "192.168.0.0/24"
      }
    }
  }
  depends_on = [azurerm_resource_group.rg-01]
}