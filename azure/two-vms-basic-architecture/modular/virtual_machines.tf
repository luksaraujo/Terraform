module "vm-windows" {
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

module "vm-linux" {
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