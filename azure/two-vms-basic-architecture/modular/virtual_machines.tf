module "vm-windows-sequencial" {
  source                        = "./modules/virtual-machine"
  resource_group_name           = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao   = "sequencial"
  vnet_name                     = module.vnet.vnet_name
  sequencial_identical_vm_names = "vm-win-lab"
  sequencial_qtde_vms           = 1
  os_vms                        = "Windows"
  vm_size                       = "Standard_B1ms"
  admin_username                = "lucas"
  admin_password                = "P@assw0rd"
  subnet_name                   = "lab-lucas-souza-tf-simple-infra-sn01"
  depends_on                    = [module.vnet]
  os_disk = {
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
  }
  os_disk_source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

module "vm-linux-sequencial" {
  source                        = "./modules/virtual-machine"
  resource_group_name           = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao   = "sequencial"
  vnet_name                     = module.vnet.vnet_name
  sequencial_identical_vm_names = "vm-lnx-lab"
  sequencial_qtde_vms           = 1
  os_vms                        = "Linux"
  vm_size                       = "Standard_B1ms"
  admin_username                = "lucas"
  admin_password                = "P@assw0rd"
  subnet_name                   = "lab-lucas-souza-tf-simple-infra-sn01"
  depends_on                    = [module.vnet]
  os_disk = {
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
  }
  os_disk_source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

module "vm-windows-dinamico" {
  source                      = "./modules/virtual-machine"
  resource_group_name         = azurerm_resource_group.rg-01.name
  estrategia_de_implementacao = "dinamico"
  vnet_name                   = module.vnet.vnet_name
  subnet_name                 = "lab-lucas-souza-tf-simple-infra-sn01"
  os_vms                      = "Windows"
  depends_on                  = [module.vnet]
  vms_dynamic = {
    "vm-frontend" = { size = "Standard_B1ms", admin_username = "lukita", admin_password = var.admin_password },
    "vm-backend"  = { size = "Standard_DS1_v2", admin_username = "lucas", admin_password = var.admin_password }
  }
}