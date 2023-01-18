module "vm-windows-dinamico" {
  source                      = "../../modules/virtual-machine"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Windows"
  depends_on                  = [module.vnet, module.public-ips-windows]
  vms_dynamic                 = var.vms_windows
  
}

module "vm-linux-dinamico" {
  source                      = "../../modules/virtual-machine"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Linux"
  depends_on                  = [module.vnet]
  vms_dynamic                 = var.vms_linux
}

module "public-ips-windows" {
  source                = "../../modules/public-ip"
  for_each              = var.vms_windows
  pip_name              = join("-", [each.key, "pip"])
  resource_group_name   = azurerm_resource_group.rg-01.name
  pip_allocation_method = "Static"
  depends_on = [azurerm_resource_group.rg-01]
}