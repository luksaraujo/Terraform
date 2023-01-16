module "vm-windows-dinamico" {
  source                      = "../../modules/virtual-machine"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Windows"
  depends_on                  = [module.vnet]
  vms_dynamic = {
    "vm-windows-01" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = var.admin_password }
  }
}

module "vm-linux-dinamico" {
  source                      = "../../modules/virtual-machine"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Linux"
  depends_on                  = [module.vnet]
  vms_dynamic = {
    "vm-linux-01" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = var.admin_password }
  }
}